package kr.or.ddit.enumpkg;

public enum ServiceType {
	GUGUDAN("/02/gugudan.jsp"),
	SESSIONTIMER("/06/sessionTimer.jsp"),
	IDOLFORM("/05/idolForm.jsp"),
	GETMEMBERPAGE("/05/getMemberPage.do"),
	IMAGEFORM("/model2/imageForm.do"),
	CALENDAR("/04/calendar.jsp");
	
	private ServiceType(String servicePage) {
		this.servicePage = servicePage;
	}
	private String servicePage;
	public String getServicePage() {
		return servicePage;
	}
}
