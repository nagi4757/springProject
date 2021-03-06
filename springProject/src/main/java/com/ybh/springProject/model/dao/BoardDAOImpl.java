package com.ybh.springProject.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.ybh.springProject.model.dto.BoardVO;

@Repository    // 현재 클래스를 dao bean으로 등록
public class BoardDAOImpl implements BoardDAO {
	
	@Inject SqlSession SqlSession;

	// 게시글 작성
	@Override
	public void create(BoardVO vo) throws Exception {
		SqlSession.insert("board.insert", vo);
	}

	// 게시글 상세보기
	@Override
	public BoardVO read(int bno) throws Exception {
		return SqlSession.selectOne("board.view", bno);
	}
	
	// 게시글 수정
	@Override
	public void update(BoardVO vo) throws Exception {
		SqlSession.update("board.updateArticle", vo);
	}

	// 게시글 삭제
	@Override
	public void delete(int bno) throws Exception {
		SqlSession.delete("board.deleteArticle",bno);
	}
	
	// 게시글 전체 목록
	@Override
	public List<BoardVO> listAll(int start, int end, String searchOption, String keyword, int bgroup) throws Exception {
		// 검색옵션, 키워드 맵에 저장
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
	    map.put("start", start);
	    map.put("end", end);
	    map.put("bgroup", bgroup);
		return SqlSession.selectList("board.listAll", map);
	}
	
	// 강의 게시글 전체 목록
	@Override
	public List<BoardVO> lectureListAll(int start, int end, int bgroup) throws Exception {
		// 검색옵션, 키워드 맵에 저장
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start",start);
		map.put("end", end);
		map.put("bgroup", bgroup);
		return SqlSession.selectList("board.lectureListAll", map);
	}

	// 게시글 조회수 증가
	@Override
	public void increaseViewcnt(int bno) throws Exception {
		SqlSession.update("board.increaseViewcnt", bno);
	}

	// 게시글 레코드 갯수
	@Override
	public int countArticle(String searchOption, String keyword, int bgroup) throws Exception {
		// 검색옵션, 키워드 맵에 저장
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		map.put("bgroup", bgroup);
		return SqlSession.selectOne("board.countArticle", map);
	}
	
	// 강의 게시글 레코드 갯수 메서드 추가
	@Override
	public int lectureCountArticle(int bgroup) throws Exception {
		return SqlSession.selectOne("board.lectureCountArticle", bgroup);
	}
	
	// 메인 게시글 출력
	@Override
	public List<BoardVO> mainListAll(int bgroupStart, int bgroupEnd) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bgroupStart", bgroupStart);
		map.put("bgroupEnd", bgroupEnd);
		return SqlSession.selectList("board.mainListAll", map);
	}
}
