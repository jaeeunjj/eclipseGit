<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 	response.setContentType("text/plain");
// 	response.setHeader("Content-Type", "text/plain");
%>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>03/responseDesc.jsp</title>
</head>
<body>
<h4>Http 프로토콜에 따른 응답 패키징 방식</h4>
<pre>
	HttpServletResponse 객체를 통해 정보 기록.
	
	1. Response Line : Protocol/ver. Status Code(응답상태코드)
		응답 상태 코드 : response.setStatusCode(상태코드)
						response.sendError(상태코드, 메시지)
		1) 100번대 : ING.. (WebSocket protocol)
		2) 200번대 : OK(Success) <%=HttpServletResponse.SC_OK %>
		3) 300번대 : 클라이언트의 추가 액션을 요구함.
			302/307(moved) , 304(not modified)
		처리 실패
		4) 400번대(client side) 
			404(Not Found), 400(Bad Request), 401/403(인가처리, Forbidden/UnAuthorized)
			405(Method not allowed), 415(unsupported media type)
		5) 500번대(server side) : 500(Internal Server Error)
	2. Response Header : 서버와 응답데이터에 부가정보[이름:값]
		response.setHeader(이름, 값), response.setIntHeader(이름, 숫자-int)
		response.setDateHeader(이름, 날짜-long)
	3. Response Body(Content Body) : 서비스할 응답 컨텐츠
		response.getWriter/response.getOutputStream() - 출력 스트림에 기록.
	
	
	응답 헤더의 기록
	1. Mime 설정 : content-Type
	2. 캐시 제어 : Pragma(HTTP/1.0), Cache-control(HTTP/1.1), Expires(공통)
		<%
			response.setHeader("Pragma", "no-cache");
			response.setHeader("Cache-Control", "no-cache");
			response.addHeader("Cache-Control", "no-store");
			Calendar cal =  Calendar.getInstance();
			cal.add(Calendar.DATE, 7);
			long date = cal.getTimeInMillis();
			response.setDateHeader("Expires", 0);
		%>
	3. 자동 요청 : Refresh
	    --> autoRequest.jsp 참고.
	4. 페이지 이동 : Location(302/307) - response.sendRedirect(url-클라이언트 방식의 절대 경로) 
		--> 04/flowControl.jsp 참고.
</pre>
</body>
</html>

















