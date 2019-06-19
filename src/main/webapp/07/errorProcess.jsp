<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.math.BigDecimal"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!--     errorPage="/errors/localError.jsp" -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>07/errorProcess.jsp</title>
</head>
<body>
<h4>웹어플리케이션의 에러 처리</h4>
<pre>
	에러 처리 방법
	1. jsp 페이지를 대상으로 한 지역적 처리.
			: page 지시자의 errorPage 속성을 통한 처리자 지정.
			
	2. 어플리케이션을 대상으로 한 전역 처리(web.xml->error-page).
		1) 발생한 예외 타입 : exception-type/location
		2) 발생한 에러 상태 코드 : error-code/location
		
	예외나 에러발생시 에러처리자가 결정되는 우선순위
		errorPage > exception-type > error-code
</pre>



<pre>
	<%
		if(1==1){
			throw new NullPointerException("강제예외 발생");
		}
		int number = 5;
// 		int result = 5/0;
		double result = number/0d;
		BigDecimal numberBig = new BigDecimal(number);
		BigDecimal zeroBig = new BigDecimal(10d);
		BigDecimal resultBig = numberBig.divide(zeroBig);
	%>
	<%=result %>
	<%=resultBig %>
</pre>
</body>
</html>










