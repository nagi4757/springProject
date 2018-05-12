package com.ybh.springProject.model.dao;

import java.util.List;

import com.ybh.springProject.model.dto.ReplyVO;

public interface ReplyDAO {
	// 댓글 목록
    public List<ReplyVO> list(Integer bno, int start, int end);
    // 댓글 입력
    public void create(ReplyVO vo);
    // 댓글 수정
    public void update(ReplyVO vo);
    // 댓글 삭제
    public void delete(ReplyVO vo);
    // 댓글 갯수
    public int count(int bno);
    // 댓글의 댓글 갯수
    public int reReplyCount(int rprtno);
}
