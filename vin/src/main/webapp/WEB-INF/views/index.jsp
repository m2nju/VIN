<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% 
	if(session.getAttribute("userName") != null){
		out.println(session.getAttribute("userName")+" 님 로그인 하셨습니다.");
	%>
		<a href="logout">로그아웃</a>
	<%
	}
	else{
		out.println("인덱스 파일입니다. 로그인이 되어 있지 않습니다.");
	%>
		<a href="naverLogin">로그인</a>
	<%
	}
	%>
	
</body>
</html>