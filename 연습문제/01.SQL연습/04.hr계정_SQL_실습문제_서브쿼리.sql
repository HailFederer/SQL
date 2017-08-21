-- 문제 1.
select count(*)
	from EMPLOYEES e
	where e.SALARY < (select avg(e.salary)
						from EMPLOYEES e);
						
-- 문제 2.
select e.EMPLOYEE_ID 사번, e.LAST_NAME 성, to_char(e.SALARY, '99999') 연봉
	from EMPLOYEES e, (select e.department_id 사번, max(e.SALARY) 최고급여
							from EMPLOYEES e
							group by e.department_id) t1
	where e.DEPARTMENT_ID = t1."사번" and e.SALARY = t1."최고급여"
	order by 연봉 desc;
	
-- 문제 2. as correlated..
select e.EMPLOYEE_ID 사번, e.LAST_NAME 성, to_char(e.SALARY, '99999') 연봉
	from EMPLOYEES e
	where e.SALARY = (select max(e.SALARY) 최고급여
							from EMPLOYEES t1
							where t1.department_id = e.department_id
							group by t1.department_id)
	order by 연봉 desc;	
	
-- 문제 3.
select j.JOB_TITLE 업무명, j2."연봉 총합"
	from JOBS j, (select e.JOB_ID, sum(e.SALARY) "연봉 총합"
					from EMPLOYEES e, JOBS j
					where e.JOB_ID = j.JOB_ID
					group by e.job_id) j2
	where j.JOB_ID = j2.JOB_ID
	order by j2."연봉 총합" desc;
	
-- 문제 4.
select e.EMPLOYEE_ID 사번, e.LAST_NAME 성, to_char(e.SALARY, '99999') 연봉
	from EMPLOYEES e, (select e.department_id 부서, avg(e.SALARY) 부서평균급여
							from EMPLOYEES e
							group by e.department_id
							having e.DEPARTMENT_ID is not null) e2
	where e.SALARY > e2."부서평균급여" and e.DEPARTMENT_ID = e2."부서"
	order by e.SALARY desc;

-- 문제 4. correlated..
select e.EMPLOYEE_ID 사번, e.LAST_NAME 성, to_char(e.SALARY, '99999') 연봉
	from EMPLOYEES e
	where e.SALARY > (select avg(t1.SALARY) 부서평균급여
							from EMPLOYEES t1
							where t1.department_id = e.department_id
							group by t1.department_id
							having t1.DEPARTMENT_ID is not null )
	order by e.SALARY desc;













