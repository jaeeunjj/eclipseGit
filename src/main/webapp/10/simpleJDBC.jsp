<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
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
	<%
		long startTime = System.currentTimeMillis();
		Class.forName("oracle.jdbc.driver.OracleDriver");
		String sql = "SELECT MEM_NAME, MEM_HP FROM MEMBER WHERE MEM_ID = 'a001' ";
		String url = "jdbc:oracle:thin:@localhost:1521/xe";
		String user = "sem";
		String password = "java";
		try(
			Connection conn = DriverManager.getConnection(url, user, password);			
			PreparedStatement pstmt = conn.prepareStatement(sql);		
		){
			
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()){
				out.println(rs.getString(1));
				out.println(rs.getString("MEM_HP"));
			}else{
				out.println("존재하지 않습니다.");
			}
		}catch(SQLException e){
			throw new RuntimeException(e);
		}
		long endTime = System.currentTimeMillis();
	%>
	소요시간 : <%=endTime-startTime %>ms
</body>
</html>











