<?xml version="1.0" encoding="UTF-8" ?>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
 <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   	
	
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
 <!-- Bootstrap core CSS -->
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<script type="text/javascript" src = "${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-xrRywqdh3PHs8keKZN+8zzc5TX0GRTLCcmivcbNJWm2rs5C8PRhcEn3czEjhAO9o" crossorigin="anonymous"></script>
<script type="text/javascript">
	function paging(page){
		location.href="?page="+page;
	}
	
	function clickHandler(albaId){
		location.href="${pageContext.request.contextPath }/alba/albaView.do?who="+albaId;
	}
</script>
</head>
<body>
	
	
	
<a href ="${pageContext.request.contextPath}/alba/albaInsert.do">신규알바 등록</a>
<!-- 	<input type="button" value="뒤로가기" /> -->
	
	<br>
	<br>
	<table>
		<thead>
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>나이</th>
				<th>주소</th>
				<th>휴대폰</th>
				<th>이메일</th>
			</tr>
		</thead>
		<tbody>
		<c:set value="${pagingVO.dataList }" var="albaList" />
		<c:choose>
			<c:when test="${not empty albaList }">
				<c:forEach items="${albaList }" var="alba">
					<tr>
						<td>${alba.al_id }</td>
						<td>
							<a href="javascript:clickHandler('${alba.al_id }')">${alba.al_name }</a>
						</td>
						<td>${alba.al_age }</td>
						<td>${alba.al_address }</td>
						<td>${alba.al_hp }</td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td colspan="5">
						알바생이 존재하지 않습니다.
					</td>
				</tr>
			</c:otherwise>
		</c:choose>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="7">
				<form name = "searchForm">
				<select name ="searchType">
					<option value="">자격증 선택</option>
					
					<c:forEach var="license" items="${licenceList}">
						<option class='${license.lic_code}' value='${license.lic_code}'>${license.lic_name}</option>
					
					</c:forEach>
				
				</select>
					<input type="text" name="searchWord" value=""/>
					<input type="hidden" name="page" />
					<input type="submit" value="검색" />
				</form>
					${pagingVO.pagingHTML } 
				</td>
			</tr>
		</tfoot>
	</table>
	
</body>
</html>










