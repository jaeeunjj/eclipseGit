<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>05/sessionDesc.jsp</title>
</head>
<body>
<h4> HttpSession session 기본 객체 </h4>
<pre>
	세션 : 
		통로 : Connection의 의미로 사용됨(DB) 
		시간 : 하나의 유저가 하나의 브라우저를 사용해서 어플리케이션을 사용시작 할때부터
				더이상 사용하지 않겠다는 종료 이벤트가 발생할때까지의 기간.
				종료 이벤트의 종료
				- 명시적인 로그아웃(쿠키 삭제)
				- 브라우저 종료
				- 만료시간 이내에 새로운 요청이 발생하지 않는 경우.
	session 객체 : 한 세션 내에서 발생하는 모든 정보들을 캡슐화한 객체.
			     : 세션이 시작될때 객체가 생성되고, 세션이 종료될때 소멸됨.
	세션 라이프 사이클
		클라이언트로부터 세션아이디가 포함되지 않은 요청(최초의 요청)이 발생하면,
		세션이 생성되고->세션 아이디 생성->최초의 요청에 대한 응답에 함께 전송
		->두번째 이후의 요청부터 다시 요청에 포함된 세션 아이디로 세션을 식별하고 유지
		->더이상 세션 아이디가 전송되지 않으면 세션 소멸.
		   		     	
	생성 시점 : <%=new Date(session.getCreationTime()) %>	
	세션 아이디 : <%=session.getId() %>
	마지막 접속 시점 : <%=new Date(session.getLastAccessedTime()) %>	 
	세션 만료 시간 : <%=session.getMaxInactiveInterval() %>s
	<%--
		session.setMaxInactiveInterval(4*60);
	--%>    	
	세션 만료 시간 : <%=session.getMaxInactiveInterval() %>s
	
	session tracking mode (web.xml -> session-config ->tracking-mode)
	1. Cookie(JSESSIONID)
	2. URL Rewriting(jsessionid) 
			: session hijacking 공격에 취약함.
	3. SSL
	
	<a href="sessionDesc.jsp;jsessionid=<%=session.getId()%>">쿠키없이 세션 유지</a>
</pre>
</body>
</html>


























