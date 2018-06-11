-- 회원 테이블 생성
create table tbl_member (
	user_no int auto_increment primary key not null,	-- 회원 번호
	user_id varchar(32) not null,						-- 회원아이디
    user_pw varchar(255) not null,						-- 비밀번호
    user_name varchar(32) not null,						-- 이름
    user_email varchar(32) not null,					-- 이메일
    user_regdate timestamp default now(),				-- 생성날짜  
    user_updatedate timestamp default now(),			-- 업데이트 날짜
    user_is_admin varchar(1) default 'N', 				-- 최고 관리자 확인
    user_emailAuthKey varchar(255) not null,            -- 이메일 인증키
    user_is_emailAuth varchar(1) default 'N'			-- 이메일 인증 확인
);