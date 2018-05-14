package com.ybh.springProject.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.ybh.springProject.model.dto.MemberVO;

// 현재 클래스를 DAO bean으로 등록시킴
@Repository
public class MemberDAOImpl implements MemberDAO {
	
	// SqlSession 객체를 스프링에서 생성하여 주입시켜준다.
	// 의존관계 주입(Dependency Injection), 느슨한 결함
	@Inject SqlSession sqlSession;
	
	// 회원 로그인 체크
	@Override
    public boolean loginCheck(MemberVO vo) {
        String name = sqlSession.selectOne("member.loginCheck", vo);
        return (name == null) ? false : true;
    }
	// 회원 로그인 정보
	@Override
    public MemberVO loginMember(MemberVO vo) {
        return sqlSession.selectOne("member.loginMember", vo);
    }
	// 회원 로그아웃
	@Override
    public void logout(HttpSession sessin) {
    }
	// 전체 회원 목록 조회
	@Override
	public List<MemberVO> memberList() {
		return sqlSession.selectList("member.memberList");
	}
	// 회원 등록
	@Override
	public void insertMember(MemberVO vo) {
		sqlSession.insert("member.insertMember", vo);
	}
	// 회원 정보 상세 조회
	@Override
	public MemberVO viewMember(String userId) {
		return sqlSession.selectOne("member.viewMember", userId);
	}
	// 회원 정보 수정 처리
	@Override
	public void deleteMember(String userId) {
		sqlSession.delete("member.deleteMember",userId);
	}
	// 회원 정보 삭제 처리
	@Override
	public void updateMember(MemberVO vo) {
		sqlSession.update("member.updateMember", vo);

	}
	// 회원 정보 수정 및 삭제를 위한 비밀번호 체크
	@Override
	public boolean checkPw(String userId, String userPw) {
		boolean result = false;
		Map<String, String> map = new HashMap<String, String>();
		map.put("userId", userId);
		map.put("userPw", userPw);
		int count = sqlSession.selectOne("member.checkPw", map);
		if(count == 1) result= true;
		return result;
	}
	
	// 회원 아이디 체크
	@Override
	public boolean checkId(String id) {
		boolean result = false;
		int count = sqlSession.selectOne("member.checkId", id);
		if(count == 1) result= true;
		return result;
	}
	
	// 회원 닉네임 체크
	@Override
	public boolean checkName(String name) {
		boolean result = false;
		int count = sqlSession.selectOne("member.checkName", name);
		if(count == 1) result= true;
		return result;
	}
}
