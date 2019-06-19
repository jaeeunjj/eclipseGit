<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	private void commandProcess(String command, 
								File srcFile, 
								File targetFile) throws IOException{
			if("copy".equals(command) || "move".equals(command)){
				try(
					FileInputStream fis = new FileInputStream(srcFile);
					FileOutputStream fos = new FileOutputStream(targetFile);
				){
					byte[] buffer = new byte[1024];
					int length = -1;
					while((length = fis.read(buffer))!=-1){
						fos.write(buffer, 0, length);
					}
					fos.flush();
				}
				if("move".equals(command)) srcFile.delete();
			}else if("delete".equals(command)){
				srcFile.delete();
			}else{
				throw new IllegalArgumentException("처리할 수 없는 명령임.");
			}
					
	}
%>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>06/servletContextDesc.jsp</title>
<script src="<%=request.getContextPath() %>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		var hiddenTag = $("#hiddenCommand");
		$(".radioBtn").on("click", function(){
// 			alert($(this).is(":checked"));
			var command = $(this).val();
			hiddenTag.val(command);
			hiddenTag.closest("form").submit();
		});
	});
</script>
</head>
<body>
<h4> ServletContext application 기본 객체 </h4>
<form>
	<input type="text" name="command" id="hiddenCommand"/>	
</form>
<pre>
	: 웹 어플리케이션과 서블릿 컨테이너(서버,WAS)에 대한 정보를 가진 객체이며,
	  하나의 어플리케이션을 대상으로 싱글턴의 형태로 관리됨.
	  
	  1) 서버에 대한 정보 획득 : 
	  		<%=application.getServerInfo() %>,
	  		<%=application.getMajorVersion() %>.<%=application.getMinorVersion() %>
	  2) 로그를 기록 : <% application.log("기록 메시지");  %>
	  3) 어플리케이션의 초기화 파라미터(컨텍스트 파라미터) 획득.
	  		<%=application.getInitParameter("appParam1") %>
	  4) 서버의 웹리소스를 확보할때.
	  		MimeText(문자열) getMimeType(파일명)
	  		파일시스템경로(realPath) getRealPath(서버방식의 URL)
	  		입력스트림 getResourceAsStream(서버방식의 URL);
	  		
	  		<input type="radio" class="radioBtn" name="command" value="copy" />복사
	  		<input type="radio" class="radioBtn" name="command" value="move"/>이동
	  		<input type="radio" class="radioBtn" name="command" value="delete"/>삭제
	  		<%
// 	  			String fileSystemPath = application.getRealPath("/images/Koala.jpg");
// 	  			out.println(fileSystemPath);
// 	  			InputStream in = application.getResourceAsStream("/images/Koala.jpg");
				String command = request.getParameter("command");
				if(StringUtils.isNotBlank(command)){
		  			String sourceUrl = "/images";
		  			String targetUrl = "/06";
		  			File sourceFolder = new File(application.getRealPath(sourceUrl));
		  			File targetFolder = new File(application.getRealPath(targetUrl));
		  			String[] imageNames = sourceFolder.list((dir,name)->{
		  				String mime = application.getMimeType(name);
	// 	  				short circuit
		  				return mime!=null && mime.startsWith("image/");
		  			});
		  			if(imageNames!=null){
		  				for(String imageName : imageNames){
		  					File srcFile = new File(sourceFolder, imageName);
		  					File targetFile = new File(targetFolder, imageName);
		  					try{
		  						commandProcess(command, srcFile, targetFile);
		  					}catch(IllegalArgumentException e){
		  						response.sendError(400, "니가 잘못했잖아!");
		  						return;
		  					}
		  				}
		  			}
				}
	  		%>
</pre>
<%-- <img src="<%=request.getContextPath() %>/06/Desert.jpg" /> --%>
</body>
</html>








