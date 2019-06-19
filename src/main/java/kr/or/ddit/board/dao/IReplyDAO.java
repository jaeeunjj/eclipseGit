package kr.or.ddit.board.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.ReplyVO;

@Repository
public interface IReplyDAO {
	public int insertReply(ReplyVO reply);
	public List<ReplyVO>selectReplyList(PagingVO<ReplyVO> pagingVO);
	public long selectReplyCount(PagingVO<ReplyVO>pagingVO);
	public int deleteReply(ReplyVO reply);

}
