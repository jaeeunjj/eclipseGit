package kr.or.ddit.prod.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.BuyerVO;

/**
 * 상품관리 과정에서 필요한 부가정보를 조회하기 위한 Persistence Layer
 *
 */
@Repository
public interface IOthersDAO {
	public List<Map<String, String>> selectLprodList();
	public List<BuyerVO> selectBuyerList(@Param("buyer_lgu") String buyer_lgu);
}
