<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	private long factorial(int number){
		if(number<=0) throw new IllegalArgumentException("팩토리얼 연산은 양수만 가능");
		if(number==1) return 1;
		return number * factorial(number-1);
	}
%>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<body>
<h4>팩토리얼 연산</h4>
<%
	String numParam = request.getParameter("number");
	if(StringUtils.isNotBlank(numParam) && 
			!StringUtils.isNumeric(numParam)){
		response.sendError(HttpServletResponse.SC_BAD_REQUEST, "숫자 문제");
		return;
	}
	
%>
<form>
	<input type="number" name="number" value="<%=numParam%>"/>
	<input type="submit" value="연산결과" />	
</form>
<%
if(StringUtils.isNotBlank(numParam)){
	int number = Integer.parseInt(numParam);
%>
<span><%=number %>!=<%=factorial(number) %></span>
<%	
}
%>
</body>
</html>







