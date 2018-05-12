-- 게시판 테이블 생성
create table tbl_board (
	bno int auto_increment primary key not null,		-- 게시물 번호
	bgroup int(2) not null,								-- 게시판 그룹번호
    title varchar(200) not null,						-- 제목
    content text,										-- 내용
    writer varchar(50) not null,						-- 이름
    regdate timestamp default now(),					-- 작성일자  
    updatedate timestamp default now(),					-- 수정일자
    viewCnt int default 0,								-- 조회수
    recnt int default 0									-- 댓글수
);



