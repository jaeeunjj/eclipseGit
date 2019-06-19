<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@	taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>   
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>13/jstlDesc.jsp</title>
</head>
<body>
<h4>JSTL(Jsp Standard Tag Library)</h4>
<form>
	import url : <input type="url" name="importUrl" value="${param.importUrl }"/>
	<input type="checkbox" name="toSource" value="true" 
		${not empty param.toSource?"checked":"" }
	/>소스로보기
	<input type="submit" value="IMPORT!!" />
</form>
<pre>
	: JSR-52 스펙에 따라 지원되는 커스텀 태그 라이브러리.
	
	사용 단계
	1. jar 파일 빌드패스에 추가
	2. taglib 지시자를 이용해 커스텀 태그 로딩.
		커스텀 태그 종류
		1) core 태그(c 태그)
			- 속성 지원 : 
			&lt;c:set var="속성명" value="값|표현식|EL" scope="영역의 종류" /&gt; 
			&lt;c:remove var="지울 속성명" scope="속성을 제거할 대상 영역" /&gt;
			 : remove 시 영역을 명시하지 않은 경우, 모든 영역에서 해당 속성명을 제거.
			<c:set var="now" value="<%=new Date() %>"  /> 
			 ${now }
			<c:set var="copyNow" value="${now }" /> 
			 ${copyNow }
			<c:set var="testAttr" value="세션속성값" scope="session" />
			<c:set var="testAttr" value="요청속성값" scope="request" />
			${requestScope.testAttr }, ${sessionScope.testAttr }
			<c:remove var="testAttr" scope="session"/>
			${requestScope.testAttr }, ${sessionScope.testAttr }
			
			- (***)흐름 제어 jstlFlowControl.jsp 참고
				조건문 :  if
				다중조건문 : choose~when~otherwise
				반복문 : forEach, forTokens
				
			- URL 재작성(URL Rewriting) : url, redirect
			
			- 기타 : import(컨텍스트 제한 없는 동적 내포), out
			
		2) ftm 태그 : fmtDesc.jsp 참고
		
		3) fn 라이브러리
			${fn:containsIgnoreCase("ABC","abc") }
			<%
				String [] array = new String[]{"a","b","c"};
				pageContext.setAttribute("array", array);
			
			%>
			${array }, ${fn: join(array, ",")} 
			<c:set var="getStr" value ='${fn: join(array, ",")} '/>
			${fn:split(getStr,",")}
			${fn:escapeXml("<h4>타이틀</h4>") }
</pre>
<c:set var="importUrl" value="${param.importUrl }" />
<c:set var="toSource" value="${param.toSource }" />
<c:if test="${not empty importUrl }">
	<div>
		<c:import url="${importUrl }" var="importSite" />
		<c:out value="${importSite }" escapeXml="${not empty toSource and toSource ? true:false}" />
	</div>
</c:if>
</body>
</html>

















