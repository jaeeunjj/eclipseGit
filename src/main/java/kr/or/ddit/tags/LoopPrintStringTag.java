package kr.or.ddit.tags;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

public class LoopPrintStringTag extends BodyTagSupport {
	@Override
	public int doStartTag() throws JspException {
		
		return 	EVAL_BODY_INCLUDE;
	}
	
	private int index=1;
	
	private int count;
	public void setCount(int count) {
		this.count = count;
	}
	
	@Override
	public int doAfterBody() throws JspException {
		if(++index<=count) {
			return EVAL_BODY_AGAIN;
		}else {
			return SKIP_BODY;
		}
		
	}
	
	@Override
	public int doEndTag() throws JspException {
		return EVAL_PAGE;
	}
	
	
}
