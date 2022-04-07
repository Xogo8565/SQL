select * from all_tab_columns where table_name = 'TB_CATEGORY';
select * from all_tab_columns where table_name = 'TB_CLASS_TYPE';

--1
create table TB_CATEGORY(
    name varchar2(10),
    use_yn char(1) default ('Y')
);

--2

create table TB_CLASS_TYPE(
    no varchar2(5) primary key,
    name varchar2(10)
);

--3

alter table tb_category add constraint category_pk primary key (name); 

--4

alter table tb_class_type modify name constraint name_nn not null;

--5
alter table tb_category modify name varchar2(20);
alter table tb_class_type modify (no varchar2(10), name varchar(20));

--6
alter table tb_category rename column name to category_name;
alter table tb_category rename column use_yn to category_use_yn;
alter table tb_class_type rename column no to class_type_no;
alter table tb_class_type rename column name to class_type_name;

--7
select constaint_name from user_constaints where table_name ='TB_CATEGORY';
alter table tb_category rename constraint category_pk to  pk_catergory_name;
select constaint_name from user_constaints where table_name ='TB_CLASS_TYPE';
alter table tb_class_type rename constraint SYS_C007243 to pk_class_type_no;

--8
INSERT INTO TB_CATEGORY VALUES ('공학','Y'); 
INSERT INTO TB_CATEGORY VALUES ('자연과학','Y'); 
INSERT INTO TB_CATEGORY VALUES ('의학','Y'); 
INSERT INTO TB_CATEGORY VALUES ('예체능','Y'); 
INSERT INTO TB_CATEGORY VALUES ('인문사회','Y'); 
COMMIT;

select * from tb_category;
--9
alter table tb_department add constraint fk_department_category foreign key (category) references tb_category (category_name);

--10
select * from tb_student;
select * from tb_department;
select * from tb_professor;
create view vm_학생일반정보 as(
    select student_no, student_name, student_address from tb_student);

select * from vm_학생일반정보;

--11

create view vm_지도면담 as (
    select* from (
       select 
          student_name "학생이름", 
         department_name "학과이름",
          professor_name "지도교수이름"
        from tb_student s, tb_department d, tb_professor
        where s.department_no = d.department_no
        and coach_professor_no = professor_no(+)
        order by 2
    )
);

select * from vm_지도면담;

--12

create view vm_학과별학생수 as(
    select 
        department_name, 
        count(*) 
    from tb_student s, tb_department d 
    where s.department_no = d.department_no
    group by department_name
);

--13

update vm_학생일반정보 set student_name ='장석수' where student_no = 'A213046';
select * from vm_학생일반정보;

-- 14
drop view vm_학생일반정보;

create view vm_학생일반정보 as(
    select student_no, student_name, student_address from tb_student) with read only;

update vm_학생일반정보 set student_name ='장석수' where student_no = 'A213046'; -- read-only view 오류

--15 
select * from tb_grade order by 1 desc;
select * from tb_class;
select * from(
    select 
        g.class_no, 
        class_name,
        count(*) 
        from tb_grade g, tb_class c
    where g.class_no = c.class_no
    and substr(term_no,1,4) in (2009,2008,2007)
    group by g.class_no, class_name
    order by 3 desc)
where rownum <= 3;