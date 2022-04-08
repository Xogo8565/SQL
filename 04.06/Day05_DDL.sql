/*
DDL(Data Definition Language)
: DB 객체 생성(Create), 수정(Alter), 삭제 (Drop) 구문

오라클 객체 종류
: User, Table, View(가상테이블), Sequence...

생성(Create) // 테이블 기준

-> create table 테이블명(
    컬럼명 자료형 (크기), 
        .... ,
    컬럼명 자료형 (크기)    
) ;
*/

create table temp(
    id varchar2(300),
    pw varchar2(500),
    age number(100),
    join_date date
);

/*
    제약조건 (Constraints)
    : 테이블을 생성할 때 구성하는 컬럼에 들어갈 데이터에 대해 제약조건을 설정하는 것
    -> 데이터의 일관성과 정확성을 유지하기 위해서(데이터 무결성)

    not null : 해당 컬럼에 null 값이 들어갈 수 없음
    unique : 중복된 값을 허용 x
    primary key(기본키) : null 값 허용 x, 중복 허용 x -> 컬럼의 고유식별자
    foreign key(외래키) : 두 테이블 간의 관계를 설정하고 -> A 테이블(id, pw, ---) B 테이블(mem_id, count, ---)
        B테이블의 mem_id 컬럼에 들어갈 수 있는 값이 A 테이블의 id에 있는 데이터여야하는 경우
    check : 해당 컬럼에 저장 가능한 값의 범위 조건을 저장해서 설정한 값만 허용
    
*/

select 
    constraint_name, constraint_type
from user_constraints
where table_name = 'EMPLOYEE';
-- (p : primary key /  c : check or not null )
-- constraint_name ( sys ~ : 시스템에서 부여된 이름)

/*
    not null : null 값을 허용 x -> 해당 컬럼에 반드시 값이 기록되어야 하는 경우
*/

create table user_nocons (
    no number 
    , pw varchar2(100)
    , name varchar2(100)
    , gender varchar2(10)
);

insert into user_nocons values(1,'abc123','tom','남');
insert into user_nocons values(2,null,null,'여');

select * from user_nocons;

/*
    제약 조건을 거는 방식
    - 컬럼 레벨 : 컬러명 자료형 제약조건
    - 테이블 레벨 : 컬럼을 모두 정의한 후에 마지막에 제약조건명(컬럼명) 형식으로 제약조건을 걸어주는 방식

    -- Not null 조건은 컬럼레벨에서만 가능
*/

create table user_cons( -- 컬럼 레벨에서 제약조건 걸기
    no number unique not null
    ,pw varchar2(100) not null
    ,name varchar2(100) not null
    ,gender varchar2(10) 
);

create table user_cons(
    no number
    , pw varchar2(100) not null
    , name varchar2(100) not null
    , gender varchar2(10) 
    , unique(no) -- 테이블 레벨에서 unique 제약조건 걸기
    
);

drop table user_cons;


insert into user_cons values(1,'aaa555','paul','남');
insert into user_cons values(2,'bbb222',null,'여'); 
-- 데이터를 삽입할 때부터 제약조건에 부합하지 않는다면 데이터가 들어가지 않음
-- 데이터의 무결성을 유지

/*
    unique : 해당 컬럼에 중복값을 제한하는 제약조건

*/

select * from user_cons;
insert into user_cons values(1,'abc123','march','남');
insert into user_cons values(1,'sdfasd','sam','여');
-- unique constraint violated
insert into user_cons values(null,'sdfasd','sam','여');
-- null 값 삽입 가능 // null값은 중복으로 삽입할 수도 있음

/*
Primary key : 컬럼의 데이터가 중복값을 허용하지 않으면서 Null값도 허용하지 않는 경우
-> Unique + not null과 동일하게 동작(엄밀하게 말하면 다름)
-> 하나의 테이블에서 primary key 는 하나만 걸어줄 수 있음 -> 고유식별자기 때문
-> Unique + not null 제약조건은 하나의 테이블에서도 여러번 사용이 가능하기 때문에 고유식별자는 아니지만 중복값과 null 값을 허용하면 안되는 경우에 사용한
*/

create table user_cons( 
    no number primary key
    ,pw varchar2(100) not null
    ,name varchar2(100) not null
    ,gender varchar2(10) 
);

create table user_cons( 
    no number primary key
    ,pw varchar2(100) primary key -- table can have only one primary key
    ,name varchar2(100) not null
    ,gender varchar2(10) 
);

drop table user_cons;

insert into user_cons values(null, '1234', 'tom', '남');
-- cannot insert null
insert into user_cons values(1, '1234', 'tom', '남');
insert into user_cons values(1, '1234', 'tom', '남');
-- unique contstraint violated


/*
    Primary key 에 대햇 하나의 컬럼이 아니라 여러 개의 컬럼에 대해 복합키 형태로 걸고 싶으면
    컬럼레벨에서는 불가
    -> 테이블 레벨에서 설정
    복합키 : 컬럼 두개 이상을 묶어서 설정하는 키


*/

create table user_cons( -- no, id를 묶어서 primary key로 설정
    no number 
    ,id varchar2(100)
    ,pw varchar2(100) not null
    ,gender varchar2(10) 
    ,primary key (no, id)
);

select * from user_cons;
insert into user_cons values(1,'abc','aaa45','남');
insert into user_cons values(1,'cba','eee45','남'); -- 데이터 삽입 가능
insert into user_cons values(1,'abc','aaa56','남'); -- unique constraint violated


/*
    Foreign key (외래키) : 참조된 다른 테이블이 제공하는 값만 사용할 수 있도록 제약하고 싶을 때
    -> 참조하는 컬럼과 참조되는 컬럼을 통해 두 테이블 간의 관계가 형성됨.
  
    -> 참조하는 컬럼이 참조되는 컬럼에 있는 값과 일치하는 값 or null 값만 가질 수 있
    
    ** 참조 하는 컬럼 : 참조 대상을 참조하는 테이블의 컬럼 
    ** 참조 되는 컬럼 : 참조 대상이 되는 컬럼
    
*/
drop table student;

create table student(
    id varchar2(100) primary key
    , name varchar2(100) not null
    , age number not null
);

insert into student values('001','tom',20);
insert into student values('002','sally',30);
insert into student values('003','Meu',25);

select * from student;

-- 도서 대여 테이블
drop table book_rental;

create table book_rental( -- 테이블 레벨
    book_id varchar2(100) primary key,
    student_id varchar2(100),
    rental_date date not null,
    foreign key (student_id) references student (id) -- foreign key (참조하는 컬럼) references 참조대상테이블 (참조대상컬럼명)
);

create table book_rental( -- 컬럼레벨
    book_id varchar2(100) primary key,
    student_id varchar2(100) references student (id), -- 컬럼명 자료형 references 참조대상테이블 (참조대상컬럼)
    rental_date date not null
);

insert into book_rental values('500','001',sysdate);
insert into book_rental values('500','005',sysdate); -- integrity constraint violated
select * from book_rental;

-- 참조되고 있는 id를 삭제 하는 경우
-- 참조되고 있는 컬럼의 데이터를 가지고 있는 자식 컬럼이 있다면 원본 테이블의 데이터 삭제 불가
-- 데이터의 무결성이 침해되기 때문

select * from student;
delete from student where id = '001'; -- integrity constraint 

-------------------------------------------------------------------------
/*
삭제 옵션
-> 부모 테이블에서 데이터 삭제할 때 자식 테이블에 있는 데이터를 어떤 방식으로 처리할지
제약조건을 걸 때 삭제 옵션도 함께 걸어 줌.
-> 기본 삭제 옵션은 on delete no action -> 자신을 참조하는 데이터가 있다면 삭제 불가

*/


-- on delete set null
-- 만약 참조하고 있던 부모데이터가 삭제되면 자식 데이터를 null 값으로 설정

drop table book_rental;

create table book_rental( -- 테이블 레벨
    book_id varchar2(100) primary key,
    student_id varchar2(100),
    rental_date date not null,
    foreign key (student_id) references student (id) on delete set null
);

insert into book_rental values('500','001',sysdate);

select * from book_rental;
select * from student;

delete from student where id = '001';

-- on delete cascade
-- 부모 데이터가 삭제되면 해당 데이터를 참조하고 있는 자식 데이터 역시도 함께 삭제

drop table book_rental;

create table book_rental( -- 테이블 레벨
    book_id varchar2(100) primary key,
    student_id varchar2(100),
    rental_date date not null,
    foreign key (student_id) references student (id) on delete cascade
);

insert into book_rental values('500','001',sysdate);

select * from book_rental;
select * from student;

delete from student where id = '001'; 


/*
    check 
    : 해당 컬럼에 입력되거나, 수정되어 들어오는 값을 체크해 설정한 값만 들어올 수 있게끔 제한
*/
drop table user_cons;

create table user_cons( 
    no number 
    ,id varchar2(100)
    ,pw varchar2(100) not null
    ,gender varchar2(10) check (gender in ('남','여'))
    ,primary key (no, id)
);

insert into user_cons values('1', 'id','pw','Mango'); -- check constraint violated
insert into user_cons values('1', 'id','pw','남'); 

-- default
create table temp (
    date_one date,
    date_two date default sysdate
);

insert into temp values(sysdate); -- not enough values // 컬럼의 총개수와 일치하지 않는 데이터를 넣음
insert into temp values(sysdate, default); -- default 라는 키워드를 이용해 값을 넣으면 테이블 생성 시 defaul 로 잡아준 값이 들어감
select * from temp;


---------------------------------------------------

/*
 drop : 객체를 삭제하기 위해 사용하는 구문
*/

----------------------------------------------------

/*
Alter : 테이블에 정의된 내용을 수정하고자 할 때 사용하는 데이터 정의어
-> 컬럼 추가/삭제, 제약조건 추가/삭제, 컬럼의 자료형 변경, default 값 변경 등
*/

create table member(
    no number not null,
    id varchar2(100),
    pw varchar2(100)
);

drop table member;

select * from member;
desc member;

-- 이미 존재하는 member 테이블에 새로운 컬럼 추가 (name)
alter table member add (name varchar2(100));

-- 새로운 컬럼 추가 (age, default 0)

alter table member add (age number default 0);

-- 제약 조건 추가 -> id 컬럼에 unique 제약조건 추가
alter table member add constraint id_unique unique(id);
select constraint_name, constraint_type from user_constraints where table_name = 'MEMBER';

-- 제약 조건 추가 -> pw 컬럼에 not null 제약 조건 추가 -> modify
alter table member add constraint pw_nn not null(pw); -- 오류 발생
alter table member modify pw constraint pw_nn not null;

-- 컬럼명 수정 -> pw 컬럼을 password 라고 변경
alter table member rename column pw to password;
desc member;

-- 컬럼의 데이터 타입 수정 name varchar2(100) -> name char(100)
alter table member modify name char(100);

-- 컬럼 삭제 
alter table member drop column age;

-- 제약조건 삭제 -- password 컬럼의 제약조건 삭제
-- 제약조건의 이름을 먼저 알아야 함
select * from user_tables;
select constaint_name from user_constaints where table_name ='MEMBER';
alter table MEMBER drop constraint pw_nn;

-- 제약조건명 수정
alter table member rename constraint SYS_C007122 to no_pk;

-- 테이블명 변경
alter table member rename to tbl_member;

select * from all_tab_columns where table_name = 'TBL_MEMBER';

desc tbl_member;