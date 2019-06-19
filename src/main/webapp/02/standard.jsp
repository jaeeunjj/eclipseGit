<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>02/standard.jsp</title>
</head>
<body>
<h4>JSP (Java Server Page)</h4>
<pre>
	: 템플릿 기반의 자바 언어를 기초로한 스크립트 언어
	소스 구성 요소
	1. 정적 텍스트 : 텍스트, html, javascript, jquery...
	2. 스크립트 구성 요소 : server side 실행 코드
		1) 지시자(directive) : &lt;%@ 지시자명 속성들(이름=값).. %&gt;
			: JSP 페이지에 부가 설정이나 환경 설정에 사용됨.
			page (필수 지시자)
				
			taglib
			include
		2) 스크립틀릿 : &lt;% 자바코드 %&gt; - 지역코드화(_JspSevice)
		<%
			String now = new Date().toString();
			
			
		%>
		3) 표현식 : &lt;%=브라우저에 출력할 값이나 변수 %&gt;
			<%=now %>
		4) 선언부 : &lt;%! %&gt;
		<%!
			String outter = "전역 변수의 값";
			public void test(){
				
			}
		%>
		5) 주석 : &lt;%-- --%&gt;
		 client side comment : html, javascript
<!-- 		 html comment -->
		<script type="text/javascript">
// 			javascript comment
		</script>
		 server side comment : java, jsp
		 <%
// 		 	java comment
		 %>
		 <%-- JSP Comment --%>
	3. 기본객체
	4. 액션 태그
	5. EL(표현언어)
	6. JSTL	
</pre>	
</body>
</html>



















