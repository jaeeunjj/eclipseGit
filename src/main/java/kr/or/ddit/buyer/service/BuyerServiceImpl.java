package kr.or.ddit.buyer.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.buyer.dao.IBuyerDAO;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.CommonException;
import kr.or.ddit.vo.BuyerVO;
import kr.or.ddit.vo.PagingVO;

@Service
public class BuyerServiceImpl implements IBuyerService {
	@Inject
	IBuyerDAO buyerDAO;
	
	@Override
	public ServiceResult createBuyer(BuyerVO buyer) {
		int rowCnt = buyerDAO.insertBuyer(buyer);
			ServiceResult result= ServiceResult.FAILED;
		if(rowCnt>0) result = ServiceResult.OK;
		return result;
	}

	@Override
	public long retriveBuyerCount(PagingVO<BuyerVO> pagingVO) {
		return buyerDAO.selectBuyerCount(pagingVO);
	}

	@Override
	public List<BuyerVO> retrieveBuyerList(PagingVO<BuyerVO> pagingVO) {
		return buyerDAO.selectBuyerList(pagingVO);
	}

	@Override
	public BuyerVO retriebeBuyer(String buyer_id) {
		BuyerVO buyer = buyerDAO.selectBuyer(buyer_id);
		if(buyer==null) {
			throw new CommonException(buyer_id+"에 해당하는 거래처가 없음.");
		}
		return buyer;
	}

	@Override
	public ServiceResult modifyBuyer(BuyerVO buyer) {
		retriebeBuyer(buyer.getBuyer_id());
		int rowCnt = buyerDAO.updateBuyer(buyer);
		ServiceResult result = ServiceResult.FAILED;
		if(rowCnt>0) result = ServiceResult.OK;
		return result;
	}

}
