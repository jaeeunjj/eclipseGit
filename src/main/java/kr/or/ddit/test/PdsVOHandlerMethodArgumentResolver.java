package kr.or.ddit.test;

import javax.servlet.http.HttpServletRequest;

import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.or.ddit.vo.PdsVO;


public class PdsVOHandlerMethodArgumentResolver implements HandlerMethodArgumentResolver{

	@Override
	public boolean supportsParameter(MethodParameter parameter) {
		return PdsVO.class.equals(parameter.getParameterType());
		
	}

	@Override
	public Object resolveArgument(
			MethodParameter parameter, 
			ModelAndViewContainer mavContainer,
			NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
		String paramName = parameter.getParameterName();//==input tag name 속성
		String contentType = webRequest.getHeader("Content-Type");
		if(contentType==null || contentType.startsWith("multipart/"))
			return null;
		
		MultipartHttpServletRequest req=  webRequest.getNativeRequest(MultipartHttpServletRequest.class);
		MultipartFile file= req.getFile(paramName);
		PdsVO pds = null;
		if(file!=null && !file.isEmpty()){
			pds = new PdsVO(file);
		}
		return pds;
	}

}
