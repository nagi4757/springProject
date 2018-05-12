package com.ybh.springProject.model.dto;

import java.sql.Date;

public class MemberVO {
	private int userNo;
	private String userId;
	private String userPw;
	private String userName; 
	private String userEmail; 
	private Date userRegdate; // java.sql.Date
	private Date userUpdatedate;
	private String userIsAdmin;
	
	// Getter/Setter
	public int getUserNo() {
		return userNo;
	}
	
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	
	public String getUserId() {
		return userId;
	}
	
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public String getUserPw() {
		return userPw;
	}
	
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	
	public String getUserName() {
		return userName;
	}
	
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String getUserEmail() {
		return userEmail;
	}
	
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	
	public Date getUserRegdate() {
		return userRegdate;
	}
	
	public void setUserRegdate(Date userRegdate) {
		this.userRegdate = userRegdate;
	}
	
	public Date getUserUpdatedate() {
		return userUpdatedate;
	}
	
	public void setUserUpdatedate(Date userUpdatedate) {
		this.userUpdatedate = userUpdatedate;
	}
	
	public String getUserIsAdmin() {
		return userIsAdmin;
	}

	public void setUserIsAdmin(String userIsAdmin) {
		this.userIsAdmin = userIsAdmin;
	}

	// toString()
	@Override
	public String toString() {
		return "MemberVO [userNo=" + userNo + ", userId=" + userId + ", userPw=" + userPw + ", userName=" + userName
				+ ", userEmail=" + userEmail + ", userRegdate=" + userRegdate + ", userUpdatedate=" + userUpdatedate
				+ ", userIsAdmin=" + userIsAdmin + "]";
	}
	
}