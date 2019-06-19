package kr.or.ddit.tags;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import com.fasterxml.jackson.databind.util.StdDateFormat;


public class SimpleDateGenTag extends SimpleTagSupport{
	private String pattern;
	
	public void setPattern(String pattern) {
		this.pattern= pattern;
	}
	
	@Override
	public void doTag() throws JspException, IOException {
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat();
		getJspContext().getOut().println(today);
		
	}
}
