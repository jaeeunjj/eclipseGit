package kr.or.ddit.board.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.PdsVO;

@Repository
public interface IPdsDAO {
	public int insertPds(PdsVO pds);
	
	public int insertPdsAll(BoardVO board);
	
	public PdsVO selectPds(int pds_no);
	
	public int deletePds(int pds_no);
}
