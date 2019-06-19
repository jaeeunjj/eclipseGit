<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<body>
<form	method="post" enctype="multipart/form-data"
	action="${pageContext.request.contextPath}/test/upload"
>
	업로더 : <input type ="text" name="uploader" />
	파일 : <input type="file" name="uploadFile" />
	<input type="submit" value="업로드" />
</form>
</body>
</html>