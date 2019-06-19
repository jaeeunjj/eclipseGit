<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	

	<!-- 구매기록 추가 : 상품코드, 상품명, 개략설명, 구매가, 마일리지 -->
	<!-- 해당 상품 클릭시 상품 상세 조회가 가능하도록. -->
	<table>
		<tr>
			<th>회원아이디</th>
			<td>${member.mem_id }</td>
		</tr>
		
		<tr>
			<th>회원명</th>
			<td>${member.mem_name }</td>
		<tr>
			<th>이미지</th>
			<td>
				<img src="data:image/*;base64,${member.mem_imgBase64} "/><br>
				
			</td>
		
		</tr>
		</tr>
		<tr>
			<th>주민번호1</th>
			<td>${member.mem_regno1 }</td>
		</tr>
		<tr>
			<th>주민번호2</th>
			<td>${member.mem_regno2 }</td>
		</tr>
		<tr>
			<th>생일</th>
			<td>${member.mem_bir }</td>
		</tr>
		<tr>
			<th>우편번호</th>
			<td>${member.mem_zip }</td>
		</tr>
		<tr>
			<th>주소1</th>
			<td>${member.mem_add1 }</td>
		</tr>
		<tr>
			<th>주소2</th>
			<td>${member.mem_add2 }</td>
		</tr>
		<tr>
			<th>집전번</th>
			<td>${member.mem_hometel }</td>
		</tr>
		<tr>
			<th>회사전번</th>
			<td>${member.mem_comtel }</td>
		</tr>
		<tr>
			<th>휴대폰</th>
			<td>${member.mem_hp }</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>${member.mem_mail }</td>
		</tr>
		<tr>
			<th>직업</th>
			<td>${member.mem_job }</td>
		</tr>
		<tr>
			<th>취미</th>
			<td>${member.mem_like }</td>
		</tr>
		<tr>
			<th>기념일</th>
			<td>${member.mem_memorial }</td>
		</tr>
		<tr>
			<th>기념일자</th>
			<td>${member.mem_memorialday }</td>
		</tr>
		<tr>
			<th>마일리지</th>
			<td>${member.mem_mileage }</td>
		</tr>
		<tr>
			<th>탈퇴여부</th>
			<td>${"Y" eq member.mem_delete ? "탈퇴":""}</td>
		</tr>
		<tr>
			<th> 구매 기록</th>
			<td>
				<table>
					<thead>
						<tr>
							<th>카트번호</th>
							<th>상품코드</th>
							<th>상품명</th>
							<th>구매가</th>
							<th>설명</th>
							<th>마일리지</th>
							<th>구매수량</th>
						</tr>
					</thead>
					<tbody>
						<c:set var="cartList" value="${member.cartList }"/>
						<c:if test="${not empty cartList }">
							<c:forEach items="${cartList }" var="cart">
								<c:forEach items="${cart.prodList }" var="prod">
									<tr>
										<c:url value="/prod/prodView.do" var="prodViewURL">
											<c:param name="what" value="${prod.prod_id }" />
										</c:url>
										<td>${cart.cart_no }</td>
										<td>${prod.prod_id }</td>
										<td><a href="${prodViewURL }">${prod.prod_name }</a></td>
										<td>${prod.prod_price }</td>
										<td>${prod.prod_outline }</td>
										<td>${prod.prod_mileage }</td>
										<td>${cart.cart_qty }</td>
									</tr>
								</c:forEach>
							</c:forEach>
						</c:if>
						<c:if test="${empty cartList }">
							<tr>
								<td colspan="5">구매기록 없음.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</td>			
		</tr>
	</table>






