package kr.or.ddit.enumpkg;

public enum OsType {
	WINDOW("윈도우 계열"), MAC("애플 계열"), 
	ANDROID("안드로이드 계열"), OTHER("뫄뫄뫄");
	OsType(String text){
		this.text = text;
	}
	private String text;
	public String getText() {
		return text;
	}
	public static OsType matchedType(String userAgent) {
		OsType[] types = values();
		userAgent = userAgent.toUpperCase();
		OsType result = OTHER;
		for(OsType tmp :types) {
			if(userAgent.contains(tmp.name())) {
				result = tmp;
				break;
			}
		}
		return result;
	}
}
//
//public class OsType {
//	public static final OsType WINDOW = new OsType(); 
//	MAC, ANDROID
//}
