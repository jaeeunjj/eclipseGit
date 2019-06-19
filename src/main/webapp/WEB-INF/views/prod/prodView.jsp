<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	

	<h4>${prod.prod_name }</h4>
	<table>
		<tr>
			<th>상품코드</th>
			<td>${prod.prod_id }</td>
		</tr>
		<tr>
			<th>상품명</th>
			<td>${prod.prod_name }</td>
		</tr>
		<tr>
			<th>상품분류</th>
			<td>${prod.lprod_nm }</td>
		</tr>
		<tr>
			<th>거래처정보</th>
			<td>
				<table>
					<thead>
						<tr>
							<th>거래처코드</th>
							<th>거래처명</th>
							<th>소재지</th>
							<th>연락처</th>
							<th>담당자명</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<c:set var="buyer" value="${prod.buyer }" />
							<td>${buyer.buyer_id }</td>
							<td>${buyer.buyer_name }</td>
							<td>${buyer.buyer_add1 }</td>
							<td>${buyer.buyer_comtel }</td>
							<td>${buyer.buyer_charger }</td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
		<tr>
			<th>구매가</th>
			<td>${prod.prod_cost }</td>
		</tr>
		<tr>
			<th>소비자가</th>
			<td>${prod.prod_price }</td>
		</tr>
		<tr>
			<th>판매가</th>
			<td>${prod.prod_sale }</td>
		</tr>
		<tr>
			<th>상품개략설명</th>
			<td>${prod.prod_outline }</td>
		</tr>
		<tr>
			<th>상세설명</th>
			<td>${prod.prod_detail }</td>
		</tr>
		<tr>
			<th>상품이미지</th>
			<td><img src = "<c:url value = '/prodImages/${prod.prod_img }'/>" /></td>
		</tr>
		<tr>
			<th>재고량</th>
			<td>${prod.prod_totalstock }</td>
		</tr>
		<tr>
			<th>신규일자등록일</th>
			<td>${prod.prod_insdate }</td>
		</tr>
		<tr>
			<th>안전재고수량</th>
			<td>${prod.prod_properstock }</td>
		</tr>
		<tr>
			<th>크기</th>
			<td>${prod.prod_size }</td>
		</tr>
		<tr>
			<th>색상</th>
			<td>${prod.prod_color }</td>
		</tr>
		<tr>
			<th>배달특기사항</th>
			<td>${prod.prod_delivery }</td>
		</tr>
		<tr>
			<th>단위수량</th>
			<td>${prod.prod_unit }</td>
		</tr>
		<tr>
			<th>총입고량</th>
			<td>${prod.prod_qtyin }</td>
		</tr>
		<tr>
			<th>총판매량</th>
			<td>${prod.prod_qtysale }</td>
		</tr>
		<tr>
			<th>개당마일리지</th>
			<td>${prod.prod_mileage }</td>
		</tr>
		<tr>
			<th>구매자 정보</th>
			<td>
				<table>
					<thead>
						<tr>
							<th>아이디</th>
							<th>이름</th>
							<th>주소</th>
							<th>휴대폰</th>
							<th>마일리지</th>
						</tr>
					</thead>
					<tbody>
						<c:set var="memberList" value="${prod.memberList }" />
						<c:choose>
							<c:when test="${not empty memberList }">
								<c:forEach items="${memberList }" var="member">
									<tr>
										<td>${member.mem_id }</td>
										<td>${member.mem_name }</td>
										<td>${member.mem_add1 }</td>
										<td>${member.mem_hp }</td>
										<td>${member.mem_mileage }</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="5"> 판매 기록이 없음. </td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<c:url value="/prod/prodUpdate.do" var="prodUpdateURL">
					<c:param name="what" value="${prod.prod_id }" />
				</c:url>
				
				<c:set var="user_auth" value="${sessionScope.authMember.mem_auth }"/>
<%-- 				<c:if test="${'ROLE_ADMIN' eq user_auth }"> --%>
				<input type="button" value="상품수정" 
					onclick="location.href='${prodUpdateURL}';"
				/>
				
<%-- 				</c:if> --%>
				
				<input type="button" value="뒤로가기" 
					onclick="history.back();"
				/>
			</td>
		</tr>
	</table>










