package kr.or.ddit.buyer.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.buyer.service.IBuyerService;
import kr.or.ddit.prod.dao.IOthersDAO;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.BuyerVO;
import kr.or.ddit.vo.PagingVO;

@Controller
public class BuyerRetrieveController {
	@Inject
	IBuyerService service;
	@Inject
	IOthersDAO othersDAO ;
	
	@RequestMapping("/buyer/buyerList.do")
	public String buyerList(
			@RequestParam(required=false, name="page",defaultValue="1")long currentPage
			,@RequestParam(required=false)String searchType
			,@RequestParam(required=false)String searchWord
			,Model model
			){
		
		PagingVO<BuyerVO> pagingVO = new PagingVO<BuyerVO>(3, 5);
		pagingVO.setSearchType(searchType);
		pagingVO.setSearchWord(searchWord);
		pagingVO.setCurrentPage(currentPage);
		
		long totalRecord = service.retriveBuyerCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<BuyerVO> buyerList = service.retrieveBuyerList(pagingVO);
		pagingVO.setDataList(buyerList);
		model.addAttribute("pagingVO", pagingVO);
		
		return "buyer/buyerList";
		
	}
	
	@RequestMapping(value="/buyer/buyerList.do", method=RequestMethod.GET, produces="application/json;charset=UTF-8")
	@ResponseBody
	public PagingVO<BuyerVO> ajaxbuyerList(
			@RequestParam(required=false, name="page",defaultValue="1")long currentPage
			,@RequestParam(required=false)String searchType
			,@RequestParam(required=false)String searchWord
			,Model model
			){
		buyerList(currentPage, searchType, searchWord, model);
		PagingVO<BuyerVO>pagingVO = (PagingVO<BuyerVO>) model.asMap().get("pagingVO");
		return pagingVO;
		
	}
	
	@RequestMapping("/buyer/buyerView.do")
	public String viewGet(
			@RequestParam(name="what",required=true) String buyer_id
			,Model model
			){
		
		BuyerVO buyer = service.retriebeBuyer(buyer_id);
		model.addAttribute("buyer", buyer);
		
		return"buyer/buyerView";
	}
	
}
