<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.apache.commons.beanutils.converters.CalendarConverter"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.DateFormatSymbols"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="java.util.Calendar"%>
<%@page import="static java.util.Calendar.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>04/calendar.jsp</title>
<style type="text/css">
	table{
		border-collapse: collapse;
		width: 100%;
		height: 500px;
	}
	td,th{
		border: 1px solid black;
	}
</style>
<script type="text/javascript">
	function calFunction(yearParam, monthParam){
		if(yearParam){
			document.calForm.year.value = yearParam;
		}
		if(monthParam || monthParam>=0){
			document.calForm.month.value = monthParam;
		}
		document.calForm.submit();
	}
</script>
</head>
<body>
<%
	Calendar cal = getInstance();
	String yearStr = request.getParameter("year");
	String monthStr = request.getParameter("month");
	String language = request.getParameter("language");
	
	// marshalling /Unmarshalling 공통 사용.
	ObjectMapper mapper = new ObjectMapper();
	Map calendarMap = null;
	Cookie[] cookies = request.getCookies();
	if(cookies!=null){
		for(Cookie tmp : cookies){
			if(tmp.getName().equals("calendarCookie")){
				String jsonString = URLDecoder.decode(tmp.getValue(), "UTF-8");
				calendarMap = mapper.readValue(jsonString, HashMap.class);
			}
		}
	}
	
	out.println(calendarMap);
	
	Locale clientLocale = request.getLocale();
	if(StringUtils.isNotBlank(language)){
		clientLocale = Locale.forLanguageTag(language);	
	}else if(calendarMap!=null){
		clientLocale = Locale.forLanguageTag((String)calendarMap.get("language"));
	}	
	DateFormatSymbols dfs = new DateFormatSymbols(clientLocale);
	
	if(StringUtils.isNumeric(yearStr) && StringUtils.isNumeric(monthStr)){
		cal.set(YEAR, Integer.parseInt(yearStr));
		cal.set(MONTH, Integer.parseInt(monthStr));
	}else if(calendarMap!=null){
		cal.set(YEAR, (Integer)calendarMap.get("year"));
		cal.set(MONTH, (Integer)calendarMap.get("month"));
	}
	
	int year = cal.get(YEAR);
	int month = cal.get(MONTH);
	
	cal.set(DAY_OF_MONTH, 1); 
	int firstDay = cal.get(DAY_OF_WEEK);
	int lastDate = cal.getActualMaximum(DAY_OF_MONTH);
	int offset = firstDay - 1;
	cal.add(MONTH, -1);
	int beforeYear = cal.get(YEAR);
	int beforeMonth = cal.get(MONTH);
	cal.add(MONTH, 2);
	int nextYear = cal.get(YEAR);
	int nextMonth = cal.get(MONTH);
	cal.add(MONTH, -1);
	
	String[] displayMonth = new String[12];
	for(int idx=0; idx<displayMonth.length; idx++){
		displayMonth[idx] = (idx+1)+"월";
	}
%>
<form name="calForm">
<input type="hidden" name="includePage" value="calendar" />
<h4>
	<a href="javascript:calFunction(<%=beforeYear%>, <%=beforeMonth%>);">이전달</a>
	<input type="text" name="year" value="<%=year %>" onblur="calFunction();"/>년
	<select name="month" onchange="calFunction();">
		<%
			String optionPtrn = "<option value='%s' %s>%s</option>";
			for(int idx=0; idx<displayMonth.length; idx++){
				String selected = "";
				if(idx==month) selected = "selected";
				out.println(
					String.format(optionPtrn, idx, selected,displayMonth[idx])		
				);
			}
		%>
	</select>
	<select name="language" onchange="calFunction();">
		<%
			Locale[] locales = Locale.getAvailableLocales();
			for(Locale tmp : locales){
				String displayLanguage = tmp.getDisplayLanguage(tmp);
				if(StringUtils.isBlank(displayLanguage)) continue;
				String languageTag = tmp.toLanguageTag();
				String selected = tmp.equals(clientLocale)?"selected":"";
				out.println(
					String.format(optionPtrn, languageTag, selected, displayLanguage)	
				);
			}
		%>
	</select>
	
	<a onclick="calFunction(<%=nextYear%>, <%=nextMonth%>);">다음달</a>
</h4>
</form>
<table>
	<thead>
		<tr>
			<%
				String ptrn2 = "<th>%s</th>";
				String[] weekStr = dfs.getWeekdays(); 
					
				for(int idx=1; idx<=7; idx++){
					out.println(
						String.format(ptrn2, weekStr[idx])		
					);
				}
			%>
		</tr>
	</thead>
	<tbody>
	<%	
		String ptrn = "<td>%s</td>";
		int count = 1;
		for(int row=0; row<6; row++){
			out.println("<tr>");
			for(int col=1; col<=7; col++){
				int dayCount = count++ - offset;
				String dayStr = (dayCount>0&&dayCount<=lastDate?
									dayCount:"&nbsp;")+"";
				out.println(
					String.format(ptrn, dayStr)		
				);
			}
			out.println("</tr>");
		}
	%>
	</tbody>
</table>
</body>
</html>
<%
	Map<String, Object> cookieMap = new HashMap<>();
	cookieMap.put("year", year);
	cookieMap.put("month", month);
	cookieMap.put("language", clientLocale.toLanguageTag());
// 	marshalling

	String jsonString = mapper.writeValueAsString(cookieMap);
	Cookie calendarCookie = new Cookie("calendarCookie", URLEncoder.encode(jsonString, "UTF-8"));
	calendarCookie.setPath(request.getContextPath());
	calendarCookie.setMaxAge(60*60*24*4);
	response.addCookie(calendarCookie);
%>








