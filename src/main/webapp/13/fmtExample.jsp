<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.TimeZone"%>
<%@page import="java.util.Date"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="java.util.Locale"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@taglib uri="http://www.ddit.or.kr/simpleDateFunctions" prefix="sdf" %>
<%@taglib uri="http://www.ddit.or.kr/localeFunctions" prefix="lf" %>       
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<body>
	
	<c:if test="${not empty param.locale }">
		<c:set var="paramLocale" value="${lf:forLanguageTag(param.locale) }"/>
	
	</c:if>

<c:set value ="${empty paramLocale? pageContext.request.locale : paramLocale}" var="currentLocale" />	
<form>
	금액 : <input type="number" name="digits" value = "${param.digits }"/>
	<select name="locale">
		<c:forEach items="${lf:availableLocales() }" var="loc">
			<c:if test="${not empty loc.country}">
			<option value="${loc.toLanguageTag()}" ${loc eq currentLocale? "selected":"" }>${loc.displayCountry }</option>
			</c:if>
		</c:forEach>
	</select>
	<input type="submit" value="전송"/>
</form>
	
	<fmt:setLocale value="${currentLocale }" />
	
<pre>
	통화 : <fmt:formatNumber value = "${param.digits }" type="currency"/>

	TimeZone 정보 : <%=TimeZone.getTimeZone(TimeZone.getAvailableIDs()[3]).getDisplayName() %>
	Time Zont에 해당하는 현재 시각 :
	<fmt:formatDate value="${sdf:genterateDate() }" type="both"
	timeZone="<%=TimeZone.getTimeZone(TimeZone.getAvailableIDs()[3]) %>"
 />
</pre>	
</body>
</html>

