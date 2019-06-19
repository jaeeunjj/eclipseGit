<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="kr.or.ddit.utils.CookieUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>12/elObjectDesc.jsp</title>
</head>
<body>
<h4>EL 기본객체</h4>
<pre>
	1) Scope 객체 : pageScope, requestScope, sessionScope, applicationScope
			${pageScope.pageAttr }, ${pageScope["pageAttr"] } 
	2) request parameter 객체 : param(Map&lt;String,String&gt;), paramValues(Map&gt;String,String[]&lt;)
		<%=request.getParameter("paramName") %>, ${param.paramName }, ${param["paramName"] }
		<%=request.getParameterValues("paramName") %>, ${ParameterValues.paramName[0] }, ${paramValues["paramName"][0] }	
	3) request header 객체 : header(Map&lt;String,String&gt;), haderValue
	<%=request.getHeader("Accept") %>, ${header.accept }, ${header["accept"] }
	<%=request.getHeader("user-agent") %>, \${header.user-agent }, ${header["user-agent"] }
	<%=request.getHeaders("Cookie") %>, ${headerValues.cookie[0] }, ${headerValues["cookie"][0]}
	
	4) cookie 객체 : cookie(Map&lt;String,Cookie&gt;)
		<%=new CookieUtil(request).getCookieValue("JSESSIONID")%>
		${cookie.JSESSIONID.getValue()}, ${cookie.JSESSIONID.value }
		${cookie["JSESSIONID"]["value"] }, ${cookie["JSESSIONID"]["name"] }
		
	5) 컨텍스트 파라미터 객체 : initParam(Map&lt;String,String&gt;)
		<%= application.getInitParameter("copyright")%>
		${initParam.copyright}, ${initParam["copyright"] }
		
	6) pageContext 객체 
<%-- 		<%=request %>, ${pageContext.getRequest() }, ${pageContext.request }, ${pageContext["request"] }	 --%>
		<%=request.getContextPath() %>, ${pageContext.request.contextPath }, ${pageContext["request"]["contextPath"] }
</pre>	
</body>
</html>