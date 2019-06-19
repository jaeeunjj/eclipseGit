<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<body>
<pre>
<%
	String exceptionMsg = exception!=null?exception.getMessage():"";
	ErrorData errorData = pageContext.getErrorData();
	int sc = errorData.getStatusCode();
	String uri = errorData.getRequestURI();
%>
	<%=uri %>방향으로 발생한 요청에서 <%=exception %>예외 발생.
	발생 원인 : <%=exceptionMsg %>
	결정된 응답 코드 : <%=sc %>
</pre>
</body>
</html>













