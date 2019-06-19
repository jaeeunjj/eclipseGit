<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="javax.servlet.annotation.WebServlet"%>
<%@page import="kr.or.ddit.utils.ReflectionUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<body>
<%=ReflectionUtils.getClassesAtBasePackageWithAnnotation("kr.or.ddit", WebServlet.class) %>
</body>
</html>