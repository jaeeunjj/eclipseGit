package kr.or.ddit.common.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


//@WebServlet("/login/logout.do")
@Controller
public class LogOutController  {
	
	@RequestMapping(value = "/login/logout.do", method= RequestMethod.POST)
	public String doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		String viewName= null;
		if(session!=null && !session.isNew()) {
			session.invalidate();
		}
		// 웰컴페이지로 이동
		
		viewName= "redirect:/";
//		resp.sendRedirect(req.getContextPath() + "/");
		return viewName;

	}
}
