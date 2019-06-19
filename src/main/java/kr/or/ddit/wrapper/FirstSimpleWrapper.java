package kr.or.ddit.wrapper;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

public class FirstSimpleWrapper extends HttpServletRequestWrapper {

	public FirstSimpleWrapper(HttpServletRequest request) {
		super(request);
	
	}

	@Override
	public String getParameter(String name) {
		if("who".equals(name)) {
			return "c001"; 
		}else {
			
			return super.getParameter(name);	
		}
		
	}
	
	
}
