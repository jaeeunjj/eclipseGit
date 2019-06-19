<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="user_auth" value="${sessionScope.authMember.mem_auth }"/>
<a class="nav-link text-white" href="${pageContext.request.contextPath}/member/memberList.do">회원관리</a>
<a class="nav-link text-white" href="${pageContext.request.contextPath}/alba/albaList.do">알바생관리</a>
<a class="nav-link text-white" href="${pageContext.request.contextPath}/buyer/buyerList.do">거래처관리</a>
<a class="nav-link text-white" href="${pageContext.request.contextPath}/prod/prodList.do">상품관리</a>
<a class="nav-link text-white" href="${pageContext.request.contextPath}/board/boardList.do">자유게시판</a>
<a class="nav-link text-white">방명록</a>
