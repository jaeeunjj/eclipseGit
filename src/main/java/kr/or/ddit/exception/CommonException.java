package kr.or.ddit.exception;

/**
 * 현재 컨텍스트 내에서만 사용할 custom exception
 * unchecked exception 의 형태로 실행 로직에 영향을 미치지 않도록 사용.
 *
 */
public class CommonException extends RuntimeException{

	public CommonException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CommonException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
		// TODO Auto-generated constructor stub
	}

	public CommonException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public CommonException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public CommonException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	
	
}
