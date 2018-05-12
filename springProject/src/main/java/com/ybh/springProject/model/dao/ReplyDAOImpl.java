package com.ybh.springProject.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.ybh.springProject.model.dto.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO {

	@Inject SqlSession sqlSession;
	
	// 댓글 목록
	@Override
	public List<ReplyVO> list(Integer bno, int start, int end) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bno", bno);
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("reply.listReply", map);
	}

	// 댓글 작성
	@Override
	public void create(ReplyVO vo) {
		if(vo.getRgrpord() != 0){
			int maxRgrpord = sqlSession.selectOne("reply.selectReplyRgrpord", vo);
			int maxPgrpReply = sqlSession.selectOne("reply.selectPrtGrpReply", vo);
			if(maxRgrpord > vo.getRgrpord()){
				vo.setRgrpord(vo.getRgrpord()+maxPgrpReply);
				sqlSession.update("reply.updateReReply", vo);
			}
			sqlSession.insert("reply.insertReReply", vo);
		}else {
			int rgrpno = sqlSession.selectOne("reply.selectReplyNo");
			vo.setRgrpno(rgrpno);
			sqlSession.insert("reply.insertReply", vo);
		}
	}

	// 댓글 수정
	@Override
	public void update(ReplyVO vo) {
		sqlSession.update("reply.updateReply", vo);
	}

	// 댓글 삭제
	@Override
	public void delete(ReplyVO vo) {
		sqlSession.insert("reply.deleteReply", vo);
		sqlSession.update("reply.updateDeleteReply", vo);
	}

	// 댓글 갯수
	@Override
	public int count(int bno) {
		return sqlSession.selectOne("reply.countReply", bno);
	}

	// 댓글의 댓글 갯수
	@Override
	public int reReplyCount(int rprtno) {
		return sqlSession.selectOne("reply.reReplyCount", rprtno);
	}

}
