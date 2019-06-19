<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="javax.crypto.SecretKey"%>
<%@page import="java.util.Date"%>
<%@page import="kr.or.ddit.utils.EncryptUitls"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	SecretKey key = EncryptUitls.generate128bitSecretKey();
	byte[] iv = EncryptUitls.generate128Iv(new Date().toString());
	Map<String, String> jsonMap = new HashMap<>();
	
	String encodedkey = EncryptUitls.encodingBase64(key.getEncoded());
	String encodedIv = EncryptUitls.encodingBase64(iv);
	
	jsonMap.put("encodedKey", encodedkey );
	jsonMap.put("encodedIv",encodedIv);
	
	session.setAttribute("secretKey", key);
	session.setAttribute("iv", iv);
	
	ObjectMapper mapper = new ObjectMapper();
	String json = mapper.writeValueAsString(jsonMap);
%>
<%=json %>