package kr.or.ddit.board.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.board.service.IBoardServie;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.BoardVO;

@Controller
public class BoardDeleteController {
	@Inject
	IBoardServie service;
	
	@RequestMapping(value = "/board/boardDelete.do", method=RequestMethod.POST)
	public String deleteRep (
			RedirectAttributes redirectAttributes
			,int bo_no
			,String bo_pass
			){
		
		BoardVO board = new BoardVO();
		board.setBo_no(bo_no);
		board.setBo_pass(bo_pass);
		
		String view = null;
		String msg = null;
		
		ServiceResult result = service.removeBoard(board);
			
		if(ServiceResult.OK.equals(result)) {
			msg = bo_no+"번 글을 삭제하였습니다.";
			view = "redirect:/board/boardList.do";
			
		}else if(ServiceResult.INVALIDPASSWORD.equals(result)){
			
			msg = "비밀번호가 맞지 않습니다.";
			view = "redirect:/board/boardView.do?what="+board.getBo_no();
			
		}else {
			msg = "서버 오류, 다시 시도.";
			view = "redirect:/board/boardView.do?what="+board.getBo_no();
			
		}
		 redirectAttributes.addFlashAttribute("message", msg);
		return view;
		
	}
	
	
	
}
