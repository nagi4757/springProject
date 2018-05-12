package com.ybh.springProject.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ybh.springProject.common.PagePager;
import com.ybh.springProject.model.dto.ReplyVO;
import com.ybh.springProject.service.ReplyService;

@RestController
@RequestMapping("/reply/*")
public class ReplyController {
	
	@Inject ReplyService replyService;
	
	// 댓글 입력
	@RequestMapping("insert.do")
	public void insert(@ModelAttribute ReplyVO vo, HttpSession session){
		String userId = (String) session.getAttribute("userId");
	    vo.setReplyer(userId);
	    replyService.create(vo);
	}
	
	// 댓글 수정
	@RequestMapping("update.do")
	public void update(@ModelAttribute ReplyVO vo){
		replyService.update(vo);
	}
	
	// 댓글 삭제
	@RequestMapping("delete.do")
	public String delete(@ModelAttribute ReplyVO vo){
		String entity ="";
		
		try {
			int reReplyCount = replyService.reReplyCount(vo.getRno());
			
			if(reReplyCount>0){
				entity = "fail";
			}else{
				replyService.delete(vo);
				entity = "success";
			}
			
			
		}catch(Exception e) {
			entity = e.getMessage();
		}
		return entity;
	}
	
	// 댓글 목록
	@RequestMapping("list.do")
    public ModelAndView list(@RequestParam int bno,
    		@RequestParam(defaultValue="1") int curPage,
    		ModelAndView mav){
		// 페이징 처리
		int count = replyService.count(bno); //댓글 갯수
		PagePager replyPager = new PagePager(count, curPage, 10, 10);
		int start = replyPager.getPageBegin();
		int end = replyPager.getPageEnd();
		List<ReplyVO> list = replyService.list(bno, start, end);
		// 뷰이름 지정
		if(bno==1){
			mav.setViewName("board/reply_list");
		}else{
			mav.setViewName("lecture/lecture_replyList");
		}
		
		// 뷰에 전달할 데이터 지정
		mav.addObject("list", list);
        mav.addObject("replyPager", replyPager);
        // reply_list.jsp로 포워딩
		return mav;
	}
}
