package kr.or.ddit.board.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.board.service.IBoardServie;
import kr.or.ddit.common.InsertHint;
import kr.or.ddit.common.UpdateHint;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.PdsVO;

@Controller
public class BoardUpdateController {
	@Inject
	IBoardServie service;
	
	@RequestMapping("/board/boardUpdate.do")
	public String boardUpdateView(
			@RequestParam(name="what", required=true) int bo_no
			,Model model
			,HttpSession session
			){
		
		BoardVO board = service.retriveBoard(bo_no);
		model.addAttribute("board", board);
		List<PdsVO> pdsList = board.getPdsList();
		
		//업데이트가 완료되지 않고  다시 Form으로 돌아올 경우 이전에 저장하고 있던 파일 목록을  다시 표시해 주기 위해 session 영역에 저장한다.
		session.setAttribute("pdsListSession",pdsList);
		
		return "board/boardForm";
		
	}
	
	@RequestMapping(value = "/board/boardUpdate.do", method = RequestMethod.POST)
	public String boardUpdate(
			@Validated(UpdateHint.class)
			@ModelAttribute("board")BoardVO board
			,BindingResult errors 
			,HttpSession session
			,Model model
			){
		
		board.setSavepdsList(board.getPdsList());
		
		//저장한 파일리스트를 session 영역에서 꺼내서 pdsList에 setting  해준다.
		board.setPdsList((List<PdsVO>) session.getAttribute("pdsListSession"));
		
		String view = null;
		String msg = null;
		
		if (!errors.hasErrors()) {
		
			ServiceResult result = service.modifyBoard(board);
			
				if(ServiceResult.OK.equals(result)) {
					
					//게시물 업데이트에 성공한 경우에는 session영역에 있는 pdsList를 삭제해준다.
					session.removeAttribute("pdsListSession");
					view = "redirect:/board/boardView.do?what="+board.getBo_no();
					
				
				}else if(ServiceResult.INVALIDPASSWORD.equals(result)){
					msg = "비밀번호가 맞지 않습니다.";
					view= "board/boardForm";
					
				}else {
					msg = "서버 오류, 다시 시도.";
					view= "board/boardForm";
				}
			
			}else {
				
				view= "board/boardForm";
				
			}
		
		model.addAttribute("message", msg);
		return view;
		
	}
	
	
	
	

}
