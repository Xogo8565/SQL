
/*
select : 테이블에서 데이터를 조회
    1. select 컬럼명 from 테이블명;
    2. select 컬럼명 from 테이블명 where 조건;

*/

select * from employee;
select emp_name from employee;
select emp_name, email, phone from employee;

-- 조건
Select * from employee 
    where dept_code = 'D6';
select * from employee 
    where salary >= 5000000;
select * from employee 
    where dept_code = 'D5' and sal_level = 'S5';
select * from employee 
    where salary >= 3000000 or job_code = 'J6';


-- job 테이블에서 job_name 을 모두 조회해보시오
select job_name from job;
-- department 테이블의 모든 데이터를 조회
select * from department;
-- employee 테이블에서 emp_name, email, phone, hire_date 의 데이터 조회
select emp_name, email, phone, hire_date from employee;
-- employee 테이블에서 월급(salary)이 250만원 이상인 사람드의 emp_name sal_level 조회
select emp_name, sal_level from employee 
    where salary>= 2500000;
-- employee 테이블에서 emp_name, phone 을 조회 -> 조건 : 월급이 350만원 이상, job_code J3
select emp_name, phone from employee 
    where salary >= 3500000 and job_code = 'J3';


-- 컬럼 산술 연산
select * from employee;
-- 연봉 salary * 12;
select emp_name, salary*12 from employee;
--select 문을 통해 조회되는 결과들 ResultSet 
-- 컬럼 별칭 설정 -> 컬럼명 as "별칭명"
select emp_name as "직원명", salary*12 "연봉(원)" from employee;
-- 임의의 문자열을 실제 데이터 값처럼 보이게끔 리터럴 추가 가능
select emp_name "직원명", salary*12||'원' "연봉" from employee;

select * from employee;
-- employee 테이블에서 emp_name(이름), 근무일수를 출력해보세요. (sysdate_현재날짜/시간)
select emp_name "이름", sysdate-hire_date "근무 일수" from employee;
-- employee 테이블에서 20년 이상 근속한 사람의 이름, 월급, 보너스율을 조회
select emp_name "이름", salary "월급", bonus "보너스" from employee 
    where (sysdate-hire_date)/365 >=20;


-- distinct : 중복값 제거 -> 한번만 표시
select job_code from employee;
select distinct job_code from employee;

/*
연산자 
= : 같다
>, < : 작다, 크다
>=, <= : 이하, 이상
!= : 같지 않다
between A and B : 특정 범위에 포함되는지 (A와 B 사이)
like / not like : 문자 패턴 비교
    ex_ 'story' like 'story' / 'story' not like 'tom'
is null / is not null : null 값 비교
in / not in : 특정한 값이 값 목록에 포함 여부

*/

-- employee 급여 350만원 보다 많고 600만원 보다 적은 사원의 이름 급여 조회
select emp_name "이름", salary ||'원' "급여" from employee 
    where salary >= 3500000 and salary <= 6000000; 
select emp_name "이름", salary||'원' "급여" from employee 
    where salary between 3500000 and 6000000;

-- employee 고용일 90/01/01 ~ 01/01/01 인 직원의 전체 데이터
select * from employee 
    where hire_date between '90/01/01' and '01/01/01';

-- like :   비교하는 값이 특정한 패턴을 만족상시켰을 때 true 값을 반환
-- '%', '_' : 와일드카드(아무 값이나 대체해서 사용할 수 있는 것)
-- % : 0글자 이상
-- 와일드 카드 문자와 만약 문자열로써 사용하고픈 특수 문자가 동일한 경우 -> 모두 와일드 문자로 인식
-- escape 옵션을 활용 -> like '#' escape '#' : # 뒤로 오는 문자는 와일드 카드가 아닌 문자열로 인식

select emp_name, salary from employee 
    where emp_name like '전%';
select emp_name, salary from employee 
    where emp_name like '전__';

-- employee 테이블에서 직원의 이메일 중 '_' 앞자리가 3자리인 직원명과 이메일을 조회
select emp_name, email from employee 
    where email like '___#_%' escape '#';

-- not like '이' 성이 아닌 직원의 사번, 이름 , 이메일 조회
select emp_name, emp_no, email from employee 
    where emp_name not like '이%';

-- employee 에서 전화 번호 처음 3자리가 010이 아닌 사원의 이름 전화번호 조회
select emp_name, phone from employee 
    where phone not like '010%';

-- employee 에서 메일 주소에 's'가 들어가고, dept = D9 or D6, 고용일이 90/01/01~00/12/01 이면서 월급이 270만원 이상인 직원의 모든 정보 조회
select * from employee 
    where email like '%s%' 
        and (dept_code = 'D9' or dept_code = 'D6') 
        and (hire_date between '90/01/01' and '01/12/01')
        and salary >= 2700000;
        

-- is null / is not null
select * from employee 
    where manager_id is null;
select * from employee 
    where manager_id is not null;

-- in / not in
-- employee 테이블에서 부서 코드가 D9 이거나 D6이거나 D5인 사원의 정보를 조회
select * from employee 
    where dept_code in ('D9', 'D6', 'D5');

-- order by : select 한 컬럼에 대해 정렬을 할 때 사용하는 구문
    -- 오름차순 정렬 (ASC_Ascending) : defalut
select emp_name, salary from employee 
    order by salary;
    
    -- 내림차순 정렬(DESC_Descending)
select emp_name, salary from employee
    order by salary desc;    
    
    -- 인덱스 활용 -> 오라클의 인덱스는 1번부터 시작
select emp_name, salary from employee
    order by 2;
    
select * from employee;

-- 실습 1. 입사일이 5년 이상 19년 이하인 직원의 이름 주민번호 급여 입사일 검색
select emp_name "이름", emp_no "주민등록번호", salary "급여", hire_date "입사일" from employee 
    where round((sysdate-hire_date)/365,1) between 5 and 19;
    
    -- 쿼리문의 실행 순서 
    -- from -> where -> select -> order by

-- 실습 2. 재직중이 아닌 직원의 이름, 부서코드를 검색
select emp_name "이름", dept_code "부서코드" from employee 
    where ent_yn = 'Y';

-- 실습 3. 입사일이 99/01/01 ~10/01/01 인 사람 중에서 급여가 2000000 원 이하인 사람의 이름, 주번, 이메일, 폰번호, 급여
select emp_name "이름", emp_no"주민등록번호", email "이메일", phone "핸드폰", salary "급여" from employee 
    where (hire_date between '99/01/01' and '10/01/01')
        and salary <= 2000000;

-- 실습 4 : 근속 년수가 10년 이상인 사람들은 검색해서 이름, 급여, 근속년수를 오름차순(근속년수 기준)으로 정렬하여 조회, 단 급여는 50% 인상시킬것
select emp_name "이름" , salary*1.5 "인상급여 ", round((sysdate-hire_date)/365,1) "근속년수" from employee 
    where (sysdate-hire_date)/365 >= 10
    order by "근속년수";
        

-- 실습 5 : 급여가 2000000원 ~ 3000000 원인 여직원 중에서 4월 생일자를 겁색하여 이름, 주번, 급여, 부서코드를 주번 순으로(내림차)으로 조회
select emp_name "이름", emp_no "주민등록번호", salary "급여", dept_code "근무부서" from employee 
    where (salary between 2000000 and 3000000)
        and (emp_no like '__04__-2%' or emp_no like '__04__-04%')
    order by emp_no desc;
        
-- 실습 6 : 남자 사원 중 보너스가 없는 사원의 오늘까지 근무일을 측정하여 1000일마다 급여의 10% 보너스를 계산하여 이름 , 특별보너스 결과를 오름 차순 정렬(이름) 조회
select emp_name "이름", floor((sysdate-hire_date)/1000)*(salary*0.1) "보너스" from employee 
    where (emp_no like '______-1%' or emp_no like '______-3%')
        and bonus is null
     order by emp_name;