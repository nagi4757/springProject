package com.ybh.springProject.model.dto;

import java.util.Date;

public class BoardVO {
	private int bno;            	// 게시글 번호
	private int bgroup;				// 게시글 그룹번호
    private String title;       	// 게시글 제목
    private String content;     	// 게시글 내용
    private String writer;      	// 게시글 작성자
    private String userName;		// 게시글 회원이름 = 게시글 작성자
    private Date regdate;       	// 게시글 작성일자 util.Date
    private Date updatedate;		// 게시글 업데이트 일자
    private int viewcnt;        	// 게시글 조회수
    private int recnt;				// 게시글 댓글의 수 추가
    private String firstImageSrc; 	// 게시글 첫번째 이미지
    
    // Getter/Setter
	public int getBno() {
		return bno;
	}
	
	public void setBno(int bno) {
		this.bno = bno;
	}
	
	public int getBgroup() {
		return bgroup;
	}

	public void setBgroup(int bgroup) {
		this.bgroup = bgroup;
	}

	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getContent() {
		return content;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	
	public String getWriter() {
		return writer;
	}
	
	public void setWriter(String writer) {
		this.writer = writer;
	}
	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public Date getRegdate() {
		return regdate;
	}
	
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	
	public Date getUpdatedate() {
		return updatedate;
	}

	public void setUpdatedate(Date updatedate) {
		this.updatedate = updatedate;
	}

	public int getViewcnt() {
		return viewcnt;
	}
	
	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}
	
	public int getRecnt() {
		return recnt;
	}

	public void setRecnt(int recnt) {
		this.recnt = recnt;
	}

	public String getFirstImageSrc() {
		return firstImageSrc;
	}

	public void setFirstImageSrc(String firstImageSrc) {
		this.firstImageSrc = firstImageSrc;
	}

	// toString()
	@Override
	public String toString() {
		return "BoardVO [bno=" + bno + ", bgroup=" + bgroup + ", title=" + title + ", content=" + content + ", writer="
				+ writer + ", userName=" + userName + ", regdate=" + regdate + ", updatedate=" + updatedate
				+ ", viewcnt=" + viewcnt + ", recnt=" + recnt + ", firstImageSrc=" + firstImageSrc + "]";
	}
	
}
