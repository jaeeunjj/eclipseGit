package kr.or.ddit.member.preparer;

import java.util.LinkedHashMap;
import java.util.Map;

import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;

import kr.or.ddit.common.annotation.Preparer;

@Preparer
public class MemberViewPreparer implements ViewPreparer{

	@Override
	public void execute(Request arg0, AttributeContext arg1) {
//		<a href="/member/memberInsert.do">신규등록</a>
		Map<String, String> menuMap = new LinkedHashMap<>();
		menuMap.put("/member/memberInsert.do","신규등록");
		menuMap.put("/member/memberList.do","회원목록");
		Map<String,Object> requestScope = arg0.getContext(Request.REQUEST_SCOPE);
		requestScope.put("menus", menuMap); 
	}
	
	
	
}
