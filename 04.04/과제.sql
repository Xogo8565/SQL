select * from user_tables;
select * from employee;
select * from department;
select * from location;
select * from job;
select * from sal_grade;

--1
select 
    emp_name,
    emp_no,
    dept_title,
    job_name
from employee e , department , job j
where (dept_code = dept_id)
and (e.job_code = j.job_code)
and substr(emp_no,8,1) =2
and emp_name like '%전%';
    
    
--2
select 
    emp_id,
    emp_name,
    dept_title
from employee , department
where dept_code = dept_id
and emp_name like '%형%';

--3
select
    emp_name,
    dept_title,
    job_name,
    dept_title
from employee e , department , job j
where (dept_code = dept_id)
and (e.job_code = j.job_code)
and dept_title like '%해외영업%';
    
    
-- 4

select
    emp_name,
    bonus,
    dept_title,
    local_name
from employee, department, location
where dept_code = dept_id
and location_id = local_code
and bonus is not null;

--5
select
    emp_name,
    job_name,
    dept_title,
    local_name
from employee e, job j, department, location
where e.job_code = j.job_code
and dept_code = dept_id
and location_id = local_code
and dept_code = 'D2';

--6
select 
    emp_name, 
    job_name, 
    salary, 
    min_sal 
from employee e, job j, sal_grade s
where e.job_code = j.job_code
and e.sal_level = s.sal_level
and salary >= min_sal-200000;

--7
select 
    emp_name,
    dept_title,
    local_name,
    national_code
from employee, department, location
where dept_code = dept_id
and location_id = local_code
and national_code in ('KO','JP');
    
--8
select 
    e1.emp_name,
    dept_title,
    e2.emp_name
from employee e1, department, employee e2
where e1.dept_code = dept_id
and e1.dept_code = e2.dept_code
and e1.emp_name != e2.emp_name
order by 1,2;
    
--9

select 
    emp_name,
    job_name,
    salary
from employee e, job j
where e.job_code = j.job_code
and bonus is null
and job_name in ('차장', '사원');

--10
select
    decode(ent_yn,'Y' ,'퇴사', '재직'),
    count(*)
from employee
group by ent_yn;
 
 --11
 -- 방명수 주민등록번호 856795로 시작해서 나이 추출불가
select 
    emp_name,
    extract(year from sysdate) - (19||substr(emp_no,1,2))+1,
    decode(dept_title,null,'부서없음',dept_title),
    job_name 
from employee e, department, job j
where dept_code = dept_id(+)
and e.job_code = j.job_code
order by 2 desc;
    

-- 
select * from tb_student;
select * from tb_department;
select * from tb_class;

--6
select 
    student_no,
    student_name,
    department_name
from tb_student s, tb_department d
where s.department_no = d.department_no
order by 2;

--7
select 
    class_name , 
    department_name 
from tb_class c, tb_department d
where c.department_no = d.department_no;

--8
select * from tb_professor;
select * from tb_class_professor;
select 
    class_name,
    professor_name
    from tb_class c, tb_class_professor cp, tb_professor p
where c.class_no = cp.class_no
and cp.professor_no = p.professor_no;

--9
select * from tb_department;
select 
    class_name,
    professor_name
    from tb_class c, tb_class_professor cp, tb_professor p, tb_department d
where c.class_no = cp.class_no
and cp.professor_no = p.professor_no
and c.department_no = d.department_no
and d.category = '인문사회';

--10
select
    s.student_no,
    s.student_name,
    round(avg(point),1)
    from tb_student s,tb_grade g,tb_department d
where s.student_no = g.student_no
and s.department_no = d.department_no
and d.department_name = '음악학과'
group by s.student_no, s.student_name;

--11
select * from tb_professor;

select 
    department_name,
    student_name,
    professor_name
    from tb_student s, tb_department d, tb_professor
where s.department_no = d.department_no
and s.coach_professor_no = professor_no
and student_no = 'A313047';

--12
select * from tb_grade;
select * from tb_student;
select * from tb_class;
select 
    student_name,
    term_no
    from tb_student s, tb_grade g, tb_class c
where s.student_no = g.student_no 
and g.class_no = c.class_no
and substr(term_no, 1,4) = 2007
and class_name = '인간관계론';

--13
select * from tb_class;
select * from tb_class_professor;

select
    class_name,
    department_name
    from tb_class c, tb_department d, tb_class_professor cp
where c.department_no = d.department_no
and c.class_no = cp.class_no(+)
and professor_no is null
and d.category = '예체능';
    
    
--14
select 
    student_name, 
    decode(professor_name, null, '지도교수 미지정', professor_name)
from tb_student s, tb_department d, tb_professor p
where s.department_no = d.department_no
and coach_professor_no = p.professor_no(+)
and department_name = '서반아어학과';

--15

select 
    s.student_no,
    student_name,
    department_name,
    trunc(avg(point),1) "평점"
from tb_student s, tb_department d, tb_grade g
where s.student_no = g.student_no
and s.department_no = d.department_no
and absence_yn = 'N'
group by s.student_no, s.student_name, department_name
having trunc(avg(point),1)>=4.0
order by 1;

--16

select * from tb_class;
select * from tb_department;

select 
    c.class_no,
    class_name,
    avg(point)
    from tb_class c, tb_department d, tb_grade g
where c.department_no = d.department_no
and c.class_no = g.class_no
and d.department_name = '환경조경학과'
and c.class_type like '%전공%'
group by c.class_no, c.class_name
order by 1;

--17

select 
    s2.student_name, 
    s2.student_address
from tb_student s1, tb_student s2
where s1.department_no = s2.department_no
and s1.student_name = '최경희';

--18
select
    student_no,
    student_name
from (select 
        s.student_no, 
        s.student_name, 
        avg(point) 
      from tb_student s, tb_grade g, tb_department d
      where s.student_no = g.student_no
      and s.department_no = d.department_no
      and department_name = '국어국문학과'
      group by s.student_no, student_name
      order by avg(point) desc)
where rownum =1;

--19
select * from tb_grade;
select * from tb_class;
select * from tb_department;

select 
    d.department_name,
    round(avg(point),1)
from tb_department d , tb_class c, tb_grade g
where d.department_no = c.department_no
and c.class_no = g.class_no
and category = (select category from tb_department where department_name = '환경조경학과')
group by department_name;