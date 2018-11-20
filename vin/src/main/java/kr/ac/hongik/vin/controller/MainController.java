package kr.ac.hongik.vin.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.ac.hongik.vin.user.dto.User;
import kr.ac.hongik.vin.user.service.UserService;
import kr.ac.hongik.vin.wine.dto.Wine;
import kr.ac.hongik.vin.wine.dto.WineSearchList;
import kr.ac.hongik.vin.wine.service.WineService;

@Controller
public class MainController {

	@Autowired
	UserService userService;

	@Autowired
	WineService wineService;

	@RequestMapping(value = "/naverLogin") // 네이버 로그인
	public String naverLogin(HttpSession session) {
		return "naver/naverlogin";
	}

	@RequestMapping(value = "/callBack") // 콜백
	public String callBack(HttpServletRequest request) throws Exception {
		return "naver/callback";
	}

	@RequestMapping(value = "/userInfo") // 유저의 정보를 받아 세션에 값을 저장하고, 회원으로 등록 요청
	public String userInformation(HttpServletRequest request) throws Exception {
		return "naver/userinfo";
	}

	@RequestMapping(path = "/registUser") // 요청받은 정보를 User 객체에 담아 DB에 저장
	public String write(@ModelAttribute User user, HttpServletRequest request) {
		String clientIp = request.getRemoteAddr();
		System.out.println("clientIp : " + clientIp);
		userService.registUser(user);

		return "redirect:/"; // 해당 path로 리다이렉트 한다.
	}

	@RequestMapping(value = "/logout") // 로그아웃
	public String logout(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();

		session.removeAttribute("access_token");
		session.removeAttribute("refresh_token");
		session.removeAttribute("userEmail");
		session.removeAttribute("userName");
		session.removeAttribute("userAge");
		session.removeAttribute("userBirth");
		session.removeAttribute("userIsMan");
		session.removeAttribute("userGrade");

		return "naver/logout";
	}
	private static final long serialVersionUID = 1L;
	@RequestMapping(value = "/wine/search") 
	public String wineSearch(HttpServletRequest request) throws Exception {
		


		return "wine/wineSearch";
	}
	@RequestMapping(value = "/wine/hello") 
	public String hello(HttpServletRequest request) throws Exception {
		return "wine/hello";
	}
	
	@GetMapping(path = "/wine/searchList") // 와인 검색
	public String wineSearchList(@RequestParam(name = "page", required = false, defaultValue = "1") int page,
			@RequestParam(name = "keyword", required = false, defaultValue = "") String keyword,
			@RequestParam(name = "types", required = false, defaultValue = "") List<String> types,
			@RequestParam(name = "countries", required = false, defaultValue = "") List<String> countries,
			@RequestParam(name = "alcohol", required = false, defaultValue = "") List<Integer> alcohol, // 이 것부터 아래의  파라미터는 최소값,최대값 
																										// 10도 이상 15도 이하면 [10,15]
			@RequestParam(name = "sweetness", required = false, defaultValue = "") List<Integer> sweetness, // 4 이하면  [0,4]
			@RequestParam(name = "acidity", required = false, defaultValue = "") List<Integer> acidity, // 2 이상이면 [2]
			@RequestParam(name = "body", required = false, defaultValue = "") List<Integer> body,
			@RequestParam(name = "tanin", required = false, defaultValue = "") List<Integer> tanin,
			@RequestParam(name = "price", required = false, defaultValue = "") List<Integer> price, ModelMap model,
			HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		System.out.println("keyword : " + keyword);
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
			page = 1; // page가 1 보다 작다면 1page를 보고 있는 것으로 간주
		} else if (page > pageCount) {
			page = pageCount;
		} // page가 전체 page를 넘어간 경우에는 끝 page를 보고 있는 것으로 간주

		// page에 해당하는 와인들 목록 구하기
		int start = (page - 1) * wineService.LIMIT;
		List<WineSearchList> list = wineService.getWineSearchListByCondition(start, keyword, types, countries, alcohol, sweetness, acidity, body, tanin, price);

		int resultCount = list.size();

		int startPage = 1;
		int endPage = 9;
		if (page >= 5) {
			startPage = page - 4;
			endPage = page + 4;
		}

		if (page > pageCount - 4) {
			startPage = pageCount - 8;
			endPage = pageCount;
		}

		model.addAttribute("page", page);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("list", list);
		model.addAttribute("pageCount", pageCount);

		return "wine/wineList";
	}

	@GetMapping(path = "/wine/details/{wine21Code}") // 와인 정보 상세보기
	public String viewWine(@PathVariable("wine21Code") int wine21Code, ModelMap model) {
		Wine wine = wineService.getWine(wine21Code);
		System.out.println(wine);
		model.addAttribute("wine", wine);

		return "wine/wineDetails";
	}

	@RequestMapping(value = "/chatting") // 플라스크 웹소켓 서버 기반 채팅
	public String chatting(HttpServletRequest request) throws Exception {
		return "chatting/chatting";
	}

	
	@RequestMapping(value = "/chatbot") // 유저의 정보를 받아 세션에 값을 저장하고, 회원으로 등록 요청
	public String chatbot(HttpServletRequest request) throws Exception {
		return "chatting/chatbot";
	}
}