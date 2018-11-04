package kr.ac.hongik.vin.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.ac.hongik.vin.wine.dao.WineDao;
import kr.ac.hongik.vin.wine.dto.Wine;
import kr.ac.hongik.vin.wine.dto.WineCodeAndNames;
import kr.ac.hongik.vin.wine.dto.WineSearchList;
import kr.ac.hongik.vin.wine.service.WineService;

@Controller
public class ApiController {

	@Autowired
	WineDao wineDao;
	
	@Autowired
	WineService wineService;
	
	@RequestMapping(value = "/api/wine/all")	// 전체 와인의 전체 데이터를 json형태로 제공하는 api의 기능을 하는 컨트롤러
	public void wines(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");

		List<Wine> list = wineDao.selectAll();

		ObjectMapper objectMapper = new ObjectMapper();
		String json = objectMapper.writeValueAsString(list);

		PrintWriter out = response.getWriter();
		out.println(json);
		out.close();
	}

	@RequestMapping(value = "/api/wine/code_and_names")	// 검색을 위해, 코드, 한글이름명, 와인이름명의 쌍을 json의 형태로 제공하는 api
	public void wineCodeAndNames(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");

		List<WineCodeAndNames> list = wineDao.selectWineCodeAndNames();

		ObjectMapper objectMapper = new ObjectMapper();
		String json = objectMapper.writeValueAsString(list);

		PrintWriter out = response.getWriter();
		out.println(json);
		out.close();
	}

	@RequestMapping(value = "/api/wine/{wine21Code}")		// 특정 와인의 전체 정보를 json의 형태로 제공하는 api
	public void getWineByCode(@PathVariable("wine21Code") int wine21Code,
			HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");

		Wine wine = wineDao.selectWine(wine21Code);

		ObjectMapper objectMapper = new ObjectMapper();
		String json = objectMapper.writeValueAsString(wine);

		PrintWriter out = response.getWriter();
		out.println(json);
		out.close();
	}
	
	@GetMapping(path = "/api/wine/search") // 와인 검색
	public void list(@RequestParam(name = "page", required = false, defaultValue = "1") int page, 
			@RequestParam(name = "types", required = false, defaultValue = "") List<String> types,
			@RequestParam(name = "countries", required = false, defaultValue = "") List<String> countries,
			@RequestParam(name = "alcohol", required = false, defaultValue = "") List<Integer> alcohol,	// 이 것부터  아래의 파라미터는 최소값, 최대값 10도 이상 15도 이하면 [10, 15]
			@RequestParam(name = "sweetness", required = false, defaultValue = "") List<Integer> sweetness,		// 4 이하면 [0,4]
			@RequestParam(name = "acidity", required = false, defaultValue = "") List<Integer> acidity,			// 2 이상이면 [2]
			@RequestParam(name = "body", required = false, defaultValue = "") List<Integer> body,	
			@RequestParam(name = "tanin", required = false, defaultValue = "") List<Integer> tanin,
			@RequestParam(name = "price", required = false, defaultValue = "") List<Integer> price,
			ModelMap model, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
	
		System.out.println("types : " + types + ", typeslength : " + types.size());
		System.out.println("countries : " + countries + ", countrieslength : " + countries.size());
		System.out.println("alcohol : " + alcohol + ", alcohollength : " + alcohol.size());
		System.out.println("sweetness : " + sweetness + ", sweetnesslength : " + sweetness.size());
		System.out.println("acidity : " + acidity + ", aciditylength : " + acidity.size());
		System.out.println("body : " + body + ", bodylength : " + body.size());
		System.out.println("tanin : " + tanin + ", taninlength : " + tanin.size());
		System.out.println("price : " + price + ", pricelength : " + price.size());
		
		
		// 전체 페이지수 구하기
		int count = wineService.getCount(); // 와인 전체 데이터의 수
		int pageCount = count / wineService.LIMIT; // 와인 데이터를 LIMIT(15)갯수 만큼 보여줬을 때의 페이지 수 ( 실제 페이지 수보다 1만큼 작게 나옴, 페이지
													// 수는 1부터 시작하기 때문에 )
		if (count >= wineService.LIMIT) // 페이지가 2개 이상 생성 된다면
			pageCount += 1;

		if (page < 1) {
			page = 1;	// page가 1 보다 작다면 1page를 보고 있는 것으로 간주
		} else if (page > pageCount) {
			page = pageCount;
		}	//	page가 전체 page를 넘어간 경우에는 끝 page를 보고 있는 것으로 간주

		// page에 해당하는 와인들 목록 구하기
		int start = (page - 1) * wineService.LIMIT;
		List<WineSearchList> list = wineService.getWineSearchListByCondition(start, types, countries, alcohol, sweetness, acidity, body, tanin, price);

		ObjectMapper objectMapper = new ObjectMapper();
		String json = objectMapper.writeValueAsString(list);

		PrintWriter out = response.getWriter();
		out.println(json);
		out.close();
//		int resultCount = list.size();
//
//		int startPage = 1;
//		
//		int endPage = 9;
//		if (page >= 5) {
//			startPage = page - 4;
//			endPage = page + 4;
//		}
//
//		if (page > pageCount - 4) {
//			startPage = pageCount - 8;
//			endPage = pageCount;
//		}
//
//		model.addAttribute("page", page);
//		
//		model.addAttribute("page", types);
//		model.addAttribute("page", countries);
//		model.addAttribute("page", alcohol);
//		model.addAttribute("page", sweetness);
//		model.addAttribute("page", acidity);
//		model.addAttribute("page", body);
//		model.addAttribute("page", tanin);
//		model.addAttribute("page", price);
//		
//		model.addAttribute("startPage", startPage);
//		model.addAttribute("endPage", endPage);
//		model.addAttribute("list", list);
//		model.addAttribute("pageCount", pageCount);
//		
//		return "wine/wineList";
	}
	
	
	
}
