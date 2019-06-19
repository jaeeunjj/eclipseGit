<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<%
	String selectedImgName = (String)request.getAttribute("imgName");
%>
<script src="/webStudy01/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		var pattern = '<img src="%C?selImg=%I" />';
		var imageArea = $("#imageArea");
		$("[name='selImg']").on("change", function(event){
			// event.target
			var selImg = $(this).val();
			var form = $(this).closest("form");
			var imgTag = pattern.replace("%C", form.attr("action"))
					   			.replace("%I", selImg);
			imageArea.html(imgTag);
		});
		
		<%
		if(selectedImgName!=null){
		%>
			$("[name='selImg']").val("<%=selectedImgName%>");
			$("[name='selImg']").trigger("change");
		<%
		}
		%>
		
		$("#imgForm").on("submit", function(event){
			event.preventDefault();
			var selImg = $("[name='selImg']").val();
			var imgTag = pattern.replace("%C", $(this).attr("action"))
								.replace("%I", selImg);
			imageArea.html(imgTag);
			return false;
		});
	});
</script>
<body>
<form id="imgForm" action="<%=request.getContextPath() %>/image.do" method="post">
	<select name="selImg">
		<%
			 File[] imageFiles = (File[])request.getAttribute("imageFiles");
			String ptrn = "<option>%s</option>";
			for(File tmp : imageFiles){
				out.println(
					String.format(ptrn, tmp.getName())		
				);
			}
		%>
	</select>
	<input type="submit" value="전송" />
</form>
<div id="imageArea">
	
</div>
</body>
</html>













    