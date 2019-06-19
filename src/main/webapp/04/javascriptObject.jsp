<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>04/javascriptObject.jsp</title>
</head>
<body>
<pre>
	알바생 : 이름, 나이, 휴대폰
	java 
	class AlbaVO{
		String name = "명노현";
		int age = 43;
		String hp = "000-00-0000";
	}
	new AlbaVO().name;
	javascript
	AlbaVO{
		name:"이진경",
		age:23,
		hp:"000-000-0000"
	}
	new AlbaVO().name;
	XML
	<AlbaVO>
		<name>이진경</name>
		<age>34</age>
		<hp>000--000--0000</hp>
	</AlbaVO>
	JSON(JavaScriptObjectNotation)
	{
		"name":"이진경",
		"age":23,
		"hp":"00-000-000"
	}
	marshalling : native -> (XML, JSON)
	UnMarahslling : (XML, JSON) -> native
</pre>
</body>
</html>










