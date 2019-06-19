<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>06/sessionTimer.jsp</title>
<script src="<%=request.getContextPath() %>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery_sessiontimer.js"></script>
<script type="text/javascript">
	$.getContextPath=function(){
		return "<%=request.getContextPath() %>";
	}
	$.fn.sampleFunc=function(text){
		this.html(text);
		return this;
	}
	
	$(function(){
		$("#timerArea").sessionTimer(5);
	});
</script>
</head>
<body>
<div id="timerArea"></div>

<pre>
1. 세션의 만료 시간을 출력 02:00
2. 초단위로 시간을 discount
3. 만료 시간이 1분이 남은 경우, 
   메시지를 통해 연장 여부 결정
4. 연장하는 경우, 타이머 리셋
	서버의 세션을 연장하기 위해 새로운 비동기 요청 발생
5. 취소하는 경우, 타이머는 계속 discount   
	0초가 되는 순간,  현재 페이지 reload.
</pre>
	 
</body>
</html>








