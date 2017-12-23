package com.ybh.springProject.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.ybh.springProject.model.dto.BoardVO;

public interface BoardService {
	// 게시글 작성
    public void create(BoardVO vo) throws Exception;
    // 게시글 상세보기
    public BoardVO read(int bno) throws Exception;
    // 게시글 수정
    public void update(BoardVO vo) throws Exception;
    // 게시글 삭제
    public void delete(int bno) throws Exception;
    // 게시글 전체 목록
    public List<BoardVO> listAll(int start, int end, String searchOption, String keyword) throws Exception;
    // 게시글 조회
    public void increaseViewcnt(int bno, HttpSession session) throws Exception;
    // 게시글 레코드 갯수 메서드 추가
    public int countArticle(String searchOption, String keyword) throws Exception;
}
