<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="kr.or.ddit.vo.ItzyVO"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
<script type="text/javascript">
	function submitHandler(event){
		var form = event.target;
		var selValue = form.itzy.value;
// 		alert(selValue?true:false);
		if(!selValue) {
			return false;
		}else{
			return true;
		}
	}
</script>
</head>
<body>
<!-- 예지, 리아, 류진, 채령, 유나 -->
<%
	Map<String,ItzyVO> itzyMap = new LinkedHashMap<String,ItzyVO>();
	application.setAttribute("itzyMap", itzyMap);
	itzyMap.put("yezi", new ItzyVO("예지", "/itzy/yezi.jsp"));
	itzyMap.put("ria", new ItzyVO("리아", "/itzy/ria.jsp"));
	itzyMap.put("ryuzin", new ItzyVO("류진", "/itzy/ryuzin.jsp"));
	itzyMap.put("cheryung", new ItzyVO("채령", "/itzy/cheryung.jsp"));
	itzyMap.put("youna", new ItzyVO("유나", "/itzy/youna.jsp"));

%>
<%-- action="<%=request.getContextPath() %>/05/getMemberPage.do" --%>
<form onsubmit="return submitHandler(event);" name="idolForm">
	<input type="text" name="includePage" value="GETMEMBERPAGE" />
	<select name="itzy" onchange="document.getElementById('submitBtn').click();">
		<option value="">멤버</option>
		<%
			String ptrn = "<option value='%s'>%s</option>";
			for(Entry<String,ItzyVO> entry : itzyMap.entrySet()){
				String code = entry.getKey();
				ItzyVO vo = entry.getValue();
				out.println(
					String.format(ptrn, code, vo.getName())	
				);				
			}
		%>
	</select>
	<input id="submitBtn" type="submit" value="확인용" />
</form>
<h4><%=application.hashCode() %></h4>
<h4><%=getServletContext().hashCode() %></h4>
</body>
</html>












