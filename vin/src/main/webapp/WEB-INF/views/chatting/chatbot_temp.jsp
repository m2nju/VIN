<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.springframework.context.ConfigurableApplicationContext"%>
<%@page import="kr.ac.hongik.vin.user.dto.User"%>
<%@page import="kr.ac.hongik.vin.config.ApplicationConfig"%>
<%@page import="org.springframework.context.annotation.AnnotationConfigApplicationContext"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="kr.ac.hongik.vin.user.service.UserService"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page import="org.json.*"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.io.UnsupportedEncodingException"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="java.net.URLEncoder"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		//System.out.println("userinfo.jsp 호출");
			//String access_token = (String) session.getAttribute("access_token"); // 네이버 엑세스 토큰
			//String refresh_token = (String) session.getAttribute("refresh_token"); // 리프레시 토큰	

			//String header = "Bearer " + access_token; // Bearer 다음에 공백 추가
			try {
		//String apiURL = "https://openapi.naver.com/v1/nid/me";
		String apiURL = "http://viniswine.tk:5001?input_text=";
		apiURL += URLEncoder.encode("프랑스 와인 추천해줘", "UTF-8");
		URL url = new URL(apiURL);
		System.out.println("url 생성 완료");
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		System.out.println("con 생성 완료");
		System.out.println("connection method 설정 완료");
		con.setRequestMethod("GET");
		//con.setRequestProperty("Authorization", header);
			int responseCode = con.getResponseCode();
			System.out.println("code : " + con.getResponseCode());

			BufferedReader br;
			if (responseCode == 200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
				System.out.println("responseCode는 200입니다.");
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer response1 = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				response1.append(inputLine);
			}
			br.close();
			out.println(response1.toString()); // 챗봇으로부터 받은 데이터를 출력해주는 메소드(json으로 찍힘)

			JSONParser parser = new JSONParser();
			Object obj = parser.parse(response1.toString());
			// response1에 저장된 json형식의 String을 파싱하여 object로
			JSONObject jsonObj = (JSONObject) obj; // jsonObj는 전체 json 오브젝트 
			//String response2 = jsonObj.get("response").toString();
			// 전체 json에서 response만 받아와서 String으로

			//JSONParser parser2 = new JSONParser();
			//Object obj2 = parser2.parse(response2); // obj는 response 오브젝트
			//JSONObject jsonObj2 = (JSONObject) obj2; // 다시 그대로 반복하여 json 오브젝트로
			String resultCode = jsonObj.get("resultcode").toString();
			String message = jsonObj.get("message").toString();
			String responseRecommend = jsonObj.get("response").toString();
			//out.println(resultCode + message + responseRecommend);
			//out.println(responseRecommend);
			/*
			id = jsonObj2.get("id").toString();
			nickname = jsonObj2.get("nickname").toString();
			email = jsonObj2.get("email").toString();
			name = jsonObj2.get("name").toString();
			birthday = jsonObj2.get("birthday").toString();
			age = Integer.parseInt(jsonObj2.get("age").toString().substring(0, 1));
			if (jsonObj2.get("gender").toString().equals("M")) {
				is_man = true;
			} else if (jsonObj2.get("gender").toString().equals("W")) {
				is_man = false;
			}
			int defaultGrade = 2;
			
			ApplicationContext ac = new AnnotationConfigApplicationContext(ApplicationConfig.class);
			 */
		} catch (Exception e) {
			System.out.println(e);
		}
	%>
</body>
</html>