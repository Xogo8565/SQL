/*
Top N 분석

: 컬럼에서 가장 큰 N 개의 값을 혹은 가장 작은 N 개의 값을 요청할 때 사용하는 쿼리
-> 상위 / 하위 N개의 데이터를 반환
-> 게시판 페이징 / 조회수 -> 인기글 등에 활용

*/

-- employee 테이블에서 가장 높은 급여를 받는 사람 순으로 정렬

select 
    emp_name, salary 
from employee
order by 2 desc;
    
/*
    rownum : 출력되는 select 문의 행마다 자동적으로 순위를 매겨줌
    default 로는 원래 존재하는 데이터의 순서대로 순위를 매겨줌.
*/

select
    rownum,
    emp_name,
    salary from employee;

-- from, where, group by, having, select, order by 순으로 동작하기 때문에 
-- select 절이 order by절보다 먼저 실행되면서 rownum 이 매겨진 후에 다시 재정렬되기 때문에 순서가 뒤죽박죽

select 
    rownum, emp_name, salary 
from employee
order by 3 desc;

-- 우리가 원하는 기준에 맞춰 이미 정렬이 된 상태의 데이터에 대해 rownum -> 순서를 매겨야 함
-- 인라인뷰 -> 서브쿼리 안에서 월급이 제일 큰 순서대로 일단 데이터를 정렬
-- -> 실제 메인 쿼리에서 rownum을 사용하게 되면 이미 정렬된 데이터에 대해 순서가 매겨짐

select * from employee order by salary desc;
select
    rownum, emp_name, salary
from(select * from employee order by salary desc);

-- 가장 높은 급여를 받는 1 사람에 대해 순위, 이름, 급여 출력

select 
    rownum, emp_name, salary
from (select * from employee order by salary desc)
where rownum =1;

-- 가장 높은 급여를 받는 5 사람의 순위 이름 급여

select
    rownum, emp_name, salary
from (select emp_name, salary from employee order by salary desc)
where rownum < 6;

-- 인라인뷰를 계속 사용해야 하니 쿼리문이 길어지는 단점


/*
     row_number() over(order by 컬럼...) : over() 안쪽의 컬럼 순서에 따라 일단 정렬을 한 후에 순위를 매겨준다.
     
    정렬 기준의 데이터에 중복값이 있다면 원래 순서대로 순위를 19,20 식0으로 매겨버린다.
    
*/

select
0    row_number() over(order by salary desc)"순위", 
    emp_name,  
    salary
from employee;

/*
    rank() over(order by 컬럼...) : over()안에 있는 컬럼에 따라서 일단 데이터를 정렬한 후에 순위를 매김
    순위를 매길 때 중복 데이터가 있다면 같은 순위를 매기고, 같은 순위를 매긴 데이터만큼 건너뛰어 다음 순위를 매김.
*/

select
    rank() over(order by salary desc)"순위",
    emp_name,
    salary
from employee;

/*
    dense_rank() over(order by 컬럼...) : over() 안에 있는 컬럼에 따라서 일단 데이터를 정렬한 후에 순위를 매김
    중복 데이터에 같은 순위를 매기고 그 다음 순위부터는 건너뜀 없이 순차적으로 순위를 매김
    -> 총 데이터의 개수와 끝순위 번호가 일치하지 않을 수 있음.
*/

select
    dense_rank() over(order by salary desc) "순위",
    emp_name,
    salary
from employee;

---------------------------------------------------------------------------------------------
-- 월급을 가장 많이 받는 5명
/* 해당 상황에서 rownum 을 where 절에서 사용하게 되면 원래 데이터의 정렬 순서를 기준으로
일단 5개의 데이터가 뽑혀 나오고 그 다음에 select 구문의 row_num() 을 통해 순서가 재정렬되는 상황
즉 -> where 절에 rownum을 쓸 수 없는 상황
*/

select
    row_number() over(order by salary desc)"순위",
    emp_name,
    salary
from employee
where rownum < 6;

/*
rownum과 동일하게 인라인뷰를 활용
*/

select
    "순위", -- 가상테이블에서 붙여준 별칭은 활용 가능(From 절이 select 보다 우선순위에 있기 때문에)
    emp_name,
    salary
from (select 
            row_number() over(order by salary desc)"순위",
            employee.* -- 다른 데이터나 컬럼과 함께 *을 쓰고 싶으면 테이블명.*로 사용한다.
          from employee);

select
    *
from (select
            row_number() over(order by salary desc) "순위",
            emp_name,
            salary
          from employee);
          
-- 급여를 제일 많이 받는 5명(Re)

select
    "순위",
    emp_name,
    salary
from (select 
            row_number() over(order by salary desc)"순위",
            employee.* 
          from employee)
where "순위" < 6;

-- 연봉 (보너스 포함)이 가장 높은 순서대로 정렬
-- 10 ~ 15 위 사이인 직원들의 순위, 사원명, 연봉, 직급코드, 부서코드 출력

select *
from (select 
            rank() over(order by (salary+salary*decode(bonus,null,0,bonus))*12 desc)"순위",
            emp_name,
            (salary+salary*decode(bonus,null,0,bonus))*12"연봉",
            job_code,
            dept_code from employee)
where "순위" between 10 and 15;

select *
from (select
            dense_rank() over(order by (salary+salary*decode(bonus,null,0,bonus))*12 desc)"순위",
            emp_name,
            (salary+salary*decode(bonus,null,0,bonus))*12"연봉",
            job_code,
            dept_code from employee)
where "순위" between 10 and 15;

select *
from (select
            row_number() over (order by (salary+salary*decode(bonus,null,0,bonus))*12 desc)"순위",
            emp_name,
            (salary+salary*decode(bonus,null,0,bonus))*12"연봉",
            job_code,
            dept_code from employee)
where "순위" between 10 and 15;

-- 가장 보너스를 많이 받는 순으로 순위를 매김
-- 4~8위인 사원들의 순위 이름 급여 보너스 출력

select *
from (select 
                row_number() over (order by decode(bonus,null,0,bonus) desc)"순위", -- 데이터에 null 값이 있는 상태에서 order by -> null 값이 큰 값으로 인식
                emp_name,
                salary,
                decode(bonus,null,0,bonus) from employee)
where "순위" between 4 and 8;
                
select *
from (select 
                rank() over (order by decode(bonus,null,0,bonus) desc)"순위",
                emp_name,
                salary,
                decode(bonus,null,0,bonus) from employee)
where "순위" between 4 and 8;
                
select *
from (select 
                dense_rank() over (order by decode(bonus,null,0,bonus) desc)"순위",
                emp_name,
                salary,
                decode(bonus,null,0,bonus) from employee)
where "순위" between 4 and 8;
                
