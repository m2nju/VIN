<%@ page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Chat Room</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/socket.io/1.4.8/socket.io.min.js"></script>
</head>
<body>
<div id="mydiv" style="overflow-y:auto; overflow-x:hidden; width:100%; height: 500px;">
<%
	String userName = (String) session.getAttribute("userName");	// 세션에 userName이라는 data가 있는 경우? 로그온되어있는 상태
	if (userName == null){	// userName이라는 data가 없는 경우, 로그온되어있지 않은 상태. 비회원 처리
		Random random = new Random();
		userName = "비회원"+ Integer.toString(random.nextInt(90000)+10000);	// ex:) 비회원21334 등의 형태로 임시 name이 부여된다.
	} 
%>
	
	
	
<script type="text/javascript">
	sendRequest();
	$(document).ready(function() {
		$('#sendbutton').on('click', function() {	// 전송 버튼이 눌렸을 때.
			console.log("send button clicked.")
			var input = $('#myMessage').val().toString();

			if(input != ""){	// input에 값이 있다면(메세지가 비어있지 않다면)
				$('#messages').append('나 : ' + input + '<br>');
				sendRequest(input);
				$('#myMessage').val('');
				document.getElementById('sendbutton').click();	
			}
			$("#mydiv").scrollTop($("#mydiv")[0].scrollHeight);
		});
			
		window.onload = function() {	// 실제 채팅과 마찬가지로, Enter 키가 눌렸을 때도  전송 버튼이 눌린 것처럼 처리.
			document.getElementById('myMessage').onkeypress = function searchKeyPress(event) {
				if (event.keyCode == 13) {	// enter 키의 keyCode는 13
					document.getElementById('sendbutton').click();	// sendbutton이 click되었다는 이벤트 발생
				}
			};
				
		document.getElementById('sendbutton').onclick = doSomething;
		}	
	});
		 
		 
	function sendRequest(message){
		console.log(message);
		$.ajax({
			url : "http://viniswine.tk:5001",	// 로컬에서 돌릴 떄
			//url : "localhost:5001",	// 원격 WAS에서 돌릴 때
			type : "GET",
			cache : false,
			dataType: 'json',
			data: { 
				input_text: message
			},
			success : function(msg){
				console.log(msg);
				if (msg.resultCode === '0') {	//	추천이 진행 중
					$('#messages').append('VIN : ' + msg.message + '<br>');	// 전송 받은 메세지를 append
					//document.getElementById('sendbutton').click();	// 서버로부터 메세지가 왔을 때, 메세지가 한 줄 밑으로 내려가 있는 현상을 수정하기 위해 전송 버튼이 눌리게 함.
				}
				if (msg.resultCode === '1') {	//	추천이 진행 중
					$('#messages').append('VIN : ' + msg.message + '<br>');	// 전송 받은 메세지를 append
					//document.getElementById('sendbutton').click();	// 서버로부터 메세지가 왔을 때, 메세지가 한 줄 밑으로 내려가 있는 현상을 수정하기 위해 전송 버튼이 눌리게 함.
				} else if ( msg.resultCode === '2'){
					
					$('#messages').append('VIN : ' + msg.message + '<br>');	// 전송 받은 메세지를 append
					
				} else if ( msg.resultCode === '3'){
					$('#messages').append('VIN : ' + msg.message + '<br>');	// 전송 받은 메세지를 append
					$('#messages').append('추천 내역입니다.' + '<br>');	// 전송 받은 메세지를 append
					if(msg.resultCode[0].wine21Code != ""){	// wine21에서 받아온 데이터라면(링크 제공)
						for (var i = 0; i < msg.response.length; i++){
							$('#messages').append('한글 제품명 : <a href ="http://viniswine.tk/wine/details/' + msg.response[i].wine21Code +'">' + msg.response[i].koreanName + '</a><br>');
							$('#messages').append('영문 제품명 : ' + msg.response[i].englishName + '<br>');
							$('#messages').append('생산 국가 : ' + msg.response[i].country + '<br>');
							$('#messages').append('생산 지역 : ' + msg.response[i].region + '<br>');
							$('#messages').append('가격 : ' + msg.response[i].price + '</a><br><br>');
						}
						sendRequest();
					} else{									// winenara에서 받아온 데이터라면
						for (var i = 0; i < msg.response.length; i++){
							
						}
					}
				} else if ( msg.resultCode === '4'){
					$('#messages').append('VIN : ' + msg.message + '<br>');
				}
				console.log('Received Message : ' + msg.type);
			}, error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	} 
</script>
<ul id="messages"></ul>
</div>

<input type="text" id="myMessage">
<button id="sendbutton">입력</button>

</body>
</html>