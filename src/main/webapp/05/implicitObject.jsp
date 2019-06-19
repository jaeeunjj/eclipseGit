<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>05/implicitObject.jsp</title>
</head>
<body>
<h4> 기본 객체 (내장 객체) </h4>
<pre>
	: 선언/생성하지 않아도 서블릿 소스 파싱 단계에서 기본 제공되는 객체.
	
	PageContext pageContext : 하나의 JSP 페이지에 대한 모든 정보를 가진 객체
		- 가장 먼저 생성되고, 나머지 기본 객체를 포함하고 있는 객체(getter)
		1) 나머지 기본 객체의 확보
		2) 페이지 이동(dispatch)
			<%
// 				RequestDispatcher rd = request.getRequestDispatcher("/05/idolForm.jsp");
// 				rd.forward(request, response);
// 				rd.include(request, response);
// 				pageContext.forward("/05/idolForm.jsp");
				pageContext.include("/05/idolForm.jsp");
			%>
		3) 속성 데이터 확보
		4) 에러 데이터 확보
	HttpServletRequest request : 요청과 클라이언트에 대한 정보
	HttpServletResponse response : 응답 정보를 가진 객체
	HttpSession session : 한 세션과 관련된 정보를 가진 객체
			-> sessionDesc.jsp 참고
	ServletContext application(singleton) : 웹어플리케이션과 서버에 대한 정보를 가진 객체
			->06/servletContextDesc.jsp 참고
	JspWriter out : 출력 스트림과 관련된 정보를 가진 객체(버퍼)
	ServletConfig config : 서블릿의 설정 정보를 가진 객체
	Object page : JSP 페이지의 인스턴스
	Throwable exception : 예외가 발생했다면, 해당 예외에 대한 참조 객체.
				- 에러를 처리하기 위해 isErrorPage 속성을 설정한 페이지에서 활성화.
				
	<%=pageContext.getRequest() == request %>
	<%=pageContext.getServletContext().hashCode() %>
	<%=application.hashCode() %>			
</pre>
</body>
</html>













