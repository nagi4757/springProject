package com.ybh.springProject.model.dto;

import java.util.Date;

public class ReplyVO {
	private int rno; 					// 댓글 번호
	private int bno; 					// 게시글 번호
	private int rgrpno;					// 댓글 그룹번호
	private int rprtno;					// 댓글 부모 번호
	private int rgrpord;				// 그룹내의 순서
	private int rdepth;					// 댓글의 depth
	private String replytext; 			// 댓글 내용
	private String replyer; 			// 댓글 작성자
	private String userName; 			// 댓글 작성자의 이름(회원의 이름)
	private Date regdate; 				// 댓글 작성일자
	private Date updatedate; 			// 댓글 수정일자
	
	// Getter/Setter
	public int getRno() {
		return rno;
	}
	
	public void setRno(int rno) {
		this.rno = rno;
	}
	
	public int getBno() {
		return bno;
	}
	
	public void setBno(int bno) {
		this.bno = bno;
	}
	
	public int getRgrpno() {
		return rgrpno;
	}

	public void setRgrpno(int rgrpno) {
		this.rgrpno = rgrpno;
	}
	
	public int getRprtno() {
		return rprtno;
	}

	public void setRprtno(int rprtno) {
		this.rprtno = rprtno;
	}

	public int getRgrpord() {
		return rgrpord;
	}

	public void setRgrpord(int rgrpord) {
		this.rgrpord = rgrpord;
	}

	public int getRdepth() {
		return rdepth;
	}

	public void setRdepth(int rdepth) {
		this.rdepth = rdepth;
	}

	public String getReplytext() {
		return replytext;
	}
	
	public void setReplytext(String replytext) {
		this.replytext = replytext;
	}
	
	public String getReplyer() {
		return replyer;
	}
	
	public void setReplyer(String replyer) {
		this.replyer = replyer;
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

	// toString()
	@Override
	public String toString() {
		return "ReplyVO [rno=" + rno + ", bno=" + bno + ", rgrpno=" + rgrpno + ", rprtno=" + rprtno + ", rgrpord="
				+ rgrpord + ", rdepth=" + rdepth + ", replytext=" + replytext + ", replyer=" + replyer + ", userName="
				+ userName + ", regdate=" + regdate + ", updatedate=" + updatedate + "]";
	}

}
