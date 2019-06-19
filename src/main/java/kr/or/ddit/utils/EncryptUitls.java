package kr.or.ddit.utils;

import java.security.InvalidKeyException;
import java.security.Key;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.util.HashMap;
import java.util.Map;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;

import org.apache.commons.codec.binary.Base64;

public class EncryptUitls {
	
	public static String encodingBase64 (byte[] encrypted){
		return Base64.encodeBase64String(encrypted);
	}
	
	public static String encryptSha512Base64(String plain){
		byte[] encrypted = encryptSha512(plain);
		return encodingBase64(encrypted);
		
	}
	
	public static byte[] decodingBase65(String encoded) {
		return Base64.decodeBase64(encoded);
	}
	
	
	public static byte[] encryptSha512(String plain) {
		MessageDigest md;
		try {
			md = MessageDigest.getInstance("SHA-512");
			byte[] encrypted = md.digest(plain.getBytes());
			String encoded = Base64.encodeBase64String(encrypted);
			return encrypted;
			
		} catch (NoSuchAlgorithmException e) {
			throw new RuntimeException(e);
		}
	}
	
	public static byte[] generate128Iv(String ivValue) throws Exception{
		byte[] iv = MessageDigest.getInstance("md5")
								.digest(ivValue.getBytes());
		return iv;
		
	}
	
	public static SecretKey generate128bitSecretKey() throws Exception{
		KeyGenerator keyGenerator = KeyGenerator.getInstance("AES");
		keyGenerator.init(128);
		SecretKey secretKey = keyGenerator.generateKey();
		return secretKey;
	}
	
	public static String encryptAESBase64(String plain, Key secretKey, byte[] iv) throws Exception {
		byte[] encrypted = encryptAES(plain, secretKey, iv);
		return encodingBase64(encrypted);
	}
	
	public static byte[] encryptAES(String plain, Key secretKey, byte[] iv) throws Exception{
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");	
		IvParameterSpec ivSpec = new IvParameterSpec(iv);
		cipher.init(Cipher.ENCRYPT_MODE, secretKey, ivSpec);
		byte[] encrypted = cipher.doFinal(plain.getBytes());
		return encrypted;
		
	}
	
	public static byte[] decryptAESFromBase64(String encoded, Key secretKey, byte[] iv) throws Exception{
		byte[] encrypted = decodingBase65(encoded);
		return decryptAES(encrypted, secretKey, iv);
		
	}
	
	public static byte[] decryptAES(byte[] encrypted, Key secretKey, byte[] iv) throws Exception {
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");	
		IvParameterSpec ivSpec = new IvParameterSpec(iv);
		cipher.init(Cipher.DECRYPT_MODE, secretKey, ivSpec);
		byte[] decrypted = cipher.doFinal(encrypted);
		return decrypted;
	}
	
	public static  void generate2048RSAKeyPair(Map<String, Key> keyMap) throws Exception{
		
		KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance("RSA");
		keyPairGenerator.initialize(2048);
		KeyPair keyPair = keyPairGenerator.generateKeyPair();
		PublicKey publicKey = keyPair.getPublic();
		PrivateKey privatekey = keyPair.getPrivate();
		keyMap.put("privateKey",privatekey);
		keyMap.put("publicKey",publicKey);
		
	}
	
	public static byte[] encryptRSA(String plain, Key key) throws Exception {
		Cipher cipher = Cipher.getInstance("RSA");
		cipher.init(Cipher.ENCRYPT_MODE,key);
		byte[] encrypted = cipher.doFinal(plain.getBytes());
		return encrypted;
	}
	
	public static String encryptRSABase64(String plain, Key key) throws Exception{
		byte[] encrypted = encryptRSA(plain, key);
		return encodingBase64(encrypted);
	}
	
	public static byte[] decryptRSA(byte[] encrypted, Key key) throws Exception {
		Cipher cipher = Cipher.getInstance("RSA");
		cipher.init(Cipher.DECRYPT_MODE,key);
		byte[] decrypted = cipher.doFinal(encrypted);
		return decrypted;
		
	}
	
	public static byte[] decryptRSAFromBase64(String encoded, Key key) throws Exception{
		byte[] encrypted = decodingBase65(encoded);
		return decryptRSA(encrypted, key);
	}
	
	
	public static void encryptExampleAES(String plain) throws Exception{
		Key secertkey = generate128bitSecretKey();
		byte[] iv = generate128Iv("테스트");
		String encoded = encryptAESBase64(plain, secertkey, iv);
		System.out.println("암호화 결과  : "+ encoded);
		
		byte[] decrypted = decryptAESFromBase64(encoded, secertkey, iv);
		System.out.println("복호화 결과 :" + new String (decrypted));
		
	}
	
	public static void encryptExampleRSA(String plain) throws Exception {
		Map<String, Key> keyMap = new HashMap<String, Key>();
		generate2048RSAKeyPair(keyMap);
		String encoded = encryptRSABase64(plain, keyMap.get("privateKey"));
		System.out.println(encoded);
		byte[] decrypted = decryptRSAFromBase64(encoded, keyMap.get("publicKey"));
		System.out.println(new String(decrypted));
		
		
	}
}
