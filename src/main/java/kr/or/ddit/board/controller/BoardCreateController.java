package kr.or.ddit.board.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.board.service.IBoardServie;
import kr.or.ddit.common.InsertHint;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.BoardVO;

@Controller
public class BoardCreateController {
	
	@Inject
	IBoardServie service; 
	
	@RequestMapping("/board/boardInsert.do")
	public String doGet(){
		return "board/boardForm";
		
	}
	
	@RequestMapping(value = "/board/boardInsert.do", method=RequestMethod.POST)
	public String doPost(
			@Validated(InsertHint.class)
			@ModelAttribute("board")BoardVO board
			,BindingResult errors 
			,Model model
			){
	
		String view = null;
		String msg = null;
			if (!errors.hasErrors() ) {
				
			ServiceResult result = service.createBoard(board);
			if(ServiceResult.OK.equals(result)) {
				view = "redirect:/board/boardView.do?what="+board.getBo_no();
			}else {
				view= "board/boardForm";
				msg = "서버 오류, 다시 시도.";
			}
			
		}else {
			view= "board/boardForm";
		}
		model.addAttribute("message", msg);
		return view;
		
	}
	
	
}
