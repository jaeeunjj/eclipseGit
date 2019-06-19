<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="kr.or.ddit.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    

<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Jekyll v3.8.5">
    <title>Dashboard Template · Bootstrap</title>
	<tiles:insertAttribute name="preScript"/>
  </head>
  <body>
    <nav class="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
  <a class="navbar-brand col-sm-3 col-md-2 mr-0" href="#">Home</a>
  
<!--   상단 메뉴바 -->
 <tiles:insertAttribute name="header"/>
  
  <ul class="navbar-nav px-3">
    <li class="nav-item text-nowrap">
    <form action="<%=request.getContextPath()%>/login/logout.do" name="logoutForm" method="post"></form>
    <%
    MemberVO authMember = (MemberVO)session.getAttribute("authMember");
	if(authMember!=null){
		%>
		<a class="nav-link"  href="<%=request.getContextPath()%>/mypage.do"><%=authMember.getMem_name() %>님(${authMember.mem_auth})</a>
		<a class="nav-link"  href="javascript:document.logoutForm.submit();">로그아웃</a>
		<%
	}else{
		%>
		<a class="nav-link"  href="<%=request.getContextPath()%>/login/loginForm.do">로그인</a>
		<a class="nav-link"  href="<%=request.getContextPath()%>/member/memberInsert.do">회원가입</a>
		<%
	}
    %>
    </li>
  </ul>
</nav>

<div class="container-fluid">
  <div class="row">
    <nav class="col-md-2 d-none d-md-block bg-light sidebar">
      <div class="sidebar-sticky">
        
<!--         좌측 메뉴 -->
		<tiles:insertAttribute name="left"/>
        
      </div>
    </nav>

    <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
		<tiles:insertAttribute name="body"/>
    </main>
  </div>
</div>
	<tiles:importAttribute name="postScript"/>
</html>
    