<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" buffer="8kb" autoFlush="true"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>05/bufferDesc.jsp</title>
</head>
<body>
<h4> 출력 버퍼 </h4>
<pre>
	웹 어플리케이션에서 응답 전송 효율을 향상시키기 위해 사용되는 저장 공간.
	버퍼의 크기 : <%=out.getBufferSize() %> bytes
	버퍼의 남은 용량 : <%=out.getRemaining() %> bytes
	<%
		for(int i=1; i<100; i++){
// 			if(i%10==0){
// 				out.flush();
// 			}
			if(i==80){
				throw new RuntimeException("강제 발생 예외");
			}
			out.println(i+"번째 기록"+out.getRemaining()+"<br />");
		}
	%>
</pre>
</body>
</html>











