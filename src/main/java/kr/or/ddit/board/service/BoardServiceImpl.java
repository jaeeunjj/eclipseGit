package kr.or.ddit.board.service;

import java.io.File;
import java.io.InputStream;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.board.dao.IBoardDAO;
import kr.or.ddit.board.dao.IPdsDAO;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.CommonException;
import kr.or.ddit.utils.EncryptUitls;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.PdsVO;

@Service
public class BoardServiceImpl implements IBoardServie {
	@Inject
	IBoardDAO boardDAO; 
	
	@Inject
	IPdsDAO pdsDAO;
	
	private void encryptPassword(BoardVO board){
		String plain = board.getBo_pass();
		if(StringUtils.isBlank(plain)) return;
		
		String encoded = EncryptUitls.encryptSha512Base64(plain);
		board.setBo_pass(encoded );
	}
	
//	@Transactional
	//현재 트랙잭션 관리 안되. 폭망!!했음.T.T
	@Override
	public ServiceResult createBoard(BoardVO board) {
		encryptPassword(board);
		
			int rowCnt = boardDAO.insertBoard(board);
			
			ServiceResult result = ServiceResult.FAILED;
			if(rowCnt > 0) {
				List<PdsVO> pdsList = board.getPdsList();
				if(pdsList!=null) {
					if(1==1) {
						throw new RuntimeException("강제 발생 예외, 트랜잭션 관리 여부 확인");
					}
					pdsDAO.insertPdsAll(board);
					for(PdsVO pds : pdsList) {
						String savePath = pds.getPds_savepath();
						MultipartFile item = pds.getFileItem();
						try(
								InputStream is = item.getInputStream();
								){
							FileUtils.copyInputStreamToFile(is, new File(savePath));
						}catch (Exception e) {
							throw new RuntimeException(e);
						}
					}
				}
				result = ServiceResult.OK;
			} // if(rowCnt > 0) end
			return result;
	}

	@Override
	public List<BoardVO> retriveBoardList(PagingVO<BoardVO> pagingVO) {
		return boardDAO.selectBoardList(pagingVO);
		
	}

	@Override
	public long retriveBoardCount(PagingVO<BoardVO> pagingVO) {
		return boardDAO.selectBoardCount(pagingVO);
	}

	@Override
	public BoardVO retriveBoard(int bo_no) {
		boardDAO.incrementHit(bo_no);
		BoardVO board = boardDAO.selectBoard(bo_no);
		if(board==null) {
			throw new CommonException(bo_no+"에 해당하는 게시물이 없음.");
		}
		return board;
		
	}

	@Override
	public ServiceResult singo(int bo_no) {
		retriveBoard(bo_no);
		int rowCnt = boardDAO.incrementReport(bo_no);
		ServiceResult result = ServiceResult.FAILED;
		if(rowCnt>0) result = ServiceResult.OK;
		return result;
	}

	@Override
	public ServiceResult likeOrHate(BoardVO board) {
		retriveBoard(board.getBo_no());
		int rowCnt = boardDAO.incrementLikeOrHate(board);
		ServiceResult result = ServiceResult.FAILED;
		if(rowCnt>0) result = ServiceResult.OK;
		return result;
		
	}

	@Override
	public ServiceResult modifyBoard(BoardVO board) {
		encryptPassword(board);
		
				ServiceResult result = ServiceResult.FAILED;
				int bo_no = board.getBo_no();
				String inputBo_pass = board.getBo_pass();
				
				BoardVO selectedBoard = new BoardVO();
				selectedBoard = boardDAO.selectBoard(bo_no);
				if(!(selectedBoard.getBo_pass().equals(inputBo_pass))) {
					result = ServiceResult.INVALIDPASSWORD;
				}else {
					
					
					if(board.getPdsDels()!=null) {
						for(int i=0; i<board.getPdsDels().length;i++) {
							PdsVO pds = pdsDAO.selectPds(board.getPdsDels()[i]);
							File srcFile = new File(pds.getPds_savepath());
							 if( srcFile .exists() ){
								 srcFile .delete();
							 	}
							 	pdsDAO.deletePds(board.getPdsDels()[i]);
							
							}
						
						}//if
						
					int rowCnt = boardDAO.updateBoard(board);
					
					if(rowCnt > 0) {
						List<PdsVO> pdsList = board.getSavepdsList();
						if(pdsList.size()>0) {
//							
							pdsDAO.insertPdsAll(board);
							for(PdsVO pds : pdsList) {
								String savePath = pds.getPds_savepath();
								MultipartFile item = pds.getFileItem();
								try(
										InputStream is = item.getInputStream();
										){
									FileUtils.copyInputStreamToFile(is, new File(savePath));
								}catch (Exception e) {
									throw new RuntimeException(e);
								}
							}
						}
						
						
						result = ServiceResult.OK;
					}
						
					
				}//else 
			
				return result;
		
		
	}

	@Override
	public ServiceResult removeBoard(BoardVO board) {
		encryptPassword(board);
				
					ServiceResult result = ServiceResult.FAILED;
					
					int bo_no = board.getBo_no();
					String inputBo_pass = board.getBo_pass();
					
					BoardVO selectedBoard = new BoardVO();
					selectedBoard = boardDAO.selectBoard(bo_no);
					if(!(selectedBoard.getBo_pass().equals(inputBo_pass))) {
						result = ServiceResult.INVALIDPASSWORD;
					}else {
							if(selectedBoard.getPdsList().get(0).getPds_no()!=null) {
								List<PdsVO> pdsList = selectedBoard.getPdsList();
								for(PdsVO pds : pdsList) {
									File srcFile = new File(pds.getPds_savepath());
									 if( srcFile .exists() ){
										 srcFile .delete();
									 	}else {
									 		result = ServiceResult.FAILED;

									 	}
									}
								
							}
						
						int rowCnt = boardDAO.deleteBoard(bo_no);
						if(rowCnt>0) {
							
							result = ServiceResult.OK;
							
						}	
						
				}
					return result;
			
		
	}
	@Override
	public PdsVO downloadPds(int pds_no) {
		
		return pdsDAO.selectPds(pds_no);
	}

}
