<%@page import="java.util.Calendar"%>
<%@ page language="java" 
    pageEncoding="UTF-8"%>
<%
	String accept =	request.getHeader("Accept");
	String content = String.format("%tc", Calendar.getInstance());
	if(accept.contains("html")){
		response.setContentType("text/html;charset=UTF-8");
		%>
		<span><%=content %></span>
		<%
	}else if(accept.contains("plain")){
		response.setContentType("text/plain;charset=UTF-8");
		%>
		<%=content %>
		<%		
	}else if(accept.contains("json")){
		response.setContentType("application/json;charset=UTF-8");
%>    
{
	"time":"<%=String.format("%tc", Calendar.getInstance()) %>"
}
<%
	}else{
		response.sendError(HttpServletResponse.SC_UNSUPPORTED_MEDIA_TYPE);
	}
%>








