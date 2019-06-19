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
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" 	></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/paging.js"></script>


<script type="text/javascript">
	$(function(){
		makePaging({
			formTagName:"searchForm",
			functionName:"${pagingVO.functionName}",
			submitHandler:function(event){
				var queryString = $(event.target).serialize();
				$(event.target.page).val("");
				$.ajax({
					url:"${pageContext.request.contextPath}/buyer/buyerList.do",
					data : queryString,
					dataType : "json", // request header(Accept), response header(Content-Type)
					success : function(resp) {
						var buyerList = resp.dataList;
						var trTags = [];
						$(buyerList).each(function(idx, buyer){
							var tr = $("<tr>").prop("id", buyer.buyer_id )
											 .append(
												$("<td>").text(buyer.rnum),		 
												$("<td>").text(buyer.buyer_id),		 
												$("<td>").text(buyer.buyer_name),		 
												$("<td>").text(buyer.lprod_nm),		 
												$("<td>").text(buyer.buyer_comtel),		 
												$("<td>").text(buyer.buyer_add1),		 
												$("<td>").text(buyer.buyer_charger),
												$("<td>").text(buyer.buyer_mail)
											 
											 );
							trTags.push(tr);
						});
						
						$("#listBody").html(trTags);
						var pagingHTML = resp.pagingHTML;
						$("#pagingArea").html(pagingHTML);
						var stateObj = {
								pagingHTML : pagingHTML,
								listHTML:$("#listBody").html()
							}
						history.pushState(stateObj,"buyerList","?"+queryString);
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
			
			});
				return false;
		}
	});
		
		$("tbody#listBody").on("click", "tr",function(){
			var what = $(this).prop("id");
			location.href="${pageContext.request.contextPath}/buyer/buyerView.do?what="+what;
		}).css({cursor:"pointer"});
		$("[name='searchForm']").on("submit", function(event){
			event.preventDefault();
		});
		window.onpopstate= function(event){
			console.log(event);
			if(event.state){
				$("#pagingArea").html(event.state.pagingHTML);
				$("#listBody").html(event.state.listHTML);
			}else{
				location.reload();
			}
		}
	});	
	
	
</script>
</head>
<body>
<h4>거래처 목록 조회</h4>
<a href ="${pageContext.request.contextPath}/buyer/buyerInsert.do">신규거래처 등록</a>

<table>
	<thead>
		<tr>
			<th>행번호</th>
			<th>거래처 아이디</th>		
			<th>거래처 이름</th>		
			<th>취급상품대분류</th>
			<th>전화번호</th>		
			<th>주소</th>		
			<th>담당자</th>		
			<th>mail</th>		
		</tr>
	</thead>
	
	<tbody id ="listBody">
		<c:set var="buyerList" value="${pagingVO.dataList }"/>
		<c:if test="${not empty buyerList}">
		<c:forEach var="buyer" items="${buyerList}">
			<tr id="${buyer.buyer_id}">
					<td>${buyer.rnum}</td>
					<td>${buyer.buyer_id}</td>
					<td>${buyer.buyer_name}</td>
					<td>${buyer.lprod_nm}</td>
					<td>${buyer.buyer_comtel}</td>
					<td>${buyer.buyer_add1}</td>
					<td>${buyer.buyer_charger}</td>
					<td>${buyer.buyer_mail}</td>
				</tr>
				
				</c:forEach>
		</c:if>
		<c:if test="${empty buyerList}">
			<tr>
				<td colspan="8">
				 	거래처가 존재하지 않습니다.
				</td>
			</tr>
		</c:if>
	
	</tbody>
	<tfoot>
		<tr>
		<td colspan="8">
			<form name = "searchForm">
				<select name="searchType">
						<option value="all" ${pagingVO.searchType eq 'all' ? "selected":"" }>전체</option>	
						<option value="buyer_name" ${pagingVO.searchType eq 'buyer_name' ? "selected":"" }>거래처이름</option>	
						<option value="buyer_add1" ${pagingVO.searchType eq 'buyer_add1' ? "selected":"" }>거래처주소</option>	
						<option value="buyer_comtel" ${pagingVO.searchType eq 'buyer_comtel' ? "selected":"" }>거래처전화번호</option>	
				</select>
				<input type="text" name="searchWord" value="${pagingVO.searchWord }"/>
				<input type="hidden" name="page" />
				<input type="submit" value="검색" />
			</form>
				<div id="pagingArea">
				${pagingVO.pagingHTML } 
				</div>
			</td>
		</tr>
	</tfoot>
</table>

</body>
</html>