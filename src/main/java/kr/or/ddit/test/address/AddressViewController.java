package kr.or.ddit.test.address;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/address")
public class AddressViewController {

	@RequestMapping("manage")
	public String view(){
		return "address/addressView";
	}
	
	
}
