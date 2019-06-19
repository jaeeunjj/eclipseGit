<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h4> 연락처 관리 </h4>
<form id="addForm">
	<input type="hidden" name="addId" />
	<pre>
		이름 : <input type="text" name="name" />
		휴대폰 : <input type="text" name="hp" />
		메일 : <input type="text" name="mail" />
	</pre>
</form>
<input type="button" value="주소록 가져오기" id="addressList"/>
<input type="button" value="신규등록" id="addressInsert"/>
<input type="button" value="수정" id="addressUpdate"/>
<input type="button" value="삭제" id="addressDelete"/>
<table>
	<thead>
		<tr>
			<th>주소록아이디</th>
			<th>성명</th>
			<th>휴대폰</th>
		</tr>
	</thead>
	<tbody>
		
	</tbody>
</table>
<script type="text/javascript">
	var modifyList = function(resp){
		var trTags = [];
		$(resp).each(function(index, address){
			var tr = $("<tr>").append(
						$("<td>").attr({class:'addId'}).text(address.addId)
						, $("<td>").attr({class:'name'}).text(address.name)
						, $("<td>").attr({class:'hp'}).text(address.hp)
					);
			trTags.push(tr);
		});
		$("table>tbody").html(trTags);
		$("#addForm")[0].reset();
	}
	$("#addressList").on("click", function(){
		$.ajax({
			url : "${pageContext.request.contextPath}/address",
			method : "get",
			dataType : "json", // request header(Accept), response header(Content-Type)
			success : modifyList,
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
	});
	$("tbody").on("click", "tr" ,function(){
		var addId = $(this).find("td:first").text();
		$.ajax({
			url : "${pageContext.request.contextPath}/address/"+addId,
			method : "get",
			dataType : "json", // request header(Accept), response header(Content-Type)
			success : function(resp) {
// 				$("#addForm").find("[name='addId']").val(resp.addId);
				for(var prop in resp){
					$("#addForm").find("[name='"+prop+"']").val(resp[prop]);
				}
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
	});
	$("#addressUpdate").on("click", function(){
		var inputs = $("#addForm").find(":input");
		var sendData = {};
		$(inputs).each(function(index, input){
			var prop = $(input).attr("name");
			var value = $(input).val();
			sendData[prop]=value;
		});
		console.log(sendData);
		var jsonData = JSON.stringify(sendData);
		console.log(jsonData);
		// jQuery 의 비동기 리다이렉션 정책 : 최초 요청의 method 가 그대로 사용됨. 
		$.ajax({
			url : "${pageContext.request.contextPath}/address",
			method : "put",
			data : jsonData,
			contentType:"application/json;charset=UTF-8",
			dataType : "json", // request header(Accept), response header(Content-Type)
			success : modifyList,
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
	});
	$("#addressDelete").on("click", function(){
		var addId = $('[name="addId"]').val();
		$.ajax({
			url : "${pageContext.request.contextPath}/address/"+addId,
			method : "delete",
			dataType : "json", // request header(Accept), response header(Content-Type)
			success : modifyList,
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
	});
	
	$("#addressInsert").on("click", function(){
		var inputs = $("#addForm").find(":input");
		var sendData = {};
		$(inputs).each(function(index, input){
			var prop = $(input).attr("name");
			var value = $(input).val();
			sendData[prop]=value;
		});
		console.log(sendData);
		var jsonData = JSON.stringify(sendData);
		console.log(jsonData);
		$.ajax({
			url : "${pageContext.request.contextPath}/address",
			method : "post",
			data : jsonData,
			contentType:"application/json;charset=UTF-8",
			dataType : "json", // request header(Accept), response header(Content-Type)
			success : modifyList,
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
	});
</script>














