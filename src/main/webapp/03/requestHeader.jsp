<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>03/requestHeader.jsp</title>
</head>
<body>
<!-- headerName 파라미터가 있는 경우, 해당 헤더의 값만 출력 -->
<!-- 없는 경우, 모든 헤더의 이름과 값을 출력 -->
<h4>요청 헤더의 종류</h4>
<%
	String headerName = request.getParameter("headerName");
// 	if(StringUtils.isBlank(headerName)){
// 		response.sendError(400, "필수파라미터 누락");
// 		return;
// 	}
	Enumeration<String> names = request.getHeaderNames();
	String pattern = "<tr><th>%s</th><td>%s</td></tr>\n";
	String optionPtrn = "<option %s>%s</option>\n";
	StringBuffer trTags = new StringBuffer();
	StringBuffer options = new StringBuffer();
	while(names.hasMoreElements()){
		String name = names.nextElement();
		String value = request.getHeader(name);
		String selected = "";
		if(name.equals(headerName)){
			selected = "selected";
		}
		options.append(String.format(optionPtrn, selected,name));
		if(StringUtils.isNotBlank(headerName) && name.equals(headerName)){
			trTags.append(String.format(pattern, name, value));
		}else if(StringUtils.isBlank(headerName)){
			trTags.append(String.format(pattern, name, value));
		}
	}
%>
<form name="headerForm">
	<select name="headerName" onchange="document.headerForm.submit();">
		<option value="">헤더명 선택</option>
		<%=options %>
	</select>
</form>
<table>
	<%=trTags %>
</table>
</body>

</html>













