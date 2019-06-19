<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>08/cookieDesc.jsp</title>
</head>
<body>
<h4>Cookie</h4>
<pre>
	: Http의 Stateless 특성의 단점을 보완하기 위해 클라이언트 사이드에 저장하는 데이터
	
	쿠키의 사용 단계
	1. 쿠키 생성(javax.servlet.http.Cookie) : 쿠키의 여러가지 속성들을 결정.
	2. 응답데이터를 통해 클라이언트쪽으로 전송(set-cookie)
	
	3. 브라우저에 의해 자기 쿠키 저장소에 저장
	4. 이후 요청에 저장되어 있던 쿠키가 서버로 다시 재전송
	
	5. 요청을 통해 재전송된 쿠키를 통해 상태 복원
	<%	
// 		name/value 속성을 먼저 결정.
// 		1.
		String cookieValue = URLEncoder.encode("한글쿠키값", "UTF-8");
		Cookie sampleCookie = new Cookie("sampleCookie", cookieValue);
// 		2.
		response.addCookie(sampleCookie);

// 		5.
		Cookie[] cookies = request.getCookies();
		if(cookies!=null){
			for(Cookie tmp : cookies){
				if(tmp.getName().equals("sampleCookie")){
					String tmpValue = URLDecoder.decode(tmp.getValue(), "UTF-8");
					out.println(tmpValue);
				}
			}
		}
	%>
	
	쿠키의 속성 종류
	1. name(생성자) : 유일성, null/공백/특수문자 허용하지 않음. 
	2. value(생성자) : String, 특수문자는 인코딩이 필요함(URLEncoder/URLDecoder활용).
	3. path : 다음번 요청이 발생시 쿠키의 재전송 여부를 결정하는 기준.
	          생략할 경우, 쿠키를 생성할 때의 경로가 반영됨.
	   <%
	   		Cookie diffCookie = new Cookie("diffCookie", "diffCookieValue");
			diffCookie.setPath(request.getContextPath() + "/09");
			response.addCookie(diffCookie);
			
			Cookie allPathCookie = new Cookie("allPathCookie", "All~Path~");
// 			allPathCookie.setPath(request.getContextPath());
			allPathCookie.setPath("/");
			response.addCookie(allPathCookie);
	   %>       
	4. domain/host : 다음번 요청이 발생시 쿠키의 재전송 여부를 결정하는 기준.
			생략할 경우, 쿠키를 생성할 때의 도메인/호스트가 반영됨.	
			GTLD - www.naver.com , blog.naver.com, mail.naver.com
			NTLD - www.naver.co.kr
	<%
		Cookie domainCookie = new Cookie("domainCookie", "Domain~Cookie~");
	   // domain 설정시 쿠키를 생성한 도메인과 depth 구조의 연관성이 없다면, 무시됨.
	   	domainCookie.setDomain(".chy.com");
	   	domainCookie.setPath("/");
	    response.addCookie(domainCookie);
	%>
	5. maxAge : 쿠키의 만료 시간(초단위) 설정.
				생략시 브라우저의 정책을 따라가나 일반적으로 세션의 만료시간을 따름.
				0 - 쿠키 삭제에도 사용됨(name/domain/path 등의 설정이 동일해야함).
				-1 - 브라우저 종료시 삭제됨.
	<%
		Cookie twoDaysCookie = new Cookie("twoDaysCookie", "Alive~for~two~days");
		twoDaysCookie.setMaxAge(-1);	
// 		twoDaysCookie.setPath(request.getContextPath());
		response.addCookie(twoDaysCookie);		
	%>	
	<a href="viewCookie.jsp">같은 경로에서 쿠키 확인하기</a>
	<a href="../09/viewCookie.jsp">다른 경로에서 쿠키 확인하기</a>
	<a href="../09/09_01/viewCookie.jsp">depth가 다른 경로에서 쿠키 확인하기</a>
</pre>
</body>
</html>











