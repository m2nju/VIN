<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>와인 검색 화면</title>
</head>
<body>
	<br>
	<div>
		<input type="text" placeholder="검색어 입력">
		<button>검색</button>
	</div>
	<div>
		<table class="table table-striped"
			style="text-align: center; border: 1px solid #dddddd;">
			<thead>
				<tr>
					<th style="background-color: #eeeeee; text-align: center;">와인코드</th>
					<th style="background-color: #eeeeee; text-align: center;">와인라벨 사진</th>
					<th style="background-color: #eeeeee; text-align: center;">한글이름</th>
					<th style="background-color: #eeeeee; text-align: center;">영어이름</th>
					<th style="background-color: #eeeeee; text-align: center;">와이너리</th>
					<th style="background-color: #eeeeee; text-align: center;">국가</th>
					<th style="background-color: #eeeeee; text-align: center;">지역</th>
					<th style="background-color: #eeeeee; text-align: center;">품종</th>
					<th style="background-color: #eeeeee; text-align: center;">빈티지</th>
					<th style="background-color: #eeeeee; text-align: center;">용량</th>
					<th style="background-color: #eeeeee; text-align: center;">타입</th>
					<th style="background-color: #eeeeee; text-align: center;">가격</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="wine">
					<tr>
						<td>${wine.wine21Code }</td>
						<td><img src ="https://s3.ap-northeast-2.amazonaws.com/vin-image/${wine.wine21Code}.jpg" width="175"></td>
						<td><a href = "details/${wine.wine21Code}">${wine.koreanName }</a></td>
						<td>${wine.englishName }</td>
						<td>${wine.winary }</td>
						<td>${wine.country }</td>
						<td>${wine.region }</td>
						<td>${wine.grapeVariety }</td>
						<td>${wine.vintage }</td>
						<td>${wine.capacity }</td>
						<td>${wine.type }</td>
						<td>${wine.price }</td>
					</tr>
					
				</c:forEach>
				
			</tbody>
		</table>
		<c:forEach items="${pageStartList}" var="pageIndex" varStatus="status">
			<a href="search?start=${pageIndex}">${status.index +1 }</a>&nbsp;&nbsp; 
		</c:forEach>

	</div>
</body>
</html>