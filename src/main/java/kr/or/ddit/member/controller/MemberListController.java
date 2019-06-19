package kr.or.ddit.member.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PagingVO;


@Controller
@RequestMapping("/member/memberList.do")
public class MemberListController{
	
	@Inject
	IMemberService service;

	@RequestMapping(produces="application/json;charset=UTF-8")
	@ResponseBody
	public PagingVO<MemberVO> ajaxGet(
			@RequestParam(name="page", required=false, defaultValue="1") long currentPage
			,@RequestParam(required=false)String searchWord
			,@RequestParam(required=false)String searchType
			,Model model
			){
		
			doGet(currentPage,searchWord,searchType,model);
			 PagingVO<MemberVO> pagingVO = (PagingVO<MemberVO>) model.asMap().get("pagingVO");
		return pagingVO;
		
	}
	
	
	//동기 요청 처리
	@RequestMapping
	public String doGet(
			@RequestParam(name="page", required=false, defaultValue="1") long currentPage
			,@RequestParam(required=false)String searchWord
			,@RequestParam(required=false)String searchType
			,Model model
			){
		
		PagingVO<MemberVO> pagingVO = new PagingVO<MemberVO>(3, 5);
		pagingVO.setSearchType(searchType);
		pagingVO.setSearchWord(searchWord);
		
		pagingVO.setCurrentPage(currentPage);
		long totalRecord = service.retrieveMemberCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<MemberVO> memberList = service.retrieveMemberList(pagingVO);
		pagingVO.setDataList(memberList);
	
		String viewName = null;
		model.addAttribute("pagingVO", pagingVO);
			
		viewName = "member/memberList";
		
		return viewName;
	}
}
