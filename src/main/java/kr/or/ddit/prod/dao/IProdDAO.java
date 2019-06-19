package kr.or.ddit.prod.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.ProdVO;

/**
 * 상품관리를 위한 Persistence Layer 추상화
 *
 */
@Repository
public interface IProdDAO {
	public int insertProd(ProdVO prod);
	public long selectProdCount(PagingVO pagingVO);
	public List<ProdVO> selectProdList(PagingVO pagingVO);
	public ProdVO selectProd(String prod_id);
	public int updateProd(ProdVO prod);
}
