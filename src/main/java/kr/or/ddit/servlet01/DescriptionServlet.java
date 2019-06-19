package kr.or.ddit.servlet01;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet Spec.
 * 	: 자바 기반의 웹 어플리케이션 구현하기 위한 API 모음.
 * 
 * ** 서블릿 개발 단계
 * 1. HttpServlet 의 하위 클래스 구현->필요한 콜백 메소드 재정의.
 * 2. 컴파일 -> /WEB-INF/classes(컨텍스트의 classpath) 에 위치.
 * 3. Servlet Container 에 등록.
 *    1) web.xml 에 등록 : servlet->servlet-name, servlet-class
 *    2) @WebServlet 으로 등록(spec 3.0).
 * 4. 웹 리퀘스트를 받을 수 있도록 요청과의 매핑 설정
 * 	  1) web.xml 에 매핑 : servlet-mapping->servlet-name, url-pattern
 *    2) @WebServlet 으로 매핑(spec 3.0).     
 *    매핑 설정 방식
 *    - 경로 매핑 : /depth/*
 *    - 확장자 매핑 : *.do
 *      /depth/*.do (X)
 * 5. 서버 재구동
 * 
 * ** 서블릿 컨테이너 
 * 		: 서블릿의 라이프사이클을 담당하며, 특정 요청에 대해 해당 서블릿을 운영하는 주체.
 * 		: 컨테이너는 등록된 서블릿에 관한 설정정보를
 *        immutable 객체인 ServletConfig 객체로 생성하고, 
 *        init 메소드를 통해 서블릿으로 전달함.
 *    컨테이너의 서블릿 관리 특성
 *    1) singleton : 일반적으로 해당 서블릿의 인스턴스를 하나만 생성하는 구조.
 *    2) 특별한 설정(load-on-startup)이 없는한 매핑된 요청이 최초로 발생하면 객체 생성.
 * 
 * ** 서블릿의 콜백 메소드 종류
 * 		생명주기 콜백
 * 		1) init(생성)
 *      2) destroy(소멸)
 *      요청 처리 콜백
 *      1) service
 *      2) doXXX	
 *
 */
@WebServlet(loadOnStartup=1, urlPatterns="/desc", 
			initParams= {@WebInitParam(name="param1", value="파라미터값")})
public class DescriptionServlet extends HttpServlet{

	public DescriptionServlet() {
		super();
		System.out.println(getClass().getSimpleName()+"인스턴스 생성");
	}
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		System.out.println(getClass().getSimpleName()+" 초기화 ");
		String value = config.getInitParameter("param1");
		System.out.println("전달된 파라미터 : "+value);
	}
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("요청 접수");
		super.service(req, resp);
		System.out.println("요청 처리 완료");
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("doGet 메소드 내에서 요청 처리");
	}
	
	@Override
	public void destroy() {
		super.destroy();
		System.out.println(getClass().getSimpleName()+" 객체 소멸 ");
	}
}



















