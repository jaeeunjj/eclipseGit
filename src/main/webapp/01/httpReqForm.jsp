<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>01/httpReqForm.jsp</title>
</head>
<body>
<form action="<%=request.getContextPath() %>/httpReq.do" 
	method="post">
<!-- 	WYSIWYG 태그 -->
<!-- 	What You See Is What You Get -->
	<pre>
		text : <input name="textParam" type="text" />
		checkbox : <input name="checkBoxParam" type="checkbox" value="Box1" />	
		<input name="checkBoxParam" type="checkbox" value="Box2"  />	
		<input name="checkBoxParam" type="checkbox" value="Box3"  />
		radio : <input name="radioParam" type="radio" value="radioOn1"/>	
		<input name="radioParam" type="radio" value="radioOn2"/>
		select : <select name="selectParam">
			<option>text1</option>
			<option value="optValue2">text2</option>
		</select>	
		<input type="submit" value="전송"/>
	</pre>
</form>
</body>
</html>















