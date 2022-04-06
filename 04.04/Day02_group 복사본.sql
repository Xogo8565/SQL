/*
    group by :그룹함수를 이용해 여러 개의 결과값을 도출하고 싶을 때 (그룹별 집계) 
    -> 그룹함수는 단 한개의 결과값을 도출
    -> 그룹함수가 적용될 그룹을 기준으로 해서 group by 절에 해당 그룹을(컬럼) 기술해 사용

*/

select decode(dept_code,null,'인턴',dept_code), sum(salary) from employee
group by dept_code;

-- 부서별 인원 조회
select decode(dept_code,null,'인턴',dept_Code), count(*) from employee
group by dept_code;


--부서별 인원 조회 -> 부서 코드가 null 인 경우에는 카운터 x
-- from, where, group by, select, order by 순으로 실행
select dept_code, count(*) from employee
where dept_code is not null
group by dept_code;

-- 부서코드, 부서별 인원, 부서별 월급 총합, 부서별 월급 평균 조회
-- 정렬은 부서코드 기준 -> 없으면 인턴

select 
    decode(dept_code,null,'인턴',dept_code) "부서코드", 
    count(*) "부서별 인원",
    to_char(sum(salary),'L999,999,999') "부서별 월급 총합",
    to_char(round(avg(salary)),'L999,999,999') "부서별 월급 평균" from employee
group by dept_code
order by 1;

-- 부서코드, 부서별 보너스를 지급받는 사원의 수를 조회
-- 부서코드 순으로 정렬

select
    decode(dept_code,null,'인턴',dept_code) "부서코드",
    count(*)||'명' "보너스를 받는 사원 수" from employee
where bonus is not null
group by dept_code
order by 1;

-- group by -> 함수를 적용한 컬럼도 사용 가능
-- 입사년도, 입사년도별 인원 수, 입사년도별 급여평균 조회

select
    substr(hire_date ,1,2) "입사년도",
    count(*)"입사년도별 인원 수",
    avg(salary)"입사년도별 급여 평균" from employee
group by substr(hire_date,1,2)
order by 1;

-- 성별, 성별별 급여의 평균값 조회 

select
    decode(substr(emp_no, 8, 1),1,'남자', '여자')"성별",
    to_char(round(avg(salary)),'L999,999,999')"급여 평균",
    to_char(sum(salary),'L999,999,999')"급여 합계",
    count(*)"인원 수"
    from employee
group by substr(emp_no,8,1)
order by 3 desc;

-- 그룹 안의 그룹 -> 한 부서 안의 다른 직급 코드에 따라 그룹
-- 각 부서 안의 직급 별로 부서코드, 직급코드, 직급 사원 수, 평균 급여

select
    decode(dept_code,null,'인턴',dept_code) "부서코드",
    job_code "직급코드",
    count(*)"직급별 인원 수",
    to_char(round(avg(salary)),'L999,999,999')"직급별 평균 급여" from employee
group by dept_code, job_code
order by 1,2;

-- 직급 별 총 급여 및 연봉을 조회(직급 코드 기준 오름차순 정렬)
select
    job_code"직급코드",
    to_char(sum(salary),'L999,999,999')"총 급여",
    to_char(sum(salary)*12,'L999,999,999,999')"총 연봉" from employee
group by job_code
order by 1;
    
    
-- 직급이 J1을 제외하고, 직급코드, 직급별 사원 수 및 평균 급여를 출력

select
    job_code "직급코드",
    count(*)"사원 수",
    to_char(round(avg(salary)),'L999,999,999') "평균 급여" from employee
where job_code != 'J1'
group by job_code
order by 1;

-- 부서코드, 성별, 부서별 성별 사원수를 구하세요.

select
    decode(dept_code,null,'인턴',dept_code) "부서코드",
    decode(substr(emp_no, 8, 1),1,'남자', '여자')"성별",
    count(*) from employee
group by dept_code, substr(emp_no, 8, 1)
order by 1,2;


-- having : group by 를 이용해서 그룹함수로 값을 구해올 때 그 값에 대한 조건을 걸고 싶다면 사용하는 절
-- select ,,, 그룹함수 from 테이블명 group by 컬럼,,, having 조건;

-- 급여 평균이 300만원 이상인 부서에 대한 부서코드 , 평균 급여 조회(D6 제외)
-- from, where, group by, having, select, order by

select 
    nvl(dept_code,'인턴') "부서코드",
    floor(avg(salary)) "평균 급여" from employee
where dept_code != 'D6'
group by dept_code
having floor(avg(salary)) >= 3000000
order by 1;


-- 인원이 3명 미만인 직급코드, 인원수 조회
select
    job_code "직업코드",
    count(*)"인원" from employee 
group by job_code
having count(*) < 3;

-- 부서별 평균 급여 250만원 미만인 부서코드, 부서의 평균 급여, 부서별 사원 수 조회
select
    dept_code "부서 코드",
    to_char(round(avg(salary)),'L999,999,999') "평균 급여",
    count(*)"사원 수" from employee
group by dept_code
having round(avg(salary)) <  2500000;