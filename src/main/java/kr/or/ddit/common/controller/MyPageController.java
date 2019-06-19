package kr.or.ddit.common.controller;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.vo.MemberVO;

//@WebServlet("/mypage.do")
@Controller
public class MyPageController{
	
	@Inject
	IMemberService service ;
	
	@RequestMapping("/mypage.do")
	public String doGet(HttpSession session, Model model) throws ServletException, IOException {
		
		MemberVO authMember =(MemberVO) session.getAttribute("authMember");
		String view = null;
		
		if(authMember==null) {
			view = "redirect:/login/loginForm.do";
		}else {
			String authId = authMember.getMem_id();
			MemberVO savedMember = service.retrieveMember(authId);
			model.addAttribute("member", savedMember);
			view = "member/mypage";
		}
		
		return view;
	}
}
