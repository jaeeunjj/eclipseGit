<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>13/jstlFlowControl</title>
<style type="text/css">
	.yellow{
		background-color: yellow;
	}
	.red{
		background-color: red;
	}
	
	.green{
		background-color: green;
	}
	
</style>
</head>
<body>
	<h4>코어(c) 태그를 이용한 흐름제어</h4>
	<form>
		당신의 나이는 <input type ="number" name ="age" value = "${param.age}"/>
		<input type="submit" value="메시지"/>
	
	</form>
	<div>
		<c:set var="age" value="${param.age }"/>
		<c:if test ="${not empty age }">		
		파라미터가 있다면,
		<c:choose>
			<c:when test ="${age lt 10 }">
				<c:set var = "message" value = "10대 미만, 아직이르다~"/>
			</c:when>
			<c:when test="${age ge 10 and age lt 20 }">
				<c:set var = "message" value = "10대, 너네도 안돼"/>
			</c:when>
			<c:when test ="${age ge 20 and age lt 30 }">
				<c:set var = "message" value = "20대, 서른되면 와라~"/>
			</c:when>
		
			<c:when test ="${age ge 30 and age lt 40 }">
				<c:set var = "message" value = "30대, 이젠봐도된다, 뭘???"/>
			</c:when>
			<c:when test ="${age ge 40 and age lt 50 }">
			<c:set var = "message" value = "40대, 편안히 감상하셈. 뭘???"/>

			</c:when>
			<c:otherwise>
			
			<c:set var = "message" value = "그이상, 심장주의!!!"/>
			
			</c:otherwise>
		</c:choose>
		
		</c:if>
		<c:if test ="${empty age }">		
			나이를 입력하지 않았음.
		</c:if>
		${message }
		
		
	</div>
	
	
	<pre>
		1. 조건문 : &lt;c:if test="조건식(표현식|EL)" &gt; &lt;/c&gt;
		<c:if test="${not empty param.test}">
		
			파라미터가 있음 : ${param.test}, ${param["test"] }
		</c:if>
		<c:if test="${empty param.test }">
			파라미터가 없음 
		</c:if>
		2. 다중 조건문 : choose when test ="조건식 (표현식|EL)"~ otherwise	
		<c:choose>
			<c:when test ="${not empty param.test}">
				파라미터가 있음.
				
			</c:when>	
			<c:otherwise>
				파라미터가 없음.
			</c:otherwise>
			
		</c:choose>	
		
		3. 반복문 : forEach, forTokens
			일반 for 문(선언절 ; 조건절; 증감절) 
			var : 반복문에서 사용될 속성명
			begin : 초기값
			end : 종료값
			step : 증가치
			향상된 for 문(집합객체 요소에 대한 블럭 변수 선언 :반복대상 집합객체)
			items : 반복 대상이 되는 집학객체 (표현식|EL)
			
			varStatus(LppoTagStatus 객체의 레퍼런스) 
					LoopTagStatus 객체의 프로퍼티 : 반복의 상태를 의미하는 데이터 캡슐화
				int begin, end, step
				int	index(반복 수행시 변경되는 속성의 현재값), count(반복횟수)
				boolean	first(첫번째 반복인 경우), last(마지막 반복인 경우)
				
				<%
					List list =Arrays.asList("a","b","c");
					pageContext.setAttribute("list", list);
				
				%>
				
			<c:forEach var ="item" items="${list}" varStatus="vs">
				${item }${vs.last?"":"," }
			
			</c:forEach>
			<c:forTokens items="아버지 가방에 들어가신다" delims=" " var="token">
				${token}
			</c:forTokens>
			<c:forTokens items="1,2,3,4,5,6,7" delims="," var="number">
				${number * 2}			
			</c:forTokens>
		4. URI 재처리 태그 : 클라이언트 사이드 경로 완성.
		%lt;c:url var="속성명" value="서버사이드 경로"&gt;
			queryString 을 생성하기 위한 설정.
			&lt;c:param name="파라미터명" value="파라미터값" &gt;
		%lt;/url&gt;
		
		&lt;c:redirect url="서버사이드경로"/&gt;
		
			<c:url value="/member/memberList.do" var="listURL">
				<c:param name="page" value="2"/>
			</c:url>
			<a href="${listURL }">회원목록</a>
		
	</pre>
	<!-- 2단부터 9단까지 승수 9까지의 구구단 출력 -->
	<table>
		<c:forEach var="dan" begin="2" end="9" step="1" varStatus="vs">
			<c:choose>
				<c:when test="${vs.first }">
					<c:set var="clzValue" value = "green"/>
				</c:when>
				<c:when test = "${vs.count eq 3 }">
					<c:set var ='clzValue'  value="yellow"/>
				</c:when>
				<c:otherwise>
					<c:set var ='clzValue'  value="nomal"/>
				</c:otherwise>
			</c:choose>
		
		<tr class = "${clzValue}">
			<th>${dan}단
			<c:forEach var="mul" begin="1" end="9" step="1"  varStatus="ivs">
				<c:if test="${ivs.last}">
					<c:set var ="clzValue" value ="red"/>
				
				</c:if>
				<c:if test="${not ivs.last}">
					<c:set var ="clzValue" value ="nomal"/>
				</c:if>
				
				<td class = "${clzValue}">
					${dan}X ${mul}=${dan*mul}
				</td>
			</c:forEach>
			
		</tr>
	
		</c:forEach>
	</table>
	
	
	
</body>
</html>