package kr.or.ddit.utils;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Calendar;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

/**
 * 쿠키의 생성 및 쿠키 객체 핸들링을 지원하는 유틸리티
 * 쉽게 만들고, 쉽게 사용하도록.
 */
public class CookieUtil {

	private HttpServletRequest request;
	private Map<String, Cookie> cookieMap;
	
//	public void setRequest(HttpServletRequest request) {
//		this.request = request;
//	}
	
	public CookieUtil(HttpServletRequest request) {
		super();
		this.request = request;
		cookieMap = new LinkedHashMap<String, Cookie>();
		Cookie[] cookies = request.getCookies();
		if(cookies!=null) {
			for(Cookie tmp : cookies) {
				cookieMap.put(tmp.getName(), tmp);
			}
		}
		
	}

	public Cookie getCookie(String name) {
		return cookieMap.get(name);
	}
	
	public String getCookieValue(String name) {
		Cookie cookie = getCookie(name);
		String cookieValue = null;
		try {
			if(cookie!=null) {
				cookieValue = URLDecoder.decode(cookie.getValue(), "UTF-8");
			}
		return cookieValue;
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 쿠키 생성
	 * @param name 쿠키명
	 * @param value 쿠키값(UTF-8 로 인코딩)
	 * @return
	 */
	public static Cookie createCookie(String name, String value) {
		try {
			value = URLEncoder.encode(value, "UTF-8");
			Cookie cookie = new Cookie(name, value);
			return cookie;
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException(e);
		}
	}
	
	/**
	 * 쿠키생성
	 * @param name
	 * @param value
	 * @param maxAge 초단위 만료 시간
	 * @return
	 */
	public static Cookie createCookie(String name, String value, int maxAge){
		Cookie cookie = createCookie(name, value);
		cookie.setMaxAge(maxAge);
		return cookie;
	}
	
//	public static final boolean PATH = false;
//	public static final boolean DOMAIN = true;
	public static enum TextType{
		PATH, DOMAIN
	}
	
	/**
	 * @param name
	 * @param value
	 * @param text : 경로나 도메인으로 사용될 텍스트
	 * @param textType text값이 경로인지 도메인인지를 결정할 상수
	 * @return
	 */
	public static Cookie createCookie(String name, String value, String text, TextType textType) {
		Cookie cookie = createCookie(name, value);
		if(TextType.DOMAIN.equals(textType)) {
			cookie.setDomain(text);
		}else if(TextType.PATH.equals(textType)){
			cookie.setPath(text);
		}
		return cookie;
	}
	
	public static Cookie createCookie(String name, String value, 
						String text, TextType textType, int maxAge) {
		Cookie cookie = createCookie(name, value, text, textType);
		cookie.setMaxAge(maxAge);
		return cookie;
	}
}











