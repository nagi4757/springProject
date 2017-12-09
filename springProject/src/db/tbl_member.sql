-- 회원 테이블 생성
create table tbl_board (
	user_id varchar(32) auto_increment primary key not null,		-- 회원아이디
    user_pw varchar(32) not null,									-- 비밀번호
    user_name varchar(32) not null,									-- 이름
    user_email varchar(32) not null,								-- 이메일
    user_regdate timestamp default now(),							-- 생성날짜  
    user_updatedate timestamp default now()							-- 업데이트 날짜
);