package kr.or.ddit.board.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.board.dao.IReplyDAO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.ReplyVO;

@Controller
public class ReplyRetreiveController {
	
	@Inject
	IReplyDAO service; 	
	@RequestMapping(value="/reply/replyList.do", produces="application/json;charset=UTF-8")
	@ResponseBody
	public PagingVO<ReplyVO> boardList(
			@RequestParam(name="page", required=false, defaultValue="1") long currentPage 
			,@RequestParam int bo_no
			){
		
		ReplyVO searchData = new ReplyVO();
		searchData.setBo_no(bo_no);
		
		
		PagingVO<ReplyVO> pagingVO = new PagingVO<ReplyVO>(5,5);
		
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSearchData(searchData);
		
		long totalRecord = service.selectReplyCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		
		List<ReplyVO> replyList = service.selectReplyList(pagingVO);
		pagingVO.setDataList(replyList);
		
		return pagingVO;
		
	}
	
		
		
}
	

