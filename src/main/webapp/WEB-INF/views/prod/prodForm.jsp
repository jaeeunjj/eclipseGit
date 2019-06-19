<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
	
<link rel="stylesheet" href="https://jqueryui.com/resources/demos/style.css">

<script type="text/javascript">
	$( function() {
	    $( "#dialog-message" ).dialog({
	      modal: true,
	      autoOpen: ${not empty message },
	      buttons: {
	        Ok: function() {
	          $( this ).dialog( "close" );
	        }
	      }
	    });
	    
	    
	    var previewArea = $("#previewArea");
		$("#prod_image").on("change", function(){
			var files = $(this).prop("files");
			var reader = new FileReader();
			reader.onloadend = function(event){
				var imgTag = $("<img/>").attr({src:event.target.result})
										.css({width:"200px", height :"200px"});
				previewArea.html(imgTag);
			}
			reader.readAsDataURL(files[0]);
						
		});
	    
	    
	    
	  } );
</script>

<div id="dialog-message">
	${message }
</div>
	<form:form modelAttribute="prod" method="post" enctype="multipart/form-data">
		<input type="hidden" name="prod_id" value="${prod.prod_id}" />
		<table>
			<tr>
				<th>상품명</th>
				<td><input type="text" name="prod_name" 
					value= "${prod.prod_name}" />
					<form:errors path="prod_name" element="span" cssClass="error"/>
					
				</td>
			</tr>
			<tr>
				<th>상품분류코드</th>
				<td>
					<select name="prod_lgu">
					<c:forEach var="lprod" items="${lprodList}">
							<option value='${lprod["lprod_gu"]}'>${lprod["lprod_nm"]}</option>
					</c:forEach>
						
					</select>
					<script type="text/javascript">
						$("[name='prod_lgu']").on("change", function(){
							var selLgu = $(this).val();
							$("[name='prod_buyer']>option:not(:first)").hide();
							$("."+selLgu).show();
							$("[name='prod_buyer']").val("");
						});
						$("[name='prod_lgu']").val("${prod.prod_lgu}"); 
					</script>
						<form:errors path="prod_lgu" element="span" cssClass="error"/></td>
			</tr>
			<tr>
				<th>거래처코드</th>
				<td>
					<select name="prod_buyer">
						<option value="">거래처선택</option>
						<c:forEach var="buyer" items="${buyerList}">
							<option class="${buyer.buyer_lgu}" value="${buyer.buyer_id}" ${buyer.buyer_id eq prod.prod_buyer?"selected":""} >${buyer.buyer_name}</option>
						</c:forEach>		
					</select>
						<form:errors path="prod_buyer" element="span" cssClass="error"/>
					</td>
			</tr>
			<tr>
				<th>구매가</th>
				<td><input type="number" name="prod_cost" 
					value="${prod.prod_cost}" />
						<form:errors path="prod_cost" element="span" cssClass="error"/>
					</td>
			</tr>
			<tr>
				<th>소비자가</th>
				<td><input type="number" name="prod_price" 
					value="${prod.prod_price}" />
						<form:errors path="prod_price" element="span" cssClass="error"/>
					</td>
			</tr>
			<tr>
				<th>판매가</th>
				<td><input type="number" name="prod_sale" 
					value="${prod.prod_sale}" />
						<form:errors path="prod_sale" element="span" cssClass="error"/>
					</td>
			</tr>
			<tr>
				<th>상품개략설명</th>
				<td><input type="text" name="prod_outline" 
					value="${prod.prod_outline}" /><span class="error">${errors["prod_outline"] }</span></td>
			</tr>
			<tr>
				<th>상세설명</th>
				<td><input type="text" name="prod_detail"
					value="${prod.prod_detail}" /><span class="error">${errors["prod_detail"] }</span></td>
			</tr>
			<tr>
				<th>상품이미지</th>
				<td>
					기존 상품 이미지<br>
					<img src = "<c:url value = '/prodImages/${prod.prod_img }'/>" /> <br>
				
					<input type="file" id="prod_image" name="prod_image" />
					<input type="text"   name="prod_img"  value = "${prod.prod_img }"/>
					<span style="width: 200px; height: 200px;" id="previewArea"></span>
					</td>
			</tr>
			<tr>
				<th>재고량</th>
				<td><input type="number" name="prod_totalstock" 
					value="${prod.prod_totalstock}" />
						<form:errors path="prod_totalstock" element="span" cssClass="error"/>
					</td>
			</tr>
			<tr>
				<th>신규일자등록일</th>
				<td><input type="text" name="prod_insdate"
					value="${prod.prod_insdate}" /><span class="error">
					</td>
			</tr>
			<tr>
				<th>안전재고수량</th>
				<td><input type="number" name="prod_properstock" 
					value="${prod.prod_properstock}" />
					<form:errors path="prod_properstock" element="span" cssClass="error"/>
					</td>
			</tr>
			<tr>
				<th>크기</th>
				<td><input type="text" name="prod_size"
					value="${prod.prod_size}" />
					</td>
			</tr>
			<tr>
				<th>색상</th>
				<td><input type="text" name="prod_color"
					value="${prod.prod_color}" />
					</td>
			</tr>
			<tr>
				<th>배달특기사항</th>
				<td><input type="text" name="prod_delivery"
					value="${prod.prod_delivery}" />
					</td>
			</tr>
			<tr>
				<th>단위수량</th>
				<td><input type="text" name="prod_unit"
					value="${prod.prod_unit}" />
					</td>
			</tr>
			<tr>
				<th>총입고량</th>
				<td><input type="number" name="prod_qtyin"
					value="${prod.prod_qtyin}" />
					</td>
			</tr>
			<tr>
				<th>총판매량</th>
				<td><input type="number" name="prod_qtysale"
					value="${prod.prod_qtysale}" />
					</td>
			</tr>
			<tr>
				<th>개당마일리지</th>
				<td><input type="number" name="prod_mileage"
					value="${prod.prod_mileage}" />
					</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="저장" />
					<input type="reset" value="취소" />
					<input type="button" value="목록으로" />
				</td>
			</tr>
		</table>
	</form:form>




