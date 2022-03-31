select * from employee;
--1
select emp_name, email, length(email) from employee;

--2
select emp_name, rtrim(email, '@kh.or.kr')"아이디" from employee;

--3
select emp_name, substr(emp_no,1,8)||'******' from employee;

--4
select emp_id, emp_name, dept_code, hire_date from employee
    where dept_code in('D5','D9');
    
--5
select emp_name, emp_no, rtrim(email, '@kh.or.kr')||'@iei.or.kr'from employee;


-- WorkBook Basic select
--1
select department_name "학과 명", category "계열" from tb_department;
--2
select department_name||'의 정원은 '||capacity||'명입니다.' "학과별 정원" from tb_department;
--3
select * from tb_department;
select student_name from tb_student
    where (department_no = '001')
    and student_ssn like '%-2%'
    and absence_yn = 'Y';
    
--4 
select student_name from tb_student
    where student_no in('A513079','A513090','A513091','A513110','A513119');
    
--5 
select department_name, category from tb_department
    where capacity between 20 and 30;
    
--6
select * from tb_department;
select * from tb_professor;
select professor_name from tb_professor 
    where department_no is null;
    
-- 7
select * from tb_student
    where department_no is null;
    
-- 8
select class_no from tb_class
    where preattending_class_no is not null;
    
-- 9
select distinct category from tb_department;

-- 10
select * from tb_student;
select student_no, student_name, student_ssn from tb_student
    where absence_yn = 'N'
   and entrance_date like '02%'
   and student_address like '%전주%';