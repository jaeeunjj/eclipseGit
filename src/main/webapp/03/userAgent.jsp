<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="kr.or.ddit.enumpkg.OsType"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
public String data="sharedData";
public enum BrowerType {
	IE("익플 계열"),TRIDENT("익플 11버전이후"), CHROME("크롬 계열"), 
	FIREFOX("파폭 계열"), OTHER("뫄뫄뫄");
	BrowerType(String text){
		this.text = text;
	}
	private String text;
	public String getText() {
		return text;
	}
	public static BrowerType matchedType(String userAgent) {
		BrowerType[] types = values();
		userAgent = userAgent.toUpperCase();
		BrowerType result = OTHER;
		for(BrowerType tmp :types) {
			if(userAgent.contains(tmp.name())) {
				result = tmp;
				break;
			}
		}
		return result;
	}
}
%>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>03/userAgent.jsp</title>
</head>
<body>
<h4>클라이언의 접속 환경을 확인(User-Agent).</h4>
<%
	String userAgent = request.getHeader("User-Agent");
	userAgent = userAgent.toLowerCase();
	String message = null;
	String pattern = "당신의 접속 환경은 %s입니다.";
	OsType osType = OsType.matchedType(userAgent);
	String text = osType.getText();
	message = String.format(pattern, text);
	
	String pattern2 = "당신의 브라우저는 %s입니다.";
	BrowerType bType = BrowerType.matchedType(userAgent);
	String text2 = bType.getText();
	String message2 = String.format(pattern2, text2);
// 	Map<String, String> osMap = new HashMap<String, String>();
// 	osMap.put("window", "윈도우 계열");
// 	osMap.put("mac", "애플 계열");
// 	osMap.put("android", "안드로이드 계열");
// 	osMap.put("other", "뫄뫄뫄");
// 	String matchedKey = "other";
// 	for(Entry<String,String> entry : osMap.entrySet()){
// 		String key = entry.getKey();
// 		if(userAgent.contains(key)){
// 			matchedKey = key;
// 			break;
// 		}	
// 	}
	
// 	if(userAgent.contains("window")){
// 		message = String.format(pattern, "윈도우 계열");
// 	}else if(userAgent.contains("mac")){
// 		message = String.format(pattern, "애플 계열");
// 	}else if(userAgent.contains("android")){
// 		message = String.format(pattern, "안드로이드 계열");
// 	}else{
// 		message = String.format(pattern, "뫄뫄뫄");
// 	}
%>
<script type="text/javascript">
	alert("<%=message%>\n<%=message2%>");
</script>
<!-- 윈도우계열, 애플계열, 안드로이드 -->
<!-- 단, 메시지는 alert 으로. -->
<!-- 당신의 접속 환경은 OOO 입니다. -->
<!-- window -> 윈도우 -->
<!-- iphone(mac) -> 애플 -->
<!-- android -> 안드로이드 -->
<!-- 당신의 브라우저는 OOO 입니다. -->
<!-- IE - > 익스플로러 -->
<!-- chrome -> 크롬 -->
<!-- firefox -> 파이어폭스 -->
</body>
</html>