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

	<div id="divResults"  onscroll=scrollEnd();></div>

</body>
<script src="https://demos.jquerymobile.com/1.4.2/js/jquery.js"></script>

<!-- 슬라이더의 최소값 최대값을 받아 처리 -->
<script>


function scrollEnd(){
	 var scrollHeight = document.compatMode=="CSS1Compat"? document.documentElement.scrollHeight : document.body.scrollHeight;
	 var clientHeight = document.compatMode=="CSS1Compat"? document.documentElement.clientHeight : document.body.clientHeight;
	 var ScrollTop = document.compatMode == "CSS1Compat"? document.documentElement.scrollTop : document.body.scrollTop;
	 var scrollPos = scrollHeight - ScrollTop;

	 if (clientHeight == scrollPos)
	 {
	 	alert("끝!");
	 }
}

var div = document.querySelector('#divResults');
 $.ajax({
	type: "GET",
	url: "/vin/api/wine/search",
	data: { 
		page: "1",
		type: "",
		country: "",
		keyword: "",
		alcohol: "",
		sweetness: "",
		acidity: "",
		body: "",
		tanin: "",
		price: "",
		},
	dataType : "json",
	
	success : function(obj) {
        showempinfo(obj);
    },
    complete : function(xhr,status) {
    
    },
    error : function(xhr, status, error) {
        console.log(error);
    }	
 }) 
 
    function showempinfo(obj) {
        
        console.log(obj);
        html = '<table>';
        html += '<tr></tr><th style="background-color: #eeeeee; text-align: center;">와인코드</th><th style="background-color: #eeeeee; text-align: center;">와인라벨사진</th><th style="background-color: #eeeeee; text-align: center;">한글이름</th><th style="background-color: #eeeeee; text-align: center;">영어이름</th><th style="background-color: #eeeeee; text-align: center;">와이너리</th><th style="background-color: #eeeeee; text-align: center;">국가</th><th style="background-color: #eeeeee; text-align: center;">지역</th><th style="background-color: #eeeeee; text-align: center;">품종</th><th style="background-color: #eeeeee; text-align: center;">빈티지</th><th style="background-color: #eeeeee; text-align: center;">용량</th><th style="background-color: #eeeeee; text-align: center;">타입</th><th style="background-color: #eeeeee; text-align: center;">가격</th>';
        for (var i = 0; i < obj.length; i++) {
            console.log("obj를 테이블 폼에 맞게 변형 후 출력");
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
        //html += '</table>';
 
        console.log("전" + html);
        div.innerHTML = html;
        console.log("후" + html);
    }
	
 function addTable(obj) {
     
     //console.log(obj);
     for (var i = 0; i < obj.length; i++) {
         console.log("obj를 테이블 폼에 맞게 변형 후 출력");
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
     //html += '</table>';

     //console.log("전" + html);
     div.innerHTML = html;
     //console.log("후" + html);
 }
    
    
    

	var minAlcohol;
	var maxAlcohol;
	function alcoholValueChanged() {
		var minAlcohol = $('#minAlcohol').val();
		var maxAlcohol = $('#maxAlcohol').val();
		
		console.log(minAlcohol, maxAlcohol);
	};
	
	var minSweetness;
	var maxSweetness;
	function sweetnessValueChanged() {
		var minSweetness = $('#minSweetness').val();
		var maxSweetness = $('#maxSweetness').val();
		
		console.log(minSweetness, maxSweetness);
	};
	
	var minAcidity;
	var maxAcidity;
	function acidityValueChanged() {
		var minAcidity = $('#minAcidity').val();
		var maxAcidity = $('#maxAcidity').val();
		
		console.log(minAcidity, maxAcidity);
	};
	var minBody;
	var maxBody;
	function bodyValueChanged() {
		var minBody = $('#minBody').val();
		var maxBody = $('#maxBody').val();
		
		console.log(minBody, maxBody);
	};
	
	var minTanin;
	var maxTanin;
	function taninValueChanged() {
		var minTanin = $('#minTanin').val();
		var maxTanin = $('#maxTanin').val();
		
		console.log(minTanin, maxTanin);
	};

	var minPrice;
	var maxPrice;
	function priceValueChanged() {
		var minPrice = $('#minPrice').val();
		var maxPrice = $('#maxPrice').val();
		
		console.log(minPrice, maxPrice);
		
		
		
		
		
	}
	
	/* var xhr = new XMLHttpRequest();
	// 비동기 방식으로 Request를 오픈한다
	xhr.open('GET', 'searchList');
	// Request를 전송한다
	xhr.send();
	
	// XMLHttpRequest.readyState 프로퍼티가 변경(이벤트 발생)될 때마다 이벤트 핸들러를 호출한다.
	xhr.onreadystatechange = function (e) {
	  // readyStates는 XMLHttpRequest의 상태(state)를 반환
	  // readyState: 4 => DONE(서버 응답 완료)
		if (xhr.readyState === XMLHttpRequest.DONE) {
	    // status는 response 상태 코드를 반환 : 200 => 정상 응답
			if(xhr.status === 200) {
				console.log(xhr.responseText);
				//document.write(xhr.responseText);
				$('#divResults').append(xhr.responseText);
				
	    	} else {
	      		console.log('Error!');
	    	}
	  	}
	}; */
	
	    
	
	var searchMenu = document.querySelector("#searchMenu");
	searchMenu.addEventListener("change", function(evt) {
		sendAjax("hello");
	}
	)
	/* function makeTemplate(data, clickedName) {
		var resultHTML = "";
		var html = document.getElementById("tabcontent").innerHTML;
		for (var i = 0, len = data.length; i < len; i++) {
			if (data[i].name === clickedName) {
				resultHTML = html.replace("{html}", data[i].html);
				break;
			}
		}
		document.querySelector(".content").innerHTML = resultHTML;
	}
	var data;
	function sendAjax(url, clickedName) {
		var oReq = new XMLHttpRequest();
		oReq.addEventListener("load", function() {
			data = JSON.parse(oReq.responseText);
			makeTemplate(data, clickedName);
		});
		oReq.open("GET", url);
		oReq.send();
	}
	var search = document.querySelector("#searchMenu");
	search.addEventListener("change", function(evt) {
		sendAjax("txt/tabui.txt", evt.target.innerHTML);
	}) */
</script>

<script
	src="https://demos.jquerymobile.com/1.4.2/js/jquery.mobile-1.4.2.min.js"></script>
</html>