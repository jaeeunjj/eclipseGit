package kr.or.ddit.board.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.board.service.IBoardServie;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.PagingVO;
@Controller
public class BoardRetreiveController {
	@Inject
	IBoardServie service;
	
	// 목록조회 : 페이징 기본, (전체, 제목, 작성자, 내용)기준의 검색기능	
	
	@RequestMapping("/board/boardList.do")//동기요청 처리
	public String boardList(
			@RequestParam(required=false, name="page",defaultValue="1")long currentPage
			,@RequestParam(required=false)String searchType
			,@RequestParam(required=false) String searchWord
			,Model model
			){

		PagingVO<BoardVO> pagingVO=new PagingVO<BoardVO>(10,7);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSearchType(searchType);
		pagingVO.setSearchWord(searchWord);
		
		long totalRecord = service.retriveBoardCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<BoardVO> boardList = service.retriveBoardList(pagingVO);
		pagingVO.setDataList(boardList);

		model.addAttribute("pagingVO", pagingVO);

		return "board/boardList";
		
	}
	
	
	@RequestMapping(value="/board/boardList.do", method=RequestMethod.GET, produces="application/json;charset=UTF-8")//비동기 요청 처리
	@ResponseBody
	public PagingVO<BoardVO> ajaxboardList(
			@RequestParam(required=false, name="page",defaultValue="1")long currentPage
			,@RequestParam(required=false)String searchType
			,@RequestParam(required=false) String searchWord
			,Model model
			){
		 boardList(currentPage, searchType, searchWord, model);
		 PagingVO<BoardVO>pagingVO = (PagingVO<BoardVO>) model.asMap().get("pagingVO");
		 return pagingVO;
	}
	
	
	//board View
	
	@RequestMapping("/board/boardView.do")
	public String boardView(
			@RequestParam(name="what",required=true)int bo_no
			,Model model
			){
		
		BoardVO board = service.retriveBoard(bo_no);
		model.addAttribute("board", board);
		return "board/boardView";
		
	}
		
}
