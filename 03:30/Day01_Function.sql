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