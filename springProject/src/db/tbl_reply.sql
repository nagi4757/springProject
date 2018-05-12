create table tbl_reply (
	rno int auto_increment primary key not null,		-- 댓글 번호
	bno int not null,									-- 게시물 번호
	rgrpno int not null,								-- 댓글 그룹번호
	rprtno int default 0,								-- 댓글 부모 번호
	rgrpord int default 0,								-- 그룹내의 순서
	rdepth int default 1,								-- 댓글의 depth
	replytext text,										-- 댓글 내용
	replyer varchar(50) not null,						-- 작성자
	regdate timestamp default now(),					-- 작성일자
	updatedate timestamp default now(),					-- 수정일자
	FOREIGN KEY (bno) REFERENCES tbl_board (bno)	
);