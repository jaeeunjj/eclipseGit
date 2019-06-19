<?xml version="1.0" encoding="UTF-8" ?>

<%@page import="kr.or.ddit.utils.EncryptUitls"%>
<%@page import="javax.crypto.SecretKey"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
<SCRIPT type="text/javascript" src="<c:url value ='/js/jquery-3.3.1.min.js'/>"></SCRIPT>
<SCRIPT type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.9-1/crypto-js.min.js"></SCRIPT>
<script type="text/javascript">
   $(function(){
      $("#submitBtn").on("click",function(){
         $.ajax({
            url : "getSecretKey.jsp",
            dataType : "json",//키랑 iv 받으려고 object형태인 json
            success : function(resp) {//jsonmap
               var encodedKey = resp.encodedKey;//base64방식으로 인코딩
               var encodedIv = resp.encodedIv;
               var key= CryptoJS.enc.Base64.parse(encodedKey);
               var iv= CryptoJS.enc.Base64.parse(encodedIv);
               var plain = $("#password").val();
               var encrypted = CryptoJS.AES.encrypt(plain, key, { iv: iv });
               var encodedPassword = encrypted.ciphertext.toString(CryptoJS.enc.Base64);
               document.loginForm.encodedPassword.value=encodedPassword;
               document.loginForm.submit();
            },
            error : function(errorResp) {
               console.log(errorResp.status);
            }

         });
      });
   });
</script>
</head>
<body>
<form method="post" name="loginForm">
   <input type="text"name="encodedPassword"/>
</form>
<hr/>
<input type ="text" id="password"/>
<input type="button" value="로그인" id="submitBtn"/>
<hr/>
<c:if test="${not empty param.encodedPassword }">
   전송된 암호문 : ${param.encodedPassword }
<%
//복호화
   String encoded = request.getParameter("encodedPassword");
   SecretKey key= (SecretKey)session.getAttribute("secretKey");
   byte[] iv= (byte[])session.getAttribute("iv");
   byte[] decrypted= EncryptUitls.decryptAESFromBase64(encoded, key, iv);
%>

복호화 결과 : <%=new String(decrypted) %>
</c:if>




</body>
</html>