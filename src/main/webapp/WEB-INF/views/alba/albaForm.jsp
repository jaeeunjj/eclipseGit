<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="kr.or.ddit.vo.LicenseVO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="kr.or.ddit.vo.AlbaVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>02/albaForm.jsp</title>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.3.1.min.js"></script>
</head>
<body>
<!-- 프로필 : 이름(name, 문자), 나이(age, 숫자), 생년월일(birth, 문자),
			 주소(address, 문자), 전번(hp, 문자), -->
<!--          특기사항(spec, 문자), 자기소개(desc, 문자), 
				자격증(lic, 코드형문자), -->
<!--          학력(grade, 코드형문자), 경력사항(career, 문자), 
			성별(gen, 선택형문자), 혈액형(btype, 선택형문자),  -->
<!--          이메일(mail, 문자) -->

<jsp:useBean id="albaVO" class="kr.or.ddit.vo.AlbaVO" scope="request" />
<jsp:useBean id="errors" class="java.util.HashMap" scope="request" />
<form method="post" >
	<input type="hidden" name="al_id" value="<%=albaVO.getAl_id() %>" />
	<table>
		<tr>
			<th>이름</th>
			<td>
				<input type="text" name="al_name" 
					required="required"
					value="<%=albaVO.getAl_name() %>"
					/>
				<span class="error"><%=errors.get("al_name") %></span>	
			</td>
		</tr>	
		<tr>
			<th>나이</th>
			<td>
				<input type="number" min="10" max="100" 
						name="al_age" required="required"
						value="<%=albaVO.getAl_age()%>"
						/>
				<span class="error"><%=errors.get("al_age") %></span>		
			</td>
		</tr>	
		<tr>
			<th>주소</th>
			<td>
				<input type="text" name="al_address" 
						required="required"
						value="<%=albaVO.getAl_address() %>"
						/>
				<span class="error"><%=errors.get("al_address") %></span>		
			</td>
		</tr>	
		<tr>
			<th>휴대폰</th>
			<td>
				<input type="text" name="al_hp" required="required"
					placeholder="000-0000-0000"
					pattern="\d{3}-\d{3,4}-\d{4}"
					value="<%=albaVO.getAl_hp() %>"
				/>
				<span class="error"><%=errors.get("al_hp") %></span>
			</td>
		</tr>	
		<tr>
			<th>이메일</th>
			<td>
				<input type="email" name="al_mail" 
					value="<%=albaVO.getAl_mail() %>"
				/>
				<span class="error"><%=errors.get("al_mail") %></span>
			</td>
		</tr>	
		<tr>
			<th>성별</th>
			<td>
				<label><input type="radio" name="al_gen" checked value="M"/>남</label>
				<label><input type="radio" name="al_gen" value="F"/>여</label>
				<span class="error"><%=errors.get("al_gen") %></span>
			</td>
		</tr>	
		<tr>
			<th>혈액형</th>
			<td>
				<select name="al_btype">
					<option value="A" <%="A".equals(albaVO.getAl_btype())?"selected":"" %>>A형</option>
					<option value="B" <%="B".equals(albaVO.getAl_btype())?"selected":"" %>>B형</option>
					<option value="AB" <%="AB".equals(albaVO.getAl_btype())?"selected":"" %>>AB형</option>
					<option value="O" <%="O".equals(albaVO.getAl_btype())?"selected":"" %>>O형</option>
				</select>
				<span class="error"><%=errors.get("al_btype") %></span>
			</td>
		</tr>	
		<tr>
			<th>최종학력</th>
			<td>
				<select name="gr_code">
					<option value="G001">고졸</option>
					<option value="G002">초대졸</option>
					<option value="G003">대졸</option>
					<option value="G004">석사</option>
					<option value="G005">박사</option>
				</select>
				<script>
					$("[name='gr_code']").val("<%=albaVO.getGr_code() %>");
				</script>
				<span class="error"><%=errors.get("gr_code") %></span>
			</td>
		</tr>	
			<th>자격증</th>
			<td>
				<select name ="lic" multiple>
					<option value="">자격증 선택</option>
					<%
						List<LicenseVO> licenseList= (List)request.getAttribute("licenseList");
						for(LicenseVO license : licenseList){
							%>
							<option class="<%=license.getLic_code()%>" value="<%=license.getLic_code()%>"><%=license.getLic_name()%></option>
							
							<% 
						}
					%>
				
				</select>
				<span class="error"><%=errors.get("lic") %></span>
			</td>
		</tr>	
		<tr>
			<th>경력사항</th>
			<td>
				<textarea name="al_career" cols="100" rows="5"><%=albaVO.getAl_career() %></textarea>
				<span class="error"><%=errors.get("al_career") %></span>
			</td>
		</tr>	
		<tr>
			<th>특기사항</th>
			<td>
				<textarea name="al_spec" cols="100" rows="5"><%=albaVO.getAl_spec() %></textarea>
				<span class="error"><%=errors.get("al_spec") %></span>
			</td>
		</tr>	
		<tr>
			<th>자기소개</th>
			<td>
				<textarea name="al_desc" cols="100" rows="5"><%=albaVO.getAl_desc() %></textarea>
				<span class="error"><%=errors.get("al_desc") %></span>
			</td>
		</tr>	
		<tr>
			<td colspan="2">
				<button type="submit">전송</button>
				<input type="reset" value="취소" />
				<input type="button" value="뒤로가기" 
						onclick="history.go(-1);"
					/>
			</td>
		</tr>
	</table>
</form>
</body>
</html>



















