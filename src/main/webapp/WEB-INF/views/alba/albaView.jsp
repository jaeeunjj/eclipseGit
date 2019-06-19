<?xml version="1.0" encoding="UTF-8" ?>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   		
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
 $(function(){
	 
	 var previewArea = $("#previewArea");
		$("#lic_image").on("change", function(){
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
	<!-- 한명의 알바생의 정보를 table 태그로 UI 구성 -->
	<table>
		<tr>
			<th>아이디</th>
			<td>${alba.al_id }</td>
		</tr>
		<tr>
			<th>이름</th>
			<td>${alba.al_name }</td>
		</tr>
		<tr>
			<th>나이</th>
			<td>${alba.al_age }</td>
		</tr>
		<tr>
			<th>주소</th>
			<td>${alba.al_address }</td>
		</tr>
		<tr>
			<th>휴대폰</th>
			<td>${alba.al_hp }</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>${alba.al_mail }</td>
		</tr>
		<tr>
			<th>성별</th>
			<td>${"M" eq alba.al_gen ? "남":"여" }</td>
		</tr>
		<tr>
			<th>혈액형</th>
			<td>${alba.al_btype }형</td>
		</tr>
		<tr>
			<th>알바생 최종학력</th>
			<c:set var="grade" value="${alba.grade}"/>
			<td>${grade.gr_name}</td>
<%-- 			<td><%=alba.getGrade().getGr_name()%></td> --%>
		</tr>
			<tr>
				<th>알바생 자격증</th>
				<td>
				<table>
				<c:set var="licenceList" value="${alba.licenceList}"/>
				<c:if test="${not empty licenceList}">
				<c:forEach items="${licenceList}" var="lic">
				
					<tr>
						<td>
						${lic.lic_name}
						이미지 등록하기 :
							<input type="file" id="lic_image" name = "lic_image" accept="image/*"/>
							<span style="width: 200px; height: 200px;" id="previewArea"></span>
						</td>
					</tr>
				</c:forEach>
				</c:if>
				
				<c:if test="${empty licenceList}">
					<tr>
						<td colspan="5"> 보유 자격증이 없음. </td>
					</tr>
				
				</c:if>				
				</table>
				</td>
			</tr>
		<tr>
			<th>특기사항</th>
			<td>${alba.al_spec }</td>
		</tr>
		<tr>
			<th>자기소개</th>
			<td>${alba.al_desc }</td>
		</tr>
		<tr>
			<th>경력사항</th>
			<td>${alba.al_career }</td>
		</tr>

		<tr>
			<td colspan="2"><input type="button" value="수정"
				onclick="location.href='albaUpdate.do?who=${alba.al_id }';" />
				<input type="button" value="삭제" /></td>
		</tr>
	</table>
</body>
</html>











