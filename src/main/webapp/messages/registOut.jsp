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
<h4> 탈퇴 약관 </h4>
<pre>
	그동안 저희 서비스를 이용해 주셔서 감삼다.
	근데, 일주일 이내에는 동일 아이디로 재가입 불가능 한거 아시죠? (왜????)
	그러면, 고갱님의 소중한 개인정보는 저희가 일주일동안  관리 할거라는거 아시죠? (왜???)
	일주일만 갖고있다가 일주일 뒤에 없앨게염.(그니까 왜???)
<%
	session.invalidate();
%>
</pre>
</body>
</html>