package com.ybh.springProject.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ybh.springProject.common.PagePager;
import com.ybh.springProject.model.dto.BoardVO;
import com.ybh.springProject.service.BoardService;

@Controller    // 현재 클래스를 컨트롤러 빈(bean)으로 등록
@RequestMapping("/lecture/*")
public class LectureController {
	
	// 의존관계 주입 => BoardServiceImpl 생성
    // IoC 의존관계 역전
	@Inject BoardService boardService;
	
	// 강의목록
	@RequestMapping("list.do")
	public ModelAndView login(@RequestParam(defaultValue="1") int curPage, 
			@RequestParam(defaultValue="2") int bgroup,
			HttpSession session) throws Exception{
		
		// 레코드의 갯수 계산
		int count = boardService.lectureCountArticle(bgroup);
		
		// 페이지 나누기 관련 처리
        PagePager boardPager = new PagePager(count, curPage, 6, 10);
        int start = boardPager.getPageBegin();
        int end = boardPager.getPageEnd();
        
        List<BoardVO> list = boardService.lectureListAll(start, end, bgroup);
        
        Map<String, Object> map = new HashMap<String, Object>();
        
        // 게시판의 첫번째 이미지만 경로 추출하기
        Pattern imgPattern = Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>");
        Matcher imgMatcher;
        
		for(int i=0;i<list.size();i++){
			imgMatcher = imgPattern.matcher(list.get(i).getContent());	
			
			if(imgMatcher.find()){
				list.get(i).setFirstImageSrc(imgMatcher.group(1));
			}else{
				list.get(i).setFirstImageSrc("http://placehold.it/700x400");
			}
		}
		
		map.put("list", list); // list
		map.put("bgroup", bgroup);
		map.put("boardPager", boardPager);
        
        // ModelAndView - 모델과 뷰
        ModelAndView mav = new ModelAndView();
        mav.addObject("map", map);
        mav.setViewName("lecture/lecture_list");
		
		return mav;
    }
	
	// 강의 상세내용 조회
	@RequestMapping(value="view.do")
	public ModelAndView view(@RequestParam int bno, HttpSession session, 
			@RequestParam(defaultValue="1") int curPage) throws Exception{
		// 조회수 증가 처리
		boardService.increaseViewcnt(bno, session);
		// 모델(데이터)+뷰(화면)를 함께 전달하는 객체
	    ModelAndView mav = new ModelAndView();
	    // 뷰의 이름
	    mav.setViewName("lecture/lecture_view");
	    mav.addObject("curPage", curPage);
	    mav.addObject("dto", boardService.read(bno));
		return mav;
	}
	
}
