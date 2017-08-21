-- 문제 1.
select e1.EMPLOYEE_ID 사번, j.JOB_TITLE 업무, e1.FIRST_NAME || ' ' || e1.LAST_NAME 이름, e1.DEPARTMENT_ID 부서명, e2.FIRST_NAME || ' ' || e2.LAST_NAME 매니저
	from EMPLOYEES e1, EMPLOYEES e2, jobs j
	where e1.MANAGER_ID = e2.EMPLOYEE_ID(+) and e1.JOB_ID = j.JOB_ID
	order by e1.EMPLOYEE_ID;
	
-- 문제 2.
select r.REGION_NAME 지역이름, c.COUNTRY_NAME 나라이름
	from COUNTRIES c, REGIONS r
	where c.REGION_ID = r.REGION_ID
	order by 지역이름 DESC, 나라이름 DESC;
	
-- 문제 3.
select d.DEPARTMENT_ID 부서번호, d.DEPARTMENT_NAME 부서명, e.FIRST_NAME||' '||e.LAST_NAME 매니저, l.CITY 도시, c.COUNTRY_NAME 나라, r.REGION_NAME 지역 
	from DEPARTMENTS d, EMPLOYEES e, LOCATIONS l, COUNTRIES c, REGIONS r
	where d.MANAGER_ID = e.EMPLOYEE_ID and d.LOCATION_ID = l.LOCATION_ID and l.COUNTRY_ID = c.COUNTRY_ID and c.REGION_ID = r.REGION_ID;
	
-- 문제 4.
select e.EMPLOYEE_ID 사번, e.FIRST_NAME||' '||e.LAST_NAME 이름
	from jobs j, JOB_HISTORY j_H, EMPLOYEES e
	where j.JOB_TITLE = 'Public Accountant' and j.JOB_ID = j_H.JOB_ID and e.EMPLOYEE_ID = j_H.EMPLOYEE_ID
	order by e.EMPLOYEE_ID;
	
-- 문제 5.
select e.EMPLOYEE_ID 사번, e.FIRST_NAME 이름, e.LAST_NAME 성, d.DEPARTMENT_NAME 부서이름
	from EMPLOYEES e, DEPARTMENTS d
	where e.DEPARTMENT_ID = d.DEPARTMENT_ID
	order by e.LAST_NAME;

select e.EMPLOYEE_ID 사번, e.FIRST_NAME 이름, e.LAST_NAME 성, nvl(d.DEPARTMENT_NAME, ' ') 부서이름
	from EMPLOYEES e, DEPARTMENTS d, (select e.last_name
										from EMPLOYEES e
										group by e.last_name
										having count(*) > 1) e2
	where e.LAST_NAME = e2.last_name and e.DEPARTMENT_ID = d.DEPARTMENT_ID(+)
	order by e.LAST_NAME asc, e.FIRST_NAME asc;
	
-- 문제 6.
select e1.EMPLOYEE_ID 사번, e1.LAST_NAME 성, to_char(e1.HIRE_DATE,'yyyy"년" mm"월" dd"일"') 채용일
	from EMPLOYEES e1, EMPLOYEES e2
	where e1.MANAGER_ID = e2.EMPLOYEE_ID and e1.HIRE_DATE < e2.HIRE_DATE
	order by e1.EMPLOYEE_ID;





	
	
	
	