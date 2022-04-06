/*
DML(Data Manipulation Language): 데이터 조작어
 Data를 조작하기 위한 언어(명령어)
-> 데이터의 삽입, 수정, 삭제, 조회 등을 제어하는 언어
-> insert, update, delete, select

 cf)DQL(Data Query Language): 데이터를 검색하기 위해 사용하는 언어
 -> select 
--------------------------------------------------------------
DDL(Data Definition Language): 데이터 정의어
 DB에서 개체(Table, User)를 정의하거나 변경, 삭제하기 위한 언어
-> DB 관리자, 설계자가 주로 사용
-> create, alter, drop, truncate(개체 초기화)
--------------------------------------------------------------
DCL(Data Control Language) : 데이터 제어어
 사용자의 권한, 관리자 설정 등을 처리하는 언어
-> grant, revoke(권한 삭제)
--------------------------------------------------------------
SQL(Structured Query Language): 구조화된 질의 언어
-> 데이터베이스에서 데이터를 조회하거나 조작w하기 위해서 사용하는 표준 언어
-> 사용하는 DBMS에 따라서 SQL 문법이 다름

*/
/*

오라클의 자료형 
**숫자
-> number(p,s)

**문자
-> char (길이값이 고정 / 2000 bytes까지 저장 작가능)
: 데이터를 저장할 때, 부여된 길이값보다 작은 길이의 데이터를 저장해도 남는 데이터의 공간을 공백으로 저장한다.

-> varchar2(길이값이 가변/ 4000 bytes까지 저장 가능)
: 지정해준 길이값보다 작은 데이터가 들어오면, 그 데이터의 크기만큼만 데이터의 공간을 차지한다.

**날짜
-> date ()
: 년/월/일까지만 표기 (저장은 시/분/초까지 저장됨)

-> timestamp (Millisecond까지 저장 가능)

*/
/*
create table 테이블명(
컬럼명 자료형,
컬럼명 자료형
);
*/

create table intro_tbl(
no number,
name char(9),
message varchar2(100),
written_date date,
signup_date timestamp
);

insert into intro_tbl values (1, 'dsksk', 'tom', sysdate, sysdate);

select * from intro_tbl;

truncate table intro_tbl;

delete from intro_tbl where no = 1;
