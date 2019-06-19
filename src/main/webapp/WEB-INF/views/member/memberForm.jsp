
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<link rel="stylesheet" href="https://jqueryui.com/resources/demos/style.css">

<script type="text/javascript">
	<c:if test="${not empty message}">
		alert("${message }");
	</c:if>
	$(function(){
		$("[type='date']").datepicker({
			dateFormat:"yy-mm-dd",
			changeYear:true,
			changeMonth:true,
			language:"ko"
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

	<h4>신규회원 가입 양식</h4>
	<form:form method="post" enctype="multipart/form-data" commandName="member">
		<table class="table">
			<tr>
				<th>회원아이디</th>
				<td><input type="text" name="mem_id" 
					value="${member.mem_id }" />
					<form:errors path="mem_id" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="text" name="mem_pass" 
						value="${member.mem_pass }" />
					<form:errors path="mem_pass" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>회원명</th>
				<td><input type="text" name="mem_name" 
					value="${member.mem_name }" /><form:errors path="mem_name" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>이미지</th>
				<td>
					<input type="file" id="mem_image" name = "mem_image" accept="image/*"/>
					<span style="width: 200px; height: 200px;" id="previewArea"></span>
				</td>
			</tr>
			
			<tr>
				<th>주민번호1</th>
				<td><input type="text" name="mem_regno1"
					value="${member.mem_regno1 }" /><form:errors path="mem_regno1" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>주민번호2</th>
				<td><input type="text" name="mem_regno2"
					value="${member.mem_regno2 }" /><form:errors path="mem_regno2" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>생일</th>
				<td><input type="date" name="mem_bir"
					value="${member.mem_bir }" /><form:errors path="mem_bir" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>우편번호</th>
				<td><input type="text" name="mem_zip" 
					value="${member.mem_zip }" /><form:errors path="mem_zip" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>주소1</th>
				<td><input type="text" name="mem_add1" 
					value="${member.mem_add1 }" /><form:errors path="mem_add1" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>주소2</th>
				<td><input type="text" name="mem_add2" 
					value="${member.mem_add2 }" /><form:errors path="mem_add2" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>집전번</th>
				<td><input type="text" name="mem_hometel"
					value="${member.mem_hometel }" /><form:errors path="mem_hometel" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>회사전번</th>
				<td><input type="text" name="mem_comtel"
					value="${member.mem_comtel }" /><form:errors path="mem_comtel" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>휴대폰</th>
				<td><input type="text" name="mem_hp"
					value="${member.mem_hp }" /><form:errors path="mem_hp" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="text" name="mem_mail" 
					value="${member.mem_mail }" /><form:errors path="mem_mail" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>직업</th>
				<td><input type="text" name="mem_job"
					value="${member.mem_job }" /><form:errors path="mem_job" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>취미</th>
				<td><input type="text" name="mem_like"
					value="${member.mem_like }" /><form:errors path="mem_like" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>기념일</th>
				<td><input type="text" name="mem_memorial"
					value="${member.mem_memorial }" /><form:errors path="mem_memorial" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>기념일자</th>
				<td><input type="date" name="mem_memorialday"
					value="${member.mem_memorialday }" 
					placeholder="1999-01-01"
					/><form:errors path="mem_memorialday" element="span" cssClass="error" /></td>
			</tr>
			<tr>
				<th>마일리지</th>
				<td>1000</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="전송" />
					<input type="reset" value="취소" />
					<input type="button" value="뒤로가기" 
						onclick="history.go(-1);"
					/>
				</td>
			</tr>
		</table>
	</form:form>





