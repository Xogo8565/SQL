/*
    서브쿼리 
    : 하나의 SQL 문 안에 포함된 다른 SQL 문
    -> 메인 쿼리가 서브 쿼리를 포함하는 종속적인 관계
    -> 서브쿼리는 소괄호 묶어줌 / 연산자의 오른쪽에 위치/ order by 절은 subquery 내에서 사용 불가
*/

select * from employee;

-- 전지연 직원의 매니저명 출력

select
    emp_name, manager_id
from employee
where emp_name = '전지연'; -- 매니저 사번 : 214
    
select
    emp_id, emp_name
from employee
where emp_id = 214; -- 방명수

select
    emp_id, emp_name
from employee
    where emp_id = (select manager_id from employee where emp_name = '전지연');
    
/*
 서브 쿼리 종류
 1. 단일행 서브쿼리
 2. 다중행 서브쿼리
 3. 다중열 서브쿼리
 4. 다중행 다중열 서브쿼리
 5. 상호 연관 서브쿼리
 6. 스칼라 서브쿼리
*/
--------------------------------------------------------------------------------------------------------------

/*
단일행 서브쿼리 : 서브쿼리의 조회 결과 값이 1개(행)일 경우
-> 전 직원의 급여 평균보다 급여를 많이 받는 사원의 사번, 사원명, 직급코드, 월급 조회
*/

select floor(avg(salary)) from employee; -- 3047662
select emp_id, emp_name, dept_code, salary from employee
where salary > 3047662;

select 
    emp_id, emp_name, dept_code, salary 
from employee
where salary > (select floor(avg(salary)) from employee);

-- 윤은해 직원과 급여가 같은 사원들의 사번, 사원명, 급여 출력

select 
    emp_id, emp_name, salary 
from employee
where salary = (select salary from employee where emp_name = '윤은해')
and emp_name != '윤은해';

-- employee 테이블에서 급여가 제일 높은 사람과 낮은 사람이 사번, 직원명, 급여 조회
select 
    emp_id, emp_name, salary
from employee
    where salary in((select max(salary) from employee),(select min(salary) from employee));
    
    
-- D5 부서 직원들의 평균월급(소수점 버림) 보다 더 많은 월급을 받는 D1, D2 부서 직원의 사번, 부서번호, 사원명, 월급 조회

select emp_id, dept_code, emp_name, salary
    from employee
    where salary > (select trunc(avg(salary)) from employee where dept_code = 'D5')
    and dept_code in ('D1','D2');
    
/*
    다중행 서브 쿼리 : 서브쿼리 조회 결과가 여러개(여러 행)일 때
    -> 다중행 서브 쿼리 앞에는 =, != 연산자를 사용할 수 없음
    -> in, not in, any, all, exist 등의 연산자 활용
    
*/
-- 송종기, 박나라 사원이 속해 있는 부서와 같은 부서원들의 모든 정보 출력
select * from employee
    where dept_code in (select dept_code from employee where emp_name in ('송종기','박나라'));
    
-- 차태연, 전지연 사원의 급여 등급과 같은 등급을 가진 사원의 직급명, 사원명 , 급여 등급 출력

select job_name, emp_name, sal_level from employee e, job j
where sal_level in (select sal_level from employee where emp_name in ('차태연','전지연'))
and e.job_code = j.job_code;

-- 직급이 대표 부사장이 아닌 직원들의 사원명 부서명 직급코드 출력
select * from department;
select * from job;
select 
    emp_name,
    dept_title,
    dept_code 
from employee e, department
where dept_code = dept_id
and e.job_code in (select job_code from job where job_name not in ('대표','부사장'))
order by 2,1;

/*
any : 서브 쿼리 결과 중 하나라도 참이면 참 
값 > any(1,2,3) : 값 > 1 or 값 > 2 or 값 >3
값 < any(1,2,3) : 값 < 1 or 값 < 2 or 값 < 3
값 = any(1,2,3) : in 과 같은 으미ㅣ
값 != any(1,2,3) : not in
*/

--급여가 200만원 혹은 300만원 보다 큰 사원의 사원명 급여 출력

select
    emp_name, salary
from employee
where salary > any(2000000,3000000);

select
    emp_name, salary
from employee
where salary < any(2000000, 3000000);

select
    emp_name, salary
from employee
where salary = any(2000000, 3000000);

select
    emp_name, salary
from employee
where salary != any(2000000, 3000000);

-- job_code J3 직원들의 급여보다 더 만ㄴㅎ은 급여를 받는 사원들의 이름, 급여

select 
    emp_name, salary
from employee
where salary > any(select salary from employee where job_code = 'J3');

-- D1, D5 부서코드를 가진 사원들의 급여보다 적게 받는 사원들의 이름 , 급여 부서코드

select
    emp_name, salary, decode(dept_code,null,'부서없음',dept_code)
from employee
where salary < any(select salary from employee where dept_code in ('D1','D5'))
and decode(dept_code,null,'부서없음',dept_code) not in ('D1','D5')
order by 3;
-- in / not in 을 사용할 때  null 값은 비교되지 않으므로 decode / nvl 등을 함께 활용해야 한다.

/*
    All : 서브 쿼리 결과 중에 모든 것치 참이어야만 참
    값 > all(1,2,3) : 값 > 1 and 값 > 2 and 값 > 3
    값 < all(1,2,3) : 값 < 1 and 값 < 2 and 값 < 3
*/

-- J3 인 직원 중 가장 큰 급여보다 더 많은 급여를 받는 사원들이 사원명 급여

select 
    emp_name, 
    salary 
from employee
where salary > all(select salary from employee where job_code = 'J3');

--------------------------------------------------------------------------------------------------------------


/*
다중열 서브 쿼리 : 서브쿼리 조회 결과 값이 여러개의 열을 갖는 경우
*/

-- 퇴사한 여직원 -> 같은 부서, 같은 직급에 해당하는 사원의 사원명, 직급코드 부서코드 입사일

select 
    emp_name, 
    dept_code,
    job_code, 
    hire_date
from employee
where (dept_code, job_code) in (select dept_code, job_code from employee 
                                                    where substr(emp_no,8,1) = 2 and ent_yn = 'Y');
                                                    
-- 하이유 직원과 같은 manager를 가지고 있고 같은 급여레벨을 갖고 있는 사원의 이름, 급여 레벨, 메니저 아이디를 조회

select 
    emp_name, 
    sal_level, 
    manager_id 
from employee
where (manager_id, sal_level) in (select manager_id, sal_level from employee where emp_name = '하이유')
and emp_name != '하이유';

-- 기술지원부, 급여가 200만원인 직원의 사원명 부서코드 급여 부서의 지역명 출력

select
    emp_name, 
    dept_code, 
    salary,
    local_name
    from employee, department, location 
where dept_code = dept_id
and location_id = local_code
and dept_title = '기술지원부'
and salary = 2000000;


select
    emp_name, 
    dept_code, 
    salary,
    local_name
    from employee, location 
where (dept_code, local_code) in (select dept_id, location_id from department where dept_title ='기술지원부')
and salary = 2000000;



-- 생일이 8월 8일인 사원들과 같은 부서 코드, 직급코드를 가진 사원들의 사원명, 생일('0808'), 부서코드, 부서명 출력
select * from employee;
--------------------------------------------------------------------------------------------------------------
-- 다중열 다중행 서브쿼리
select 
    emp_name,
    substr(emp_no,3,4),
    dept_code,
    dept_title
from employee, department
where dept_code = dept_id
and(dept_code, job_code) in (select dept_code, job_code from employee where substr(emp_no, 3,4) = '0808')
and substr(emp_no,3,4) != '0808';

-- join -> group by
-- 부서코드 부서명 부서별평균급여 부서별인원수 출력

select 
    decode(dept_code,null,'없음',dept_code), 
    decode(dept_title,null,'없음',dept_title), 
    round(avg(salary)), 
    count(*)
from employee, department
where dept_code = dept_id(+)
group by dept_code, dept_title
having count(*) >2
order by 1;

--1
select
    emp_name,
    dept_code,
    salary 
from employee, department
where dept_code = dept_id
and dept_title = '기술지원부';

select * from employee;

--2
select 
    emp_id,
    emp_name,
    salary,
    manager_ID
from employee
where manager_id is not null
and salary > (select avg(salary) from employee);

--3
select
    emp_name,
    job_code,
    trunc(salary,-4),
    sal_level
from employee
where (job_code, sal_level) in (select job_code, min(sal_level) from employee group by job_code);

select job_code, min(sal_level) from employee group by job_code;
--------------------------------------------------------------------------------------------------------------

/*
인라인 뷰 (inline - view)
    : from 절에서 사용하는 서브쿼리
    -- 인라인 뷰를 사용할 때ㅐ는 인라인뷰에서 조회해 온 데이터에 대해서만 메인쿼리문에서 데이터를 가져올 수 있음
*/

select 
    *
from (select emp_name, salary from employee);

select
emp_no -- 불가능
from (select emp_name, salary from employee;

/*
스칼라 서브쿼리 : select 절에서 사용하는 서브쿼리 -> 하나의 컬럼만 가져울 소 있음
*/

select
emp_name,
(select dept_title from department where dept_code = dept_id)
from employee;