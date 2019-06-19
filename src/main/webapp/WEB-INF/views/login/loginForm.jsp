<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="kr.or.ddit.utils.CookieUtil"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="java.util.Objects"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>login/loginForm.jsp</title>

<c:if test="${not empty message } ">
	<script type="text/javascript">
			alert("${message}");
	</script>
</c:if>

</head>
<body>
<form action="<%=request.getContextPath() %>/login/loginCheck.do"
	method="post"
>
	<ul>
		<li>
			<%
			   String mem_id = new CookieUtil(request).getCookieValue("idCookie");
			%>
			아이디:<input type="text" name="mem_id" value="<%=Objects.toString(mem_id, "") %>"/>
			<input type="checkbox" name="saveId" value="saved" 
				<%=StringUtils.isNotBlank(mem_id)?"checked":"" %>
			/>아이디기억하기
		</li>
		<li>
			비번:<input type="text" name="mem_pass" />
			<input type="submit" value="로그인" />
		</li>
	</ul>
</form>
</body>
</html>












