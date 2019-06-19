<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>05/basePage.jsp</title>
</head>
<body>
<%
	pageContext.include("/06/pagePart1.jsp");
%>
<%-- <iframe src="<%=request.getContextPath() %>/06/pagePart1.jsp"></iframe> --%>
<hr />
<%-- <iframe src="<%=request.getContextPath() %>/06/pagePart2.jsp"></iframe> --%>
<%
	pageContext.include("/06/pagePart2.jsp");
%>
</body>
</html>