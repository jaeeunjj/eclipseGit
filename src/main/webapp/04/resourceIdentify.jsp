<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>04/resourceIdentify.jsp</title>
</head>
<body>
<h4>자원의 식별</h4>
<pre>
	URI(Unified Resource Identifier)
	URL(Unified Resource Locator) : 절대 경로를 기준으로 자원의 식별
	URN(Unified Resource Naming) : 자원의 명칭을 등록하고 식별.
	URC(Unified Resource Content) : 등록/식별, 포괄적, 중복	
	
	URL 표기 방법
	http://www.naver.com
	protocol(scheme)://host.domain/depth01/...../resource_name[확장자 포함]
	
	상대 경로 : 현재 위치를 기준으로 자원의 경로를 기술.
	현재 위치 : /webStudy01/04 -> ../images/Koala.jpg
	절대 경로 : 
		http://localhost/webStudy01/04/images/Koala.jpg
		//localhost/webStudy01/04/images/Koala.jpg
		클라이언트 방식 : <%=request.getContextPath() %>/04/images/Koala.jpg (***)
		서버 방식 : contextPath 를 제외한 경로 기술 ex) /04/images/Koala.jpg
		
</pre>
<%-- <img src="<%=request.getContextPath() %>/images/Koala.jpg"/> --%>
<%
	String realPath = getServletContext().getRealPath("/images/Koala.jpg");
%>
서버상의 실제 자원 위치 : <%=realPath %>
</body>
</html>

















