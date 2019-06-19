package kr.or.ddit.servlet03;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.ResourceBundle;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.utils.CookieUtil;

/**
 * Model2 구조상에서 
 * 요청을 받고,
 * 분석하고,
 * 컨텐츠를 생성하고,
 * 뷰 레이어를 선택하고,
 * 컨텐츠를 공유하고,
 * 해당 뷰로 이동하는 역할만을 담당할 컨트롤러.
 *
 */
@WebServlet("/model2/imageForm.do")
public class ImageFormControllerServlet extends HttpServlet {
	
	File sampleFolder;
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		ResourceBundle bundle =
				ResourceBundle.getBundle("kr.or.ddit.servlet01.sample");
		String folderPath = bundle.getString("sampleFolder");
		sampleFolder = new File(folderPath);
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		File[] imageFiles = sampleFolder.listFiles((dir, name)->{
			String mime = getServletContext().getMimeType(name);
			return mime!=null && mime.startsWith("image/");
		});
		
//		Cookie[] cookies = req.getCookies();
//		String imgName = null;
//		
//		if(cookies!=null){
//			for(Cookie tmp : cookies){
//				if(tmp.getName().equals("imgCookie")){
//					imgName = URLDecoder.decode(tmp.getValue(), "UTF-8");
//					req.setAttribute("imgName", imgName);
//				}
//			}
//		}
		
		CookieUtil cookieUtil = new CookieUtil(req);
		String imgName = cookieUtil.getCookieValue("imgCookie");
		req.setAttribute("imgName", imgName);
		
		req.setAttribute("imageFiles", imageFiles);
		String view = "/WEB-INF/views/imageFormView.jsp";
		RequestDispatcher rd = req.getRequestDispatcher(view);
		rd.include(req, resp);
	}
}













