package com.ybh.springProject.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ybh.springProject.common.PagePager;
import com.ybh.springProject.model.dto.BoardVO;
import com.ybh.springProject.service.BoardService;

@Controller    // 현재 클래스를 컨트롤러 빈(bean)으로 등록
@RequestMapping("/board/*")
public class BoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Resource(name="uploadPath")
    String uploadPath;
	
	// 의존관계 주입 => BoardServiceImpl 생성
    // IoC 의존관계 역전
	@Inject BoardService boardService;
	
	// 게시글 목록
	@RequestMapping("list.do")
	// @RequestParam(defaultValue="") ==> 기본값 할당 : 현재페이지를 1로 초기화
	public ModelAndView list(@RequestParam(defaultValue="title") String searchOption,
			@RequestParam(defaultValue="") String keyword,
			@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="1") int bgroup, HttpSession session) throws Exception{
		
        // 레코드의 갯수 계산
        int count = boardService.countArticle(searchOption, keyword, bgroup);
        
        // 관리자 확인
        String manager = (String)session.getAttribute("userIsAdmin");
        
        // 페이지 나누기 관련 처리
        PagePager boardPager = new PagePager(count, curPage, 10, 10);
        int start = boardPager.getPageBegin();
        int end = boardPager.getPageEnd();
        
        List<BoardVO> list = boardService.listAll(start, end, searchOption, keyword, bgroup);
        
        /*mav.addObject("list", list); // 데이터를 저장
        mav.addObject("count", count);
        mav.addObject("searchOption", searchOption);
        mav.addObject("keyword", keyword);*/
        // 데이터를 맵에 저장
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("list", list); // list
        map.put("count", count); // 레코드의 갯수
        map.put("searchOption", searchOption); // 검색옵션
        map.put("keyword", keyword); // 검색키워드
        map.put("boardPager", boardPager);
        
        // ModelAndView - 모델과 뷰
        ModelAndView mav = new ModelAndView();
        mav.addObject("map", map); // 맵에 저장된 데이터를 mav에 저장
        
        if(bgroup>1 && manager.equals("Y")){
        	map.put("bgroup", bgroup);
        	mav.setViewName("board/all_board_list"); // 뷰를 list.jsp로 설정
        }else{
        	mav.setViewName("board/board_list"); // 뷰를 list.jsp로 설정
        }
        
        return mav; // list.jsp로 List가 전달된다.
    }
	
    // 게시글 작성화면
    // @RequestMapping("board/write.do")
    // value="", method="전송방식"
	@RequestMapping(value="write.do", method=RequestMethod.GET)
    public String write(@RequestParam(defaultValue="1") int bgroup, Model model){
		model.addAttribute("bgroup", bgroup);
        return "board/board_write"; // write.jsp로 이동
    }
	
	// 게시글 작성처리
	@RequestMapping(value="insert.do", method=RequestMethod.POST)
    public String insert(@ModelAttribute BoardVO vo, HttpSession session) throws Exception{
		// session에 저장된 userId를 writer에 저장
		String writer = (String)session.getAttribute("userId");
		// 관리자 확인
        String manager = (String)session.getAttribute("userIsAdmin");
        int bgroup = vo.getBgroup();
		// vo에 writer를 세팅
		vo.setWriter(writer);
        boardService.create(vo);
        if(bgroup>1 && manager.equals("Y")){
        	return "redirect:list.do?bgroup="+bgroup;
        }else{
            return "redirect:list.do";
        }
    }
	
	// 게시글 상세내용 조회, 게시글 조회수 증가 처리
    // @RequestParam : get/post방식으로 전달된 변수 1개
    // HttpSession 세션객체
	@RequestMapping(value="view.do", method=RequestMethod.GET)
	public ModelAndView view(@RequestParam int bno, 
			HttpSession session, 
			@RequestParam(defaultValue="1") int curPage, 
    		@RequestParam(defaultValue="title") String searchOption, 
    		@RequestParam(defaultValue="") String keyword) throws Exception{
		// 조회수 증가 처리
	    boardService.increaseViewcnt(bno, session);
	    // 모델(데이터)+뷰(화면)를 함께 전달하는 객체
	    ModelAndView mav = new ModelAndView();
	    // 뷰의 이름
	    mav.setViewName("board/board_view");
	    // 뷰에 전달할 데이터
	    mav.addObject("curPage", curPage);
    	mav.addObject("searchOption", searchOption);
    	mav.addObject("keyword", keyword);
	    mav.addObject("dto", boardService.read(bno));
	    return mav;
	}
	
    // 게시글 수정
    // 폼에서 입력한 내용들은 @ModelAttribute BoardVO vo로 전달됨
    @RequestMapping(value="update.do", method=RequestMethod.POST)
    public String update(@ModelAttribute BoardVO vo) throws Exception{
        boardService.update(vo);
        return "redirect:list.do";
    }
    
    @RequestMapping(value="update.do", method=RequestMethod.GET)
    public ModelAndView update(@RequestParam int bno, 
    		@RequestParam(defaultValue="1") int curPage, 
    		@RequestParam(defaultValue="title") String searchOption, 
    		@RequestParam(defaultValue="") String keyword) throws Exception{
    	ModelAndView mav = new ModelAndView();
    	mav.setViewName("board/board_update");
    	mav.addObject("curPage", curPage);
    	mav.addObject("searchOption", searchOption);
    	mav.addObject("keyword", keyword);
    	mav.addObject("dto", boardService.read(bno));
	    return mav;
    }
    
    // 게시글 삭제
    @RequestMapping("delete.do")
    public String delete(@RequestParam int bno) throws Exception{
        boardService.delete(bno);
        return "redirect:list.do";
    }
    
    // 이미지 업로드
    @RequestMapping(value="imageUpload.do", method=RequestMethod.POST, produces="text/plain;charset=utf-8")
    public ResponseEntity<String> imageUpload(MultipartFile file) throws Exception{
    	logger.info("originalName : "+file.getOriginalFilename());
        logger.info("size : "+file.getSize());
        logger.info("contentType : "+file.getContentType());
        
        return new ResponseEntity<String>(boardService.imageUpload(uploadPath, file.getOriginalFilename(), file.getBytes()), HttpStatus.OK);
    }
    
}
