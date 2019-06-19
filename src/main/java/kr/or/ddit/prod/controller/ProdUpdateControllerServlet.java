package kr.or.ddit.prod.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Properties;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.common.UpdateHint;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.prod.dao.IOthersDAO;
import kr.or.ddit.prod.service.IProdService;
import kr.or.ddit.vo.ProdVO;
import kr.or.ddit.wrapper.FileUploadRequestWrapper;

@Controller
public class ProdUpdateControllerServlet {
	@Inject
	IProdService service;
	@Inject
	IOthersDAO othersDAO;
	
	
	private void withOthersData(Model model) {
		// prodForm 에서 사용할 분류정보/거래처정보를 전달.
		model.addAttribute("lprodList", othersDAO.selectLprodList());
		model.addAttribute("buyerList", othersDAO.selectBuyerList(null));
	}
	
	@RequestMapping("/prod/prodUpdate.do")
	public String doGet(
			@RequestParam(name="what" ,required=true) String prod_id
			,Model model
			){
		
		withOthersData(model);
		ProdVO prod = service.retrieveProd(prod_id);
		model.addAttribute("prod", prod);
		
		return "prod/prodForm";
	}
	
	@RequestMapping(value="/prod/prodUpdate.do", method=RequestMethod.POST)
	public String doPost(
			@Validated(UpdateHint.class)
			@ModelAttribute("prod") ProdVO prod
			,BindingResult errors 
			,Model model
			){
		withOthersData(model);
		String view = null;
		String msg = null;
		if(!errors.hasErrors()){
			ServiceResult result = service.modifyProd(prod);
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


























