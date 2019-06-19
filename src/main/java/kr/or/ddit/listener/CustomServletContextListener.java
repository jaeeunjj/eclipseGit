package kr.or.ddit.listener;

import java.util.HashSet;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.or.ddit.Constants;
import kr.or.ddit.vo.MemberVO;

@WebListener
public class CustomServletContextListener implements ServletContextListener {
	private static Logger logger = LoggerFactory.getLogger(CustomServletContextListener.class); 

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		ServletContext application = sce.getServletContext();
	
		application.setAttribute(Constants.USERCOUTATTRNAME, new Integer(0));
		application.setAttribute(Constants.USERLISTATTRNAME, new HashSet<MemberVO>());
		
			logger.info("{} 컨텍스트 초기화", application.getContextPath());
			
	
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		ServletContext application = sce.getServletContext();
		logger.info("{} 컨텍스트 소멸", application.getContextPath());
	}

}
