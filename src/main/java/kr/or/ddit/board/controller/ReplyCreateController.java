package kr.or.ddit.board.controller;

import java.io.IOException;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.board.service.IBoardReplyService;
import kr.or.ddit.common.InsertHint;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.ReplyVO;

@Controller
public class ReplyCreateController {
	
	@Inject
	IBoardReplyService service; 
	
	@RequestMapping(value = "/reply/replyInsert.do", method= RequestMethod.POST)
	public String replyInsert (
			@Validated(InsertHint.class) @ModelAttribute("reply") ReplyVO reply
			,Errors errors
			, Model model
			) throws IOException {
		
		String view = null;
		String msg=null;
		
		if(!errors.hasErrors()) {
			ServiceResult result = service.createReply(reply);
			if(ServiceResult.OK.equals(result)) {
				view = "redirect:/reply/replyList.do?bo_no="+reply.getBo_no();
				
			}else {
				msg = "서버 오류, 다시 시도.";
				model.addAttribute("sucess","false");
				model.addAttribute("msg", msg);
				view ="jsonView";
			}
			
		}else {
			msg = "검증실패";
			model.addAttribute("sucess","false");
			model.addAttribute("msg", msg);
			view ="jsonView";
		}
		
		return view;
	}
	
		
	
}
