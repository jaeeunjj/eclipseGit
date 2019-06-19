package kr.or.ddit.servlet01;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ImageFormServlet extends HttpServlet{
	File sampleFolder;
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		sampleFolder = new File(config.getInitParameter("contentPath"));
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html;charset=UTF-8");
		System.out.println(getServletContext().hashCode());
		String template = readTemplate("imageForm.tmpl");
//		jpg/png/gif/bmp..
		File[] files = sampleFolder.listFiles((dir, name)->{
				String mimeText = getServletContext().getMimeType(name);
				return mimeText.startsWith("image/");
			});
		
		StringBuffer options = new StringBuffer();
		String pattern = "<option value='%1$s'>%1$s</option>";
		if(files!=null) {
			for(File temp : files) {
				options.append(
					String.format(pattern, temp.getName())	
						);
			} // for end
		} // if end		
		
		String html = template.replace("@data", options.toString());
		
		try(
			PrintWriter out = resp.getWriter();
		){
			out.println(html);			
		}
	}// doPost end

	private String readTemplate(String tmplPath) throws IOException {
		String absolutePath = getClass().getResource(tmplPath).getFile();
		File tmplFile = new File(absolutePath);
		try(
			FileInputStream fis = new FileInputStream(tmplFile);
			InputStreamReader isr = new InputStreamReader(fis, "UTF-8");
			BufferedReader reader = new BufferedReader(isr);
		){
			StringBuffer template = new StringBuffer();
			String temp = null;
			while((temp=reader.readLine())!=null) {
				template.append(temp+"\n");
			}
			return template.toString();
		}
	}
}













