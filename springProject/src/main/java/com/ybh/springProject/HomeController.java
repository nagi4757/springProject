package com.ybh.springProject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

//Controller 애노테이션
@Controller
public class HomeController {
	// 시작페이지 mapping 변경
    @RequestMapping("/")
    public String main(Model model){
        // model : 데이터를 담는 그릇 역할, map구조로 저장된다.
        // model.addAttribute("변수명", 값);
        model.addAttribute("msg", "홈페이지 방문을 환영합니다!");
        return "main"; // main.jsp로 포워딩
	}
}
