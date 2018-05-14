package com.ybh.springProject.service;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.ybh.springProject.model.dao.MemberDAOImpl;
import com.ybh.springProject.model.dto.MemberVO;

// 현재 클래스를 스프링에서 관리하는 service bean으로 등록
@Service
public class MemberServiceImpl implements MemberService {
	
	// MemberDAOImpl 객체를 스프링에서 생성하여 주입시킴
	@Inject MemberDAOImpl memberDao;
	
	@Inject PasswordEncoder passwordEncoder;
	
	// 회원 로그인 체크
	@Override
    public boolean loginCheck(MemberVO vo, HttpSession session) {
        boolean result = memberDao.loginCheck(vo);
        
        if (result) { // true일 경우 세션에 등록
        	
        	MemberVO vo2 = loginMember(vo);
            
            if(passwordEncoder.matches(vo.getUserPw(),vo2.getUserPw())){
            	// 세션 변수 등록
                session.setAttribute("userId", vo2.getUserId());
                session.setAttribute("userName", vo2.getUserName());
                session.setAttribute("userIsAdmin", vo2.getUserIsAdmin());
            }else{
            	result = false;
            }
        } 
        return result;
    }
	
	// 회원 로그인 정보
	@Override
    public MemberVO loginMember(MemberVO vo) {
        return memberDao.loginMember(vo);
    }
	
	// 회원 로그아웃
	@Override
    public void logout(HttpSession session) {
        // 세션 변수 개별 삭제
        // session.removeAttribute("userId");
        // 세션 정보를 초기화 시킴
        session.invalidate();
    }
	
	// 전체 회원 목록 조회
	@Override
	public List<MemberVO> memberList() {
		return memberDao.memberList();
	}
	
	// 회원 등록
	@Override
	public void insertMember(MemberVO vo) {
		String encPassword = passwordEncoder.encode(vo.getUserPw());
		vo.setUserPw(encPassword);
		memberDao.insertMember(vo);
	}
	
	// 회원 정보 상세 조회 
	@Override
	public MemberVO viewMember(String userId) {
		return memberDao.viewMember(userId);
	}
	
	// 회원 정보 수정 처리
	@Override
	public void deleteMember(String userId) {
		memberDao.deleteMember(userId);
	}
	
	// 회원 정보 삭제 처리
	@Override
	public void updateMember(MemberVO vo) {
		memberDao.updateMember(vo);
	}
	
	// 회원 정보 수정 및 삭제를 위한 비밀번호 체크
	@Override
	public boolean checkPw(String userId, String userPw) {
		return memberDao.checkPw(userId, userPw);
	}

	// 아이디 체크
	@Override
	public boolean CheckId(String id) {
		return memberDao.checkId(id);
	}

	// 비밀번호 체크
	@Override
	public boolean CheckName(String name) {
		return memberDao.checkName(name);
	}
	
}
