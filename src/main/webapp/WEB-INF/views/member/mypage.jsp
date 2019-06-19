<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="kr.or.ddit.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>   
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
<c:if test="${not empty message }">
alert("${message}");
	<c:remove var="message" scope="session"/>
</c:if>

	$(function(){
		var myPageForm = $("[name='myPageForm']");
		$("#delBtn").on("click", function(){
			var origin = myPageForm.attr("action");
			myPageForm.attr("action", "${pageContext.request.contextPath}/member/memberDelete.do")
			myPageForm.find(":input:not(.both)").prop("disabled", true);
			var password = myPageForm.find("[name='mem_pass']").val();
			if(password){
				myPageForm.submit();
			}else{
				alert("비밀번호 입력하셈.");
			}
			myPageForm.attr("action", origin);
			myPageForm.find(":input").prop("disabled", false);
		});
		
		
		var previewArea = $("#previewArea");
		$("#mem_image").on("change", function(){
			var files = $(this).prop("files");
			var reader = new FileReader();
			reader.onloadend = function(event){
				var imgTag = $("<img/>").attr({src:event.target.result})
										.css({width:"200px", height :"200px"});
				previewArea.html(imgTag);
			}
			reader.readAsDataURL(files[0]);
						
		});
	});
</script>
</head>
<body>

<h4>${sessionScope.authMember.mem_name}님의 마이페이지</h4>
<form:form modelAttribute="member" name="myPageForm" action="${pageContext.request.contextPath}/member/memberUpdate.do" 
		method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<th>회원아이디</th>
				<td><input type="text" class="both" name="mem_id" required
					value= "${member.mem_id}"/>
					<form:errors path="mem_id" element="span" cssClass="error"/>
					</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="text" name="mem_pass" required
						value="${member.mem_pass }" />
					<form:errors path="mem_pass" element="span" cssClass="error" /></td>
			</tr>
			
			<tr>
				<th>회원명</th>
				<td><input type="text" name="mem_name" required
					value="${member.mem_name}" /><form:errors path="mem_name" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>이미지</th>
				<c:if test="${not empty member.mem_img} "/>
				<td><img src="data:image/*;base64,${member.mem_imgBase64} " />
				이미지 수정 : <input type="file" id="mem_image" name = "mem_image" accept="image/*"/>
				<span style="width: 200px; height: 200px;" id="previewArea"></span>
				
				</td>

			</tr>

			<tr>
				<th>주민번호1</th>
				<td><input type="text" name="mem_regno1"
					value="${member.mem_regno1}" /><form:errors path="mem_regno1" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>주민번호2</th>
				<td><input type="text" name="mem_regno2"
					value="${member.mem_regno2}" /><form:errors path="mem_regno2" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>생일</th>
				<td><input type="text" name="mem_bir"
					value="${member.mem_bir}" /><form:errors path="mem_bir" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>우편번호</th>
				<td><input type="text" name="mem_zip" required
					value="${member.mem_zip}" /><form:errors path="mem_zip" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>주소1</th>
				<td><input type="text" name="mem_add1" required
					value="${member.mem_add1}" /><form:errors path="mem_add1" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>주소2</th>
				<td><input type="text" name="mem_add2" required
					value="${member.mem_add2}" /><form:errors path="mem_add2" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>집전번</th>
				<td><input type="text" name="mem_hometel"
					value="${member.mem_hometel}" /><form:errors path="mem_hometel" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>회사전번</th>
				<td><input type="text" name="mem_comtel"
					value="${member.mem_comtel}" /><form:errors path="mem_comtel" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>휴대폰</th>
				<td><input type="text" name="mem_hp"
					value="${member.mem_hp}" /><form:errors path="mem_hp" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="text" name="mem_mail" required
					value="${member.mem_mail}" /><form:errors path="mem_mail" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>직업</th>
				<td><input type="text" name="mem_job"
					value="${member.mem_job}" /><form:errors path="mem_job" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>취미</th>
				<td><input type="text" name="mem_like"
					value="${member.mem_like}" /><form:errors path="mem_like" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>기념일</th>
				<td><input type="text" name="mem_memorial"
					value="${member.mem_memorial}" /><form:errors path="mem_memorial" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>기념일자</th>
				<td><input type="text" name="mem_memorialday"
					value="${member.mem_memorialday}" /><form:errors path="mem_memorialday" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>마일리지</th>
				<td><input type="number" name="mem_mileage"
					value="${member.mem_mileage}" /><form:errors path="mem_mileage" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>탈퇴여부</th>
				<td><input type="text" name="mem_delete"
					value="${member.mem_delete }" /><form:errors path="mem_delete" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="저장" /> 
					<input type="reset" value="취소" /> 
					<input type="button" value="탈퇴" id="delBtn" class="both" />
				</td>
			</tr>
		</table>
	</form:form>
</body>
</html>















