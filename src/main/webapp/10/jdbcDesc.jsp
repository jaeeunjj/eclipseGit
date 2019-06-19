<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="kr.or.ddit.db.ConnectionFactory"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>10/jdbcDesc.jsp</title>
</head>
<body>
<h4>JDBC(Java DataBase Connectivity)</h4>
<%
String searchUser = request.getParameter("user");
%>
<form>
	<input type="text" name="user" value="<%=searchUser %>"/>
	<input type="submit" value="전송" />
</form>
<pre>
	: java.sql.*/javax.sql.* 를 통해  JDBC API 제공.
	
	JDBC 프로그래밍 단계
	1. 드라이버를 빌드패스에 추가 : 벤더가 제공
	2. 드라이버 로딩 
	3. Connection 생성
	4. 쿼리 객체 생성
		1) Statement : 기본적인 쿼리 객체이며, 런타임에 쿼리를 동적으로 변경할 수 있는 객체.
		2) PreparedStatement(선컴파일된 쿼리 객체) :
				정적 쿼리 객체이며, 객체 생성 단계에서 쿼리가 고정되며, 
				대신 변경할 부분만 쿼리 파라미터(?)를 설정함. 
		3) CallableStatement : 프로시저나 함수들을 호출할수 있는 쿼리 객체.
	5. 쿼리 실행
		1) ResultSet executeQuery : SELECT
		2) int executeUpdate : INSERT/UPDATE/DELETE, 질의의 영향을 받은 레코드수(row count)
	6. 결과 집합 핸들링
	7(*). 연결 종료 및 자원 해제
	<%
		
		
		if(StringUtils.isBlank(searchUser))	return;
		
		String sql = "SELECT MEM_NAME, MEM_HP FROM MEMBER WHERE MEM_ID = ? ";
		try(
			Connection conn = ConnectionFactory.getConnection();
// 			Statement stmt = conn.createStatement();
			PreparedStatement pstmt = conn.prepareStatement(sql);		
		){
			
			pstmt.setString(1, searchUser);
			
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
// 		finally{
// 			try{
// 				if(rs!=null)	rs.close();
// 				if(stmt!=null)	stmt.close();
// 				if(conn!=null)	conn.close();
// 			}catch(SQLException e){}
// 		}
	%>
</pre>
</body>
</html>
















