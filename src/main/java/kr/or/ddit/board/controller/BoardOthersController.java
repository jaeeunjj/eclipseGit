package kr.or.ddit.board.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.board.service.BoardServiceImpl;
import kr.or.ddit.board.service.IBoardServie;
import kr.or.ddit.enumpkg.BrowserType;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.utils.CookieUtil;
import kr.or.ddit.utils.CookieUtil.TextType;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.PdsVO;

@Controller
public class BoardOthersController {
	@Inject
	IBoardServie service;

	@Inject
	WebApplicationContext  container;
	
	@RequestMapping(value="/board/boardReport.do" ,method=RequestMethod.GET, produces="application/json;charset=UTF-8")
	@ResponseBody
	public Object singoController(
			@RequestParam(name="bo_no")int bo_no
			, @CookieValue(name="singoCookie", required=false) String cookieString
			,HttpServletResponse resp
			){
		
		String msg=null;
		Map<String, Object> resultMap = new HashMap<String, Object>();
		BoardVO board = new BoardVO();
		
		ServiceResult result = service.singo(bo_no);
		if(ServiceResult.OK.equals(result)) {
			board = service.retriveBoard(bo_no);
			
			if(StringUtils.isBlank(cookieString)) {
				cookieString= bo_no+"";
				
			}else {
				cookieString=cookieString+","+bo_no;
				
			}
			
			Cookie cookie = CookieUtil.createCookie("singoCookie", cookieString
					, container.getServletContext().getContextPath() 
					, TextType.PATH, 60*60*24*7);
			resp.addCookie(cookie);
			
			
		}else {
			
			msg = "서버 오류, 다시 시도.";
			resultMap.put("sucess","false");
			resultMap.put("msg", msg);
		}
		
		
		if(resultMap.size()>0) {
			
			return resultMap;
		}else {
			
			return board;
		
		}
		
	}
	
 
	@RequestMapping(value="/board/like.do",method=RequestMethod.GET, produces="application/json;charset=UTF-8")
	@ResponseBody
	public Object likeHateController(
			@RequestParam(name="bo_no")int bo_no
			,@RequestParam(name="type")String lhParam
			, @CookieValue(name="likeCookie", required=false) String cookieString
			,HttpServletResponse resp
			) throws IOException{
		
		BoardVO board = new BoardVO();
		board = service.retriveBoard(bo_no);
		
		ServiceResult result =null;
		
		if("LIKE".equals(lhParam)) {
			
			board.setBo_like(board.getBo_like()+1);
			result = service.likeOrHate(board);
			
			if(StringUtils.isBlank(cookieString)) {
				cookieString= bo_no+"";
				
			}else {
				cookieString=cookieString+","+bo_no;
				
			}
			
			Cookie cookie = CookieUtil.createCookie("likeCookie"
					, cookieString
					, container.getServletContext().getContextPath() 
					, TextType.PATH, 60*60*24*7);
			resp.addCookie(cookie);
			
		}else if("HATE".equals(lhParam)) {
			
			board.setBo_hate(board.getBo_hate()+1);
			result = service.likeOrHate(board);
			
			if(StringUtils.isBlank(cookieString)) {
				cookieString = bo_no+"";
				
			}else {
				cookieString=cookieString+","+bo_no;
				
			}
			
			Cookie cookie = CookieUtil.createCookie("likeCookie"
					, cookieString
					, container.getServletContext().getContextPath() 
					, TextType.PATH, 60*60*24*7);
			resp.addCookie(cookie);
			
		}else {
			
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "잘못된 요청입니다.");
			return null;
			
		}
		
		String msg=null;
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		if(ServiceResult.OK.equals(result)) {
			board = service.retriveBoard(bo_no);
			
		}else {
			
			msg = "서버 오류, 다시 시도.";
			resultMap.put("sucess","false");
			resultMap.put("msg", msg);
		}
	
		if(resultMap.size()>0) {
			
			return resultMap;
			
		}else {
		
		return board;
		
		}
		
	}
	
		
	@RequestMapping("/board/download.do")
	public String downloadController(
			@RequestParam(name="what", required=true)int pds_no
			, @RequestHeader(name="User-Agent") String userAgent
			, HttpServletResponse resp
			) throws IOException{
		
		PdsVO pds = service.downloadPds(pds_no);
		
		String savePath =  pds.getPds_savepath();
		String filename = pds.getPds_filename();
		
		BrowserType brType = BrowserType.matchedType(userAgent);
		
		if(BrowserType.IE.equals(brType)||BrowserType.TRIDENT.equals(brType)) {
			filename = URLEncoder.encode((filename),"UTF-8");
		}else {
			filename = new String(filename.getBytes(),"ISO-8859-1");//대부분의 OS에서 사용하는 인코딩 방식
		}
		File saveFile = new File(savePath);
		
		if(!saveFile.exists()) {
			resp.sendError(400);
			return null;
		}
		
		resp.setHeader("Content-Disposition", "attachment;filename=\""+filename+"\"");
		
		try(
				 InputStream is = new FileInputStream(saveFile);
					OutputStream os = resp.getOutputStream();	
				){
			                
			IOUtils.copy(is, os);
			
		}
		
		
		return null;
		
	}
	
	
}
