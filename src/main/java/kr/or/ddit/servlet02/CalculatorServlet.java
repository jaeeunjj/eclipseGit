package kr.or.ddit.servlet02;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.enumpkg.OperatorType;

@WebServlet("/calculator.do")
public class CalculatorServlet extends HttpServlet {
	@FunctionalInterface
	public static interface MakeResult{
		public String makeResult(double result);
	}
	public static enum CalculateType{
		PLAIN("text/plain;charset=UTF-8", (result)->{return result+"";}), 
		JSON("application/json;charset=UTF-8", (result)->{
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("result", result);
			ObjectMapper mapper = new ObjectMapper();
			try {
				return mapper.writeValueAsString(resultMap);
			} catch (JsonProcessingException e) {
				throw new RuntimeException(e);
			} //{"result":12.0}
		}), 
		HTML("text/html;charset=UTF-8", (result)->{
			return "<span>"+result+"</span>";
		}),
		XML("application/xml;charset=UTF-8", (result)->{
			return "<result>"+result+"</result>";
		});
		private CalculateType(String mimeText, MakeResult realMaker){
			this.mimeText = mimeText;
			this.realMaker = realMaker;
		}
		private MakeResult realMaker;
		public MakeResult getRealMaker() {
			return realMaker;
		}
		private String mimeText;
		public String getMimeText() {
			return mimeText;
		}
		public String getResult(double leftOp, double rightOp, OperatorType opType) {
			double result = opType.operate(leftOp, rightOp);
			return realMaker.makeResult(result);
		}
		public static CalculateType matches(String accept) {
			CalculateType matchedType = HTML;
			CalculateType[] types = values();
			accept = accept.toUpperCase();
			for(CalculateType tmp : types) {
				if(accept.contains(tmp.name())) {
					matchedType = tmp;
					break;
				}
			}
			return matchedType;
		}
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 파라미터 확보
		String leftStr = req.getParameter("leftOp");
		String rightStr = req.getParameter("rightOp");
		String operator = req.getParameter("operator");
		OperatorType opType = null;
		boolean valid = true;
		try {
			opType = OperatorType.valueOf(operator);
		}catch (IllegalArgumentException e) {
			valid=false;
		}
		// 검증(필수파라미터 전송 여부, 데이터 타입), 연산자 검증 추가
		if(	valid &&
				StringUtils.isNotBlank(leftStr) && StringUtils.isNotBlank(rightStr) &&
				StringUtils.isNumeric(leftStr) && StringUtils.isNumeric(rightStr)) {
			// 통과
//			연산->연산 결과(html)
			double leftOp = Double.parseDouble(leftStr);
			double rightOp = Double.parseDouble(rightStr);
			String accept = req.getHeader("Accept");
			String content = null;
			String mime = null;
			
			CalculateType matchedType = CalculateType.matches(accept);
			mime = matchedType.getMimeText();
			content = matchedType.getResult(leftOp, rightOp, opType);

			resp.setContentType(mime);
			try(
				PrintWriter out = resp.getWriter();
			){
				out.println(content);
			}
		}else {
		// 불통
//			bad request 응답 상태코드 전송
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "피연산자 확인");
		}	
	}
}











