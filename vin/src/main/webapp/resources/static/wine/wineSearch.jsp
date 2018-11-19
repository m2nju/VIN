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
	<br>
	<div id="searchMenu" class="navbar-nav">
		<div>
			<form id="keyword" action="./search" accept-charset="utf-8"
				method="GET">
				<input type="text" placeholder="검색어 입력" name="keyword"> <input
					type="submit" value="검색" />
			</form>
		</div>


		<!-- 가격 최소값 최대값 슬라이더 -->
		<div>
			<form id="alcohol">
				<div data-role="rangeslider">
					<label for="minAlcohol">알콜도수:</label> <input type="range"
						name="minAlcohol" id="minAlcohol" min="0" max="25" value="10"
						data-popup-enabled="true" data-show-value="true"
						onchange=alcoholValueChanged()> <label for="maxAlcohol">알콜도수:</label>
					<input type="range" name="maxAlcohol" id="maxAlcohol" min="0"
						max="25" value="18" data-popup-enabled="true"
						data-show-value="true" onchange=alcoholValueChanged()>
				</div>
			</form>
			<form id="sweetness">
				<div data-role="rangeslider">
					<label for="minSweetness">당도:</label> <input type="range"
						name="minSweetness" id="minSweetness" min="0" max="5" value="1"
						data-popup-enabled="true" data-show-value="true"
						onchange=sweetnessValueChanged()> <label for="maxPrice">당도:</label>
					<input type="range" name="maxSweetness" id="maxSweetness" min="0"
						max="5" value="4" data-popup-enabled="true" data-show-value="true"
						onchange=sweetnessValueChanged()>
				</div>
			</form>
			<form id="acidity">
				<div data-role="rangeslider">
					<label for="minAcidity">산미:</label> <input type="range"
						name="minAcidity" id="minAcidity" min="0" max="5" value="1"
						data-popup-enabled="true" data-show-value="true"
						onchange=acidityValueChanged()> <label for="maxPrice">산미:</label>
					<input type="range" name="maxAcidity" id="maxAcidity" min="0"
						max="5" value="4" data-popup-enabled="true" data-show-value="true"
						onchange=acidityValueChanged()>
				</div>
			</form>
			<form id="body">
				<div data-role="rangeslider">
					<label for="minBody">바디:</label> <input type="range" name="minBody"
						id="minBody" min="0" max="5" value="1" data-popup-enabled="true"
						data-show-value="true" onchange=bodyValueChanged()> <label
						for="maxBody">바디:</label> <input type="range" name="maxBody"
						id="maxBody" min="0" max="5" value="4" data-popup-enabled="true"
						data-show-value="true" onchange=bodyValueChanged()>
				</div>
			</form>
			<form id="tanin">
				<div data-role="rangeslider">
					<label for="minTanin">타닌:</label> <input type="range"
						name="minTanin" id="minTanin" min="0" max="5" value="1"
						data-popup-enabled="true" data-show-value="true"
						onchange=taninValueChanged()> <label for="maxTanin">타닌:</label>
					<input type="range" name="maxAcidity" id="maxTanin" min="0" max="5"
						value="4" data-popup-enabled="true" data-show-value="true"
						onchange=taninValueChanged()>
				</div>
			</form>
			<form id="price">
				<div data-role="rangeslider">
					<label for="minPrice">가격:</label> <input type="range"
						name="minPrice" id="minPrice" min="0" max="1000000" value="10000"
						data-popup-enabled="true" data-show-value="true"
						onchange=priceValueChanged()> <label for="maxPrice">가격:</label>
					<input type="range" name="maxPrice" id="maxPrice" min="0"
						max="1000000" value="200000" data-popup-enabled="true"
						data-show-value="true" onchange=priceValueChanged()>
				</div>
			</form>
		</div>
	</div>

	<div id="divResults"></div>
	<tr id='addbtn'>
		<td colspan="5">
			<div class="btns">
				<a href="javascript:moreList();" class="btn btn-primary">더보기</a>
			</div>
		</td>
	</tr>

</body>
<script src="https://demos.jquerymobile.com/1.4.2/js/jquery.js"></script>

<!-- 슬라이더의 최소값 최대값을 받아 처리 -->
<script>
var html = "";

var pageNum = 1;	// 기본 페이지는 1
var typeInput = "";
var countryInput = "";
var keywordInput = "";
var alcoholInput = "";
var sweetnessInput = "";
var acidityInput = "";
var bodyInput = "";
var taninInput = "";
var priceInput = "";


var div = document.querySelector('#divResults');

$.ajax({
	type: "GET",
	url: "/vin/api/wine/search",
	data: { 
		page: pageNum,
		type: typeInput,
		country: countryInput,
		keyword: keywordInput,
		alcohol: alcoholInput,
		sweetness: sweetnessInput,
		acidity: acidityInput,
		body: bodyInput,
		tanin: taninInput,
		price: priceInput,
		},
	dataType : "json",
	
	success : function(obj) {
		showWineTable(obj);
    },
    complete : function(xhr,status) {
    
    },
    error : function(xhr, status, error) {
        console.log(error);
    }	
}) 

function showWineTable(obj) {		// 맨 처음에 api를 받아와 테이블로 만들어줌
    
    console.log(obj);
    html = '<table>';
    html += '<tr></tr><th style="background-color: #eeeeee; text-align: center;">와인코드</th><th style="background-color: #eeeeee; text-align: center;">와인라벨사진</th><th style="background-color: #eeeeee; text-align: center;">한글이름</th><th style="background-color: #eeeeee; text-align: center;">영어이름</th><th style="background-color: #eeeeee; text-align: center;">와이너리</th><th style="background-color: #eeeeee; text-align: center;">국가</th><th style="background-color: #eeeeee; text-align: center;">지역</th><th style="background-color: #eeeeee; text-align: center;">품종</th><th style="background-color: #eeeeee; text-align: center;">빈티지</th><th style="background-color: #eeeeee; text-align: center;">용량</th><th style="background-color: #eeeeee; text-align: center;">타입</th><th style="background-color: #eeeeee; text-align: center;">가격</th>';
    console.log("obj를 테이블 폼에 맞게 변형 후 출력");
    for (var i = 0; i < obj.length; i++) {
       html += '<tr><td>' + obj[i].wine21Code
        		+ '</td><td> ' + '<img src="https://s3.ap-northeast-2.amazonaws.com/vin-image/' + obj[i].wine21Code + '.jpg" width="175">'
                + '</td><td> ' + '<a href = "/vin/wine/details/' + obj[i].wine21Code + '">' + obj[i].koreanName
                + '</td><td> ' + obj[i].englishName
                + '</td><td> ' + obj[i].winary
                + '</td><td> ' + obj[i].country
                + '</td><td> ' + obj[i].region
                + '</td><td> ' + obj[i].grapeVariety
                + '</td><td> ' + obj[i].vintage
                + '</td><td> ' + obj[i].capacity
                + '</td><td> ' + obj[i].type
                + '</td><td> ' + obj[i].price + '</td></tr>';
    }
    html += '</table>';

    //console.log("전" + html);
    div.innerHTML = html;
    //console.log("후" + html);
}
	
 function refreshSearchListByCondition(){		// 카테고리 조건이 변경되면 화면을 새로 갱신
	 	console.log("리프레시 컨디션");
		pageNum = 1;
		//('#divResults').html(); 
		$.ajax({
			url : "/vin/api/wine/search",
			type : "GET",
			cache : false,
			dataType: 'json',
			data: { 
				page: pageNum,
				type: typeInput,
				country: countryInput,
				keyword: keywordInput,
				alcohol: alcoholInput,
				sweetness: sweetnessInput,
				acidity: acidityInput,
				body: bodyInput,
				tanin: taninInput,
				price: priceInput,
			},
			//data : "conectType="+conectType +"&eDate="+eDate+"&sDate="+sDate+"&codeId="+codeId+"&limit="+limit,
			success : function(obj){
			//console.log(data);
				$('#addbtn').remove();//remove btn
				var content="";
				console.log("price 조건 변경");
				console.log(priceInput);
				console.log("price 조건 변경2");  
				content = '<table>';
			    content += '<tr></tr><th style="background-color: #eeeeee; text-align: center;">와인코드</th><th style="background-color: #eeeeee; text-align: center;">와인라벨사진</th><th style="background-color: #eeeeee; text-align: center;">한글이름</th><th style="background-color: #eeeeee; text-align: center;">영어이름</th><th style="background-color: #eeeeee; text-align: center;">와이너리</th><th style="background-color: #eeeeee; text-align: center;">국가</th><th style="background-color: #eeeeee; text-align: center;">지역</th><th style="background-color: #eeeeee; text-align: center;">품종</th><th style="background-color: #eeeeee; text-align: center;">빈티지</th><th style="background-color: #eeeeee; text-align: center;">용량</th><th style="background-color: #eeeeee; text-align: center;">타입</th><th style="background-color: #eeeeee; text-align: center;">가격</th>';
				for (var i = 0; i < obj.length; i++) {
					content += '<tr><td>' + obj[i].wine21Code
	            		+ '</td><td> ' + '<img src="https://s3.ap-northeast-2.amazonaws.com/vin-image/' + obj[i].wine21Code + '.jpg" width="175">'
	                    + '</td><td> ' + '<a href = "/vin/wine/details/' + obj[i].wine21Code + '">' + obj[i].koreanName
	                    + '</td><td> ' + obj[i].englishName
	                    + '</td><td> ' + obj[i].winary
	                    + '</td><td> ' + obj[i].country
	                    + '</td><td> ' + obj[i].region
	                    + '</td><td> ' + obj[i].grapeVariety
	                    + '</td><td> ' + obj[i].vintage
	                    + '</td><td> ' + obj[i].capacity
	                    + '</td><td> ' + obj[i].type
	                    + '</td><td> ' + obj[i].price + '</td></tr>'
				}
				//content+="<tr id='addbtn'><td colspan='5'><div class='btns'><a href='javascript:moreList();' class='btn'>더보기</a></div>  </td></tr>";
				$('#addbtn').remove();//remove btn
				//$(content).appendTo("#divResults");
				div.innerHTML = content;
			}, error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	};
 
 
	function moreList(){
		pageNum = pageNum + 1;
		$.ajax({
			url : "/vin/api/wine/search",
			type : "GET",
			cache : false,
			dataType: 'json',
			data: { 
				page: pageNum,
				type: typeInput,
				country: countryInput,
				keyword: keywordInput,
				alcohol: alcoholInput,
				sweetness: sweetnessInput,
				acidity: acidityInput,
				body: bodyInput,
				tanin: taninInput,
				price: priceInput,
			},
			//data : "conectType="+conectType +"&eDate="+eDate+"&sDate="+sDate+"&codeId="+codeId+"&limit="+limit,
			success : function(obj){
			//console.log(data);
				$('#addbtn').remove();//remove btn
				var content="";
				console.log("obj를 테이블 폼에 맞게 변형 후 출력");
				content = '<table>';
			    //content += '<tr></tr><th style="background-color: #eeeeee; text-align: center;">와인코드</th><th style="background-color: #eeeeee; text-align: center;">와인라벨사진</th><th style="background-color: #eeeeee; text-align: center;">한글이름</th><th style="background-color: #eeeeee; text-align: center;">영어이름</th><th style="background-color: #eeeeee; text-align: center;">와이너리</th><th style="background-color: #eeeeee; text-align: center;">국가</th><th style="background-color: #eeeeee; text-align: center;">지역</th><th style="background-color: #eeeeee; text-align: center;">품종</th><th style="background-color: #eeeeee; text-align: center;">빈티지</th><th style="background-color: #eeeeee; text-align: center;">용량</th><th style="background-color: #eeeeee; text-align: center;">타입</th><th style="background-color: #eeeeee; text-align: center;">가격</th>';
				
				for (var i = 0; i < obj.length; i++) {
					content += '<tr><td>' + obj[i].wine21Code
	            		+ '</td><td> ' + '<img src="https://s3.ap-northeast-2.amazonaws.com/vin-image/' + obj[i].wine21Code + '.jpg" width="175">'
	                    + '</td><td> ' + '<a href = "/vin/wine/details/' + obj[i].wine21Code + '">' + obj[i].koreanName
	                    + '</td><td> ' + obj[i].englishName
	                    + '</td><td> ' + obj[i].winary
	                    + '</td><td> ' + obj[i].country
	                    + '</td><td> ' + obj[i].region
	                    + '</td><td> ' + obj[i].grapeVariety
	                    + '</td><td> ' + obj[i].vintage
	                    + '</td><td> ' + obj[i].capacity
	                    + '</td><td> ' + obj[i].type
	                    + '</td><td> ' + obj[i].price + '</td></tr>'
					}
				//content+="<tr id='addbtn'><td colspan='5'><div class='btns'><a href='javascript:moreList();' class='btn'>더보기</a></div>  </td></tr>";
				$('#addbtn').remove();//remove btn
				$(content).appendTo("#divResults");
			}, error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	};
    

	var minAlcohol;
	var maxAlcohol;
	function alcoholValueChanged() {
		var minAlcohol = $('#minAlcohol').val();
		var maxAlcohol = $('#maxAlcohol').val();
		
		console.log(minAlcohol, maxAlcohol);
		alcoholInput = [minAlcohol, maxAlcohol].toString();
		console.log(alcoholInput);
		refreshSearchListByCondition();
	};
	
	var minSweetness;
	var maxSweetness;
	function sweetnessValueChanged() {
		var minSweetness = $('#minSweetness').val();
		var maxSweetness = $('#maxSweetness').val();
		
		console.log(minSweetness, maxSweetness);
		sweetnessInput = [minSweetness, maxSweetness].toString();
		console.log(sweetnessInput);
		refreshSearchListByCondition();
	};
	
	var minAcidity;
	var maxAcidity;
	function acidityValueChanged() {
		var minAcidity = $('#minAcidity').val();
		var maxAcidity = $('#maxAcidity').val();
		
		console.log(minAcidity, maxAcidity);
		acidityInput = [minAcidity, maxAcidity].toString();
		console.log(acidityInput);
		refreshSearchListByCondition();
		
	};
	var minBody;
	var maxBody;
	function bodyValueChanged() {
		var minBody = $('#minBody').val();
		var maxBody = $('#maxBody').val();
		
		console.log(minBody, maxBody);
		bodyInput = [minBody, maxBody].toString();
		console.log(bodyInput);
		refreshSearchListByCondition();
	};
	
	var minTanin;
	var maxTanin;
	function taninValueChanged() {
		var minTanin = $('#minTanin').val();
		var maxTanin = $('#maxTanin').val();
		
		console.log(minTanin, maxTanin);
		taninInput = [minTanin, maxTanin].toString();
		console.log(taninInput);
		refreshSearchListByCondition();
	};

	var minPrice;
	var maxPrice;
	function priceValueChanged() {
		var minPrice = $('#minPrice').val();
		var maxPrice = $('#maxPrice').val();
		
		console.log(minPrice, maxPrice);	
		priceInput = [minPrice,maxPrice].toString();
		console.log(priceInput);
		refreshSearchListByCondition();
	}

	var searchMenu = document.querySelector("#searchMenu");
	searchMenu.addEventListener("change", function(evt) {
		refreshSearchListByCondition();
		//sendAjax("hello");
	});
</script>

<script
	src="https://demos.jquerymobile.com/1.4.2/js/jquery.mobile-1.4.2.min.js"></script>
</html>