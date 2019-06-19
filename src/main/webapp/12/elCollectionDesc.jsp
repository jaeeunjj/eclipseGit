<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>12/elCollectionDesc.jsp</title>
</head>
<body>
<h4>EL을 이용한 집합객체의 요소 접근방법</h4>
<pre>
	<%
		String[] array = new String[]{"arrayValue1", "arrayValue2"};
		pageContext.setAttribute("arrayAttr", array);
		List list = new ArrayList<>();
		list.add("listValue1");
		list.add("listValue2");
		pageContext.setAttribute("listAttr", list);
		
		Map map = new HashMap<>();
		map.put("key1", "mapValue1");
		map.put("key 2", "mapValue2");
		pageContext.setAttribute("mapAttr", map);		
		
		Set set = new HashSet<>();
		set.add("setValue1");
		set.add("setValue2");
		pageContext.setAttribute("setAttr", set);
		
	%>
	<%=pageContext.getAttribute("arrayAttr") %>, ${arrayAttr}
	<%=((String[])pageContext.getAttribute("arrayAttr"))[0] %>, ${arrayAttr[0]}
	<%-- 	<%=((String[])pageContext.getAttribute("arrayAttr1"))[3] %>--%>, ${arrayAttr1[3]} 
	\${arrayAttr.prop } : 객체의 프로퍼티에 접근
	since servlet3.0 /EL 2.2 메소드 호출지원
	 ${listAttr.get(0) }, ${listAttr[0] }, ${listAttr[3]}  
	 ${mapAttr.get("key 2") } ,\${mapAttr.key 2 }, ${mapAttr["key 2"] }
	
</pre>
</body>
</html>