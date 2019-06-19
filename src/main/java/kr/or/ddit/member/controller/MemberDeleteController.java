package kr.or.ddit.member.controller;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.vo.MemberVO;

//@WebServlet("/member/memberDelete.do")
@Controller
public class MemberDeleteController {
	@Inject
	IMemberService service; 
	
	@RequestMapping(value="/member/memberDelete.do", method=RequestMethod.POST)
	public String doPost(HttpSession session, String mem_pass, HttpServletResponse resp) throws ServletException, IOException {
		MemberVO authMember =  (MemberVO) session.getAttribute("authMember");
		
		if(authMember==null ) {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "로그인 전이거나 비번 누락. 탈퇴 힘듦.");
			return null;
		}
		
		MemberVO member = new MemberVO(authMember.getMem_id(), mem_pass);
		ServiceResult result = service.removeMember(member);
		String view = null;
		
		String msg = null;
		switch (result) {
			case INVALIDPASSWORD:
				view = "redirect:/mypage.do";
				msg = "비번 오류";
				break;
			case FAILED:
				view = "redirect:/mypage.do";
				
				msg = "서버 오류, 쫌따 다시.";
				break;
	
			default: // OK
				view = "redirect:/messages/registOut.jsp";
				
				session.removeAttribute("authMember");
				break;
		}
		
		session.setAttribute("message", msg);
		return view;
		
	}
}











