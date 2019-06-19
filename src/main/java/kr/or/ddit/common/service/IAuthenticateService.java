package kr.or.ddit.common.service;

import kr.or.ddit.vo.MemberVO;

/**
 * 로그인 처리를 위한 Business Logic Layer 의 추상화
 *
 */
public interface IAuthenticateService {
	/**
	 * 아이디와 비번을 기반으로 인증을 판단하는 로직
	 * @param member
	 * @return NOTEXIST, OK, INVALIDPASSWORD
	 */
	public Object authenticate(MemberVO member);
}
