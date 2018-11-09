<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>와인 검색 화면</title>


<link rel="stylesheet"
	href="https://demos.jquerymobile.com/1.4.2/css/themes/default/jquery.mobile-1.4.2.min.css">


</head>
<body>
	<%
		List<String> types = new ArrayList<String>();
		types.add("red");
		types.add("white");
		types.add("sparkling");

		StringBuilder stringBuilder = new StringBuilder();
		for (int i = 0; i < types.size(); i++) {
			stringBuilder.append(types.get(i));
			stringBuilder.append(",");
		}

		stringBuilder.setLength(stringBuilder.length() - 1);
		String typesString = stringBuilder.toString();

		///////////////////////
		stringBuilder.setLength(0); // set length of buffer to 0
		stringBuilder.trimToSize(); // trim the underlying buffer

		List<String> price = new ArrayList<String>();
		price.add("10000");
		price.add("50000");

		for (int i = 0; i < price.size(); i++) {
			stringBuilder.append(price.get(i));
			stringBuilder.append(",");
		}

		stringBuilder.setLength(stringBuilder.length() - 1);
		String priceString = stringBuilder.toString();
	%>

	<br>
	<div>
		<form action="./search" accept-charset="utf-8" method="GET">
		<input type="text" placeholder="검색어 입력" name="keyword">
		<input type ="submit" value="검색"/>
		</form>
	</div>
	
	
	<!-- 가격 최소값 최대값 슬라이더 -->
	<div>
		<form id="alcohol">
			<div data-role="rangeslider">
				<label for="minAlcohol">알콜도수:</label> 
				<input type="range" name="minAlcohol" id="minAlcohol" min="0" max="25" value="10" 
					data-popup-enabled="true" data-show-value="true" onchange=valueChanged()> 
					
				<label for="maxAlcohol">알콜도수:</label>
				<input type="range" name="maxAlcohol" id="maxAlcohol" min="0" max="25" value="18" 
					data-popup-enabled="true" data-show-value="true" onchange=valueChanged()>
			</div>
		</form>
		<form id="sweetness">
			<div data-role="rangeslider">
				<label for="minSweetness">당도:</label> 
				<input type="range" name="minSweetness" id="minSweetness" min="0" max="5" value="1" 
					data-popup-enabled="true" data-show-value="true" onchange=valueChanged()> 
					
				<label for="maxPrice">당도:</label>
				<input type="range" name="maxSweetness" id="maxSweetness" min="0" max="5" value="4" 
					data-popup-enabled="true" data-show-value="true" onchange=valueChanged()>
			</div>
		</form>
		<form id="acidity">
			<div data-role="rangeslider">
				<label for="minAcidity">산미:</label> 
				<input type="range" name="minAcidity" id="minAcidity" min="0" max="5" value="1" 
					data-popup-enabled="true" data-show-value="true" onchange=valueChanged()> 
					
				<label for="maxPrice">산미:</label>
				<input type="range" name="maxAcidity" id="maxAcidity" min="0" max="5" value="4" 
					data-popup-enabled="true" data-show-value="true" onchange=valueChanged()>
			</div>
		</form>
		<form id="body">
			<div data-role="rangeslider">
				<label for="minBody">바디:</label> 
				<input type="range" name="minBody" id="minBody" min="0" max="5" value="1" 
					data-popup-enabled="true" data-show-value="true" onchange=valueChanged()> 
					
				<label for="maxBody">바디:</label>
				<input type="range" name="maxBody" id="maxBody" min="0" max="5" value="4" 
					data-popup-enabled="true" data-show-value="true" onchange=valueChanged()>
			</div>
		</form>
		<form id="tanin">
			<div data-role="rangeslider">
				<label for="minTanin">타닌:</label> 
				<input type="range" name="minTanin" id="minTanin" min="0" max="5" value="1" 
					data-popup-enabled="true" data-show-value="true" onchange=valueChanged()> 
					
				<label for="maxTanin">타닌:</label>
				<input type="range" name="maxAcidity" id="maxTanin" min="0" max="5" value="4" 
					data-popup-enabled="true" data-show-value="true" onchange=valueChanged()>
			</div>
		</form>
		<form id="price">
			<div data-role="rangeslider">
				<label for="minPrice">가격:</label> 
				<input type="range" name="minPrice" id="minPrice" min="0" max="1000000" value="10000" 
					data-popup-enabled="true" data-show-value="true" onchange=valueChanged()> 
					
				<label for="maxPrice">가격:</label>
				<input type="range" name="maxPrice" id="maxPrice" min="0" max="1000000" value="200000" 
					data-popup-enabled="true" data-show-value="true" onchange=valueChanged()>
			</div>
		</form>
	</div>
	<form>
		
	</form>
	
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
						<td><img
							src="https://s3.ap-northeast-2.amazonaws.com/vin-image/${wine.wine21Code}.jpg"
							width="175"></td>
						<td><a href="details/${wine.wine21Code}">${wine.koreanName }</a></td>
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
		
		
		
		
		<!-- 페이지네이션 -->
		<c:if test="${page >= 5}">
			<a href="search?page=${page}"> &lt; </a>&nbsp;&nbsp;
		</c:if>  
		<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
			<a href="search?page=${i}">${i}</a>&nbsp;&nbsp;
		</c:forEach>
		<c:if test="${page <= pageCount - 4}">
			<a href="search?page=${page + 10}"> &gt; </a>&nbsp;&nbsp;
		</c:if> 
	</div>

</body>
<script src="https://demos.jquerymobile.com/1.4.2/js/jquery.js"></script>

<!-- 슬라이더의 최소값 최대값을 받아 처리 -->
<script>
	var minPrice;
	var maxPrice;
	function valueChanged() {
		var minPrice = $('#minPrice').val();
		var maxPrice = $('#maxPrice').val();
		
		console.log(minPrice, maxPrice);
	};
</script>

<script
	src="https://demos.jquerymobile.com/1.4.2/js/jquery.mobile-1.4.2.min.js"></script>
</html>