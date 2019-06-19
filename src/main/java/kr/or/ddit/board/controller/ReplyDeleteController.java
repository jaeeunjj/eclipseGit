package kr.or.ddit.board.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.board.service.IBoardReplyService;
import kr.or.ddit.common.DeleteHint;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.ReplyVO;

@Controller
public class ReplyDeleteController {
	@Inject
	IBoardReplyService service;
	
	@RequestMapping("/reply/replyDelete.do")
	public String deleteRep (
			//errors 가 없으면  검증 실패시 무조건 400에러
			@Validated(DeleteHint.class) @ModelAttribute("reply") ReplyVO reply
			,Model model
			){
	
		String view = null;
		String msg=null;
		
		ServiceResult result = service.removeReply(reply);
		
		if(ServiceResult.OK.equals(result)) {
			view = "redirect:/reply/replyList.do?bo_no="+reply.getBo_no();
			
		}else {
			msg = "비밀번호가 맞지 않습니다.";
			model.addAttribute("sucess","false");
			model.addAttribute("msg", msg);
			view="jsonView";
		}
		
		return view;
	}
	
}
