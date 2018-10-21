<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/header.jsp"%>

<!DOCTYPE html>
<html>
<head>

<title>Insert title here</title>

</head>
<body>
	<%
		if (session.getAttribute("userName") != null) {
			out.println(session.getAttribute("userName") + " 님 로그인 하셨습니다.");
	%>
	<a href="logout">로그아웃</a>
	<%
		} else {
			out.println("인덱스 파일입니다. 로그인이 되어 있지 않습니다.");
	%>
	<a href="naverLogin">로그인</a>
	<%
		}
	%>
	<br>
	<h3><a href="wineSearch">와인 검색 화면으로</a></h3>
</body>
</html>