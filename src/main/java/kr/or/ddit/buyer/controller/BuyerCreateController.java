package kr.or.ddit.buyer.controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.buyer.service.IBuyerService;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.prod.dao.IOthersDAO;
import kr.or.ddit.vo.BuyerVO;

/**
 *  /buyer/buyerList.do
 *  /buyer/buyerView.do?what
 *  /buyer/buyerUpdate.do?what
 *  /buyer/buyerInsert.do
 *
 */

@Controller
public class BuyerCreateController {
	@Inject
	IBuyerService service;
	
	@Inject
	IOthersDAO othersDAO ;
	
	private void withOthersData(Model model) {
		// prodForm 에서 사용할 분류정보/거래처정보를 전달.
		model.addAttribute("lprodList", othersDAO.selectLprodList());
	
	}
	
	@RequestMapping("/buyer/buyerInsert.do")
	public String doGet(Model model){
		withOthersData(model);
		return "buyer/buyerForm";	
	}
	
	@RequestMapping(value="/buyer/buyerInsert.do",method=RequestMethod.POST )
	public String doPost(
			@Validated
			@ModelAttribute("buyer")BuyerVO buyer
			,BindingResult errors
			,Model model
			){
		withOthersData(model);
		
		model.addAttribute("errors", errors);
		
		String view = null;
		String msg=null;
		
		if(!errors.hasErrors()) {
			ServiceResult result = service.createBuyer(buyer);
			if(ServiceResult.OK.equals(result)) {
				view = "redirect:/buyer/buyerView.do?what="+buyer.getBuyer_id();
			}else {
				view= "buyer/buyerForm";
				msg = "서버 오류, 다시 시도.";
			}
			
		}else {
			view= "buyer/buyerForm";
		}
		model.addAttribute("message", msg);
		
		return view;
		
	}
	
}
