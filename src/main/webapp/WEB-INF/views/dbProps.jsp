<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="kr.or.ddit.vo.DataBasePropertyVO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="kr.or.ddit.db.ConnectionFactory"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<body>
<h4>Database properties</h4>
<table>
	<%
		Map<String, Object> model = (Map) request.getAttribute("model");
		String[] headers =(String[])model.get("headers");
		List<DataBasePropertyVO> propList = (List) model.get("propList");
		out.println("<thead><tr>");
		for(String header : headers){
			out.println("<th>"+header+"</th>");			
		}
		out.println("</tr></thead>");
		out.println("<tbody>");
		for(DataBasePropertyVO propVO : propList){
			out.println("<tr>");
			out.println("<td>"+propVO.getProperty_name()+"</td>");	
			out.println("<td>"+propVO.getProperty_value()+"</td>");	
			out.println("<td>"+propVO.getDescription()+"</td>");	
			out.println("</tr>");
		}
		out.println("</tbody>");
	%>
</table>
</body>
</html>