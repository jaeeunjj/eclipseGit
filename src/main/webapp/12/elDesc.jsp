<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<body>
<h4>EL(Expression Language : 표현언어)</h4>
<pre>
	: 데이터를 출력하기 위한 목적의 스크립트 형태 서버사이드 언어.
	토큰 구분기호  :\${속성명(EL 변수명) }
	
	<%
		pageContext.setAttribute("pageAttr", "페이지 영역의 속성");
		//pageContext가 나머지 객체를 포함하기 때문에 리퀘스트 스코프에 값을 줄 수 있음..
		pageContext.setAttribute("requestAttr", "리퀘스트 영역의 속성",PageContext.REQUEST_SCOPE);
		pageContext.setAttribute("sameName", "페이지데이터");
		request.setAttribute("sameName", "요청데이터");
	
	%>
	1) 네가지 기본 영역의 속성 데이터 출력
	<%=pageContext.getAttribute("pageAttr") %>, ${pageAttr}
	<%=request.getAttribute("requestAttr") %>, ${requestAttr} 
	<%=pageContext.getAttribute("requestAttr",PageContext.REQUEST_SCOPE) %>
	<%=pageContext.getAttribute("sameName") %>, ${pageScope.sameName} 
	<%=request.getAttribute("sameName") %> , ${requestScope.sameName} 
	
	2) EL 연산자 지원 : 피연산자(리터럴, 속성)
		- 산술연산자 (+-/*%)
			${3+4}, ${'3'+4}, ${"3"+"4"}, \${'a'+4} "+"는 산술 연산만 수행.    
			${6/3}, ${5/2}, ${5%2}  "/" 기본적으로 double 형으로 수행. 
		- 논리연산자(&&(and), ||(or), !(not))
			<%
				pageContext.setAttribute("leftOp", false);
				pageContext.setAttribute("rightOp", "true");
				pageContext.setAttribute("leftStr", new String("스트링"));
				pageContext.setAttribute("rightStr", new String("스트링"));
			%>
			${true and true}, ${leftOp or rightOp}  
			${not false}, ${not tesOP} 
		- 비교연산자(gt, lt, ge, le, eq, ne)
			${3 lt 5}, \${leftOp gt 4 }, ${leftOp eq rightOp }
			${leftStr ne rightStr }
		- **단항연산자(empty-데이터가 비어있는지.. , 증감연산자는 지원되지 않음.)
			: 속성의 존재여부 -> null 여부 -> 타입 체킹 후  size()/length() 호출 후 비어있는지 확인 
		
		<% pageContext.setAttribute("testOp","   "); 
			List testList = new ArrayList<>();
			testList.add("");
			pageContext.setAttribute("testList", testList);
		%>
<!-- 		- 속성이 있는지(없으면 비어있다고 판단해서 true) -->
			${empty testOp}, ${not empty testOp} 
			${empty testList}, <%=testList!=null?testList.size()==0:false %>
		
		- 삼항연산자(?:) \${조건식? 참문장:거짓문장}
			${not empty testList?testList.size():"비어있음"} 
		 		
	3) 속성으로 공유되고 있는 집합 객체에 대한 접근 방법 제공
		elCollectionDesc.jsp 참고	
	
	4) 속성으로 공유되고있는 자바 객체에 대한 접근 방법 제공(dot notation)
	<jsp:useBean id ="member" class ="kr.or.ddit.vo.MemberVO" />
	<jsp:setProperty property="mem_name" name = "member" value="김은대"/>
	${member }, ${member.getMem_name() },  ${member.mem_name }, ${member["mem_name"] }
	${member.getTestStr() }, ${member.testStr } ,${member["testStr"] }

	5) EL의 기본 객체 11가지 :elObjectDesc.jsp 참고
		: pageScope, requestScope, sessionScope, applicationScope
	 
</pre>
</body>
</html>