package kr.or.ddit.servlet01;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ResourceBundle;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import kr.or.ddit.utils.CookieUtil;
import kr.or.ddit.utils.CookieUtil.TextType;

@WebServlet("/image.do")
public class ImageProviderServlet extends HttpServlet {
	File sampleFolder;
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		ResourceBundle bundle = ResourceBundle.getBundle("kr.or.ddit.servlet01.sample");
		String folderPath = bundle.getString("sampleFolder");
		sampleFolder = new File(folderPath);
	}
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 파라미터 확보(selImg)
		String selImg = req.getParameter("selImg");
		// 검증
		if(StringUtils.isBlank(selImg)) {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST, 
					"이미지를 선택하시오.");
			return;
		}
		// 이미지 존재 여부
		File imageFile = new File(sampleFolder, selImg);
		if(!imageFile.exists()) {
			resp.sendError(HttpServletResponse.SC_NOT_FOUND, "이미지가 없음.");
			return;
		}
		
		// 쿠키 셋팅
//		Cookie cookie = new Cookie("imgCookie", URLEncoder.encode(selImg, "UTF-8"));
//		cookie.setMaxAge(60*60*24*7);
//		cookie.setPath(req.getContextPath());
		Cookie cookie = CookieUtil.createCookie("imgCookie", selImg, req.getContextPath(), 
								TextType.PATH, 60*60*24*7);
		resp.addCookie(cookie);
		
//		tip! 이미지 파일의 mime 확인 방법
		String mimeText = getServletContext().getMimeType(selImg);
		resp.setContentType(mimeText);
		byte[] buffer = new byte[1024];
		int length = -1;
		try(
			FileInputStream fis = new FileInputStream(imageFile);
			OutputStream os = resp.getOutputStream();	
		){
			while((length = fis.read(buffer))!=-1) {
				os.write(buffer, 0, length);
			}
		}
	}
}













