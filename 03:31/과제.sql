select * from employee;

-- 1
select nvl(dept_code,'인턴') "부서코드",
    emp_name "사원명",
    decode(dept_code,'D5','10%','D2','20%','D9','30%','없음') "보너스율",
    decode(dept_code,'D5',salary*0.1,'D2',salary*0.2,'D9',salary*0.3,0)"특별보너스액"
from employee
order by 1;

--2
select emp_name"사원명",
    case 
        when substr(emp_no,1,2) between 60 and 64 then '60대 초반'
        else '60대 후반'
    end "나이대"
from employee
    where substr(emp_no,1,2) between 60 and 69;

--3
select emp_name "사원명",
    trunc((sysdate-hire_date)/365)"년차",
    case 
        when trunc((sysdate-hire_date)/365) < 10 then 'Junior'
        when trunc((sysdate-hire_date)/365) between 10 and 19  then 'Intermediate'
        else 'Senior'
    end"등급"
from employee
order by 2;
    

-- Workbook
--1
select * from tb_student;
select * from tb_department;
select student_no"학번",
    student_name "이름",
    to_char(entrance_date,'yyyy-mm-dd') "입학년도"
from tb_student
    where department_no = 002
order by 3;

--2 
select * from tb_professor;
select professor_name, professor_ssn from tb_professor
    where  length(professor_name)!=3;
    
--3

select professor_name "이름",
    floor((sysdate - to_date(19||substr(professor_ssn,1,6),'yyyymmdd'))/365) "나이"
from tb_professor
    where substr(professor_ssn,8,1) = 1
order by 2;

--4 
select substr(professor_name,2,2)"이름" from tb_professor;

--5
select * from tb_student;

select student_no, student_name from tb_student
        where (to_date(decode(substr(entrance_date,1,1), '0',20,19) || to_char(entrance_date,'yymmdd'),'yyyymmdd') - to_date(19||substr(student_ssn,1,6),'yyyymmdd'))/365 > 19;
--6 
select to_char(to_date(20201225, 'yyyymmdd'),'day') from dual;

--7

--#1 991011 : 20991011
--#2 491011 : 20491011
--#3 991011 : 19991011
--#4 491011 : 20491011

--8
select student_no, student_name from tb_student
    where substr(student_no,1,1) != 'A';

--9 
select round(avg(point),1)"평점" from tb_grade
    where student_no = 'A517178';
    
--10
select distinct department_no"학과번호"
     from tb_student;
     
--11
select count(*) from tb_student
    where coach_professor_no is null;
    
--12
select * from tb_grade;
select substr(term_no,1,4) "년도", round(avg(point),1) "년도 별 평점" from tb_grade
    where student_no = 'A112113'
    group by substr(term_no,1,4);
    
--13
select count(*) from tb_student  
    where absence_yn = 'Y';

select distinct department_no "학과코드명", 
    count(decode(absence_yn,'Y',1)) "휴학생 수" 
from tb_student
    group by department_no
order by 1;

--14
select student_name "동일인물", count(*) "동명인 수" from tb_student
    group by student_name
    having count(*)>1
order by 1;
    
-- 15 
select * from tb_grade;
select 
    nvl(substr(term_no,1,4),' ') "년도",
    nvl(substr(term_no,5,2),' ') "학기",
    round(avg(point),1) "평균"
from tb_grade
    where student_no = 'A112113'
    group by rollup(substr(term_no,1,4), substr(term_no,5,2));
    