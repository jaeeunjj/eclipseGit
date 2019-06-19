package kr.or.ddit.prod.controller;


import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.prod.dao.IOthersDAO;
import kr.or.ddit.prod.service.IProdService;
import kr.or.ddit.vo.ProdVO;

@Controller
public class ProdInsertController {
	@Inject
	IProdService service ;
	@Inject
	IOthersDAO othersDAO ;
	
	private void withOthersData(Model model) {
		// prodForm 에서 사용할 분류정보/거래처정보를 전달.
		model.addAttribute("lprodList", othersDAO.selectLprodList());
		model.addAttribute("buyerList", othersDAO.selectBuyerList(null));
	}
	
	@RequestMapping("/prod/prodInsert.do")
	public String doGet(Model model){
		withOthersData(model);
		return "prod/prodForm";
	}
	
	@RequestMapping(value ="/prod/prodInsert.do", method = RequestMethod.POST)
	public String doPost(
			@Validated
			@ModelAttribute("prod") ProdVO prod
			,BindingResult errors 
			,Model model
			){
		withOthersData(model);
		String view = null;
		String msg = null;
		if(!errors.hasErrors()) {
			ServiceResult result = service.createProd(prod);
			if(ServiceResult.OK.equals(result)) {
				view = "redirect:/prod/prodView.do?what="+prod.getProd_id();
			}else {
				view = "prod/prodForm";
				msg = "서버 오류, 다시 시도.";
			}
		}else {
			view = "prod/prodForm";
		}
		
		model.addAttribute("message", msg);
		
		return view;
	}

	

}
