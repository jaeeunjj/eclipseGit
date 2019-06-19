<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>06/scopeDesc.jsp</title>
</head>
<body>
<h4>영역( Scope )</h4>
<pre>
	: 속성 데이터를 공유하기 위한 저장 공간
	속성(Attribute) : Scope 를 통해 공유되는 데이터(이름:값의 형태로 저장됨).
	
	각 Scope 에 대한 제어권을 가진 기본객체와 생명주기가 동일한 영역.
	
	page scope : pageContext 를 통해 접근하며, 하나의 jsp 페이지 내에서만 유효한 영역.
	request scope : request 를 통해 접근하며, 하나의 요청이 생존하는 동안만 유효한 영역.
	session scope : session 을 통해 접근하며, 한 세션 내에서만 유효한 영역.
	application scope : ServletContext 를 통해 접근하며, 
						하나의 어플리케이션내에서 공유되는 영역.
	
	<%
		pageContext.setAttribute("pageAttr", "페이지 영역의 속성");
		request.setAttribute("requestAttr", "리퀘스트 영역의 속성");
		session.setAttribute("sessionAttr", "세션 영역의 속성");
		application.setAttribute("applicationAttr", "어플리케이션 영역의 속성");
		
// 		pageContext.include("/06/viewAttribute.jsp");
		response.sendRedirect(request.getContextPath() + "/06/viewAttribute.jsp");
	%>	
	여기서부터는 다시 돌아온 이후.
	<%=pageContext.getAttribute("pageAttr") %>				
	<%=request.getAttribute("requestAttr") %>				
	<%=session.getAttribute("sessionAttr") %>				
	<%=application.getAttribute("applicationAttr") %>
	
<!-- 	<a href="viewAttribute.jsp">속성데이터 확인하러 가기</a>				 -->
</pre>
</body>
</html>





















