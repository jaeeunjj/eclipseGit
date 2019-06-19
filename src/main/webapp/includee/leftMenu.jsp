<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<form id="cmdForm" action="<%=request.getContextPath() %>/index.do">
	<input type="hidden" name="includePage" />
</form>    
<ul class="nav flex-column">
	<li class="nav-item">
		<a class="cmdA nav-link" href="gugudan">구구단</a>
	</li>
	<li class="nav-item">
		<a class="cmdA nav-link" href="sessionTimer">세션타이머</a>
	</li>
	<li class="nav-item">
		<a class="cmdA nav-link" href="idolForm">itzy 폼</a>
	</li>
	<li class="nav-item">
		<a class="cmdA nav-link" href="calendar">달력</a>
	</li>
	<li class="nav-item">
		<a class="cmdA nav-link" href="imageForm">이미지뷰어</a>
	</li>
	
	<li class="nav-item">
		현재 방문자 수 : ${applicationScope.userCount } <br/>
		<c:forEach items="${applicationScope.userList}" var="user">
			${user.mem_name }<br />
		</c:forEach>
		
	</li>
	<c:forEach items="${menus }" var="menu">
		<li>
			<a href="<c:url value='${menu.key }'/>">${menu.value }</a>
		
		</li>
	</c:forEach>
</ul>
<script type="text/javascript">
	var cmdForm = $("#cmdForm");
// 	alert(cmdForm.length);
	$(".cmdA").on("click", function(event){
		event.preventDefault();
		var href = $(this).attr("href");
<%-- 		$(this).attr("href", "<%=request.getContextPath()%>"+href); --%>
		cmdForm.find("[name='includePage']").val(href);
		cmdForm[0].includePage.value=href;
		cmdForm.submit();
		return false;
	});
</script>
