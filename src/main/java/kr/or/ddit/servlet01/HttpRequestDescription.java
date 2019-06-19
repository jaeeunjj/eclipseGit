package kr.or.ddit.servlet01;

import java.io.IOException;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Http Request
 * 	1. Request Line 
 * 		URL, Protocol, Http Method
 *      Http Method : 요청의 목적/의도/방식
 *      1) GET(조회, Read) : 대부분의 요청은 GET 방식임.
 *               form 태그의 method 속성으로 변경 가능.
 *               조회 목적의 요청이므로 Body 영역을 구성하지 않음.
 *      2) POST(등록, Create) : 전송 목적의 요청이므로 Body 를 구성.
 *      3) PUT(수정, Update)
 *      4) DELETE(삭제)
 *      5) Head
 *      6) Option
 *      7) Trace
 *  2. Request Header : client 와 request에 대한 부가정보(metadata)
 *  	                이름과 값의 쌍으로 전달됨[name:value].
 *  				ex) Accept, Accept-language, User-Agent....
 *  3. Request Body(Content Body) : 서버로 보낼 내용(파라미터등..)
 *  
 * ===> MiddleWare(Server, WAS, ServletContainer, Tomcat) 
 * 		전달된 요청을 캡슐화해서 HttpServletRequest 객체를 생성.	
 * 
 *   클라이언트에서 서버로 파라미터를 전송하는 방법
 *   1) GET  : Line 을 통해 URL 의 일부 형태로 전송
 *   		URL?QueryString
 *   			section1&section2
 *   			param_name=param_value
 *   2) POST : Body 영역을 통해 전송
 *    
 *   ***파라미터에 특수문자가 포함된 경우
 *    IETF 에서 정한 RFC2396 규약에 따라
 *    % 인코딩(URLEncoding) 방식으로 인코딩됨.
 *    ex) %EB%8D%B0%EC%9D%B4%ED%84%B0
 *    ** 파라미터를 꺼내기 전 디코딩 설정 필요.
 *    1) POST :  request.setCharacterEncoding(encoding)
 *    2) GET : 서버 설정 변경 필요
 *           tomcat : server.xml -> connector(http) -> URIEncoding
 *           										useBodyEncodingForURI
 */
@WebServlet("/httpReq.do")
public class HttpRequestDescription extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		String protocol = req.getProtocol();
		String httpMethod = req.getMethod();
		System.out.printf("Line : %s %s %s\n", uri, protocol, httpMethod);
		System.out.println("===================");
		Enumeration<String> headerNames = req.getHeaderNames();
		while (headerNames.hasMoreElements()) {
			String name = headerNames.nextElement();
			String value = req.getHeader(name);
			System.out.printf("%s:%s\n", name, value);
		}
		System.out.println("=========================");
		req.setCharacterEncoding("UTF-8");
		Map<String, String[]> parameterMap = req.getParameterMap();	
		for(Entry<String, String[]>  entry: parameterMap.entrySet()) {
			String name = entry.getKey();
			String[] values = entry.getValue();
			System.out.printf("%s:%s\n", name, Arrays.toString(values));
		}
		
		System.out.println("=========================");
		String bodyEncoding = req.getCharacterEncoding();
		int contentLength = req.getContentLength();
		String contentType = req.getContentType();
		String contextPath = req.getContextPath();
		String serverAddr = req.getLocalAddr();
		int serverPort = req.getLocalPort();
		String clientAddr = req.getRemoteAddr();
		int clientPort = req.getRemotePort();
		Locale locale = req.getLocale();
		String queryString = req.getQueryString();
		System.out.printf("bodyEncoding : %s\n", bodyEncoding);
		System.out.printf("contentLength : %d\n", contentLength);
		System.out.printf("contentType : %s\n", contentType);
		System.out.printf("contextPath : %s\n", contextPath);
		System.out.printf("serverAddr : %s\n", serverAddr);
		System.out.printf("serverPort : %d\n", serverPort);
		System.out.printf("clientAddr : %s\n", clientAddr);
		System.out.printf("clientPort : %d\n", clientPort);
		System.out.printf("client Locale : %s\n", locale.toString());
		System.out.printf("queryString : %s\n", queryString);
	}
}














