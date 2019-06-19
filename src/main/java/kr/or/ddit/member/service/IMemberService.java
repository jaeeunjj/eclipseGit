package kr.or.ddit.member.service;

import java.util.List;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PagingVO;

/**
 * 회원관리를 위한 Business Logic Layer 의 추상화
 *
 */
public interface IMemberService {
	/**
	 * 신규 등록
	 * @param member
	 * @return OK, FAILED, PKDUPLICATED
	 */
	public ServiceResult createMember(MemberVO member);
	/**
	 * 회원 상세 조회
	 * @param mem_id
	 * @return 존재하지 않는 경우, CommonException 발생.
	 */
	public MemberVO retrieveMember(String mem_id);
	
	/**
	 * totalRecord 조회용
	 * @param pagingVO
	 * @return
	 */
	public long retrieveMemberCount(PagingVO<MemberVO> pagingVO);
	/**
	 * 회원 목록 조회
	 * @param paigingVO TODO
	 * @return 존재하지 않는 경우, list.size()==0
	 */
	public List<MemberVO> retrieveMemberList(PagingVO<MemberVO> pagingVO);
	/**
	 * 회원 정보 수정
	 * @param member
	 * @return CommonException, INVALIDPASSWORD, OK, FAILED
	 */
	public ServiceResult modifyMember(MemberVO member);
	/**
	 * 회원 탈퇴 혹은 삭제
	 * @param member
	 * @return CommonException, INVALIDPASSWORD, OK, FAILED
	 */
	public ServiceResult removeMember(MemberVO member);
	
}














