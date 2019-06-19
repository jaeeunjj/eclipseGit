<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.Locale"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>       
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<body>
<!-- 	1000000 -->
<!-- 1. 클라이언트가 locale 을 선택할수 있는  UI 만들기 -->
<!-- 2. 선택된 locale에 따라서 통화 표시로 출력이 되도록.. -->

<%
	Locale[] locales = Locale.getAvailableLocales();
	pageContext.setAttribute("locales",locales);
	
%>
	<form>
	<select name="language">
		<option>언어 선택</option>
	<c:forEach  var="local" items="${locales}">
	<c:if test="${not empty local.country}">
		<option  value="${local}" ${param.language eq local ? "selected":""}>${local.displayLanguage}</option> 
	</c:if>
		
		
	</c:forEach>
	</select>
	<input name="genNum" type="text" value ="${param.genNum}">
	<input type="submit">
	</form>
	<fmt:setLocale value="${param.language}"  />
	<div>
	
	<fmt:formatNumber value="${param.genNum}"  type="currency"
		var="getCurrency"
		/>
		${getCurrency }
	
	</div>
	
</body>
</html>