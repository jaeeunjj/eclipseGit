package kr.or.ddit.servlet01;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GugudanServlet
 */
@WebServlet(
		urlPatterns = { "/gugudan.do" }, 
		initParams = { 
				@WebInitParam(name = "param1", value = "값1")
		})
public class GugudanServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public GugudanServlet() {
        super();
    }
	public void init(ServletConfig config) throws ServletException {
	}

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.service(request, response);
	}

	protected void doGet(HttpServletRequest request, 
						HttpServletResponse response) throws ServletException, IOException {
		// head 로 "구구단" 이라는 타이틀 출력
		//2단부터 9단까지의 구구단을 table 태그를 이용해서 출력.
		String minDanStr = request.getParameter("minDan");
		String maxDanStr = request.getParameter("maxDan");
		int minDan = 2;
		int maxDan = 9;
		if(minDanStr!=null && minDanStr.matches("[2-9]")
				&& maxDanStr!=null && maxDanStr.matches("[2-9]")) {
			minDan = Integer.parseInt(minDanStr);
			maxDan = Integer.parseInt(maxDanStr);
			
		}
			
		response.setContentType("text/html;charset=UTF-8");
		
		String absolutePath = getClass().getResource("gugudan.tmpl").getFile();
		File tmplFile = new File(absolutePath);
		FileInputStream fis = new FileInputStream(tmplFile);
		InputStreamReader isr = new InputStreamReader(fis, "UTF-8");
		BufferedReader reader = new BufferedReader(isr);
		StringBuffer template = new StringBuffer();
		String temp = null;
		while((temp=reader.readLine())!=null) {
			template.append(temp+"\n");
		}
		
		StringBuffer data = new StringBuffer();
		String pattern = "<td>%d*%d=%d</td>";
		for(int dan=minDan; dan<=maxDan; dan++) {
			data.append("<tr>");
			for(int mul=1; mul<=9; mul++) {
				data.append(String.format(pattern, dan, mul, (dan*mul)));
			}
			data.append("</tr>");
		}
		
		String html = template.toString().replaceAll("@data@", data.toString());
		html = html.replaceAll("@color@", "red");
		
		try(
			PrintWriter out = response.getWriter();	
		){
			out.println(html);			
		}
	}
 
}















