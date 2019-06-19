package kr.or.ddit.common.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.enumpkg.ServiceType;

@Controller
public class IndexController {
	
	@RequestMapping({"/","/index.do"})
	public String index(@RequestParam(name="includePage", required=false) String pageParam
			, HttpServletResponse response, Model model ) throws IOException{
	
		String includePage = null;
		int statusCode = 0;
		if(StringUtils.isNotBlank(pageParam)){
			try{
				ServiceType serviceType = ServiceType.valueOf(pageParam.toUpperCase());
				includePage = serviceType.getServicePage();
			}catch(IllegalArgumentException e){
				statusCode = HttpServletResponse.SC_NOT_FOUND;
			}
		}
		String view = null;
		if(statusCode!=0){
			response.sendError(statusCode);
		}else {
			model.addAttribute("includePage", includePage);
			view = "index";
			
		}
		return view;
		
	}
}
