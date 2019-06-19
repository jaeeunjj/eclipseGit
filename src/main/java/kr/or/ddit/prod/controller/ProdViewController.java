package kr.or.ddit.prod.controller;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.prod.service.IProdService;
import kr.or.ddit.prod.service.ProdServiceImpl;
import kr.or.ddit.vo.ProdVO;

@Controller
public class ProdViewController  {
	@Inject
	IProdService service; 
	@RequestMapping("/prod/prodView.do")
	public String doGet(
			@RequestParam(name="what",required=true)String prod_id
			,Model model){
		
		ProdVO prod =  service.retrieveProd(prod_id);
		model.addAttribute("prod", prod);
		
		return  "prod/prodView";
	}
}












