package com.ybh.springProject.controller;

import java.util.List;

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
import org.springframework.web.servlet.ModelAndView;

import com.ybh.springProject.model.dto.MemberVO;
import com.ybh.springProject.service.MemberService;

@Controller // 현재의 클래스를 controller bean에 등록시킴
@RequestMapping("/member/*") // 모든맵핑은 /member/를 상속
public class MemberController {
	// 로깅을 위한 변수
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	// MemberService 객체를 스프링에서 생성하여 주입시킴
	@Inject MemberService memberService;
	
	// 로그인 화면
	@RequestMapping("login.do")
    public String login() throws Exception{
        return "member/member_login";    // views/member/login.jsp로 포워드
    }
	
	// 로그인 처리
	@RequestMapping("loginCheck.do")
    public ModelAndView loginCheck(@ModelAttribute MemberVO vo, 
    		HttpSession session) throws Exception{
        String result = memberService.loginCheck(vo, session);
        
        ModelAndView mav = new ModelAndView();
        if (result.equals("loginTure")) { // 로그인 성공
            // main.jsp로 이동
            mav.setViewName("redirect:/");
        }else if(result.equals("EmailAuthFailure")){ // 이메일 인증 실패    
        	// login.jsp로 이동
            mav.setViewName("member/member_login");
            mav.addObject("msg", "EmailAuthFailure");
        }else if(result.equals("loginFailure")){ // 로그인 실패
        	// login.jsp로 이동
            mav.setViewName("member/member_login");
            mav.addObject("msg", "failure");
        }
        return mav;
    }
	
	// 로그아웃 처리
    @RequestMapping("logout.do")
    public ModelAndView logout(HttpSession session) throws Exception{
        memberService.logout(session);
        ModelAndView mav = new ModelAndView();
        mav.setViewName("member/member_login");
        mav.addObject("msg", "logout");
        return mav;
    }
	
	// 회원 목록
	// url pattern mapping
	@RequestMapping("list.do")
	public String memberList(Model model) throws Exception{
	// controller => service => dao 요청
		List<MemberVO> list = memberService.memberList();
		model.addAttribute("list", list);
		return "member/member_list";
	}
	
	// 회원 등록 페이지로 이동
	@RequestMapping("write.do")
	public String memberWrite(){
		
		return "member/member_write";
	}
	
	// 회원 등록 처리 후 ==> 회원목록으로 리다이렉트
	// @ModelAttribute에 폼에서 입력한 데이터가 저장된다.
	@RequestMapping("insert.do")
	// * 폼에서 입력한 데이터를 받아오는 법 3가지 
	//public String memberInsert(HttpServlet request){
	//public String memberInsert(String userId, String userPw, String userName, String userEmail){
	public String memberInsert(@ModelAttribute MemberVO vo) throws Exception{
		// 테이블에 레코드 입력
		memberService.insertMember(vo);
		// * (/)의 유무에 차이
		// /member/list.do : 루트 디렉토리를 기준
		// member/list.do : 현재 디렉토리를 기준
		// member_list.jsp로 리다이렉트
		return "redirect:/";
	}
	
	// 회원 아이디 체크
	@RequestMapping(value="checkId.do", method=RequestMethod.POST, produces="text/plain;charset=utf-8")
	public ResponseEntity<String> memberCheckId(@RequestParam String id)throws Exception {
		boolean result = memberService.checkId(id);
		
		if(result) {
			return new ResponseEntity<String>("failure", HttpStatus.OK);
		}else {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		}
	}
	
	// 회원 닉네임 체크
	@RequestMapping(value="checkName.do", method=RequestMethod.POST, produces="text/plain;charset=utf-8")
	public ResponseEntity<String> memberCheckName(@RequestParam String name)throws Exception { 
		boolean result = memberService.checkName(name);
	
		if(result) {
			return new ResponseEntity<String>("failure", HttpStatus.OK);
		}else {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		}
		
	}
	
	// 회원 이메일 체크
	@RequestMapping(value="checkEmail.do", method=RequestMethod.POST, produces="text/plain;charset=utf-8")
	public ResponseEntity<String> memberCheckEmail(@RequestParam String email)throws Exception { 
		boolean result = memberService.checkEmail(email);
	
		if(result) {
			return new ResponseEntity<String>("failure", HttpStatus.OK);
		}else {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		}
		
	}
	
	
	// 회원 상세정보 조회
	@RequestMapping("view.do")
	public String memberView(@RequestParam String userId, Model model) throws Exception{
		// 회원 정보를 model에 저장
		model.addAttribute("dto", memberService.viewMember(userId));
		//System.out.println("클릭한 아이디 확인 : "+userId);
		logger.info("클릭한 아이디 : "+userId);
		// member_view.jsp로 포워드
		return "member/member_view";
	}
	
	// 회원 정보 수정 처리
	@RequestMapping("update.do")
	public String memberUpdate(@ModelAttribute MemberVO vo, Model model) throws Exception{
		// 비밀번호 체크
		boolean result = memberService.checkPw(vo.getUserId(), vo.getUserPw());
		if(result){ // 비밀번호가 일치하면 수정 처리후, 전체 회원 목록으로 리다이렉트
			memberService.updateMember(vo);
			return "redirect:/member/list.do";
		} else { // 비밀번호가 일치하지 않는다면, div에 불일치 문구 출력, viwe.jsp로 포워드
			// 가입일자, 수정일자 저장
			MemberVO vo2 = memberService.viewMember(vo.getUserId());
			vo.setUserRegdate(vo2.getUserRegdate());
			vo.setUserUpdatedate(vo2.getUserUpdatedate());
			model.addAttribute("dto", vo);
			model.addAttribute("message", "비밀번호 불일치");
			return "member/member_view";
		}
	}
	// 회원정보 삭제 처리
	// @RequestMapping : url mapping
	// @RequestParam : get or post방식으로 전달된 변수값
	@RequestMapping("delete.do")
	public String memberDelete(@RequestParam String userId, 
			@RequestParam String userPw, Model model) throws Exception{
		// 비밀번호 체크
		boolean result = memberService.checkPw(userId, userPw);
		if(result){ // 비밀번호가 맞다면 삭제 처리후, 전체 회원 목록으로 리다이렉트
			memberService.deleteMember(userId);
			return "redirect:/member/list.do";
		} else { // 비밀번호가 일치하지 않는다면, div에 불일치 문구 출력, viwe.jsp로 포워드
			model.addAttribute("message", "비밀번호 불일치");
			model.addAttribute("dto", memberService.viewMember(userId));
			return "member/member_view";
		}
	}
	
	// 이메일 인증
	@RequestMapping("emailConfirm.do")
	public ModelAndView memberEmailConfirm(@RequestParam String emailAuthKey, 
			@RequestParam String userId) throws Exception{
	
		ModelAndView mav = new ModelAndView();
		boolean result = memberService.emailConfirm(userId, emailAuthKey);
		
		if(result) {
			mav.addObject("msg", "EmailAuthSuccess");
		}else{
			mav.addObject("msg", "EmailAuthError");
		}
		
		mav.setViewName("member/member_login");
		
		return mav;
	}
}
