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

<style>
/* Customize the label (the container) */
.container {
	display: block;
	position: relative;
	padding-left: 35px;
	margin-bottom: 12px;
	cursor: pointer;
	font-size: 22px;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
}

/* Hide the browser's default checkbox */
.container input {
	
	opacity: 0;
	cursor: pointer;
	height: 0;
	width: 0;
}

/* Create a custom checkbox */
.checkmark {
	position: absolute;
	top: 0;
	left: 0;
	height: 25px;
	width: 25px;
	background-color: #eee;
}

/* On mouse-over, add a grey background color */
.container:hover input ~ .checkmark {
	background-color: #ccc;
}

/* When the checkbox is checked, add a blue background */
.container input:checked ~ .checkmark {
	background-color: #2196F3;
}

/* Create the checkmark/indicator (hidden when not checked) */
.checkmark:after {
	content: "";
	position: absolute;
	display: none;
}

/* Show the checkmark when checked */
.container input:checked ~ .checkmark:after {
	display: block;
}

/* Style the checkmark/indicator */
.container .checkmark:after {
	left: 9px;
	top: 5px;
	width: 5px;
	height: 10px;
	border: solid white;
	border-width: 0 3px 3px 0;
	-webkit-transform: rotate(45deg);
	-ms-transform: rotate(45deg);
	transform: rotate(45deg);
}
</style>
</head>
<body>
	<br>
	<div id="searchMenu" class="navbar-nav">
		<div>
			<form id="keyword" action="javascript:searchKeyword();"
				accept-charset="utf-8" method="GET">
				<input type="text" placeholder="검색어 입력" name="keywordInput"
					id="keywordInput"> <input type="submit" value="검색" />
			</form>
		</div>
		
		<div>
			<form id="types">
				<label class="container" style="width: 15% !important; display: inline-block !important;">레드 
					<input type="checkbox" checked="checked" onclick="typesChanged(this.form)" name="red" value="red"> 
					<span class="checkmark"></span>
				</label> 
				<label class="container" style="width: 15% !important; display: inline-block !important;">화이트 
					<input type="checkbox" checked="checked" onclick="typesChanged(this.form)" name="white" value="white"> 
					<span class="checkmark"></span>
				</label> 
				<label class="container" style="width: 15% !important; display: inline-block !important;">스파클링 
					<input type="checkbox" checked="checked" onclick="typesChanged(this.form)" name="sparkling" value="sparkling"> 
					<span class="checkmark"></span>
				</label> 
				<label class="container" style="width: 15% !important; display: inline-block !important;">로제 
					<input type="checkbox" checked="checked" onclick="typesChanged(this.form)" name="rose" value="rose"> 
					<span class="checkmark"></span>
				</label> 
				<label class="container" style="width: 15% !important; display: inline-block !important;">기타 
					<input type="checkbox" checked="checked" onclick="typesChanged(this.form)" name="etc" value="etc"> 
					<span class="checkmark"></span>
				</label>
			</form>
		</div>
		
		<div>
			<form id="countries">
				<label class="container" style="width: 15% !important; display: inline-block !important;">남아프리카 
					<input type="checkbox" checked="checked" onclick="countriesChanged(this.form)" name="ZA" value="ZA"> 
					<span class="checkmark"></span>
				</label> 
				<label class="container" style="width: 15% !important; display: inline-block !important;">뉴질랜드
					<input type="checkbox" checked="checked" onclick="countriesChanged(this.form)" name="NZ" value="NZ"> 
					<span class="checkmark"></span>
				</label> 
				<label class="container" style="width: 15% !important; display: inline-block !important;">독일
					<input type="checkbox" checked="checked" onclick="countriesChanged(this.form)" name="DE" value="DE"> 
					<span class="checkmark"></span>
				</label> 
				<label class="container" style="width: 15% !important; display: inline-block !important;">미국
					<input type="checkbox" checked="checked" onclick="countriesChanged(this.form)" name="US" value="US"> 
					<span class="checkmark"></span>
				</label> 
				<label class="container" style="width: 15% !important; display: inline-block !important;">스페인 
					<input type="checkbox" checked="checked" onclick="countriesChanged(this.form)" name="ES" value="ES"> 
					<span class="checkmark"></span>
				</label>
				<label class="container" style="width: 15% !important; display: inline-block !important;">아르헨티나
					<input type="checkbox" checked="checked" onclick="countriesChanged(this.form)" name="AR" value="AR"> 
					<span class="checkmark"></span>
				</label> 
				<label class="container" style="width: 15% !important; display: inline-block !important;">오스트리아
					<input type="checkbox" checked="checked" onclick="countriesChanged(this.form)" name="AT" value="AT"> 
					<span class="checkmark"></span>
				</label> 
				<label class="container" style="width: 15% !important; display: inline-block !important;">이탈리아
					<input type="checkbox" checked="checked" onclick="countriesChanged(this.form)" name="IT" value="IT"> 
					<span class="checkmark"></span>
				</label> 
				<label class="container" style="width: 15% !important; display: inline-block !important;">일본
					<input type="checkbox" checked="checked" onclick="countriesChanged(this.form)" name="JP" value="JP"> 
					<span class="checkmark"></span>
				</label> 
				<label class="container" style="width: 15% !important; display: inline-block !important;">칠레
					<input type="checkbox" checked="checked" onclick="countriesChanged(this.form)" name="CL" value="CL"> 
					<span class="checkmark"></span>
				</label>
				<label class="container" style="width: 15% !important; display: inline-block !important;">캐나다
					<input type="checkbox" checked="checked" onclick="countriesChanged(this.form)" name="CA" value="CA"> 
					<span class="checkmark"></span>
				</label> 
				<label class="container" style="width: 15% !important; display: inline-block !important;">포루투갈
					<input type="checkbox" checked="checked" onclick="countriesChanged(this.form)" name="PT" value="PT"> 
					<span class="checkmark"></span>
				</label> 
				<label class="container" style="width: 15% !important; display: inline-block !important;">프랑스
					<input type="checkbox" checked="checked" onclick="countriesChanged(this.form)" name="FR" value="FR"> 
					<span class="checkmark"></span>
				</label> 
				<label class="container" style="width: 15% !important; display: inline-block !important;">헝가리
					<input type="checkbox" checked="checked" onclick="countriesChanged(this.form)" name="HU" value="HU"> 
					<span class="checkmark"></span>
				</label> 
				<label class="container" style="width: 15% !important; display: inline-block !important;">호주
					<input type="checkbox" checked="checked" onclick="countriesChanged(this.form)" name="AU" value="AU"> 
					<span class="checkmark"></span>
				</label>
			</form>
		</div>




		<!-- 가격 최소값 최대값 슬라이더 -->
		<div style="display: block">
			<form id="alcohol">
				<div data-role="rangeslider"  >
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
						data-popup-enabled="true" data-show-value="true" onchange="sweetnessValueChanged()"> <label for="maxPrice">당도:</label>
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
						onchange="acidityValueChanged()"> <label for="maxPrice">산미:</label>
					<input type="range" name="maxAcidity" id="maxAcidity" min="0"
						max="5" value="4" data-popup-enabled="true" data-show-value="true"
						onchange="acidityValueChanged()">
				</div>
			</form>
			<form id="body">
				<div data-role="rangeslider">
					<label for="minBody">바디:</label> <input type="range" name="minBody"
						id="minBody" min="0" max="5" value="1" data-popup-enabled="true"
						data-show-value="true" onchange="bodyValueChanged()"> <label
						for="maxBody">바디:</label> <input type="range" name="maxBody"
						id="maxBody" min="0" max="5" value="4" data-popup-enabled="true"
						data-show-value="true" onchange="bodyValueChanged()">
				</div>
			</form>
			<form id="tanin">
				<div data-role="rangeslider">
					<label for="minTanin">타닌:</label> <input type="range"
						name="minTanin" id="minTanin" min="0" max="5" value="1"
						data-popup-enabled="true" data-show-value="true"
						onchange="taninValueChanged()"> <label for="maxTanin">타닌:</label>
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
						onchange="priceValueChanged()"> <label for="maxPrice">가격:</label>
					<input type="range" name="maxPrice" id="maxPrice" min="0"
						max="1000000" value="200000" data-popup-enabled="true"
						data-show-value="true" onchange="priceValueChanged()">
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
var keywordInput = "";
var typesInput = "";
var countriesInput = "";
var alcoholInput = "";
var sweetnessInput = "";
var acidityInput = "";
var bodyInput = "";
var taninInput = "";
var priceInput = "";


var div = document.querySelector('#divResults');

$.ajax({
	//type: "GET",
	url : "/vin/api/wine/search",		// 로컬 WAS에서 돌릴 때
	//url: "/api/wine/search",			// 원격에서 돌릴 때
	data: { 
		page: pageNum,
		keyword: keywordInput,
		types: typesInput,
		countries: countriesInput,
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
                + '</td><td> ' + obj[i].countries
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
	
function searchKeyword(){		// 카테고리 조건이 변경되면 화면을 새로 갱신
 	console.log("searchKeyword");
	pageNum = 1;
	keywordInput = $('#keywordInput').val();
	//('#divResults').html(); 
	$.ajax({
		url : "/vin/api/wine/search",	// 로컬에서 돌릴 떄
		//url : "/api/wine/search",	// 원격 WAS에서 돌릴 때
		type : "GET",
		cache : false,
		dataType: 'json',
		data: { 
			page: pageNum,
			keyword: keywordInput,
			types: typesInput,
			countries: countriesInput,
			alcohol: alcoholInput,
			sweetness: sweetnessInput,
			acidity: acidityInput,
			body: bodyInput,
			tanin: taninInput,
			price: priceInput,
		},
		success : function(obj){
			$('#addbtn').remove();//remove btn
			var content="";
			console.log("keyword");
			console.log(keywordInput);
			console.log("keyword2");  
			content = '<table>';
		    content += '<tr></tr><th style="background-color: #eeeeee; text-align: center;">와인코드</th><th style="background-color: #eeeeee; text-align: center;">와인라벨사진</th><th style="background-color: #eeeeee; text-align: center;">한글이름</th><th style="background-color: #eeeeee; text-align: center;">영어이름</th><th style="background-color: #eeeeee; text-align: center;">와이너리</th><th style="background-color: #eeeeee; text-align: center;">국가</th><th style="background-color: #eeeeee; text-align: center;">지역</th><th style="background-color: #eeeeee; text-align: center;">품종</th><th style="background-color: #eeeeee; text-align: center;">빈티지</th><th style="background-color: #eeeeee; text-align: center;">용량</th><th style="background-color: #eeeeee; text-align: center;">타입</th><th style="background-color: #eeeeee; text-align: center;">가격</th>';
			for (var i = 0; i < obj.length; i++) {
				content += '<tr><td>' + obj[i].wine21Code
            		+ '</td><td> ' + '<img src="https://s3.ap-northeast-2.amazonaws.com/vin-image/' + obj[i].wine21Code + '.jpg" width="175">'
                    + '</td><td> ' + '<a href = "/vin/wine/details/' + obj[i].wine21Code + '">' + obj[i].koreanName
                    + '</td><td> ' + obj[i].englishName
                    + '</td><td> ' + obj[i].winary
                    + '</td><td> ' + obj[i].countries
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
	
	
 function refreshSearchListByCondition(){		// 카테고리 조건이 변경되면 화면을 새로 갱신
	 	console.log("리프레시 컨디션");
	 	//console.log(typesInput);
		pageNum = 1;
		keywordInput = $('#keywordInput').val();
		//('#divResults').html(); 
		$.ajax({
			url : "/vin/api/wine/search",	// 로컬에서 돌릴 떄
			//url : "/api/wine/search",	// 원격 WAS에서 돌릴 때
			type : "GET",
			cache : false,
			dataType: 'json',
			data: { 
				page: pageNum,
				keyword: keywordInput,
				types: typesInput,
				countries: countriesInput,
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
				content = '<table>';
			    content += '<tr></tr><th style="background-color: #eeeeee; text-align: center;">와인코드</th><th style="background-color: #eeeeee; text-align: center;">와인라벨사진</th><th style="background-color: #eeeeee; text-align: center;">한글이름</th><th style="background-color: #eeeeee; text-align: center;">영어이름</th><th style="background-color: #eeeeee; text-align: center;">와이너리</th><th style="background-color: #eeeeee; text-align: center;">국가</th><th style="background-color: #eeeeee; text-align: center;">지역</th><th style="background-color: #eeeeee; text-align: center;">품종</th><th style="background-color: #eeeeee; text-align: center;">빈티지</th><th style="background-color: #eeeeee; text-align: center;">용량</th><th style="background-color: #eeeeee; text-align: center;">타입</th><th style="background-color: #eeeeee; text-align: center;">가격</th>';
				for (var i = 0; i < obj.length; i++) {
					content += '<tr><td>' + obj[i].wine21Code
	            		+ '</td><td> ' + '<img src="https://s3.ap-northeast-2.amazonaws.com/vin-image/' + obj[i].wine21Code + '.jpg" width="175">'
	                    + '</td><td> ' + '<a href = "/vin/wine/details/' + obj[i].wine21Code + '">' + obj[i].koreanName
	                    + '</td><td> ' + obj[i].englishName
	                    + '</td><td> ' + obj[i].winary
	                    + '</td><td> ' + obj[i].countries
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
		keywordInput = $('#keywordInput').val();
		$.ajax({
			url : "/vin/api/wine/search",	// 로컬에서 돌릴 때
			//url : "/api/wine/search",		// 원격 WAS에서 돌릴 떄
			type : "GET",
			cache : false,
			dataType: 'json',
			data: { 
				page: pageNum,
				keyword: keywordInput,
				types: typesInput,
				countries: countriesInput,
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
	                    + '</td><td> ' + obj[i].countries
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
    
	function typesChanged(form)

	   {
	        var typesCheckbox = [];

	        if (form.red.checked)
	        	typesCheckbox.push(form.red.value);
	        if (form.white.checked)
	        	typesCheckbox.push(form.white.value);
	        if (form.sparkling.checked)
	        	typesCheckbox.push(form.sparkling.value);
	        if (form.rose.checked)
	        	typesCheckbox.push(form.rose.value);
	        if (form.etc.checked)
	        	typesCheckbox.push(form.etc.value);
	        
	     	
			
	        //typesInput = typesCheckbox.slice(0, -1);
	        typesInput = typesCheckbox.toString();
	        console.log(typesInput);
	        refreshSearchListByCondition();
	   }
	
	function countriesChanged(form)

	   {
	        var countriesCheckbox = [];

	        if (form.ZA.checked)
	        	countriesCheckbox.push(form.ZA.value);
	        if (form.NZ.checked)
	        	countriesCheckbox.push(form.NZ.value);
	        if (form.DE.checked)
	        	countriesCheckbox.push(form.DE.value);
	        if (form.US.checked)
	        	countriesCheckbox.push(form.US.value);
	        if (form.ES.checked)
	        	countriesCheckbox.push(form.ES.value);
	        if (form.AR.checked)
	        	countriesCheckbox.push(form.AR.value);
	        if (form.AT.checked)
	        	countriesCheckbox.push(form.AT.value);
	        if (form.IT.checked)
	        	countriesCheckbox.push(form.IT.value);
	        if (form.JP.checked)
	        	countriesCheckbox.push(form.JP.value);
	        if (form.CL.checked)
	        	countriesCheckbox.push(form.CL.value);
	        if (form.CA.checked)
	        	countriesCheckbox.push(form.CA.value);
	        if (form.PT.checked)
	        	countriesCheckbox.push(form.PT.value);
	        if (form.FR.checked)
	        	countriesCheckbox.push(form.FR.value);
	        if (form.HU.checked)
	        	countriesCheckbox.push(form.HU.value);
	        if (form.AU.checked)
	        	countriesCheckbox.push(form.AU.value);
	        
	        
	     	
			
	        //countriesInput = typesCheckbox.slice(0, -1);
	        countriesInput = countriesCheckbox.toString();
	        console.log(countriesInput);
	        refreshSearchListByCondition();
	   }
	
	
	var minAlcohol;
	var maxAlcohol;
	function alcoholValueChanged() {
		var minAlcohol = $('#minAlcohol').val();
		var maxAlcohol = $('#maxAlcohol').val();
		if(maxAlcohol == 25){
			maxAlcohol = 100;
		}
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
		if (maxPrice == 1000000){
			maxPrice = 10000000;
		}
		console.log(minPrice, maxPrice);	
		priceInput = [minPrice,maxPrice].toString();
		console.log(priceInput);
		refreshSearchListByCondition();
	};

	var searchMenu = document.querySelector("#searchMenu");
	searchMenu.addEventListener("change", function(evt) {
		refreshSearchListByCondition();
		//sendAjax("hello");
	}	)
</script>

<script
	src="https://demos.jquerymobile.com/1.4.2/js/jquery.mobile-1.4.2.min.js"></script>
</html>