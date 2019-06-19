package kr.or.ddit.common.service;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.member.dao.IMemberDAO;
import kr.or.ddit.utils.EncryptUitls;
import kr.or.ddit.vo.MemberVO;

@Service
public class AuthenticateServiceImpl implements IAuthenticateService {
	@Inject
	IMemberDAO memberDAO;
	
	private void encryptPassword(MemberVO member){
		String plain = member.getMem_pass();
		if(StringUtils.isBlank(plain)) return;
		
		String encoded = EncryptUitls.encryptSha512Base64(plain);
		member.setMem_pass(encoded);
	}
	
	@Override
	public Object authenticate(MemberVO member) {
		MemberVO savedMember = memberDAO.selectMember(member.getMem_id());
		Object result = null;
		if(savedMember==null ||"Y".equals(savedMember.getMem_delete())) {
			result = ServiceResult.NOTEXIST;
		}else {
				encryptPassword(member);
				if(savedMember.getMem_pass().equals(member.getMem_pass())) {
//				try {
//					BeanUtils.copyProperties(member, savedMember);
//				} catch (IllegalAccessException | InvocationTargetException e) {
//					throw new RuntimeException(e);
//				}
//				result = ServiceResult.OK;
					result = savedMember;
				}else {
					result = ServiceResult.INVALIDPASSWORD;
				}
			}
		
		return result;
	}

}
