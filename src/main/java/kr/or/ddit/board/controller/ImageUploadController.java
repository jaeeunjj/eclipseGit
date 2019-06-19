package kr.or.ddit.board.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.wrapper.FileUploadRequestWrapper;

@Controller
public class ImageUploadController {
	
	@Value("#{appInfo['boardImages']}")//spEL사용
	String saveUrl;
	
	@Inject
	WebApplicationContext rootcontainer;
	
	File saveFolder;
	
	@PostConstruct
	public void init(){
		String realPath = rootcontainer.getServletContext().getRealPath(saveUrl);
		saveFolder = new File(realPath);
		if(saveFolder.exists()) saveFolder.mkdirs();
		
	}
	
	@RequestMapping(value="/board/imageUpload.do", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> imageUpload(
			@RequestPart(name="upload", required=true) MultipartFile fileItem
			) throws IOException{
			Map<String, Object> resultMap = new HashMap<String, Object>();
			if(fileItem!=null) {
				if(!saveFolder.exists())saveFolder.mkdirs();
				String savename = UUID.randomUUID().toString();	
				
			try(
					
					InputStream is = fileItem.getInputStream();
//					PrintWriter out = resp.getWriter();
					){
					FileUtils.copyInputStreamToFile(is, new File(saveFolder,savename));
					resultMap.put("fileName",fileItem.getName());
					resultMap.put("uploaded",1);
					resultMap.put("url",rootcontainer.getServletContext().getContextPath()+saveUrl+"/"+savename);
					
					
				}catch (IOException e) {
				Map<String, Object> error = new HashMap<>();
				error.put("number", 500);
				error.put("message", e.getMessage());
				resultMap.put("error", error);
				}	
					
				}
			
		
		return  resultMap;
	}
}














