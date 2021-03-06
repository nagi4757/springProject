package com.ybh.springProject.service;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;

import com.ybh.springProject.model.dao.BoardDAO;
import com.ybh.springProject.model.dto.BoardVO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Inject BoardDAO boardDao;

	// 게시글쓰기
	@Override
	public void create(BoardVO vo) throws Exception {
		String title = vo.getTitle();
        String content = vo.getContent();
        String writer = vo.getWriter();
        // *태그문자 처리 (< ==> &lt; > ==> &gt;)
        // replace(A, B) A를 B로 변경
        title = title.replace("<", "&lt;");
        title = title.replace("<", "&gt;");
        writer = writer.replace("<", "&lt;");
        writer = writer.replace("<", "&gt;");
        // *공백문자 처리
        title = title.replace("  ",    "&nbsp;&nbsp;");
        writer = writer.replace("  ",    "&nbsp;&nbsp;");
        // *줄바꿈 문자처리
        content = content.replace("\n", "<br>");
        vo.setTitle(title);
        vo.setContent(content);
        vo.setWriter(writer);
        boardDao.create(vo);
	}

	// 게시글 상세보기
	@Override
	public BoardVO read(int bno) throws Exception {
		return boardDao.read(bno);
	}

	// 게시글 수정
	@Override
	public void update(BoardVO vo) throws Exception {
		boardDao.update(vo);
	}
	
	// 게시글 삭제
	@Override
	public void delete(int bno) throws Exception {
		boardDao.delete(bno);
	}

	// 게시글 전체 목록
	@Override
	public List<BoardVO> listAll(int start, int end, String searchOption, String keyword, int bgroup) throws Exception {
		return boardDao.listAll(start, end, searchOption, keyword, bgroup);
	}

	// 게시글 조회수 증가
	@Override
	public void increaseViewcnt(int bno, HttpSession session) throws Exception {
		 long update_time = 0;
	     // 세션에 저장된 조회시간 검색
	     // 최초로 조회할 경우 세션에 저장된 값이 없기 때문에 if문은 실행X
	     if(session.getAttribute("update_time_"+bno) != null){
	    	 update_time = (Long)session.getAttribute("update_time_"+bno);
	     }
	     // 시스템의 현재시간을 current_time에 저장
	     long current_time = System.currentTimeMillis();
	     // 일정시간이 경과 후 조회수 증가 처리 24*60*60*1000(24시간)
	     // 시스템현재시간 - 열람시간 > 일정시간(조회수 증가가 가능하도록 지정한 시간)
	     if(current_time - update_time > 5*1000){
	    	 boardDao.increaseViewcnt(bno);
	    	 // 세션에 시간을 저장 : "update_time_"+bno는 다른변수와 중복되지 않게 명명한 것
	         session.setAttribute("update_time_"+bno, current_time);
	     }
	}

	// 게시글 레코드 갯수
	@Override
	public int countArticle(String searchOption, String keyword, int bgroup) throws Exception {
		return boardDao.countArticle(searchOption, keyword, bgroup);
	}
	
	// 강의 게시글 레코드 갯수
	@Override
	public int lectureCountArticle(int bgroup) throws Exception {
		return boardDao.lectureCountArticle(bgroup);
	}
	
	// 강의 게시글 전체목록
	@Override
	public List<BoardVO> lectureListAll(int start, int end, int bgroup) throws Exception {
		return boardDao.lectureListAll(start, end, bgroup);
	}
	
	// 이미지 처리
	@Override
	public String imageUpload(String uploadPath, String originalName, byte[] fileData) throws Exception {
		// UUID 발급
		UUID uuid = UUID.randomUUID();
		// 저장할 파일명 = UUID + 원본이름
		String savedName = uuid.toString() + "_" + originalName;
		// 파일 경로(기존의 업로드경로), 파일명을 받아 파일 객체 생성
		File target = new File(uploadPath, savedName);
		// 임시 디렉토리에 업로드된 파일을 지정된 디렉토리로 복사
		FileCopyUtils.copy(fileData, target);
		
		String uploadedFileName = "/resources/images/" + savedName;
		
		return uploadedFileName;
		
	}

	// 메인 게시글 출력
	@Override
	public List<BoardVO> mainListAll(int bgroupStart, int bgroupEnd) throws Exception {
		return boardDao.mainListAll(bgroupStart, bgroupEnd);
	}
	
}
