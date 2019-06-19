package kr.or.ddit.member.service;

import java.util.List;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.CommonException;
import kr.or.ddit.member.dao.IMemberDAO;
import kr.or.ddit.utils.EncryptUitls;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PagingVO;

@Service
public class MemberServiceImpl implements IMemberService {
	
	
	IMemberDAO memberDAO;
	
	@Inject
	public void setMemberDAO(IMemberDAO memberDAO) {
		this.memberDAO = memberDAO;
	}
	
	
	private void encryptPassword(MemberVO member){
		String plain = member.getMem_pass();
		if(StringUtils.isBlank(plain)) return;
		
		String encoded = EncryptUitls.encryptSha512Base64(plain);
		member.setMem_pass(encoded);
	}

	@Override
	public ServiceResult createMember(MemberVO member) {
		boolean flag = false;
		try {
			retrieveMember(member.getMem_id());
		}catch (CommonException e) {
			flag = true;
		}
		ServiceResult result = null;
		if(flag) {
			encryptPassword(member);
			int rowCnt = memberDAO.insertMember(member);
			if(rowCnt > 0) {
				result = ServiceResult.OK;
			}else {
				result = ServiceResult.FAILED;
			}
		}else {
			result = ServiceResult.PKDUPLICATED;
		}
		return result;
	}

	@Override
	public MemberVO retrieveMember(String mem_id) {
		MemberVO member = memberDAO.selectMember(mem_id);
		if(member==null)
			throw new CommonException(mem_id+"에 해당하는 회원이 없음.");
		return member;
	}
	
	@Override
	public long retrieveMemberCount(PagingVO<MemberVO> pagingVO) {
		return memberDAO.selectMemberCount(pagingVO);
	}
	
	@Override
	public List<MemberVO> retrieveMemberList(PagingVO<MemberVO> pagingVO) {
		return memberDAO.selectMemberList(pagingVO);
	}

	@Override
	public ServiceResult modifyMember(MemberVO member) {
		MemberVO savedMember = retrieveMember(member.getMem_id());
		ServiceResult result = null;
		encryptPassword(member);
		
		if(savedMember.getMem_pass().equals(member.getMem_pass())) {
			int rowCnt = memberDAO.updateMember(member);
			if(rowCnt>0) {
				result = ServiceResult.OK;
			}else {
				result = ServiceResult.FAILED;
			}
		}else {
			result = ServiceResult.INVALIDPASSWORD;
		}
		return result;
	}

	@Override
	public ServiceResult removeMember(MemberVO member) {
		MemberVO savedMember = retrieveMember(member.getMem_id());
		ServiceResult result = null;
		encryptPassword(member);
		
		if(savedMember.getMem_pass().equals(member.getMem_pass())) {
			int rowCnt = memberDAO.deleteMember(member.getMem_id());
			if(rowCnt>0) {
				result = ServiceResult.OK;
			}else {
				result = ServiceResult.FAILED;
			}
		}else {
			result = ServiceResult.INVALIDPASSWORD;
		}
		return result;
	}

}
