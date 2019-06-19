<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="<%=request.getContextPath() %>/js/jquery-3.3.1.min.js"></script>
<%
	int second = 5;
	String goPage = "http://www.naver.com";
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%-- <meta http-equiv="Refresh" content="<%=second %>;url=<%=goPage %>" /> --%>
<title>03/autoRequest.jsp</title>
</head>
<body>
<h4>Auto Request</h4>
<pre>
	<%--
		response.setIntHeader("Refresh", 1);
	--%>
	서버의 현재 시각 : <span id="serverWatch"></span>
<%-- 	<span id="secondArea"></span>초 뒤에 <%=goPage %>로 간다. --%>
	클라이언트의 현재 시각 : <span id="clientWatch"></span>
</pre>
<script type="text/javascript">
	var clientWatch = document.querySelector("#clientWatch");
	var serverWatch = document.querySelector("#serverWatch");
// 	var spanTag = document.querySelector("#secondArea");
<%-- 	var initSecond = <%=second %>; --%>
// 	AJAX Asynchronose Javascript And Xml
	setInterval(function(){
// 		spanTag.innerHTML = initSecond--;
		var now = new Date();
		clientWatch.innerHTML = now;
$.ajax({
	url : "getServerTime.jsp",
	method : "get",
	dataType : "json", // request header(Accept), response header(Content-Type)
	success : function(resp) {
		$(serverWatch).html(resp.time);
	},
	error : function(errorResp) {
		console.log(errorResp.status);
	}
});
	}, 1000);
	
</script>
</body>
</html>













