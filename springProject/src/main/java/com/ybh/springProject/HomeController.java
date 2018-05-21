package com.ybh.springProject;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ybh.springProject.model.dto.BoardVO;
import com.ybh.springProject.service.BoardService;

//Controller 애노테이션
@Controller
public class HomeController {
	
	@Inject BoardService boardService;
	
	// 시작페이지 mapping 변경
    @RequestMapping("/")
    public String main(Model model) throws Exception{
    	
    	List<BoardVO> freeBoardList = boardService.mainListAll(1,2);
    	List<BoardVO> LectureBoardList = boardService.mainListAll(2,4);
    	
    	// 게시판의 첫번째 이미지만 경로 추출하기
        Pattern imgPattern = Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>");
        Matcher imgMatcher;
        
		for(int i=0;i<freeBoardList.size();i++){
			imgMatcher = imgPattern.matcher(freeBoardList.get(i).getContent());	
			
			if(imgMatcher.find()){
				freeBoardList.get(i).setFirstImageSrc(imgMatcher.group(1));
			}else{
				freeBoardList.get(i).setFirstImageSrc("http://placehold.it/700x400");
			}
		}
		
		for(int i=0;i<LectureBoardList.size();i++){
			imgMatcher = imgPattern.matcher(LectureBoardList.get(i).getContent());	
			
			if(imgMatcher.find()){
				LectureBoardList.get(i).setFirstImageSrc(imgMatcher.group(1));
			}else{
				LectureBoardList.get(i).setFirstImageSrc("http://placehold.it/700x400");
			}
		}
    	
        // model : 데이터를 담는 그릇 역할, map구조로 저장된다.
        // model.addAttribute("변수명", 값);
        model.addAttribute("freeBoardList", freeBoardList);
        model.addAttribute("LectureBoardList", LectureBoardList);
        
        return "main"; // main.jsp로 포워딩
	}
}
