package kr.or.ddit.common.controller;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.common.service.IAuthenticateService;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.utils.CookieUtil;
import kr.or.ddit.utils.CookieUtil.TextType;
import kr.or.ddit.vo.MemberVO;

//@WebServlet("/login/loginCheck.do")
@Controller
public class LoginCheckController  {
	
	@Inject
	IAuthenticateService service; 
	
	@RequestMapping("login/loginForm.do")
	public String loginForm(){
		
		return "login/loginForm";
	}
	
	@RequestMapping(value = "/login/loginCheck.do" , method=RequestMethod.POST)
	public String doPost(
			 @RequestParam(required=false)String mem_id
			,@RequestParam(required=false) String mem_pass
			,@RequestParam(required=false)String saveId
			,HttpServletRequest request, HttpServletResponse response
			,RedirectAttributes redirectAttributes
			) throws IOException{
		String goPage = null;
		HttpSession session = request.getSession(false);
		if(session==null || session.isNew()) {
			response.sendError(400, "정상절차에 의한 로그인 시도가 아님.");
			return null;
		}
		
		String message = null;
	// 2. 검증(필수파라미터 전송)
		if(StringUtils.isBlank(mem_id) || StringUtils.isBlank(mem_pass)){
	// 3. 불통(누락) loginForm.do 로 이동(원본 요청의 파라미터가 생존한채 전달)
			message = "아이디나 비번 누락";
			goPage = "redirect:/login/loginForm.do";
		}else{
			MemberVO member = new MemberVO(mem_id, mem_pass);
			Object result = service.authenticate(member);
	// 4. 통과(아이디와 비번이 같으면 인증 성공)
			if(result instanceof MemberVO) {
				int maxAge = 0;
				if(StringUtils.equals(saveId, "saved")) {
					maxAge = 60*60*24*7;
				}
				Cookie idCookie = CookieUtil.createCookie("idCookie", mem_id, 
										request.getContextPath(), TextType.PATH, maxAge);
				response.addCookie(idCookie);
//	 	4-1. 인증 성공 : 웰컴 페이지로 이동(원본 요청을 전달하지 않고 이동)
				if(mem_id.equals("c001")) {
					((MemberVO) result).setMem_auth("ROLE_ADMIN");

				}else {
					
					((MemberVO) result).setMem_auth("ROLE_USER");
				}
				
				session.setAttribute("authMember", result);
				goPage = "redirect:/";
			}else{
//	 	4-2. 인증 실패 : loginForm.do 로 이동(원본 요청의 파라미터가 생존한채 전달)
				
				if(ServiceResult.INVALIDPASSWORD.equals(result)) {
					message = "비밀번호 오류";
				}else {
					message = "존재하지 않는 아이디";
				}
				
				session.setAttribute("failedId", mem_id);
				goPage = "redirect:/login/loginForm.do";
			}
		}
		redirectAttributes.addFlashAttribute("message", message);
		return goPage;
	}
}
