package com.ybh.springProject.model.dao;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.ybh.springProject.model.dto.MemberVO;

public interface MemberDAO {
	// 회원 로그인 체크
    public boolean loginCheck(MemberVO vo);
    // 회원 로그인 정보
    public MemberVO loginMember(MemberVO vo);
    // 회원 로그아웃
    public void logout(HttpSession session);
	// 회원 목록 
	public List<MemberVO> memberList();
	// 회원 입력
	public void insertMember(MemberVO vo);
	// 회원 정보 상세보기
	public MemberVO viewMember(String userId);
	// 회원삭제
	public void deleteMember(String userId);
	// 회원정보 수정
	public void updateMember(MemberVO vo);
	// 비밀번호 체크
	public boolean checkPw(String userId, String userPw);
	// 아이디 체크
	public boolean checkId(String id);
	// 닉네임 체크
	public boolean checkName(String name);
	// 이메일 체크
	public boolean checkEmail(String email);
	// 이메일 인증키 검증
	public boolean checkEmailAuth(String id);
	// 이메일 인증확인
	public boolean emailConfirm(String userId, String emailAuthKey);
}
