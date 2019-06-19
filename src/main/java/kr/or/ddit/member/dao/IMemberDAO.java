package kr.or.ddit.member.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PagingVO;

/**
 * 회원관리를 위한 Persistence Layer 의 추상화
 * Member 테이블을 대상으로 CRUD Data Access Method 
 */
@Repository
public interface IMemberDAO {
	/**
	 * 신규 회원 등록
	 * @param member 신규 등록할 회원의 정보를 가진 VO
	 * @return row count > 0 : 성공
	 */
	public int insertMember(MemberVO member);
	/**
	 * 한명의 회원에 대한 상세 정보 조회
	 * @param mem_id 조회할 회원의 아이디
	 * @return 존재하지 않는다면, null 반환. 
	 */
	public MemberVO selectMember(String mem_id);
	
	/**
	 * 페이징 처리를 위해 totalRecord 조회
	 * @param pagingVO
	 * @return
	 */
	public long selectMemberCount(PagingVO<MemberVO> pagingVO);
	/**
	 * 회원의 목록 조회
	 * @param pagingVO TODO
	 * @return
	 */
	public List<MemberVO> selectMemberList(PagingVO<MemberVO> pagingVO);
	/**
	 * 회원정보 수정
	 * @param member PK 를 비롯한 수정할 회원에 대한 정보
	 * @return row count > 0 : 성공
	 */
	public int updateMember(MemberVO member);
	
	/**
	 * 회원정보 삭제(????)
	 * @param mem_id 삭제할 회원의 아이디
	 * @return
	 */
	public int deleteMember(String mem_id);
}








