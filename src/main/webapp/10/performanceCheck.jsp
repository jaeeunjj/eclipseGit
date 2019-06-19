<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>10/performanceCheck.jsp</title>
</head>
<body>
<h4>소요시간</h4>
<pre>
	: latency time + processing time
	** latency time 의 비율을 낮추기 위해 pooling 시스템 적용
	pooling 적용시 장점 : 소요시간을 줄일수 있고, 소요 메모리를 줄일수 있음.
	한번의 연결과 한번의 처리 : 15ms
	100번의 연결과 100의 처리 : 1000ms,  17ms
	1번 연결과 100번 처리 : 20ms 
</pre>
</body>
</html>