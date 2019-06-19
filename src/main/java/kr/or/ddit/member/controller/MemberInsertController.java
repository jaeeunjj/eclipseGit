package kr.or.ddit.member.controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.common.InsertHint;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.wrapper.FileUploadRequestWrapper;

//@WebServlet("/member/memberInsert.do")
@Controller
public class MemberInsertController {
	@Inject
	IMemberService service; 

	@RequestMapping("/member/memberInsert.do")
	public String doGet()  {
		// 가입 양식 제공
		String view = "member/memberForm";
		return view;
	}

	@RequestMapping(value ="/member/memberInsert.do", method = RequestMethod.POST)
	public String doPost(@Validated(InsertHint.class)@ModelAttribute("member")MemberVO member
			, BindingResult errors
			, Model model
			){
		
		
		String view = null;
		String msg = null;
		if (!errors.hasErrors()) {
			ServiceResult result = service.createMember(member);
			switch (result) {
			case PKDUPLICATED:
				view = "member/memberForm";
				msg = "아이디 중복, 딴거로 바꾸셈.";
				break;
			case FAILED:
				view = "member/memberForm";
				msg = "서버 오류, 잠시 뒤 다시 한번 해보셈.";
				break;
			default: // OK
				view = "redirect:/";
				
			}
		} else {
			view = "member/memberForm";
		}
		
		model.addAttribute("message", msg);
		return view;
		

	}


}
