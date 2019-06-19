package kr.or.ddit.board.service;

import java.util.List;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.PdsVO;

public interface IBoardServie {
	public ServiceResult createBoard(BoardVO board);//insert pds
	public List<BoardVO> retriveBoardList(PagingVO<BoardVO>pagingVO);
	public long retriveBoardCount (PagingVO<BoardVO>pagingVO);
	public BoardVO retriveBoard(int bo_no);//조회수 증가 필요
	public ServiceResult singo(int bo_no);
	public ServiceResult likeOrHate(BoardVO board);
	public ServiceResult modifyBoard(BoardVO board);//글이 없는경우, 비번인증 실패, 수정 성공, 수정실패 ,delete pds, insert pds
	public ServiceResult removeBoard(BoardVO board);//글이 없는경우, 비번인증 실패, 수정 성공, 수정실패 
	public PdsVO downloadPds(int pds_no);
	
	
	
}
