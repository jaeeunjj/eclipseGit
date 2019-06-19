<?xml version="1.0" encoding="UTF-8" ?>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
	
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="https://jqueryui.com/resources/demos/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

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
	  });
</script>
</head>
<body>
<div id="dialog-message">
	${message }
</div>
	<form:form modelAttribute ="buyer" method="post">
		<input type="hidden" name="buyer_id" value="${buyer.buyer_id}" />
		<table>
			<tr>
				<th>거래처이름</th>
				<td><input type="text" name="buyer_name" required
					value="${buyer.buyer_name}" />
					<form:errors path="buyer_name" element="span" cssClass="error"/>
					</td>
			</tr>
			<tr>
				<th>거래상품 대분류</th>
				<td>
					<select name="buyer_lgu" required>
					<c:forEach var="lprod" items="${lprodList}" >
					
					<option value='${lprod["lprod_gu"]}' ${lprod["lprod_gu"] eq 
					buyer["buyer_lgu"] ? "selected":""}>${lprod["lprod_nm"]}</option>
					
					</c:forEach>
					</select>				
				<form:errors path="buyer_lgu" element="span" cssClass="error"/>
				
				</td>
				
			</tr>
			<tr>
				<th>은행</th>
				<td><input type="text" name="buyer_bank"
					value="${buyer.buyer_bank}" />
					<form:errors path="buyer_bank" element="span" cssClass="error"/>
					</td>
			</tr>
			<tr>
				<th>계좌번호</th>
				<td><input type="text" name="buyer_bankno"
					value="${buyer.buyer_bankno}" />
					<form:errors path="buyer_bankno" element="span" cssClass="error"/>
					</td>
			</tr>
			<tr>
				<th>예금주</th>
				<td><input type="text" name="buyer_bankname"
					value="${buyer.buyer_bankname}" />
					<form:errors path="buyer_bankname" element="span" cssClass="error"/>
					</td>
			</tr>
			<tr>
				<th>우편번호</th>
				<td><input type="text" name="buyer_zip"
					value="${buyer.buyer_zip}" />
					<form:errors path="buyer_zip" element="span" cssClass="error"/>
					</td>
			</tr>
			<tr>
				<th>주소1</th>
				<td><input type="text" name="buyer_add1"
					value="${buyer.buyer_add1}" />
					<form:errors path="buyer_add1" element="span" cssClass="error"/>
					</td>
			</tr>
			<tr>
				<th>주소2</th>
				<td><input type="text" name="buyer_add2"
					value="${buyer.buyer_add2}" /><span class="error">${errors["buyer_add2"] }</span></td>
			</tr>
			<tr>
				<th>거래처전화번호</th>
				<td><input type="text" name="buyer_comtel" required
					value="${buyer.buyer_comtel}" />
					<form:errors path="buyer_comtel" element="span" cssClass="error"/>
					</td>
			</tr>
			<tr>
				<th>거래처팩스번호</th>
				<td><input type="text" name="buyer_fax" required
					value="${buyer.buyer_fax}" />
					<form:errors path="buyer_fax" element="span" cssClass="error"/>
					</td>
			</tr>
			<tr>
				<th>거래처이메일</th>
				<td><input type="text" name="buyer_mail" required
					value="${buyer.buyer_mail}" />
					<form:errors path="buyer_mail" element="span" cssClass="error"/>
					</td>
			</tr>
			<tr>
				<th>담당자</th>
				<td><input type="text" name="buyer_charger"
					value="${buyer.buyer_charger}" /><span class="error">${errors["buyer_charger"] }</span></td>
			</tr>
			<tr>
				<th>구내전화번호</th>
				<td><input type="text" name="buyer_telext"
					value="${buyer.buyer_telext }" /><span class="error">${errors["buyer_telext"] }</span></td>
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

</body>
</html>