package com.ybh.springProject.service;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.ybh.springProject.common.MailHandler;
import com.ybh.springProject.common.TempKey;
import com.ybh.springProject.model.dao.MemberDAOImpl;
import com.ybh.springProject.model.dto.MemberVO;

// 현재 클래스를 스프링에서 관리하는 service bean으로 등록
@Service
public class MemberServiceImpl implements MemberService {
	
	// MemberDAOImpl 객체를 스프링에서 생성하여 주입시킴
	@Inject private MemberDAOImpl memberDao;
	
	@Inject private PasswordEncoder passwordEncoder;
	
	@Inject private JavaMailSender mailSender;
	
	// 회원 로그인 체크
	@Override
    public String loginCheck(MemberVO vo, HttpSession session) throws Exception{
		String result = "";
        boolean loginCheck = memberDao.loginCheck(vo);
        boolean checkEmailAuth = memberDao.checkEmailAuth(vo.getUserId());
        
        if (loginCheck) { // true일 경우 세션에 등록
        	
        	MemberVO vo2 = loginMember(vo);
            
            if(passwordEncoder.matches(vo.getUserPw(),vo2.getUserPw())){
            	if(checkEmailAuth) {
            		// 세션 변수 등록
                    session.setAttribute("userId", vo2.getUserId());
                    session.setAttribute("userName", vo2.getUserName());
                    session.setAttribute("userIsAdmin", vo2.getUserIsAdmin());
                    result = "loginTure";
            	}else {
            		result = "EmailAuthFailure";
            	}
            }else{
            	result = "loginFailure";
            }
        } 
        return result;
    }
	
	// 회원 로그인 정보
	@Override
    public MemberVO loginMember(MemberVO vo) throws Exception{
        return memberDao.loginMember(vo);
    }
	
	// 회원 로그아웃
	@Override
    public void logout(HttpSession session) throws Exception{
        // 세션 변수 개별 삭제
        // session.removeAttribute("userId");
        // 세션 정보를 초기화 시킴
        session.invalidate();
    }
	
	// 전체 회원 목록 조회
	@Override
	public List<MemberVO> memberList() throws Exception{
		return memberDao.memberList();
	}
	
	// 회원 등록
	@Override
	public void insertMember(MemberVO vo) throws Exception{
		String encPassword = passwordEncoder.encode(vo.getUserPw());
		vo.setUserPw(encPassword);
		
		String emailAuthKey = new TempKey().getKey(50,false);  // 인증키 생성
		vo.setUserEmailAuthKey(emailAuthKey);
		
		memberDao.insertMember(vo);
		
		MailHandler sendMail = new MailHandler(mailSender);
		sendMail.setSubject("[나기의 세상 이메일 인증]-ナギの世界のメール認証");
		
		sendMail.setText(
                new StringBuffer().append("<h1>메일인증 - メール認証</h1>").
                append("<p>본 메일은 회원가입 중복방지를 위한 메일인증 시스템을 하고 있습니다.<p>").
                append("<p>나기의 세상 홈페이지의 회원가입을 원하신 분은 아래의 메일 인증 확인을 눌러주세요.<p><br>").
                append("<p>本メールは会員加入の重複を防ぐため、メールの認証システムを行います。<p>").
                append("<p>ナギの世界ホームページの会員登録したい方は、下記の「メール認証確認する」を押してください。<p><br>").
                append("<a href='http://localhost:7070/springProject/member/emailConfirm.do?userId=").
                append(vo.getUserId()).
                append("&emailAuthKey=").
                append(emailAuthKey).
                append("' target='_blank'>메일 인증 확인 メール認証確認する</a>").toString());
		
		sendMail.setFrom("dbsqhd4757@naver.com", "Nagi");
        
		sendMail.setTo(vo.getUserEmail());
        sendMail.send();
		
	}
	
	// 회원 정보 상세 조회 
	@Override
	public MemberVO viewMember(String userId) throws Exception{
		return memberDao.viewMember(userId);
	}
	
	// 회원 정보 수정 처리
	@Override
	public void deleteMember(String userId) throws Exception{
		memberDao.deleteMember(userId);
	}
	
	// 회원 정보 삭제 처리
	@Override
	public void updateMember(MemberVO vo) throws Exception{
		memberDao.updateMember(vo);
	}
	
	// 회원 정보 수정 및 삭제를 위한 비밀번호 체크
	@Override
	public boolean checkPw(String userId, String userPw) throws Exception{
		return memberDao.checkPw(userId, userPw);
	}

	// 아이디 체크
	@Override
	public boolean checkId(String id) throws Exception{
		return memberDao.checkId(id);
	}

	// 비밀번호 체크
	@Override
	public boolean checkName(String name) throws Exception{
		return memberDao.checkName(name);
	}

	// 이메일 체크
	@Override
	public boolean checkEmail(String email) throws Exception{
		return memberDao.checkEmail(email);
	}

	// 이메일 인증확인
	@Override
	public boolean emailConfirm(String userId, String emailAuthKey) throws Exception {
		return memberDao.emailConfirm(userId, emailAuthKey);
	}
	
}
