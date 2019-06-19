<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="kr.or.ddit.enumpkg.ServiceType"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String includePage = (String)request.getAttribute("includePage");
%>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>index.jsp</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/main.css" />
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.3.1.min.js"></script>
</head>
<body>
<div id="top">
	<jsp:include page="/includee/topMenu.jsp" />
</div>
<div id="left">
	<jsp:include page="/includee/leftMenu.jsp" />
</div>
<div id="content">
<%
	if(StringUtils.isBlank(includePage)){
		String authId = (String)session.getAttribute("authId");
		if(StringUtils.isNotBlank(authId)){
			%>
			<h4><%=authId %>님 <a href="<%=request.getContextPath()%>/login/logout.jsp">로그아웃</a></h4>
			<%
		}else{
			%>
			<h4><a href="<%=request.getContextPath()%>/login/loginForm.jsp">로그인하러 가기</a></h4>
			<%
		}
	}else{
		pageContext.include(includePage);		
	}
%>
<h4>web.xml(Deployment Descriptor)에 등록된 웰컴 페이지</h4>
</div>
<div id="footer">
	<jsp:include page="/includee/footer.jsp" />
</div>
</body>
</html>












