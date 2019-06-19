<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.vo.ProdVO"%>
<%@page import="kr.or.ddit.vo.BuyerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="buyer" class="kr.or.ddit.vo.BuyerVO" scope="request"></jsp:useBean>
	<table>
		<tr>
			<th>거래처아이디</th>
			<td>${buyer.buyer_id}</td>
		</tr>
		<tr>
			<th>거래처이름</th>
			<td>${buyer.buyer_name}</td>
		</tr>
		<tr>
			<th>거래품목정보</th>
			<td>
				<table>
					<thead>
						<tr>
							<th>상품명</th>
							<th>상품분류</th>
							<th>매입가</th>
							<th>상품개략설명</th>
							<th>재고수량</th>
						</tr>
					</thead>
					<tbody>
						<c:set var="pordList" value="${buyer.prodList }"/>
						<c:if test="${not empty prodList }">
							<c:forEach var="prod" items="${prodList }">
								<c:if test="${not empty prod.prod_name }">
									<tr>
										<td><a href="${pageContext.request.contextPath}/prod/prodView.do?what=${prod.prod_id}">${prod.prod_name}</a></td>
										<td>${buyer.lprod_nm}</td>
										<td>${prod.prod_cost}</td>
										<td>${prod.prod_outline}</td>
										<td>${prod.prod_totalstock}</td>
									</tr>
								</c:if>
								<c:if test="${empty prod.prod_name }">
									<tr><td>해당 거래처와 거래한 상품이 없습니다.</td></tr>
								</c:if>
							
							</c:forEach>
						</c:if>
					</tbody>
				</table>
			
			</td>
			
		</tr>
		<tr>
			<th>은행</th>
			<td>${buyer.buyer_bank}</td>
		</tr>
		<tr>
			<th>계좌번호</th>
			<td>${buyer.buyer_bankno}</td>
		</tr>
		<tr>
			<th>예금주</th>
			<td>${buyer.buyer_bankname}</td>
		</tr>
		<tr>
			<th>우편번호</th>
			<td>${buyer.buyer_zip}</td>
		</tr>
		<tr>
			<th>주소1</th>
			<td>${buyer.buyer_add1}</td>
		</tr>
		<tr>
			<th>주소2</th>
			<td>${buyer.buyer_add2}</td>
		</tr>
		<tr>
			<th>거래처전화번호</th>
			<td>${buyer.buyer_comtel}</td>
		</tr>
		<tr>
			<th>거래처팩스번호</th>
			<td>${buyer.buyer_fax}</td>
		</tr>
		<tr>
			<th>거래처이메일</th>
			<td>${buyer.buyer_mail}</td>
		</tr>
		<tr>
			<th>담당자</th>
			<td>${buyer.buyer_charger}</td>
		</tr>
		<tr>
			<th>구내전화번호</th>
			<td>${buyer.buyer_telext}</td>
		</tr>

		<tr>
			<td colspan="2">
				<input type="button" value="거래처정보수정" 
					onclick="location.href='${pageContext.request.contextPath}/buyer/buyerUpdate.do?what=${buyer.buyer_id}';"
				/>
				<input type="button" value="뒤로가기" 
					onclick="history.back();"
				/>
			</td>
		</tr>

	</table>

</body>
</html>