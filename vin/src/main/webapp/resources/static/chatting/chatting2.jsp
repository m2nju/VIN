<!DOCTYPE html>
<html>
<head lang="en">
<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
<script type="text/javascript"
	src="//cdnjs.cloudflare.com/ajax/libs/socket.io/0.9.16/socket.io.min.js"></script>
<script type="text/javascript">
	$(document).ready(
			function() {
				var socket = io.connect("http://viniswine.tk:5050/mynamespace");
				socket.on('response', function(msg) {
					$("#received").append(
							'<p> ' + msg.username + ': ' + msg.data + '</p>');
				});
				$("form#broadcast").submit(function(event) {
					if ($("#input-data").val() == "") {
						return false;
					}
					socket.emit("request", {
						data : $("#input-data").val()
					});
					$("#input-data").val("");
					return false;
				});
			});
</script>
<meta charset="UTF-8">
<title>websock test</title>
</head>
<body>
	<h1>Received</h1>
	<div id="received"></div>
	<form id="broadcast" action="#">
		<input id="input-data" type="text" /> <input type="submit" />
	</form>
</body>
</html>
