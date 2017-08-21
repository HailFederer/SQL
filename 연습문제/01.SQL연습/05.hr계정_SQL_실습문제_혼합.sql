-- 문제 1.
select e.FIRST_NAME||' '||e.LAST_NAME 이름, to_char(e.SALARY,'9999') 연봉, d.DEPARTMENT_NAME "부서 이름"
	from EMPLOYEES e, DEPARTMENTS d
	where e.DEPARTMENT_ID = d.DEPARTMENT_ID and e.HIRE_DATE = (select max(e.HIRE_DATE)
							from EMPLOYEES e);
							
-- 문제 2.
select e.EMPLOYEE_ID 사번, e.LAST_NAME 성, to_char(e.SALARY, '99999') 연봉
	from EMPLOYEES e, (select e.department_id 부서, avg(e.SALARY) 부서평균급여
							from EMPLOYEES e
							group by e.department_id
							having e.DEPARTMENT_ID is not null) e2
	where e.SALARY > e2."부서평균급여" and e.DEPARTMENT_ID = e2."부서"
	order by e.SALARY desc;
	
-- 문제 3.
select e.EMPLOYEE_ID 사번, e.FIRST_NAME 이름, e.LAST_NAME 성, j.JOB_TITLE 업무, to_char(e.SALARY, '99999') 연봉
	from EMPLOYEES e, JOBS j
	where e.JOB_ID = j.JOB_ID and
		  e.DEPARTMENT_ID = (select t1.부서
								from (select e.department_id 부서, avg(e.SALARY) 평균연봉
										from EMPLOYEES e
										group by e.department_id
										having e.DEPARTMENT_ID is not null) t1
								where t1.평균연봉 = (select max(avg(e.SALARY)) top_avg
														from EMPLOYEES e
														group by e.department_id
														having e.DEPARTMENT_ID is not null));

-- 문제 4.
select d.DEPARTMENT_NAME "평균 연봉이 가장 높은 부서", round(t1.평균연봉) 평균연봉
	from (select e.department_id 부서, avg(e.SALARY) 평균연봉
			from EMPLOYEES e
			group by e.department_id
			having e.DEPARTMENT_ID is not null) t1,
		 DEPARTMENTS d
	where t1.부서 = d.DEPARTMENT_ID and
		  t1.평균연봉 = (select max(avg(e.SALARY)) top_avg
							from EMPLOYEES e
							group by e.department_id
							having e.DEPARTMENT_ID is not null);

-- 문제 5(도시).
select l.CITY "평균 연봉이 가장 높은 도시"
	from LOCATIONS l,
		 (select d.LOCATION_ID 지역, avg(e.SALARY) 평균연봉
			from EMPLOYEES e, DEPARTMENTS d
			where e.DEPARTMENT_ID = d.DEPARTMENT_ID
			group by d.location_id
			having d.location_id is not null) t1
	where l.LOCATION_ID = t1.지역 and
		  t1.평균연봉 = (select max(avg(e.SALARY)) top_avg
							from EMPLOYEES e, DEPARTMENTS d
							where e.DEPARTMENT_ID = d.DEPARTMENT_ID
							group by d.location_id
							having d.location_id is not null);
-- 문제 5(대륙).
select l.CITY "평균 연봉이 가장 높은 대륙"
	from LOCATIONS l,
		 (select d.LOCATION_ID 지역, avg(e.SALARY) 평균연봉
			from EMPLOYEES e, DEPARTMENTS d
			where e.DEPARTMENT_ID = d.DEPARTMENT_ID
			group by d.location_id
			having d.location_id is not null) t1
	where l.LOCATION_ID = t1.지역 and
		  t1.평균연봉 = (select max(avg(e.SALARY)) top_avg
							from EMPLOYEES e, DEPARTMENTS d
							where e.DEPARTMENT_ID = d.DEPARTMENT_ID
							group by d.location_id
							having d.location_id is not null);

select r.REGION_NAME "평균 연봉이 가장 높은 대륙", t1.avg_sal 평균연봉
	from REGIONS r,
		 (select r.REGION_ID 지역, avg(e.SALARY) avg_sal
				from EMPLOYEES e, DEPARTMENTS d, LOCATIONS l, COUNTRIES c, REGIONS r
				where e.DEPARTMENT_ID = d.DEPARTMENT_ID and d.LOCATION_ID = l.LOCATION_ID and l.COUNTRY_ID = c.COUNTRY_ID and c.REGION_ID = r.REGION_ID
				group by r.REGION_ID
				order by avg(e.SALARY) desc) t1
	where rownum = 1 and r.REGION_ID = t1.지역;
	
	select * from REGIONS r;

-- 문제 6.
select j.JOB_TITLE "평균 연봉이 가장 높은 업무", t1.평균연봉
	from JOBS j,
		 (select e.JOB_ID 업무, avg(e.SALARY) 평균연봉
			from EMPLOYEES e
			group by e.JOB_ID
			having e.JOB_ID is not null) t1
	where j.JOB_ID = t1.업무 and
		  t1.평균연봉 = (select max(avg(e.SALARY)) top_avg
							from EMPLOYEES e
							group by e.JOB_ID
							having e.JOB_ID is not null);

-- 문제 6. top-k 방식..
select j.JOB_TITLE "평균 연봉이 가장 높은 업무", t1.평균연봉
	from JOBS j,
		 (select e.JOB_ID 업무, avg(e.SALARY) 평균연봉
				from EMPLOYEES e
				group by e.JOB_ID
				having e.JOB_ID is not null
				order by avg(e.SALARY) desc) t1
	where rownum = 1 and j.JOB_ID = t1.업무;

-- 문제 6(변형). top-k 방식..
select j.JOB_TITLE "평균 연봉이 가장 높은 업무", t1.평균연봉
	from JOBS j,
		 (select e.JOB_ID 업무, avg(e.SALARY) 평균연봉
				from EMPLOYEES e
				group by e.JOB_ID
				having e.JOB_ID is not null
				order by avg(e.SALARY) desc) t1
	where rownum = 1 and j.JOB_ID = t1.업무;















