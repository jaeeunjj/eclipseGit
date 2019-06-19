<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.ddit.or.kr/genDate" prefix="gd"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.ddit.or.kr/loopPrintString" prefix="lp" %>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>13/customDesc.jsp</title>
</head>
<body>
<h4> 커스텀 라이브러리 작성</h4>
<pre>
	EL 커스텀 함수 정의 
	1. 자바 클래스를 정의 하고, 실제 함수의 실행 코드를 가진 static 메소드 정의
	  ex) SimpleDateFunctions. java-> generateDate
	2. tld(Tab Library Definition)파일 작성
		1) /WEB-inf/tlds 폴더 생성
			다른 위치에 tld파일 생성시, web.xml에 등록이 필요함.
		2) *.tld 파일 형태로 파일 생성(xml)
			ex) simpleDateFunctions.tld
		3) uri, short-name, function-> name/function-cladd/function-signature
	 
	 커스텀 태그 정의
	 1. 커스텀 태그의 핸들러 클래스(TagSupport 타입) 작성
	 	1) SimpleTagSupport : 태그의 바디가 없는 경우.
	 	2) BodyTagSupport : 태그의 바디가 있는 경우.
	 2. tld 작성
	 	tag -> tag-class -> body-content(empty, JSP, Scriptless)	 	 
	 <c:set var ="pattern" value ="yyyy-MM-dd" />	
	<gd:genDate pattern="${pattern }"/>
	
	<lp:printString count="5">
		텍스트
	</lp:printString>
</pre>
</body>
</html>

