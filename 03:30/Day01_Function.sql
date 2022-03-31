/*
자바에서의 메서드 = 오라클에서는 함수
- 단일 행 함수 : 각 행마다 반복적으로 적용돼서 입력받은 행의 개수 만큼 결과를 반환

ex) length() -> 데이터의 길이값 반환

- 그룹 함수 : 특정한 행들의 집합으로 그룹이 형성되어 -> 그룹 당 1개의 결과를 반환

*/

-- 문자형 함수
-- lengthb() : 주어진 컬럼/ 문자열에 대한 길이(byte)로 변환해주는 함수
select emp_name, length(emp_name), lengthb(emp_name) from employee;

-- instr(컬럼/문자열, 찾고자 하는 문자(열), 시작 인덱스, 검색된 문자(열)의 순번) : 특정 문자열에서 찾고자 하는 문자열 위치를 찾아주는 함수 
-- 시작 인덱스에 음수값을 넣으면 뒤에서부터 탐색
-- dual 테이블 : 오라클에서 제공해주는 연산, 함수 실행 용도로 사용하는 특수한 테이블

select instr('Hello World Hi High', 'H', 1, 3) from dual;

-- employee 테이블에서 email, email  컬럼의 @ 위치를 조회

select email,instr(email, '@', 1, 1) from employee;

-- lpad() / rpad() : 주어진 컬럼/ 문자열을 대상으로 해서 임의의 문자열을 왼쪽 / 오른쪽에 덧붙여서 길이 N의 문자열을 반환하는 함수
select lpad(email, 20, '#') from employee;

-- ltrim(대상이 되는 컬럼/문자열, 제거하고 싶은 문자(열)) / rtrim()
-- 주어진 컬럼/ 문자열을 대상으로 제거하고 싶은 문자를 제거한 후 나머지를 반환하는 함수
-- 제거하고 싶은 문자열이 왼쪽(문자열의 시작)에 있을 때 / rtrim 문자열의 오른쪽에 제거하고 싶은 문자열이 있을 때
select rtrim(email, 'kh.or.kr') from employee;
select ltrim(email, 'kh.or.kr') from employee;

-- 문제 1 : Hello KH Java 문자열을 Hello KH 가 출력되도록
select rtrim ('Hello KH Java', ' Java') from dual;
-- 문제 2 : Hello KH Java 문자열을 KH Java 가 출력되도록
select ltrim('Hello KH Java', 'Hello') from dual;
-- 문제 3 : DEPARTMENT 테이블에서 dept_title을 출력, 단 마지막 부 글자를 빼고 출력되도록
select rtrim(dept_title,'부') from department;
-- 982341678934509hello923498413948 문자열에서 앞 뒤 모든 숫자를 제거
select ltrim(rtrim('982341678934509hello923498413948', '0123456789'), '0123456789') from dual;

--substr(대상이 되는 컬럼 / 문자열, 문자열을 잘라낼 위치, 반환할 문자의 개수) : 대상이 되는 컬럼 / 문자열에서 시작위치로부터 제시한 문자의 개수만큼 문자(열)을 잘라서 반환해주는 함수
-- 1부터 5까지만 잘라내서 표시
select substr('HappyHappyDay', 1, 5) from dual;
-- 음수면 문자열의 우측부터 세기 시작한다.
select substr('HappyHappyDay', -7,3) from dual;

-- employee 테이블에서 사원명 조회 -> 성만 중복 없이 사전순으로 조회
select distinct substr(emp_name,1,1) from employee 
    order by 1;
    
-- employee 의 사원번호, 사원명, 주민번호, 연봉을 조회, 단 뒷 6자리는  별표시로
select emp_id"사번", emp_name"이름", substr(emp_no,1,8)||'******'"주민등록번호", salary*12"연봉" from employee
    where emp_no like '%-1%';

select emp_id"사번", emp_name"이름", rpad(substr(emp_no,1,8),14,'*')"주민등록번호", salary*12"연봉" from employee
    where substr(emp_no,8,1) in (1,3);

-- concat(대상문자열 1, 대상문자열 2) : 두개의 문자열을 하나로 합친 후 반환해주는 함수
select concat('ABCD', '가나다라') from dual;
select 'abcd'||'가나다라' from dual;

-- lower(대상 문자열 / 컬럼) / upper(대상 문자열 / 컬럼) / inicap(대상 문자열 / 컬럼)
-- lower -> 대상 문자열을 모두 소문자로 변환
-- upper -> 대상 문자열을 모두 대문자로 변환
-- initcap -> 각 단어의 이니셜을 대문자로 변환

select lower('Welcome To My World') from dual;
select upper('welcome to my world') from dual;
select initcap('welcome to my world') from dual;

-- replace(대상이 되는 문자열 / 컬럼, 변경대상이 되는 문자(열) , 변경할 문자(열) )
-- 대상이 되는 문자열 / 컬럼을 기준으로 변경대상이 되는 문자(열)을 찾아서 변경할 문자(열)로 바꿔주는 함수
select replace('Hello Hi High', 'Hi', 'Ho') from dual;
select replace('Hello Hi High', 'Hi', '')from dual;

--------------------------------------------------------------------------------------------------------

-- 숫자형 함수
-- abs(숫자) : 인자로 전달받은 숫자의 절대값을 반환해주는 함수
select abs(10) from dual;
select abs(-10) from dual;

-- mod(숫자, 나눌 값) :  인자로 전달받은 숫자를 나눌 값으로 나눠서 나머지를 반환해주는 함수
select mod(10,3) from dual;
select mod(10,2) from dual;
select mod(10,4) from dual;

-- round(숫자) : 인자로 받은 숫자를 반올림하여 반환해주는 함수
-- round(숫자, 소숫점 인덱스 위치) : 인자로 받은 숫자를 지정한 위치 다음 자리 수에서 반올림하여 반환해주는 함수
--> 인덱스 위치까지 표기
--> 2번째 인자값을 음수로 넘길수도 있음

select round(123.456) from dual;
select round(123.678) from dual;
select round(123.456, 1) from dual;
select round(123.456, -2) from dual;

-- floor(숫자) : 인자로 받은 숫자의 소숫점 자리를 모두 버리고(내림) 반환해주는 함수
select floor(123.456) from dual;
select floor(123.568) from dual;

-- trunc(숫자, 소숫점 위치) : 인자로 받은 숫자를 지정한 위치까지 잘라서 반환해주는 함수
Select trunc(123.456,1) from dual;
select trunc(123.456,2) from dual;

-- ceil(숫자) : 올림
select ceil(123.456) from dual;
select ceil(123.567) from dual;

-- employee 테이블에서 직원명, 입사일, 오늘까지의 근무일수 조회
-- 주말도 포함, 소숫점 아래는 버림
select emp_name, hire_date, floor(sysdate-hire_date) from employee;

------------------------------------------------------------------------------

-- 날짜 함수
-- sysdate : 시스템에 저장되어있는 현재 날짜(시간 포함)을 반환해주는 함수
select sysdate from dual;
-- current_date : session(접속) timezone에 따라 현재 날짜(시간)을 반환해주는 함수
select current_date from dual;

-- months_between(날짜형1, 날짜형2) : 날짜형 1과 날짜형 2 사이의 개월 수 차이를 반환해주는 함수
select months_between(sysdate, hire_date) from employee;
select floor(months_between(sysdate, hire_date)/12) from employee;
select months_between(sysdate, sysdate-31) from dual;

-- add_months(기준 날짜, 더할 개월 수) : 날짜를 기준으로 해서 두번째 인자 값을 더해서 반환해주는 함수
select add_months(sysdate, 1) from dual;
select add_months(sysdate, -1) from dual;

-- employee 테이블에서 사원명, 입사일, 입사 후 6개월이 된 날짜
select emp_name, hire_date, add_months(hire_date,6) from employee;

-- next_day(기준 날짜, 요일/숫자) : 기준 날짜를 기준으로 해서 오른쪽에 해당하는 가장 가까운 날짜를 반환해주는 함수
-- 요일의 형식 : '월' or "월요일"
-- 숫자의 의미 : 1 = '일', 2 = '월' ... 7 = '토'
select next_day(sysdate, '월') from dual;
select next_day(sysdate, 2) from dual;

-- last_day(기준 날짜) : 기준 날짜를 바탕으로 해서 해당 날짜가 속한 달의 마지막 날을 반환해주는 함수
select last_day(sysdate) from dual;
select last_day(add_months(sysdate,-1)) from dual;

-- employee 테이블에서 사원명, 입사일, 입사월의 마지막 날 조회
select emp_name, hire_date, last_day(hire_date) from employee;
-- 다음 달의 마지막 날 조회
select last_day(add_months(sysdate, 1)) from dual;

-- extract(year/month/day from date(기준날짜)) : 기준날짜로부터 년/월/일을 추출하여 반환
select extract(year from sysdate) from dual;
select extract(month from sysdate) from dual;
select extract(day from sysdate) from dual;

-- employee 테이블에서 사원명, 입사년도, 입사월, 입사일을 조회
SELECT emp_name, hire_date, extract(year from hire_date), extract(month from hire_date), extract(day from hire_date) from employee;

-- employee 테이블에서 사원명, 입사일, 년차를 출력 (단, 입사일 -> YYYY년 MM월 DD일. 연차 -> 올림)
select emp_name
    , extract(year from hire_date)||'년 '||extract(month from hire_date)||'월 '||extract(day from hire_date)||'일' "입사일"
    , ceil((sysdate-hire_date)/365)||'년차'"년차" from employee
order by hire_date;
-- 문자열을 기준으로 order by를 하게 되면 문자로써 더 작은 숫자를 작다고 인식 (10과 3이 있다면 10을 더 작다고 인식) : 3을 기준으로 하면 x

-- 특별 보너스 지급 -> 자료가 필요
-- employee 테이블에서 입사일을 기준으로 다음달 1일부터 6개월을 계산해서 조회
-- 사원명, 입사일, 기준일, 기준일 + 6개월

select emp_name
    , hire_date "입사일"
    , last_day(hire_date)+1 "기준일"
    , add_months((last_day(hire_date)+1),6) "기준일+6개월" from employee
order by 2;

------------------------------------------------------------------------------------------

-- 형 변환
-- to_char(date/number, format) : 날짜 혹은 숫자를 특정한 형식의 문자형으로 변환해주는 함수
/*
Date -> 문자열로 변환하는 경우
*/
-- 년 : YY/YYYY, 월 : MM, 일 : DD
select sysdate from dual;
select to_char(sysdate, 'YY-MM-DD') from dual;
select to_char(sysdate, 'YYYY/MM/DD') from dual;
-- 중간에 한글을 넣을 때는 한글의 앞 뒤로 ""를 붙여야 한다.
select emp_name
    , to_char(hire_date, 'YYYY"년" MM"월" DD"일"') FROM EMPLOYEE;
    
-- DAY : X요일
select to_char(sysdate, 'yy/mm/dd/day') from dual;
-- DY : X(요일)
select to_char(sysdate, 'yy/mm/dd/dy') from dual;

-- Month : x월
select to_char(sysdate, 'yy/month/dd') from dual;

-- HH, MI, SS : 시 분 초
select to_char(sysdate,'hh:mi:ss') from dual;

-- PM/AM : 오후 / 오전
select to_char(sysdate, 'PM HH:MI:SS') from dual;
select to_char(sysdate, 'AM HH:MI:SS') from dual;

-- HH24 : 24시간을 기준으로 표기
select to_char(sysdate, 'HH24:MI:SS') from dual;

-- employee 테이블 사원명, 입사일 -> 1999/02/05(화) 형태
select emp_name, to_char(hire_date, 'YYYY/MM/DD(dy)') from employee order by 2;

/*
숫자 -> 문자열로 변경하는 경우
*/
-- to_char(대상 숫자, 
-- 123456789 -> 0이나 9를 이용해 문자형으로 변환
-- 9 : 지정해준 형식보다 짧은 숫자가 들어온다면 대상이 되는 숫자 길이에 맞춰서 결과값을 반환
-- 0 : 지정해준 형식보다 짧은 숫자가 들어온다면 대상이 되는 숫자 형식에 맞추서 길이를 지정하고 남는 자리수는 0으로 채워 줌.
select to_char(123456789, '999,999,999') from dual;
select to_char(123456789, '000,000,000') from dual;
select to_char(12345, '999,999,999'), to_char(12345, '000,000,000') from dual;


-- 통화 표시 -> L (local)
select to_char(123456789, '999,999,999') from dual;

-- employee - > 직원명, 직급코드, 연봉 조회
-- 연봉은 원화 표시활용
-- 연봉보너스가 적용된 금액으로 조회

-- nvl(숫자/컬럼, 치환값) : 해당 숫자나 컬럼이 NULL이면 치환값으로 변환 
select * from employee;
select emp_name, dept_code, to_char(salary*12*(1+NVL(bonus,0)),'L999,999,999,999') from employee;


-- to_date(숫자/문자, 형식) : 숫자형 혹은 문자형 데이터를 날짜형 타입으로 변환
select to_date(20220331,'yyyymmdd') from dual;
select to_date(20220331,'yymmdd') from dual;
select to_date('20220331', 'yymmdd') from dual;
-- 시간값을 변환할 때 앞에 년/월/일 정보를 명시하지 않으면 현재 달의 1일의 날짜리 인식해버림.
select to_date('110808', 'HH:MI:SS') from dual;
select to_char(to_date('110808', 'hh:mi:ss'), 'yyyy/mm/dd hh:mi:ss') from dual;
-- 년도값의 앞자리(19xx,20xx)가 제대로 명시되지 않으면 2000년대로 인식
select to_char(to_date('890909', 'yymmdd'), 'yyyy/mm/dd') from dual;

--employee 테이블에서 2000년도 이후에 입사한 사원명, 사번, 입사일 조회
select emp_name, emp_id, hire_date from employee
    where hire_date >= to_date('20000101', 'YYYYMMDD');

-- to_number(문자형, 형식) : 문자형을 숫자형으로 변환해주는 함수
select to_number('123,456,789','999,999,999') from dual;
select to_number('123,456,789','999,999') from dual; -- 넘겨주는 문자 형식에 맞춰 숫자 형식도 동일하게
select to_number('s123,456','9,999,999') from dual; -- 숫자가 아닌 것은 넘겨주는 것이 불가


-- 묵시적 형변환
-- 오라클에서는 어느 자동적으로 자료형을 유추해서 형변환을 실행
-- 하지만 묵시적 형변환에 의존하기 보다는 정확한 연산을 위해서는 정확한 자료형으로 변환한 후에 연산할 것

-- 숫자
select emp_name, salary from employee
    where salary = 8000000;
-- 문자
select emp_name, salary from employee
    where salary = '8000000';
    
select 25 +'25' from dual;
select emp_name, hire_date from employee;
select emp_name, hire_date from employee
    where hire_date = to_date('20130206','yymmdd');
select emp_name, hire_date from employee
    where hire_date = '20130206';
    
    
-- 60년 생의 직원명과 년생, 보너스율을 출력하시오(보너스율 null 이면 0을로)
select emp_name"직원명"
, to_number(substr(emp_no,1,2),'99')"년생"
, nvl(bonus,0)*100||'%' "보너스율" from employee
    where to_number(substr(emp_no,1,2),'99') between 60 and 69;


-------------------------------------------------------------------------------------

-- 그룹 함수
-- sum(숫자/컬럼) : 해당 컬럼이나 숫자 값의 총 합을 구해주는 함수
select salary from employee;
select sum(salary) from employee;
-- 부서코드가 d5인 사람들의 급여의 총합
select sum(salary) from employee
    where dept_code = 'D5';

-- 그룹함수를 사용할 때는 단일한 결과값이 나오게 됨.
-- 직원명, 직원들의 급여 총합 출력
select emp_name, sum(salary) from employee;

-- avg(컬럼) : 해당 컬럼 값들의 평균을 구해주는 함수
select round(avg(salary)) from employee;

-- 송종기 사원과 선동일 사원의 평균 급여
select * from employee;
select avg(salary) from employee
    where emp_name in ('송종기', '선동일');
    
-- 전 직원의 보너스 평균 -> 소수점 둘째자루 수에서 반올림해서 조회
-- 그룹함수를 사용할 때 만약 NULL값이 존재하면 아예 제외 대상이 됨.
-- null 값을 0으로 치환해주는 과정 필요
select round(avg(nvl(bonus,0)),2) from employee;

-- count(컬럼) : 해당 컬럼 내 데이터의 개수를 반환해주는 함수
select count(emp_name) from employee;
select count(*) from employee;
-- 보너스를 지급해야하는 사원의 수
select count(*) from employee
    where bonus is not null;
select count(*) from employee
    where dept_code = 'D5';
-- 사람들이 속해 있는 부서의 수 카운트
select count(distinct dept_code) from employee
    where dept_code is not null;
    
    
-- Max/Min(컬럼) : 해당 그룹에서 최대값/최소값을 반환해주는 함수
select max(salary), min(salary) from employee;
-- employee 테이블에서 가장 오래 일한 사원의 입사일, 가장 적게 일한 사원의 입사일
select min(hire_date), max(hire_date) from employee;

--------------------------------------------------------------------------------
-- 조건식
/*
decode(대상표현식, 조건1, 결과1, 조건2, 결과2, ... , default)
    : 대상표현식/값이 조건식 1과 같다면 결과 1이 반환, 조건2 와 같다면 결과 2가 반환
    -> 이 모든 것이 충족되지 않으면 default 값 변환
    -> equal 비교만 가능 (Java / swtich와 비슷)
 
*/
select emp_name "사원명"
    ,decode(substr(emp_no,8,1), 1, '남', 2, '여')"성별"from employee;

-- default 활용
select emp_name "사원명"
    ,decode(substr(emp_no,8,1), 1, '남', '여')"성별" from employee;


/*문제 1. 사번 직원명과 퇴사여부를 출력, 퇴사 여부가 y면 퇴사일을 'yy년 mm월 dd일 퇴사' 
출력 else '재직중' 정렬 순서는 퇴사여부, 사번 컬럼 오름차순*/
select * from employee;
select emp_id "사번"
    , emp_name "직원명" 
    , decode(ent_yn,'Y',to_char(ent_date,'yy"년 "mm"월 "dd"일 퇴직"'),'재직 중')"퇴사여부" from employee
order by ent_yn desc, 1;
    
    
/*
case 
    when 조건 1 then 결과 1
    when 조건 2 then 결과 2
    ...
    else 모든 조건이 충족되지 않으면 반횐되는 결과값
end

cf) else를 설정해주지 않으면 null 값 변환
cf2) 반환되는 결과값의 자료형은 일관적이어야 한다.
*/

select 
    case
        when '가나다' = '하하하' then '같음'
        when 1 > 5 then '1이 5보다 큽니다.'
        else '맞는 조건이 없습니다.'
    end
from dual;
select * from employee;

select emp_id "사번"
    , emp_name "직원명"
    , case
        when ent_yn = 'N' then '재직 중'
        else to_char(ent_date,'yy"년 "mm"월 "dd"일 퇴직"')
    end "퇴사여부"
from employee
order by ent_yn desc,1;

/* 부서별 실적 조회
d2, d6 부서는 상/d9 하/ 나머지 중 / 인턴 해당없음 출력
부서코드 없음 = 인턴
부서코드 중복 x, 정렬순서는 부서코드 오름차순
*/
--#1
select distinct nvl(dept_code,'인턴') "부서코드",
    case 
        when dept_code in ('D2', 'D6') then '상'
        when dept_code = 'D9' then '하'
        when dept_code is null then '해당없음'
        else '중'
    end "1분기 실적"
from employee
order by 1;

--#2
select distinct decode(dept_code, null, '인턴', dept_code)"부서코드"
    , case 
        when dept_code in ('D2', 'D6') then '상'
        when dept_code = 'D9' then '하'
        when dept_code is null then '해당없음'
        else '중'
    end "1분기 실적"
from employee
order by 1;