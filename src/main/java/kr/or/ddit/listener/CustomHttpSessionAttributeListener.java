package kr.or.ddit.listener;

import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;

import kr.or.ddit.Constants;
import kr.or.ddit.vo.MemberVO;

//@WebListener
public class CustomHttpSessionAttributeListener implements HttpSessionAttributeListener {

	@Override
	public void attributeAdded(HttpSessionBindingEvent event) {
		String attrName = event.getName();
		if("authMember".equals(attrName)) {
			ServletContext application = event.getSession().getServletContext();
			Set<MemberVO> userList = (Set<MemberVO>) application.getAttribute(Constants.USERLISTATTRNAME);
			MemberVO authMember = (MemberVO) event.getValue();
			userList.add(authMember);
		}
	}

	@Override
	public void attributeRemoved(HttpSessionBindingEvent event) {
		String attrName = event.getName();
		if("authMember".equals(attrName)) {
			ServletContext application = event.getSession().getServletContext();
			Set<MemberVO> userList = (Set<MemberVO>) application.getAttribute(Constants.USERLISTATTRNAME);
			MemberVO authMember = (MemberVO) event.getValue();
			userList.remove(authMember);
		}

	}

	@Override
	public void attributeReplaced(HttpSessionBindingEvent event) {
		// TODO Auto-generated method stub

	}

}
