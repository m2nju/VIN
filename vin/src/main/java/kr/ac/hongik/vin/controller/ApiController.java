package kr.ac.hongik.vin.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.ac.hongik.vin.wine.dao.WineDao;
import kr.ac.hongik.vin.wine.dto.Wine;
import kr.ac.hongik.vin.wine.dto.WineCodeAndNames;

public class ApiController {

	@Autowired
	WineDao wineDao;
	
	
	@RequestMapping(value = "/wines")
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

	@RequestMapping(value = "/wineCodeAndNames")
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

	@RequestMapping(value = "/getWineByCode")
	public void getWineByCode(@RequestParam(name = "wine21Code", required = false, defaultValue = "0") int wine21Code,
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
}
