package kr.or.ddit.buyer.service;

import java.util.List;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.BuyerVO;
import kr.or.ddit.vo.PagingVO;

public interface IBuyerService {
	public ServiceResult createBuyer(BuyerVO buyer);
	public long retriveBuyerCount(PagingVO<BuyerVO> pagingVO);
	public List<BuyerVO> retrieveBuyerList(PagingVO<BuyerVO> pagingVO);
	public BuyerVO retriebeBuyer(String buyer_id);
	public ServiceResult modifyBuyer(BuyerVO buyer);
}
