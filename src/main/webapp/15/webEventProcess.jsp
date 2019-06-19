<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>15/webEventProcess.jsp</title>
</head>
<body>
<h4> 웹 어플리케이션의 이벤트 처리</h4>
<pre>
	1. 타겟 : 웹 컨텍스트
	2. 이벤트 종류 : lifecycle , Attribute
		request : 생성/소멸 , add/remove/replace
		session : 생성/소멸 , add/remove/replace
		ServletContext : 생성/소멸, add/remove/replace
	3. 핸들러 구현(Listener 구현)
	4. 타겟에 이벤트 핸들러 바인드 : web.xml을 통해 바인드
	
</pre>	
</body>
</html>