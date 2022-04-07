/*
view : 하나 이상의 테이블에서 원하는 데이터를 선택해서 새로운 가상 테이블을 만들어주는 것
-> 뷰를 통해 만들어진 테이블이 물리적으로 존재하는 것은 아니고 다른 테이블의 데이터만 조합하여 보여주는 것
-> 특정 계정이 원본 데이터에 접근해서 모든 데이터(불필요한 데이터)에 접근하는 것을 방지할 수 있음.
-> 뷰를 생성하는 권한 => 제한적(뷰의 내용을 수정하면 원본 테이블의 데이터도 수정되기 때문)
-> 원본 테이블의 내용이 수정되면 뷰의 내용도 수정된다 / 데이터 실시간 공유(업데이트)

create view viewname as select ~

*/
-- view 생성권한 부여
grant create view to kh;

-- emp_no, emp_name. email, phone

create view emp_view as(
    select emp_no, emp_name, phone, email from employee);

select * from emp_view;


-- 권한이 부여되지 않은 계정은 emp_view 에 접근할 수 없음
-- view에 대한 select 권한을 줄 때 system이 아니라 뷰를 생성한 계정에서 권한을 부여
grant select on kh.emp_view to test01;

select * from kh.emp_view;

-- 선동일 -> 이름을 김동일로 수정
update employee set emp_name = '김동일' where emp_name ='선동일';
select * from employee;
commit;

select * from kh.emp_view; --> view 안의 emp_name 변화

-- 뷰 삭제
drop view emp_view;
commit;

select * from kh.emp_view; -- does not exist

--------------------------------------------------------------------------------
/*
Sequence : 순차적으로 정수 값을 자동으로 생성하는 객체

create sequence sequencename 
1. start with N -> N부터 시작
2. increment by N -> N 단위로 숫자가 증가
3. maxvalue N / nomaxvalue -> 최댓값을 설정
4. minvalue N / nominvalue
5. cycle / nocycle -> 최댓값에 도달하면 처음으로 돌아가 다시 순번을 매길 것인지
6. cache / nocache -> 메모리 상에 미리 시퀀스를 뽑아 올려두고 사용하는 것(버퍼)
*/

create sequence seq_tmp 
    start with 1
    increment by 1
    -- maxvalue 10
    nomaxvalue
    -- cycle -- 10++ 면 1로 회귀
    nocycle -- maxvalue ++ 면 에러 발생. 일반적으로 nocycle 은 nomaxvalue랑 함께 사용
    nocache;
  
drop sequence seq_tmp;

select * from user_sequences where sequence_name = 'SEQ_TMP';

/*

nextval : 현재 시퀀스의 다음값을 반환
currval : 시퀀스의 현재값을 반환
    -> 접속하고 nextval 이 단 한번도 사용되지 않았다면 사용이 불가능 

*/

select seq_tmp.currval from dual; -- not yet defined
select seq_tmp.nextval from dual;
select seq_tmp.currval from dual; 

select * from coffee;

insert into coffee values (seq_tmp.nextval, 4000, 'Max' );
insert into coffee values (seq_tmp.nextval, 4000, 'Max' );
