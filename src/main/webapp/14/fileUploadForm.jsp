<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<body>
<form action='${pageContext.request.contextPath}/fileUploadload2_5.do'
	method="post" enctype="multipart/form-data" 

>
	업로더명 : <input type="text" name ="uploader"/>
	업로드할 자료 : <input type="file" name ="uploadFile"/>
	<input type ="submit" value="업로드"/>

</form>
	<c:if test="${not empty sessionScope.dataMap}">
	업로드 결과 : ${sessionScope.dataMap} 
	<c:remove var="data" scope="session"/>
	</c:if>
</body>
</html>