/*
DML
: 데이터 조작어
-> 데이터를 삽입, 수정, 삭제, 조회하는 언어
-> insert, update, delete, select
*/

/*
insert : 테이블에 새로운 행을 추가할 때 사용하는 구문
-> insert into 테이블명 values(Data1, Data2 ....); -- 모든 행에 대한 데이터를 추가하고자 할 때 사용하는 구문
-> insert into 테이블명 (column1, column,2 ... ) values (Data1 , Data2) -- 특정한 Column에만 데이터를 넣고 싶은 경우 사용하는 구문

*/

create table member(
    id varchar2(100) primary key,
    pw varchar2(100) not null,
    nickname varchar2(100) unique,
    email varchar2(100)
);

insert into member values('abc123','abc','ABC초콜릿','abc@google.com');
insert into member (id, pw) values('eee555','eee');
insert into member(id, pw, nickname , email) values('aaa','fdss','에이에이','aa@google.com');
insert into member values(123, sysdate, 'ffd', 'abc@naver.com'); -- 묵시적 형변환 : 오라클이 자동으로 자료형을 추측하여 변환해주는 것

select * from member;

-- 서브쿼리를 이용해서 insert 구문 사용
insert into member (select emp_id, job_code, emp_name, email from employee where emp_id ='200');


---------------------------------------------------------------------------------------------------------------------------

/*
Update : 컬럼에 저장된 데이터를 수정하는 구문 -> 테이블의 전체 행 개수에 변화를 주지 않음
-> update 테이블명 set 변경할 컬럼명 = 변경할 값 where 조건
*/

select * from member;

update member set email = 'eee@gmail.com'; -- 조건을 명시하지 않으면 모든 열이 수정됨
update member set email = 'abc@naver.com' where id = 'abc123';

-- pw, nickname
update member set pw = '1234', nickname = '이티' where id = 'eee555';


/*
delete : 테이블의 행을 삭제하는 구문 -> 행의 개수에 변화가 생김
-> 조건문을 걸어주지 않으면 테이블의 모든 데이터가 삭제됨.

delete from 테이블명 where조건

*/

delete from member where id = '200';
select * from member;
delete from member; -- 전체 삭제
----------------------------------------------------------------------------------

/*
truncate : 테이블의 전체 행을 삭제할 때 사용하는 구문
-> 되돌릴 수 없음 -> 즉 영구적으로 삭제 -> rollback x
*/
commit; -- 다시 insert 후 커밋
rollback; -- Delete 후 롤백하면 데이터가 복원되지만, truncate는 복원이 안 된다.
select * from member;

truncate table member;
