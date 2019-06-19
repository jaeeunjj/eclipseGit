<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>02/gugudan.jsp</title>
<style type="text/css">
	.yellow{
		background-color: yellow;
	}
</style>
</head>
<body>
<%
	int minDan = 2;
	int maxDan = 9;
	String minStr = request.getParameter("minDan");
	String maxStr = request.getParameter("maxDan");
	
	if((StringUtils.isNotBlank(minStr) && !StringUtils.isNumeric(minStr))
			||(StringUtils.isNotBlank(maxStr) && !StringUtils.isNumeric(maxStr))
			){
		response.sendError(400);
		return;		
	}
		
	
	if(StringUtils.isNumeric(minStr) && 
			StringUtils.isNumeric(maxStr)){
		minDan = Integer.parseInt(minStr);
		maxDan = Integer.parseInt(maxStr);
	}
%>

<form>
	<input type="hidden" name="includePage" value="gugudan" />
	<ul>
		<li>최소단 : <input type="number" min="2" max="9" 
						name="minDan" value="<%=minDan%>"/></li>
		<li>최대단 : <input type="number" min="2" max="9" 
						name="maxDan" value="<%=maxDan%>"/>
			<input type="submit" value="구구단 출력!"/>
		</li>
	</ul>
</form>

<table>
	<%
		for(int dan = minDan; dan<=maxDan; dan++){
			String clz = "normal";
			if(dan==3) clz = "yellow";
			%>
			<tr class="<%=clz %>">
			<%
			for(int mul=1; mul<=9; mul++){
				%>
				<td><%=String.format("%d*%d=%d", dan, mul, (dan*mul)) %></td>
				<%
			}
			%>
			</tr>
			<%			
		}
	%>
</table>
<%!
	
	public StringBuffer gugudan(int minDan, int maxDan){
		StringBuffer trTags = new StringBuffer();
		String pattern = "<td>%d*%d=%d</td>";
		for(int dan = minDan; dan<=maxDan; dan++){
			String clz = "normal";
			if(dan==3) clz = "yellow";
			trTags.append(String.format("<tr class='%s'>", clz));
			for(int mul=1; mul<=9; mul++){
				trTags.append(String.format(pattern, dan, mul, (dan*mul)));
			}
			trTags.append("</tr>");
		}
		return trTags;
	}
%>
<table>
	<%=gugudan(minDan, maxDan)%>
</table>
</body>
</html>


























