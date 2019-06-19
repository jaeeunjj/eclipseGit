package kr.or.ddit.enumpkg;

public enum BrowserType {
		IE("익플 계열"), TRIDENT("익플 11버전이후"), CHROME("크롬 계열"), 
		FIREFOX("파폭 계열"), OTHER("뫄뫄뫄");
		BrowserType(String text){
			this.text = text;
		}
		private String text;
		public String getText() {
			return text;
		}
		public static BrowserType matchedType(String userAgent) {
			BrowserType[] types = values();
			userAgent = userAgent.toUpperCase();
			BrowserType result = OTHER;
			for(BrowserType tmp :types) {
				if(userAgent.contains(tmp.name())) {
					result = tmp;
					break;
				}
			}
			return result;
		}
}
	
	

