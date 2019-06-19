<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="kr.or.ddit.vo.AlbaVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>07/actionTagDesc.jsp</title>
</head>
<body>
<h4>jsp 액션태그(Action Tag)</h4>
<pre>
	: JSP 스펙에 따라 기본 제공되는 커스텀 태그의 일종으로
	  서버사이드에서 동작하는 태그의 형태.
	  커스텀태그의 사용 : &lt;prefix:tagname 속성들... &gt;
<%-- 	  <jsp:forward page="/05/sessionDesc.jsp" /> --%>
<%-- 	  <jsp:include page="/05/sessionDesc.jsp" /> --%>
	  <jsp:useBean id="albaVO" class="kr.or.ddit.vo.AlbaVO" scope="request"></jsp:useBean>
	  <jsp:setProperty property="*" name="albaVO"/>
	  <jsp:getProperty property="age" name="albaVO"/>
	  <jsp:getProperty property="name" name="albaVO"/>
	  <%--
	  	
// 	  	AlbaVO albaVO = (AlbaVO) request.getAttribute("albaVO");
// 	    if(albaVO==null){
// 	    	albaVO = new AlbaVO();
// 	    	request.setAttribute("albaVO", albaVO);
// 	    }
		albaVO.setAge(new Integer(request.getParameter("age")));
	  	albaVO.setAge(34); 
	  	out.println(albaVO.getAge());
	  --%>	
</pre>
</body>
</html>

















