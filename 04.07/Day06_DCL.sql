/*
DCL 
: 데이터 제어어
->데이터베이스에 관한 보안, 무결성, 복구 등 DBMS를 제어하기 위한 언어
-> grant, revoke / TCL(commit, rollback)
*/

/*
    grant : 사용자 또는 role(resource, connect, dba)에 대해 권한 부여
    #dba = DB 관리자 권한
    -> system/관리자 계정 접속 -> 신규 사용자 생성 -> grant 접속 권한 부여 -> 리소스 권한 부여
*/

create user test01 identified by test01;
grant connect, resource to test01;

create table coffee(
    name varchar2(100) primary key,
    price number not null,
    brand varchar2(100) not null
);

insert into coffee values ('maxim', 3000, 'maxim');
insert into coffee values ('아메리카노', 4000,'kanu');
insert into coffee values ('카페라떼', 3400,'nescafe');
commit;


select * from kh.coffee; -- test01 계정으로 접속 후 조회 시 table not exist

-- system 계정에서 test01 계정이 가지고 있는 coffee 테이블에 접근 권한 부여

grant select on kh.coffee to test01;
insert into kh.coffee values ('바닐라라떼', 6000,'starbucks'); -- insufficient priviliege


-- system 계정에서 test01 계정한테 kh 계정의 coffee 테이블에 대한 insert 권한 부여
grant insert on kh.coffee to test01;
insert into kh.coffee values ('바닐라라떼', 6000,'starbucks'); -- insert 성공

-- revoke -> 부여된 권한을 회수하는 명령어
revoke select, insert on kh.coffee from test01;
select * from kh.coffee; -- 에러 발생

select * from dba_role_privs where grantee = 'KH';

