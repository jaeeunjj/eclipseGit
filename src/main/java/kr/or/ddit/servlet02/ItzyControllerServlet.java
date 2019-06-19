package kr.or.ddit.servlet02;

import java.io.IOException;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;

import kr.or.ddit.vo.ItzyVO;

@WebServlet("/05/getMemberPage.do")
public class ItzyControllerServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Map<String,ItzyVO> itzyMap = (Map<String,ItzyVO>) getServletContext().getAttribute("itzyMap");

		String memCode = request.getParameter("itzy");
		int statusCode = 0;
		if(StringUtils.isBlank(memCode)){
			statusCode = HttpServletResponse.SC_BAD_REQUEST;
		}else{
			if(!itzyMap.containsKey(memCode)){
				statusCode = HttpServletResponse.SC_NOT_FOUND;
			}
		}
		if(statusCode==0){
			String goPage = "/WEB-INF" + itzyMap.get(memCode).getPage();
			RequestDispatcher rd = request.getRequestDispatcher(goPage);
			rd.include(request, response);
//	 		response.sendRedirect(request.getContextPath() + goPage);
			return;
		}else{
			response.sendError(statusCode);
		}
	}
}
