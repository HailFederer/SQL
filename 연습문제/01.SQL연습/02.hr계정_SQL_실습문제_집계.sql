-- 문제 1.
select max(e.SALARY) 최고임금, min(e.SALARY) 최저임금, max(e.SALARY)-min(e.SALARY) "최고임금 - 최저임금" from EMPLOYEES e;

-- 문제 2.
select to_char(max(e.HIRE_DATE),'yyyy"년 "mm"월 "dd"일"') from EMPLOYEES e;

-- 문제 3.
select avg(e.SALARY) 평균임금, max(e.SALARY) 최고임금, min(e.SALARY) 최저임금, e.DEPARTMENT_ID
	from EMPLOYEES e
	where e.DEPARTMENT_ID IS NOT NULL 
	group by e.DEPARTMENT_ID
	order by avg(e.SALARY) desc, max(e.SALARY) desc, min(e.SALARY) desc;
	
-- 문제 4.
select avg(e.SALARY) 평균임금, max(e.SALARY) 최고임금, min(e.SALARY) 최저임금, e.JOB_ID
	from EMPLOYEES e
	group by e.JOB_ID
	order by avg(e.SALARY) desc, max(e.SALARY) desc, min(e.SALARY) desc;
	
-- 문제 5.
select to_char(max(e.HIRE_DATE), 'yyyy"년 "mm"월 "dd"일') "가장 오래 근속한 직원의 입사일" 
	from EMPLOYEES e
	where e.EMPLOYEE_ID NOT IN (select DISTINCT j.EMPLOYEE_ID 
									from JOB_HISTORY j
									where j.END_DATE IS NOT NULL)
	order by e.EMPLOYEE_ID;

-- 문제 6.
select e.department_id 부서, ceil(avg(e.SALARY)) 평균임금, min(e.SALARY) 최저임금, ceil(avg(e.SALARY)-min(e.SALARY)) "(평균임금-최저임금)"
	from EMPLOYEES e
	where e.DEPARTMENT_ID IS NOT NULL
	group by e.department_id
	having abs( avg(e.SALARY) - min(e.SALARY) ) < 2000 
	order by (평균임금-최저임금) desc;
	
-- 문제 7.
select j.JOB_TITLE
	from JOBS j
	where j.JOB_ID = (select t1."업무"
						from (select e.JOB_ID "업무", max(e.SALARY)-min(e.SALARY) "임금 차"
								from EMPLOYEES e
								group by job_id) t1
						where t1."임금 차" = (select max(max(e.SALARY)-min(e.SALARY)) "가장 큰 임금 차"
												from EMPLOYEES e
												group by job_id));
select j.JOB_TITLE, t1."임금 차"
	from JOBS j, (select e.JOB_ID "업무", max(e.SALARY)-min(e.SALARY) "임금 차"
					from EMPLOYEES e
					group by job_id) t1
	where j.JOB_ID = t1."업무" and t1."임금 차" = (select max(max(e.SALARY)-min(e.SALARY)) "가장 큰 임금 차"
														from EMPLOYEES e
														group by job_id);







