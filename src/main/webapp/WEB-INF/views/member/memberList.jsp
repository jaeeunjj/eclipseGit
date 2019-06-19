<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>   

<script type="text/javascript" src="${pageContext.request.contextPath }/js/paging.js"></script>
</head>
<body>
	<form>
	<input type ="radio" name="language" value="ko"
		onChange="document.forms[0].submit();"
		${"ko" eq param.language?"checked":"" }
	/> 한국어
	<input type ="radio" name="language" value="en"
		onChange="document.forms[0].submit();"
		${"en" eq param.language?"checked":"" }
	
	/> 영어
	</form>
	<c:if test="${empty param.language }">
			<c:set var="language" value="${pageContext.request.locale}"/>
		</c:if>
		<c:if test="${not empty param.language }">
			<c:set var="language" value="${param.language}"/>
	
		</c:if>
		
			
	
<table>
	<thead>
		<tr>
		<fmt:setLocale value="${language}" />
		<fmt:bundle basename="kr.or.ddit.msgs.message" prefix="member.">
			<th><fmt:message key="mem_id"/></th>
			<th><fmt:message key="mem_name"/></th>
			<th><fmt:message key="mem_hp"/></th>
			<th><fmt:message key="mem_add1"/></th>
			<th><fmt:message key="mem_mail"/></th>
			<th><fmt:message key="mem_mileage"/></th>
		</fmt:bundle>
		</tr>
	</thead>
	<tbody id="listBody">
		<c:set var="memberList" value="${pagingVO.dataList }"/>
		<c:forEach var="member" items="${memberList }">
			<tr>
				<td>${member.mem_id }</td>
				<td><a href="${pageContext.request.contextPath }/member/memberView.do?who=${member.mem_id }">${member.mem_name }</a></td>
				<td>${member.mem_hp }</td>
				<td>${member.mem_add1 }</td>
				<td>${member.mem_mail }</td>
				<td>${member.mem_mileage }</td>
			</tr>
		</c:forEach>
	</tbody>
	<tfoot>
		<tr>
			<td colspan="6">
				<form name="searchHiddenForm">
					<input type="hidden" name="searchType" value="${pagingVO.searchType}"/>
					<input type="hidden" name="searchWord" value="${pagingVO.searchWord }"/>
					<input type="hidden" name="page"/>
				</form>
				<form name="searchForm">
					<select name="searchType">
						<option value="all" ${pagingVO.searchType eq 'all' ? "selected":"" }>전체</option>	
						<option value="mem_name" ${pagingVO.searchType eq 'mem_name' ? "selected":"" }>이름</option>	
						<option value="mem_add1" ${pagingVO.searchType eq 'mem_add1' ? "selected":"" }>지역</option>	
						<option value="mem_hp" ${pagingVO.searchType eq 'mem_hp' ? "selected":"" }>휴대폰</option>	
					</select>
					<input type="text" name="searchWord" value="${pagingVO.searchWord }"/>
					<input type="submit" value="검색" />
				</form>
				<div id="pagingArea">
				${pagingVO.pagingHTML }
				</div>
			</td>
		</tr>
	</tfoot>
</table>
<script type="text/javascript">
makePaging({
	formTagName:"searchHiddenForm",
	functionName:"${pagingVO.functionName }",
	submitHandler:function(event){
		event.preventDefault();
		var queryString = $(event.target).serialize();
		event.target.page.value="";
		$.ajax({
			url : "${pageContext.request.contextPath }/member/memberList.do",
			data : queryString,
			dataType : "json", // request header(Accept), response header(Content-Type)
			success : function(resp) {
				var memberList = resp.dataList;
				var pagingHTML = resp.pagingHTML;
				var trTags = [];
				$(memberList).each(function(idx, member){
					var tr = $("<tr>").text(member.mem_id)
									.append(
										$("<td>").text(member.mem_id)		
										,$("<td>").append(
													$("<a>").text(member.mem_name)
															.attr("href", "${pageContext.request.contextPath }/member/memberView.do?who="+member.mem_id)
												 )
										,$("<td>").text(member.mem_hp)		 
										,$("<td>").text(member.mem_add1)		 
										,$("<td>").text(member.mem_mail)		 
										,$("<td>").text(member.mem_mileage)		 
									);
					trTags.push(tr);
				});
				$("#listBody").html(trTags);
				$('#pagingArea').html(resp.pagingHTML);
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
		return false; // 동기 요청 취소
	}
});
</script>










