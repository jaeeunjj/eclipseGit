package kr.or.ddit.prod.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.prod.dao.IOthersDAO;
import kr.or.ddit.prod.service.IProdService;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.ProdVO;

@Controller
public class ProdListController {
	
	@Inject
	IProdService service;
	
	@Inject
	IOthersDAO othersDAO;
	
			
	private void withOthersData(Model model) {
		// prodForm 에서 사용할 분류정보/거래처정보를 전달.
		model.addAttribute("lprodList", othersDAO.selectLprodList());
		model.addAttribute("buyerList", othersDAO.selectBuyerList(null));
	}
	
	@RequestMapping("/prod/prodList.do")
	public String prodList(@RequestParam(required=false, name="page",defaultValue="1")long currentPage, Model model, ProdVO prod, PagingVO<ProdVO> pagingVO){
		withOthersData(model);
		
		ProdVO searchProd = prod;
		pagingVO.setSearchData(searchProd);
		
		
		pagingVO.setCurrentPage(currentPage);
		long totalRecord = service.retrieveProdCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<ProdVO> prodList = service.retrieveProdList(pagingVO);
		pagingVO.setDataList(prodList);
		
		return 	"prod/prodList";
	}
	
	
	
	
	@RequestMapping(value="/prod/prodList.do", method=RequestMethod.GET, produces="application/json;charset=UTF-8")
	@ResponseBody
	public PagingVO<ProdVO> ajaxProdList(@RequestParam(required=false, name="page",defaultValue="1")long currentPage, Model model, ProdVO prod, PagingVO<ProdVO> pagingVO){
		prodList(currentPage,model, prod, pagingVO);
		return pagingVO;
	}
	
}

















