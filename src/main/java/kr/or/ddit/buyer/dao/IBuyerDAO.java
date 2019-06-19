package kr.or.ddit.buyer.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.BuyerVO;
import kr.or.ddit.vo.PagingVO;

@Repository
public interface IBuyerDAO {
	public int insertBuyer (BuyerVO buyer);
	public long selectBuyerCount(PagingVO<BuyerVO> pagnigVO);
	public List<BuyerVO> selectBuyerList(PagingVO<BuyerVO> pagingVO);
	public BuyerVO selectBuyer(String buyer_id);
	public int updateBuyer(BuyerVO buyer);
	
}
