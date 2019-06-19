package kr.or.ddit.prod.service;

import java.util.List;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.ProdVO;

/**
 * 상품관리를 위한 
 Layer 의 추상화
 *
 */
public interface IProdService {
	public ServiceResult createProd(ProdVO prod);
	public long retrieveProdCount(PagingVO pagingVO);
	public List<ProdVO> retrieveProdList(PagingVO pagingVO);
	/**
	 * 상품 상세 조회
	 * @param prod_id
	 * @return 존재하지 않는 경우, CommonException 발생.
	 */
	public ProdVO retrieveProd(String prod_id);
	public ServiceResult modifyProd(ProdVO prod);
}














