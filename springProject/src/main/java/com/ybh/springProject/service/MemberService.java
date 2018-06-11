package com.ybh.springProject.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.ybh.springProject.model.dto.MemberVO;

public interface MemberService {
	// 회원 로그인 체크
	public String loginCheck(MemberVO vo, HttpSession session) throws Exception;
	// 회원 로그인 정보
	public MemberVO loginMember(MemberVO vo) throws Exception;
	// 회원 로그아웃
	public void logout(HttpSession session) throws Exception;
	// 회원 목록 
	public List<MemberVO> memberList() throws Exception;
	// 회원 입력
	public void insertMember(MemberVO vo) throws Exception;
	// 회원 정보 상세보기
	public MemberVO viewMember(String userId) throws Exception;
	// 회원삭제
	public void deleteMember(String userId) throws Exception;
	// 회원정보 수정
	public void updateMember(MemberVO vo) throws Exception;
	// 비밀번호 체크
	public boolean checkPw(String userId, String userPw) throws Exception;
	// 아이디 체크
	public boolean checkId(String id) throws Exception;
	// 닉네임 체크
	public boolean checkName(String name) throws Exception;
	// 이메일 체크
	public boolean checkEmail(String email) throws Exception;
	// 이메일 인증확인
	public boolean emailConfirm(String userId, String emailAuthKey) throws Exception;
}
