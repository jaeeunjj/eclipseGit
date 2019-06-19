package kr.or.ddit.test.address;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.vo.AddressVO;

@RestController
@RequestMapping("/address")
public class AddressController {
	private Map<String, AddressVO> addressMap;
	
	@PostConstruct
	public void init(){
		addressMap = new LinkedHashMap<>();
		addressMap.put("AD001", new AddressVO("AD001", "김은대", "000-000-0000", "aa@naver.com"));
		addressMap.put("AD002", new AddressVO("AD002", "이쁜이", "000-000-0000", "bb@naver.com"));
		addressMap.put("AD003", new AddressVO("AD003", "신용환", "000-000-0000", "cc@naver.com"));
	}
	
	@RequestMapping(method=RequestMethod.GET, produces="application/json;charset=UTF-8")
	public List<AddressVO> list(){
		return new ArrayList<>(addressMap.values());
	}
	
	@RequestMapping(value="{addId}", method=RequestMethod.GET)
	public AddressVO addressOne(@PathVariable String addId){
		return addressMap.get(addId);
	}
	
	@RequestMapping(method=RequestMethod.PUT)
	public List<AddressVO> update(@RequestBody AddressVO address){
		System.out.println(address);
		addressMap.put(address.getAddId(), address);
		return new ArrayList<>(addressMap.values());
	}
	
	@RequestMapping(value="{addId}", method=RequestMethod.DELETE)
	public List<AddressVO> delete(@PathVariable String addId){
		addressMap.remove(addId);
		return new ArrayList<>(addressMap.values());
	}
	
	@RequestMapping(method=RequestMethod.POST)
	public List<AddressVO>  insert( @RequestBody AddressVO address ){
		Iterator<String> keys = addressMap.keySet().iterator();
		String lastKey = null;
		while (keys.hasNext()) {
			lastKey = (String) keys.next();
		}
		String newId = String.format("AD%03d", Integer.parseInt(lastKey.substring(2))+1);
		address.setAddId(newId);
		addressMap.put(address.getAddId(), address);
		return new ArrayList<>(addressMap.values());
	}
	
}






