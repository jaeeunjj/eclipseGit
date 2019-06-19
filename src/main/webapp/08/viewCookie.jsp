<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>08/viewCookie.jsp</title>
</head>
<body>
<h4>동일 경로</h4>
<table>
	<thead>
		<tr>
			<th>쿠키명</th>
			<th>쿠키값</th>
		</tr>
	</thead>
	<tbody>
		<%
			Cookie[] cookies = request.getCookies();
			if(cookies!=null){
				for(Cookie tmp : cookies){
					%>
					<tr>
						<td><%=tmp.getName() %></td>
						<td><%=URLDecoder.decode(tmp.getValue(), "UTF-8") %></td>
					</tr>
					<%
				}
			}
		%>
	</tbody>
</table>
</body>
</html>














