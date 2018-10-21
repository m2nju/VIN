package kr.ac.hongik.vin.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLConnection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.ac.hongik.vin.user.dto.User;
import kr.ac.hongik.vin.user.service.UserService;
import kr.ac.hongik.vin.wine.dao.WineDao;
import kr.ac.hongik.vin.wine.dto.Wine;
import kr.ac.hongik.vin.wine.dto.WineCodeAndNames;
import kr.ac.hongik.vin.wine.dto.WineSearchList;
import kr.ac.hongik.vin.wine.service.WineService;

@Controller
public class MainController {

	@Autowired
	UserService userService;

	@Autowired
	WineService wineService;


	@RequestMapping(path = "/registUser")
	public String write(@ModelAttribute User user, HttpServletRequest request) {
		String clientIp = request.getRemoteAddr();
		System.out.println("clientIp : " + clientIp);
		userService.registUser(user);

		return "redirect:/"; // 해당 path로 리다이렉트 한다.
	}

	@RequestMapping(value = "/naverLogin")
	public String naverLogin(HttpSession session) {
		return "naver/naverlogin";
	}

	@RequestMapping(value = "/callBack")
	public String callBack(HttpServletRequest request) throws Exception {
		// System.out.println("Controller에서 callBack 호출");
		return "naver/callback";
	}

	@RequestMapping(value = "/userInfo")
	public String userInformation(HttpServletRequest request) throws Exception {
		return "naver/userinfo";
	}

	@RequestMapping(value = "/logout")
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

	@GetMapping(path = "/wineSearch")
	public String list(@RequestParam(name = "start", required = false, defaultValue = "0") int start, ModelMap model) {
		// start로 시작하는 방명록 목록 구하기
		List<WineSearchList> list = wineService.getWineSearchList(start);

		// 전체 페이지수 구하기
		int count = wineService.getCount();
		int pageCount = count / WineService.LIMIT;
		if (count % wineService.LIMIT > 0)
			pageCount++;

		// 페이지 수만큼 start의 값을 리스트로 저장
		// 예를 들어 LIMIT가 15, 페이지수가 3이면
		// 0, 15, 30 이렇게 저장된다.
		// wineSearch?start=0 , wineSearch?start=5, wineSearch?start=10 으로 링크가 걸린다.
		List<Integer> pageStartList = new ArrayList<>();
		for (int i = 0; i < pageCount; i++) {
			pageStartList.add(i * wineService.LIMIT);
		}

		model.addAttribute("list", list);
		model.addAttribute("count", count);
		model.addAttribute("pageStartList", pageStartList);
		
		
		int i = 0;
		while (i < list.size()) {
			System.out.println(list.get(i));	// 읽어온 WineSearchList 클래스를 출력해봄.
			i++;
		}

		return "wine/wineList";
	}
}