package com.ybh.springProject.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.ybh.springProject.model.dao.ReplyDAO;
import com.ybh.springProject.model.dto.ReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService {
	
	@Inject ReplyDAO replyDao;

	// 댓글 목록
	@Override
	public List<ReplyVO> list(Integer bno, int start, int end) {
		return replyDao.list(bno, start, end);
	}

	// 댓글 작성
	@Override
	public void create(ReplyVO vo) {
		String replyText = vo.getReplytext();
		replyText = replyText.replace("\n", "<br>");
		vo.setReplytext(replyText);
		replyDao.create(vo);
	}

	// 댓글 수정
	@Override
	public void update(ReplyVO vo) {
		String replyText = vo.getReplytext();
		replyText = replyText.replace("\n", "<br>");
		vo.setReplytext(replyText);
		replyDao.update(vo);
	}

	// 댓글 삭제
	@Override
	public void delete(ReplyVO vo) {
		replyDao.delete(vo);
	}
	
	// 댓글의 댓글 갯수
	@Override
	public int reReplyCount(int rprtno) {
		return replyDao.reReplyCount(rprtno);
	}
	
	// 댓글 갯수
	@Override
	public int count(int bno) {
		return replyDao.count(bno);
	}
}
