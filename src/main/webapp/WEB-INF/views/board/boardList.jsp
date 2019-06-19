<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
<!-- Bootstrap core CSS -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/paging.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="https://jqueryui.com/resources/demos/style.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
$(function(){
	$( "#dialog-message" ).dialog({
	      modal: true,
	      autoOpen: ${not empty message },
	      buttons: {
	        Ok: function() {
	          $( this ).dialog( "close" );
	        }
	      }
	    });
	
	
		makePaging({
			formTagName:"searchForm",
			functionName:"${pagingVO.functionName}",
			submitHandler:function(event){
				var queryString = $(event.target).serialize();
				$(event.target.page).val("");
				$.ajax({
					url:"${pageContext.request.contextPath}/board/boardList.do",
					data : queryString,
					dataType : "json", // request header(Accept), response header(Content-Type)
					success : function(resp) {
						var boardList = resp.dataList;
						var pagingHTML = resp.pagingHTML;
						var trTags = [];
						$(boardList).each(function(idx, board){
							var tr = $("<tr>").prop("id", board.bo_no )
											 .append(	 
												$("<td>").text(board.bo_no),		 
												$("<td>").html(board.bo_title),		 
												$("<td>").text(board.bo_writer),		 
												$("<td>").text(board.bo_date),		 
												$("<td>").text(board.bo_like),		 
												$("<td>").text(board.bo_hate),
												$("<td>").text(board.bo_hit)
											 
											 );
							trTags.push(tr);
						});
						
						$("#listBody").html(trTags);
						$("#pagingArea").html(pagingHTML);
						var stateObj = {
								pagingHTML : pagingHTML,
								listHTML:$("#listBody").html()
							}
						history.pushState(stateObj,"boardList","?"+queryString);
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
			location.href="${pageContext.request.contextPath}/board/boardView.do?what="+what;
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
<div id="dialog-message">
	${message }
</div>

	<a href ="<c:url value='/board/boardInsert.do'/>">새글쓰기</a>
	<h4>게시글 목록 조회</h4>
	<table class="table table-striped table-bordered">
		<thead class="table-header thead-dark">
			<tr>
				<th>번호</th>
				<th>글 제목</th>
				<th>작성자</th>
				<th>작성일자</th>
				<th>좋아요</th>
				<th>싫어요</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody id="listBody">
			<c:set var="boardList" value="${pagingVO.dataList }" />
			<c:if test="${not empty boardList}">
				<c:forEach var="board" items="${boardList }">
					<tr id="${board.bo_no}">
						<td>${board.bo_no}</td>
						<td>${board.bo_title}</td>
						<td>${board.bo_writer}</td>
						<td>${board.bo_date}</td>
						<td>${board.bo_like}</td>
						<td>${board.bo_hate}</td>
						<td>${board.bo_hit}</td>
					</tr>

				</c:forEach>
			</c:if>
			<c:if test="${empty boardList}">
				<tr>
					<td colspan="7">게시글이 존재하지 않습니다.</td>
				</tr>
			</c:if>

		</tbody>
		<tfoot>
			<tr>
				<td colspan="7">
				<form name = "searchForm">
				<select name="searchType">
						<option value="all" ${pagingVO.searchType eq 'all' ? "selected":"" }>전체</option>	
						<option value="bo_title" ${pagingVO.searchType eq 'bo_title' ? "selected":"" }>제목</option>	
						<option value="bo_writer" ${pagingVO.searchType eq 'bo_writer' ? "selected":"" }>작성자</option>	
						<option value="bo_content" ${pagingVO.searchType eq 'bo_content' ? "selected":"" }>내용</option>	
				</select>
				<input type="text" name="searchWord" value="${pagingVO.searchWord }"/>
				<input type="hidden" name="page" />
				<input type="submit" value="검색" />
			</form>
				
					<div id="pagingArea">${pagingVO.pagingHTML }</div>
		
		</td>
		</tr>
		</tfoot>
	</table>

</body>
</html>