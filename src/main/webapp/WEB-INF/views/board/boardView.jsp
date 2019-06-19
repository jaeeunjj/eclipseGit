<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>	
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
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
		formTagName:"hiddenForm",
		functionName:"paging",
		submitHandler:function(event){
			var queryString = $(event.target).serialize();
			$(event.target.page).val("");
			$.ajax({
				url:"${pageContext.request.contextPath}/reply/replyList.do",
				data : queryString,
				dataType : "json", // request header(Accept), response header(Content-Type)
				success : function(resp) {
				var trTags =  makeReplyList(resp);
					
					$("#listBody").html(trTags);
					var pagingHTML = resp.pagingHTML;
					$("#pagingArea").html(pagingHTML);
					var stateObj = {
							pagingHTML : pagingHTML,
							listHTML:$("#listBody").html()
				}
					
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
		
		});
			return false;
	}
	});
	paging(1);
	
	//Insert reply
	$("#replyForm").on("submit", function(event){
		event.preventDefault();
		var form = $(this);
		var queryString = $(this).serialize();
		var action = $(this).attr("action");
		$.ajax({
			url : action,
			method : "post",
			data : queryString,
			dataType : "json", // request header(Accept),response header(Content-type)
			success : function(resp) {
				if(resp.dataList){
					var trTags =  makeReplyList(resp);
					$("#listBody").html(trTags);
					var pagingHTML = resp.pagingHTML;
					$("#pagingArea").html(pagingHTML);
					var stateObj = {
							pagingHTML : pagingHTML,
							listHTML:$("#listBody").html()
						}
					$(".insertArea").val("");
					
				}else{
					if(resp.msg){
						alert(resp.msg);
					}
				}	
				
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
		
	});
	
	//keypress 키를 눌렀을때 이벤트 발생
	//keyup 키를 눌렀다 뗄때 이벤트 발생
	// 			data :{
				
	// 				rep_no : repNO
	// 				, bo_no :boNo
	// 				,rep_pass : repPass
					
	// 			} 이런식으로 data를 줄 수도 있음..
	
	
// 	alert($("#deletRep").length);
	//Delete reply
	$("#listBody").on("click", ".deleteRep",function(event){//동적인 element 에는 바인딩 하지않기.. 정적인 elemnt 에  이벤트 바인딩하고 자식 노드 사용하기.
		var delPass = $(this).prev().val();
		var repno= $(this).prop("id");
		$("#delPass").val(delPass);
		$("#rep_no").val(repno);
// 		id="rep_no"value = "${reply.rep_no}"
		
		var form = $("#deleteForm");
		var queryString = $("#deleteForm").serialize();
		var action = $("#deleteForm").attr("action");
		$.ajax({
			url : action,
			data : queryString,
			dataType : "json", // request header(Accept),response header(Content-type)
			success : function(resp) {
				if(resp.dataList){
					var trTags =  makeReplyList(resp);
					
					$("#listBody").html(trTags);
					var pagingHTML = resp.pagingHTML;
					$("#pagingArea").html(pagingHTML);
					var stateObj = {
							pagingHTML : pagingHTML,
							listHTML:$("#listBody").html()
						}
					
				}else{
					if(resp.msg){
						alert(resp.msg);
					}
				}	
				
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
		
		
	});
	
	
	$(".boardOthers").on("click",function(event){
		var hidebtn = $(this);
		var bo_no = ${board.bo_no};
		var btnid = $(this).prop("id");
		var url=null;
		var type="";
		
		if(btnid=="like"){
			url="${pageContext.request.contextPath}/board/like.do";
			type="LIKE";
		}else if(btnid=="hate"){
			url="${pageContext.request.contextPath}/board/like.do";
			type="HATE";
		}else{
			url="${pageContext.request.contextPath}/board/boardReport.do";
		}
		
		$.ajax({
			url : url,
			data : {bo_no :bo_no
					,type :type},
			dataType : "json", // request header(Accept),response header(Content-type)
			success : function(resp) {
				if(resp.msg){
					alert(resp.msg);
				}else{
				
				hidebtn.remove();
				var singosu = resp.bo_report;
				var like = resp.bo_like;
				var hate = resp.bo_hate;
				if(btnid=="like"){
					$("#likesu").html(like);
				}else if(btnid=="hate"){
					$("#hatesu").html(hate);
				}else{
					$("#singosu").html(singosu);
				}
				
				}
				
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
		
	});
	
});	


</script>
</head>
<body>
<div id="dialog-message">
	${message }
	 <c:remove var = "message" scope = "session"/>
</div>
	<table>
	
		<tr>
			<th>글번호</th>
			<td>${board.bo_no }</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>${board.bo_title }</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${board.bo_writer }</td>
		</tr>
		
		<tr>
			<th>작성일</th>
			<td>${board.bo_date }</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>${board.bo_content }</td>
		</tr>
		
		<tr>
			<th>조회수</th>
			<td>${board.bo_hit }</td>
		</tr>
		
		<tr>
			<th>첨부파일</th>
			<c:set var = "pdsList" value="${board.pdsList}"/>
			<td>
			<c:if test="${not empty pdsList[0].pds_filename }">
				<table>
					<c:forEach var="pds" items="${pdsList }">
						<c:url value ="/board/download.do" var="downloadURL">
							<c:param name="what" value="${pds.pds_no }" />
						</c:url>
					
					<tr>
						<td><a href="${downloadURL}">파일명 : ${pds.pds_filename } 파일크기:${pds.pds_fancysize }</a></td>
					</tr>
					</c:forEach>	
					
					
				</table>
				</c:if>
				<c:if test="${empty pdsList[0].pds_filename }">
					첨부 파일이 없습니다.
				</c:if>
			</td>
		</tr>
		
		<tr>
			<th>아이피</th>
			<td>${board.bo_ip }</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>${board.bo_mail }</td>
		</tr>
		
		<tr>
		<th>댓글 목록</th>
			<td>
				<table>
					<thead>
					<tr>
						<th>작성자</th>
						<th>IP</th>
						<th>댓글내용</th>
						<th>댓글날짜</th>
						<th>비밀번호 입력</th>
					</tr>
					</thead>
					<tbody id="listBody">
						

					</tbody>
					<tfoot>
					<tr>
					<td>
						<form name = "hiddenForm">
							<input type="hidden" name="page" />
							<input type="hidden" name="bo_no" value = "${board.bo_no }"/>
						</form>
						
						</td>
						
					</tr>
					
					<tr>
					<td colspan="7">
					<div id="pagingArea"></div>
					</td>
					</tr>
					</tfoot>

				</table>
			</td>
		</tr>
		<tr>
			<td colspan="2">
			<c:url value="/board/boardInsert.do" var="boardInsertURL">
				<c:param name="parent" value="${board.bo_no} "/>
			</c:url>
			
			<input type="button" value ="답글쓰기"
			 onclick="location.href='${boardInsertURL}';"
			/>
			<input type="button" value="목록으로" onclick="location.href='<c:url value="/board/boardList.do"/>';"/>
			
			<c:url value="/board/boardUpdate.do" var="boardUpdateURL">
				<c:param name="what" value="${board.bo_no}"/>
			</c:url>
			
			
			<input type="button" value ="수정하기" onclick="location.href='${boardUpdateURL}';"/>
			<hr/>
			
			<form id="deleteForm" action="<c:url value='/board/boardDelete.do'/>" method="post">
			비밀번호 입력 :<input type="text" name="bo_pass"/>
			<input type="hidden"  name ="bo_no" value ="${board.bo_no}" />
			<input type="submit" value ="글 삭제하기" />
			</form>
			
			<hr/>
			
		</td>
		</tr>
	</table>

	신고 :<span id="singosu">${board.bo_report }</span>
	
	<c:if test="${not fn:contains(cookie.singoCookie.value, board.bo_no) }">
	<input class ="boardOthers"  type="button" id="singo" value= "신고"/>
	</c:if>	
	
	좋아요 :<span id ="likesu">${board.bo_like }</span>
	
	<c:if test="${not fn:contains(cookie.likeCookie.value, board.bo_no) }">
	<input  class ="boardOthers" type="button" id ="like" value= "좋아요" />
	</c:if>
	
	
	싫어요 :<span  id = "hatesu"> ${board.bo_hate }</span>
	
	<c:if test="${not fn:contains(cookie.likeCookie.value, board.bo_no) }">
	<input class ="boardOthers" type="button" id="hate" value= "싫어요"/>
	</c:if>
	<hr/>
	
	
	<form  id ="replyForm" action ="<c:url value='/reply/replyInsert.do'/>">
		<h4>댓글달기</h4>
		<input type = "hidden" name="bo_no" value ="${board.bo_no }"/>
		작성자 : <input type="text" name = "rep_writer" class="insertArea"/><br/>
		비밀번호 : <input type="text" name = "rep_pass" class="insertArea" /><br/>
		<input type="hidden" name = "rep_ip" value="${pageContext.request.remoteAddr}"/>
		댓글내용 :<textarea name="rep_comment" class="insertArea"></textarea>
		<input type ="submit" value="댓글작성"/>
	
	</form>
	
	<form id = "deleteForm" action ="<c:url value='/reply/replyDelete.do'/>">
		<input type="hidden" id="rep_no" name="rep_no" />
		<input type="hidden" id="delPass" name="delPass"/>
		<input type="hidden" name="bo_no" value = "${board.bo_no }"/>
	</form>
	<br/>
	<br/>
	
	
</body>
</html>