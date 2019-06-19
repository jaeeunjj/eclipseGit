<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.TimeZone"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@taglib uri="http://www.ddit.or.kr/simpleDateFunctions" prefix="sdf" %>
<%@taglib uri="http://www.ddit.or.kr/timeZoneFunctions" prefix="tz" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<body>

<form>
<select name="timeLoc">
<c:forEach var="loc" items="${tz:getAvailableIDs() }">
	<option value="${loc}"${loc eq param.timeLoc? "selected":""  }>${tz:getTimeZone(loc).getDisplayName()}</option>
</c:forEach>	
</select>

<input type="submit" value="전송"/>
</form>
<pre>
TimeZone 정보 : <div>${tz:getTimeZone(param.timeLoc).getDisplayName()}</div>
Time Zont에 해당하는 현재 시각 :
<fmt:formatDate value="${sdf:genterateDate() }" type="both"
timeZone='${tz:getTimeZone(param.timeLoc)}'
 />
</pre>	

</body>
</html>