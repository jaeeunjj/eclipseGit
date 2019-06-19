<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
    <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%-- <script type="text/javascript" src="<c:url value='/js/ckeditor/ckeditor.js'/>"></script> --%>
<script src="https://cdn.ckeditor.com/4.11.4/standard-all/ckeditor.js"></script>
<!-- Bootstrap core CSS -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/paging.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/makeReplyList.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="https://jqueryui.com/resources/demos/style.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
$(function(){
	$(".pdsDelBtn").on("click", function(event){
		var input = $("<input>").attr({
									type :"text"
									,name : "pdsDels"
									,value :$(this).prop("id")
								}) 
								
			$("#boardForm").append(input);
		 	$(this).prev().hide();
			$(this).hide();					
		
		});
	
	
	
	$( "#dialog-message" ).dialog({
	      modal: true,
	      autoOpen: ${not empty message },
	      buttons: {
	        Ok: function() {
	          $( this ).dialog( "close" );
	        }
	      }
	   });
	
	
	});


</script>
<title>Insert title here</title>
</head>
<style>
 	.b_1{
 		width: 100%;
 	}

</style>
<body>
<div id="dialog-message">
	${message }
	 <c:remove var = "message" scope = "session"/>
</div>
<form:form method="post" enctype="multipart/form-data" id="boardForm" commandName="board">
	<table>
			<tr>
				<th>제목</th>
				<td colspan="4"><input type="text" name="bo_title" id="title" class="b_1" 
					value="${board.bo_title}"
					placeholder="${not empty param.parent?'RE:':''}"
					/>
					<form:errors path="bo_title" element="span" cssClass="error" />
					</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><input type="text" name="bo_writer" 
					value="${board.bo_writer}" />
					<form:errors path="bo_writer" element="span" cssClass="error" />
					</td>
				<th>비밀번호</th>
				<td><input type="text" name="bo_pass" 
					 />
					 <form:errors path="bo_pass" element="span" cssClass="error" />
					 </td>	
			</tr>
			
			<tr>
					<th>이메일</th>
				<td><input type="text" name="bo_mail" value="${board.bo_mail}" /><span
					class="error">${errors["bo_mail"]}</span></td>			
			</tr>
			<c:set var = "pdsList" value="${board.pdsList}"/>
				<c:if test="${not empty pdsList[0].pds_filename }">
				<tr>
					<th>기존 첨부파일</th>
				
					<td>
					<hr/>
				
					<table>
						<c:forEach var="pds" items="${pdsList }">
						<tr>
							<td>
								<span>파일명 : ${pds.pds_filename } 파일크기:${pds.pds_fancysize }</span>
								<input type="button" value="삭제" class="pdsDelBtn" id="${pds.pds_no }">
								<div id="cBtnArea"></div>
							</td>
						</tr>
						</c:forEach>	
					</table>
				
					<hr/>
					</td>
					
				</tr>
			</c:if>
			
			<tr>
				<th> 첨부파일</th>
				<td>
					<input type="file" name ="bo_files">
					<input type="file" name ="bo_files">
					<input type="file" name ="bo_files">
				</td>
			</tr>
			
			
			<tr>
				<th colspan="4">내용</th>
			</tr>
			
			<tr>
			
			<td colspan="4"><textarea rows="10" name="bo_content" cols="50" id="bo_content"  class="b_1">${board.bo_content}
				</textarea>
				<span class="error">${errors["bo_content"]}</span>
				
			</td>
			</tr>
			
		</table>
		
		<br/>
		
		<input type="hidden" name = "bo_no" value="${board.bo_no}"/>
		<input type="hidden" name = "bo_parent" value="${param.parent}"/>
		<input type="hidden" name = "code_id" value="BT01"/>
		<input type="hidden" name = "bo_ip" value="${pageContext.request.remoteAddr}"/>
		<input type="submit" value="전송" />
		<input type="reset" value="취소" />
		<input type="button" value="뒤로가기" onclick="history.go(-1);"/>
		<input type="button" value="목록으로" onclick="location.href='<c:url value="/board/boardList.do"/>';"/>
		

</form:form>
</body>
 <script type="text/javascript">
 CKEDITOR.replace( "bo_content", {
  	filebrowserImageUploadUrl:"<c:url value='/board/imageUpload.do'/>"
  
	} );

 </script>

</html>