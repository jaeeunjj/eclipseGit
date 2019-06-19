package kr.or.ddit.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.vo.PdsVO;

@Controller
public class SpringFileUploadController {
	
	@RequestMapping("/test/upload")
	public String upload(String uploader, PdsVO uploadFile){
		System.out.println(uploadFile);
		return null;
		
	}
	
	
}
