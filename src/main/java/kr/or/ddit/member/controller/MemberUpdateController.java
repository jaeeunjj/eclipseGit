package kr.or.ddit.member.controller;


import javax.inject.Inject;
    
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.common.UpdateHint;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.vo.MemberVO;

@Controller
public class MemberUpdateController{
	@Inject
	IMemberService service;

	@RequestMapping(value="/member/memberUpdate.do", method=RequestMethod.POST)
	public String doPost(
			@Validated(UpdateHint.class) @ModelAttribute("member") MemberVO member
			, Errors errors, Model model
			){
		
		String view = null;
		String msg = null;
		if (!errors.hasErrors()) {
			ServiceResult result = service.modifyMember(member);
			switch (result) {
			case INVALIDPASSWORD:
				view = "member/mypage";
				msg = "비번 오류";
				break;
			case FAILED:
				view = "member/mypage";
				msg = "서버 오류, 잠시 뒤 다시 한번 해보셈.";
				break;
			default:
				view = "redirect:/mypage.do";
			}
		} else {
			view = "member/mypage";
		}
		model.addAttribute("message", msg);
		return view;

	}

}
