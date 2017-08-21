-- 문제 1.
select e.FIRST_NAME||' '||e.LAST_NAME 이름, e.EMAIL 이메일, 
    -- 첫번째 숫자단위 자릿수 맞춤
    LPAD(SUBSTR(e.PHONE_NUMBER, 1, INSTR(e.PHONE_NUMBER, '.', 1, 1)-1),
    MAX(LENGTH(SUBSTR(e.PHONE_NUMBER, 1, INSTR(e.PHONE_NUMBER, '.', 1, 1)-1))) over (), ' ') ||'-'||
    -- 두번째 숫자단위 자릿수 맞춤
    LPAD(SUBSTR(e.PHONE_NUMBER, INSTR(e.PHONE_NUMBER, '.', 1, 1)+1, 
    INSTR(e.PHONE_NUMBER, '.', 1, 2)-INSTR(e.PHONE_NUMBER, '.', 1, 1)-1),
    MAX(LENGTH(SUBSTR(e.PHONE_NUMBER, INSTR(e.PHONE_NUMBER, '.', 1, 1)+1, 
    INSTR(e.PHONE_NUMBER, '.', 1, 2)-INSTR(e.PHONE_NUMBER, '.', 1, 1)-1))) over (), '  ')  ||'-'|| 
    -- 세번째 숫자단위 자릿수 맞춤
    LPAD(SUBSTR(e.PHONE_NUMBER, INSTR(e.PHONE_NUMBER, '.', 1, 2)+1, 
    DECODE(INSTR(e.PHONE_NUMBER, '.', 1, 3), 0, length(e.PHONE_NUMBER)+1, INSTR(e.PHONE_NUMBER, '.', 1, 3))
        - INSTR(e.PHONE_NUMBER, '.', 1, 2)-1),
        MAX(LENGTH(SUBSTR(e.PHONE_NUMBER, INSTR(e.PHONE_NUMBER, '.', 1, 2)+1, 
    DECODE(INSTR(e.PHONE_NUMBER, '.', 1, 3), 0, length(e.PHONE_NUMBER)+1, INSTR(e.PHONE_NUMBER, '.', 1, 3))
        - INSTR(e.PHONE_NUMBER, '.', 1, 2)-1))) over (), ' ') 
    -- 마지막 연결문자 포함여부 결정
        || NVL2(SUBSTR(e.PHONE_NUMBER, DECODE(INSTR(e.PHONE_NUMBER, '.', 1, 3), 0, length(e.PHONE_NUMBER)+1, INSTR(e.PHONE_NUMBER, '.', 1, 3)+1), 
    DECODE(INSTR(e.PHONE_NUMBER, '.', 1, 4), 0, length(e.PHONE_NUMBER)+1, INSTR(e.PHONE_NUMBER, '.', 1, 4))
        - INSTR(e.PHONE_NUMBER, '.', 1, 3)-1), '-', ' ') ||
    -- 네번째 숫자단위 자릿수 맞춤
        LPAD(NVL(SUBSTR(e.PHONE_NUMBER, DECODE(INSTR(e.PHONE_NUMBER, '.', 1, 3), 0, length(e.PHONE_NUMBER)+1, INSTR(e.PHONE_NUMBER, '.', 1, 3)+1), 
    DECODE(INSTR(e.PHONE_NUMBER, '.', 1, 4), 0, length(e.PHONE_NUMBER)+1, INSTR(e.PHONE_NUMBER, '.', 1, 4))
        - INSTR(e.PHONE_NUMBER, '.', 1, 3)-1), ' '),
         MAX(LENGTH(NVL(SUBSTR(e.PHONE_NUMBER, DECODE(INSTR(e.PHONE_NUMBER, '.', 1, 3), 0, length(e.PHONE_NUMBER)+1, INSTR(e.PHONE_NUMBER, '.', 1, 3)+1), 
    DECODE(INSTR(e.PHONE_NUMBER, '.', 1, 4), 0, length(e.PHONE_NUMBER)+1, INSTR(e.PHONE_NUMBER, '.', 1, 4))
        - INSTR(e.PHONE_NUMBER, '.', 1, 3)-1), ' ')))  over (), ' ') 전화번호 
from EMPLOYEES e order by e.HIRE_DATE asc;

-- 문제 2. (부서별로 부서이름과 최고임금을 임금의 내림차순으로 정렬
select d.department_name, e.employee_id, e.FIRST_NAME||' '||e.LAST_NAME 이름, e.salary
from employees e, departments d
where e.department_id = d.department_id 
and (e.department_id, e.salary) 
in (select department_id, max(salary) from employees group by department_id) 
order by e.salary desc;

-- 문제 3.
select count(*) from employees where manager_id is null;

-- 문제 4.
select job_title, max_salary from jobs order by MAX_SALARY desc;

-- 문제 5.
select count(*) from departments;

-- 문제 6.
select * from departments order by length(DEPARTMENT_NAME) desc;

-- 문제 7.
select count(*) from departments where MANAGER_ID is null;

-- 문제 8.
select c.COUNTRY_NAME from COUNTRIES c, LOCATIONS l, DEPARTMENTS d, EMPLOYEES e
	where e.DEPARTMENT_ID = d.DEPARTMENT_ID and d.LOCATION_ID = l.LOCATION_ID and l.COUNTRY_ID = c.COUNTRY_ID and e.DEPARTMENT_ID is not null
	group by c.COUNTRY_NAME
	order by c.COUNTRY_NAME asc;
	

-- 문제 9.
select * from REGIONS r
	order by length(r.region_name) asc;

-- 문제 10.
select lower(city) from locations 
where location_id
in
(select location_id from departments where location_id is not null)
order by location_id asc;