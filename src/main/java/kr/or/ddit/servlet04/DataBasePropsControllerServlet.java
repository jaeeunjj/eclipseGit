package kr.or.ddit.servlet04;

import java.io.IOException;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.dbprop.service.DataBasePropertyService;
import kr.or.ddit.dbprop.service.IDataBasePropertyService;

@WebServlet("/model2/dbProps.do")
public class DataBasePropsControllerServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		IDataBasePropertyService propService = new DataBasePropertyService();
		
		Map<String, Object> model = propService.readProperties();
		
		req.setAttribute("model", model);
		
		String view = "/WEB-INF/views/dbProps.jsp";
		RequestDispatcher rd = req.getRequestDispatcher(view);
		rd.forward(req, resp);
		
	}
}





