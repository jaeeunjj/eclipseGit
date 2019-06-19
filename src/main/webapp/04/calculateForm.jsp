<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="kr.or.ddit.enumpkg.OperatorType"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="com.sun.org.apache.xalan.internal.xsltc.runtime.Operators"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>04/calculate.jsp</title>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		var resultArea = $("#resultArea");
		$("#calForm").on("submit", function(event){
			event.preventDefault();
			var action = $(this).attr("action");
			var method = $(this).attr("method");
			var queryString = $(this).serialize();
// 			alert(queryString);
			$.ajax({
				url : action,
				method : method,
				data : queryString,
// 				data:{
// 					leftOp:5,
// 					rightOp:7
// 				}
				dataType : "json", // request header(Accept), response header(Content-Type)
				success : function(resp) {
					resultArea.html(resp.result);
// 	 				var result = $(resp).find("result");
// 	 				resultArea.html(result);
				},
				error : function(errorResp) {
					console.log(errorResp.status);
				}
			});
			return false;
		});
	});
</script>
</head>
<body>
<h4>사칙연산기</h4>

<form id="calForm" action="<%=request.getContextPath() %>/calculator.do">
	<input type="number" name="leftOp" />
	<%
		String ptrn = "<option value='%s'>%s</option>\n";
		StringBuffer options = new StringBuffer();
		for(OperatorType tmp : OperatorType.values()){
			options.append(String.format(ptrn, tmp.name(), tmp.getSign()));
		}
	%>
	<select name="operator">
		<%=options %>
	</select>
	<input type="number" name="rightOp" />
	<input type="submit" value="=" />
	<span id="resultArea"></span>
</form>
</body>
</html>











