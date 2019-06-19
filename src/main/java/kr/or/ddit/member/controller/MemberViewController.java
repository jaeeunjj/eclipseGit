package kr.or.ddit.member.controller;


import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.vo.MemberVO;

//@WebServlet("/member/memberView.do")

@Controller
public class MemberViewController{
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	IMemberService service ;
	
	@RequestMapping("/member/memberView.do")
	public String doGet(@RequestParam(name="who", required=true) String mem_id, Model model) {
		
		if(logger.isDebugEnabled()) {
			logger.debug("{} 에 대한 상세조회", mem_id);
		}else {
			logger.info("{} 에 대한 상세조회", mem_id);
		}
		
		MemberVO member = service.retrieveMember(mem_id);
		model.addAttribute("member", member);
		 
		 return "member/memberView";
		
	}
}






