/*
    조인문(Join)
    : 두 개 이상의 테이블을 결합하는 것 -> 조합하려고 하는 테이블에서 각 테이블의 공통된 컬럼을 데이터로 합쳐서 표현하는 것
    조건을 제시하지 않으면 모든 경우의 수를 조회
    
    1) ANSI 표준 Join
    2) Oracle Join
    
*/

select * from employee; --23개
select * from department; -- 9개
select * from employee, department
    order by 1; -- 207개

-- 조인문을 사용할 때 각 테이블이 갖고 있는 컬럼명이 같을 때, 컬럼명이 다를 때

-- 1) 컬럼명이 다른 경우
-- 부서코드가 같은 employee, department 테이블의 사번 사원명 부서코드 부서명 조회

-- Oracle
select 
    e.emp_ID"사번", 
    e.emp_name"사원명", 
    e.dept_code, 
    d.dept_title from employee e, department d
where e.dept_code = d.dept_id;

--ANSI
select emp_id, emp_name, dept_code, dept_title
from employee join department
on dept_code = dept_id;

-- 2) 컬럼 명이 같은 경우
-- 사번 사원명 직급코드 직급명 출력
-- 각 테이블에 별칭을 붙일 수 있음

-- Oracle

select * from employee, job;

select emp_id, emp_name, j.job_code, job_name 
    from employee e, job j
where e.job_code = j.job_code
order by 3,1;

-- ANSI

select 
    emp_id, emp_name, job_code, job_name 
from employee  join job
    using (job_code);
    

/*
1. Cross Join

2. Inner Join
 
3. Outer Join
 3-1. Left Outer Join
 3-2. Right Outer Join
 3-3. Full Outer Join

4. Self Join

5. 다중 Join

** Non-equi Join
*/


/*
Cross Join : 조인되는 테이블에 조건을 명시하지 않아 모든 데이터의 경우의 수가 조합되어 나오는 경우
- 한 테이블의 총 행수 * 다른 테이블의 총 행수

*/
-- oracle
select * from employee, department;
-- ANSI
select * from employee cross join department;

/*
Inner Join : 테이블 A 와 테이블 B 에서 조건이 맞는 데이터만 반환
- Join 명이 명시 되지 않으면 Inner Join(Default)
--Oracle
select 
    columm... 
from tableA, tableB where condition;

--ANSI
select 
    columm... 
from tableA inner join tableB on condition; 
*/

select * from employee, department 
where dept_code = dept_id;

select * from employee inner join department
on dept_code = dept_id;

-- 총무부, 회계관리부인 사원들의 사원명, 이메일, 부서명, 부서코드만 조회
select emp_name, email, dept_title, dept_code from employee, department
where dept_code = dept_id
and dept_title in ('총무부','회계관리부');

select emp_name, email, dept_title, dept_code from employee join department
on dept_code = dept_id
where dept_title in ('총무부','회계관리부');

-- 해외영업부(해외영업1,2,3) 의 모든 직원들의 사번 사원명 부서명 부서코드 연봉 출력

select emp_id, emp_name, dept_code, dept_title, salary*12 from  employee join department
on dept_code = dept_id
where dept_title like '해외영업%';

-- 대리급 사원 들의 급여 목록 출력 
-- 대리급 사원들의 사원명, 직급코드 직급명 부서코드(null=인턴) 월급 조회, 이름 오름차순, 월급 내림차순

select 
    emp_name"사원명", 
    e.job_code"직급코드", 
    job_name"직급명", 
    decode(dept_code, null, '인턴', dept_code)"부서코드", 
    to_char(salary, 'L999,999,999')"월급" 
from employee e, job j
where e.job_code = j.job_code
and job_name = '대리'
order by 1, 5 desc;

select 
    emp_name"사원명", 
    job_code"직급코드", 
    job_name"직급명", 
    decode(dept_code, null, '인턴', dept_code)"부서코드", 
    to_char(salary, 'L999,999,999')"월급" 
from employee  join job
    using (job_code)
where job_name = '대리'
order by 1, 5 desc;

---------
/*
Left Outer Joing (외부조인/ 합집합 -> 왼쪽 외부 조인)
: 조인하는 테이블의 A의 데이터를 모두 반환, B는 조건 구문에 일치하는 데이터만 반환
-> inner Join 조건을 걸게 되면 조건에만 맞는 데이터가 반환
-> left Outer Join 조건이 일치하지 않아도 왼쪽 테이블의 데이터는 모두 반환

oracle : select columm... from tableA, tableB where columm = columm(+);
ANSI : select columm... from tableA, tableB left outer join tableB on/using

*/

-- 모든 직원들의 부서명을 출력(부서코드가 null이어도 출력)
-- inner join 을 사용할 경우 조건이 일치하지 않는 데이터가 full로 조회되지 않는 경우가 발생
select * from employee, department
where dept_code = dept_id(+);

select * from employee left outer join department
on (dept_code = dept_id);

-- 기술지원부를 제외하고 모든 부서 직웡늬 사번, 사원명, 부서명 연봉조회, 
-- 부서명이 없는 직원 -> 미정, 연봉 오름차순
-- != , = , like, not like 등의 equal 연산자를 이용하게 되면 null 값에 대한 비교가 제대로 이뤄지지 않으므로, 
-- decode문을 이용하거나
-- or dept_code is null; -> 등의 구문을 추가해서 우회해야 한다.
select 
    emp_id"사번", 
    emp_name"사원명", 
    decode(dept_title, null, '미정', dept_title)"부서명", 
    salary*12"연봉" 
from employee left outer join department
    on (dept_code = dept_id)
    where decode(dept_title,null,'미정',dept_title) != '기술지원부'
    order by 4;
    
/*
Right Outer Join (합집합/ 오른쪽 외부 조인)
: 조인하고자 하는 테이블 A와 테이블 B가 있을 때, 테이블 A는 조건 구문에 일치하는 데이터만 반환, 테이블 B는 조건에 상관없이 모든 데이터를 반환

Oracle : 
select columm... from tableA, tableB where columm(+) = columm;
ANSI
select columm... from tableA right outer join tableB on/using;

*/

select 
    emp_name, dept_title
from employee, department
    where dept_code(+) = dept_id;


/*
Full Outer Join (합집합)
: 테이블 A와 테이블 B를 조인할 때 조건에 맞지 않더라도 모든 데이터를 출력

ANSI
select columm ... from tableA full outer join tableB on/using
*/

select 
    emp_name,
    dept_title
from employee full outer join department
    on dept_code = dept_id;
    
    
/*
Non - Equi Join(비등가 조인)
-> 지정한 컬럼의 값이 일치하는 경우가 아니라
값의 범위에 포함되는 행을 연결 ( between, <, >, <= 등)


*/

insert into kh.employee 
    values('999', '신아람', '990101-1111111', 'gg@kh.or.kr', '01011111111', 'D8', 'J5', 'S1',
        8000, 0.3, null, to_date('90/02/06', 'YY/MM/DD'), null, 'N');
        
        
-- emp_id, emp_name, salary, sal_level -> sal_level 의 min_sal 과 max_sal 사이인 경우만 출력

select * from sal_grade;

select emp_id, emp_name, salary, e.sal_level from employee e join sal_grade s
on salary between min_sal and max_sal;

delete employee where emp_name ='신아람';

/*

Self Join : 다른 테이블이 아닌 같은 테이블을 join 하는 것
-> 똑같은 테이블을 join 하기 때문에 각 테이블의 별칭을 반드시 지정하고
사용하려는 컬럼명 어떤 별칭에 해당하는 컬럼명을 사용하는 건지 명확히 제시해야 한다.

*/

-- 각각의 사원들에 대한 manager_id 확인
select emp_id, emp_name, manager_id from employee;

-- 해당 사원을 담당하는 매니저의 emp_name 출력

select 
    e1.emp_id"직원 사번", 
    e1.emp_name"직원 명", 
    e1.manager_id"매니저 사번", 
    e2.emp_name "매니저 명"   
from employee e1 join employee e2
on e1.manager_id = e2.emp_id;

-- 매니저명과 해당 매니저가 관리하고 있는 사원명, 급여 출력

select 
    e2.emp_name"매니저명", 
    e1.emp_name"사원명",
    e1.salary"급여"
    from employee e1 join employee e2
    on e1.manager_id = e2.emp_id;
    
/*
다중 Join : 여러 개의 조인문을 사용하는 경우
*/

-- employee department 조인 -> 사번, 사원명, 부서코드, 부서명  + 부서지역면
select * from location;
select * from department;


select 
    emp_id"사번", 
    emp_name"사원명", 
    dept_code"부서코드", 
    dept_title"부서명",
    local_name"부서지역명"
from employee, department, location
    where dept_code = dept_id
    and location_id = local_code
    order by 5,3,1;
    
select 
    emp_id"사번", 
    emp_name"사원명", 
    dept_code"부서코드", 
    dept_title"부서명",
    local_name"부서지역명"
from employee 
    join department on (dept_code = dept_id)
    join location on (location_id = local_code)
    order by 5,3,1;
