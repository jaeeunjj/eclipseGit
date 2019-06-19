<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>04/flowControl.jsp</title>
</head>
<body>
<h4>웹어플리케이션에서 흐름 제어(페이지 이동)</h4>
<pre>
	A  --> B 로의 이동.
	1. Request Dispatch(서버측 위임)
		한번의 요청(최초 요청)에 대해 서버내에서 이동하는 방식
		Http 의 Connectless/Stateless 특성에 따라
		요청에 대해 응답이 전송되기 전까지는 요청 정보가 생존함.
		A->B 로 이동시 응답이 전송되지 않기때문에 B쪽으로 원본 요청이 전달됨.
		1) Forward : A 에서 생성된 모든 데이터는 삭제되고, 최종 응답은 B에서만 전송됨.
		2) Include : A에서 B로 이동시 기존 데이터가 삭제되지 않고, B측에서 데이터를 생성한 후,
					A 로 복귀, 최종적으로 A와 B의 모든 데이터가 전송됨.
		<%
// 			RequestDispatcher rd = request.getRequestDispatcher("/04/resourceIdentify.jsp");
// // 			rd.forward(request, response);
// 			rd.include(request, response);
		%>
	2. Redirect
		Http 의 Connectless/Stateless 특성에 따라
		요청에 대해 응답이 전송되기 전까지는 요청 정보가 생존함.
		A->B 로 이동시 중간에 Body 가 없는 응답(302/Location)이 클라이언트쪽으로 전송
		클라이언트측에서 Location 헤더의 방향으로 새로운 요청을 전송함.
		<%
			response.sendRedirect(request.getContextPath() + "/04/resourceIdentify.jsp");
		%>
</pre>
</body>
</html>












