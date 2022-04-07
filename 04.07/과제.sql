wselect * from tb_class_type;
insert into tb_class_type values (01, '전공필수');
insert into tb_class_type values (02, '전공선택');
insert into tb_class_type values (03, '교양필수');
insert into tb_class_type values (04, '교양선택');
insert into tb_class_type values (05, '논문지도');

--2
select * from tb_student;
create table tb_학생일반정보 as(
    select 
        student_no,
        student_name,
        student_address from tb_student
);

select * from tb_학생일반정보;

--3 
create table tb_국어국문학과 as(
    select
        student_no"학번",
        student_name"학생이름",
        19||substr(student_ssn,1,4)"출생년도",
        professor_name"지도교수이름"
    from tb_student s, tb_professor, tb_department d
    where coach_professor_no = professor_no
    and s.department_no = d.department_no
    and department_name = '국어국문학과'
);


--4
select * from tb_department;
update tb_department set capacity = round(1.1*capacity);

--5
update tb_student set student_address = '서울시 종로구 숭인동 181-21' where student_no = 'A413042';
select * from tb_student where student_no = 'A413042';

--6
update tb_student set student_ssn = substr(student_ssn,1,6);
select * from tb_student;

--7

update tb_grade set point = 3.5 
where term_no = 200501
and class_no = 
    (select class_no from tb_class where class_name = '피부생리학')
and student_no = 
    (select student_no from tb_student s, tb_department d
    where s.department_no = d.department_no
    and student_name = '김명훈'
    and d.department_name = '의학과');
    
--8
select * from tb_grade;
select * from tb_student;

delete from tb_grade 
where (student_no) in (select student_no from tb_student where absence_yn ='Y');

