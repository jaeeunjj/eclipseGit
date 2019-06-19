<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.Locale"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>   
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<body>
<h4>fmt (국제화 태그, format 태그)</h4>
<form>
	<input type ="radio" name="language" value="ko_KR"
		onChange="document.forms[0].submit();"
		${"ko" eq param.language?"checked":"" }
	/> 한국어_한국
	<input type ="radio" name="language" value="en_US"
		onChange="document.forms[0].submit();"
		${"en" eq param.language?"checked":"" }
	
	/> 영어_미국
</form>
	
<pre>
	: 국제화 서비스 처리를 위한 태그(i18n, l10n 지원)
	1) locale 에 따른 언어처리
		: setLocale, bundle, message
		- 언어 종류 : 영어, 한글
		- 언어별로 메시지 번들 작성
			basename : kr.or.ddit.msgs.message
			locale : en, ko (파일명에 포함되나 basname에는 포함되지 않는다.)
		- 언어결정 : setLocale
		<c:if test="${empty param.language }">
			<c:set var="language" value="${pageContext.request.locale}"/>
		</c:if>
		<c:if test="${not empty param.language }">
			<c:set var="language" value="${param.language}"/>
	
		</c:if>
		
			<fmt:setLocale value="${language}" />
		- 언어에 따른 메시지 번들 로딩 : bundle
			<fmt:bundle basename="kr.or.ddit.msgs.message">
		- 메시지 번들 내의 메시지 출력 : message
				<fmt:message key="bow"/>
			</fmt:bundle>
	
	2) locale 에 따른 메시지 형식처리
		- parse : 문자열을 일정 형식에 따라 특정 데이터 타입으로 변환하는 과정
		- format : 특정 타입의 데이터를 일정 형식에 따라 문자열로 변환하는 과정
		<fmt:parseNumber value="100,000" pattern="###,###" var="genNum"
		/>
		${genNum *3 } 
		<fmt:formatNumber value="${genNum *3 }" pattern="###,###" 
		var="genStr"
		/>
		${genStr}
		
		<fmt:formatNumber value="${genNum *3 }"  type="currency"
			var="getCurrency"
		/>
		${getCurrency }
		
		<fmt:formatDate value="<%=new Date() %>" type="both"
			dateStyle="long" timeStyle="long"
			var="genDateStr"
		
		/>
		${genDateStr }
		
		<fmt:parseDate value ="${genDateStr }" type="both"
		 	dateStyle="long" timeStyle="long"
		 	var="genDate"
		/>
		${genDate.time}
		
</pre>


</body>
</html>