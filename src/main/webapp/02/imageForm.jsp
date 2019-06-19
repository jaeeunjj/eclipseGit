<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.io.FilenameFilter"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<script src="/webStudy01/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		var pattern = '<img src="../image.do?selImg=%I" />';
		var imageArea = $("#imageArea");
		$("[name='selImg']").on("change", function(event){
			// event.target
			var selImg = $(this).val();
			var imgTag = pattern.replace("%I", selImg);
			imageArea.html(imgTag);
		});
		
		$("#imgForm").on("submit", function(event){
			event.preventDefault();
			var selImg = $("[name='selImg']").val();
			var imgTag = pattern.replace("%I", selImg);
			imageArea.html(imgTag);
			return false;
		});
	});
</script>
<body>
<%
	ResourceBundle bundle = ResourceBundle.getBundle("kr.or.ddit.servlet01.sample");
	String folderPath = bundle.getString("sampleFolder");
	File sampleFolder = new File(folderPath);
// 	File[] files = sampleFolder.listFiles((dir, name)->{
// 		String mimeText = getServletContext().getMimeType(name);
// 		return mimeText.startsWith("image/");
// 	});
	File[] files = sampleFolder.listFiles(new FilenameFilter(){
		public boolean accept(File dir, String name){
			String mimeText = getServletContext().getMimeType(name);
	 		return mimeText.startsWith("image/");
		}
	});
	
	StringBuffer options = new StringBuffer();
	String pattern = "<option value='%1$s'>%1$s</option>";
	if (files != null) {
		for (File temp : files) {
			options.append(String.format(pattern, temp.getName()));
		} // for end
	} // if end
%>
<form id="imgForm" action="../image.do" method="post">
	<select name="selImg">
		<%=options %>
	</select>
	<input type="submit" value="전송" />
</form>
<div id="imageArea">

</div>
</body>
</html>













    