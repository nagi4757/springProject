package com.ybh.springProject.model.dao;

import java.util.List;

import com.ybh.springProject.model.dto.BoardVO;

public interface BoardDAO {
	// 게시글 작성
    public void create(BoardVO vo) throws Exception;
    // 게시글 상세보기
    public BoardVO read(int bno) throws Exception;
    // 게시글 수정
    public void update(BoardVO vo) throws Exception;
    // 게시글 삭제
    public void delete(int bno) throws Exception;
    // 게시글 전체 목록
    public List<BoardVO> listAll(int start, int end, String searchOption, String keyword, int bgroup) throws Exception;
    // 강의 게시글 전체 목록
    public List<BoardVO> lectureListAll(int start, int end, int bgroup) throws Exception;
    // 게시글 조회 증가
    public void increaseViewcnt(int bno) throws Exception;
    // 게시글 레코드 갯수 메서드 추가
    public int countArticle(String searchOption, String keyword, int bgroup) throws Exception;
    // 강의 게시글 레코드 갯수 메서드 추가
    public int lectureCountArticle(int bgroup) throws Exception;
    // 메인 게시글 출력
    public List<BoardVO> mainListAll(int bgroupStart, int bgroupEnd) throws Exception;
}
