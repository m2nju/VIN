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
		$(document).ready(function() {
			var sock = io.connect('http://viniswine.tk:9999');	// Flask 서버의 port 번호를 9999는 소켓 통신을 위한 port이다. 소켓 연결
			sock.on('connect', function() {
				var connect_string = 'new_connect';
				sock.send(connect_string);
			});

			sock.on('hello', function(msg) {
				$('#messages').append('<li>' + '>>Hello :' + msg + '</li>');
				console.log('Received Hello Message');
			});

			sock.on('message', function(msg) {	// 서버로부터 메세지가 왔을 때.
				// console.log(type(msg));
				if (msg.type === 'normal') {	//	정상적인 채팅 메세지일 때
					$('#messages').append('>> ' + decodeURIComponent(msg.message) + '<br>');	// 전송 받은 메세지를 URI 디코딩한다.
					//document.getElementById('sendbutton').click();	// 서버로부터 메세지가 왔을 때, 메세지가 한 줄 밑으로 내려가 있는 현상을 수정하기 위해 전송 버튼이 눌리게 함.
				} else {
					$('#messages').append('<li>' + msg.message + '</li>');
				}
				console.log('Received Message : ' + msg.type);
			});

			$('#sendbutton').on('click', function() {	// 전송 버튼이 눌렸을 때.
				var input = $('#myMessage').val();
				input = String(input);
				if(input != ""){	// input에 값이 있다면(메세지가 비어있지 않다면)
					input = encodeURIComponent('<%=userName%>' + ' : ' + input);	// 메세지의 앞 쪽에 userName을 붙여 URI 인코딩하여 전송한다.
	
					sock.send(input);
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
		})
	</script>
	<ul id="messages"></ul>
	</div>
	<input type="text" id="myMessage">
	<button id="sendbutton">입력</button>
	
</body>
</html>