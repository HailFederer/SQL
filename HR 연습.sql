SELECT *
  FROM EMPLOYEES e;

  SELECT e.*, e1.FIRST_NAME || ' ' || e1.LAST_NAME 매니저
    FROM EMPLOYEES e, EMPLOYEES e1
   WHERE e.MANAGER_ID = e1.EMPLOYEE_ID(+)
ORDER BY e.EMPLOYEE_ID;

SELECT *
  FROM JOB_HISTORY j;

SELECT 100 * 10
  FROM EMPLOYEES e;

SELECT SYSDATE FROM DUAL;

SELECT ADD_MONTHS (SYSDATE, 3) FROM DUAL;

SELECT ADD_MONTHS ('2015-01-01', 3) FROM DUAL;

SELECT LAST_DAY ('2015-01-03') FROM DUAL;

SELECT MONTHS_BETWEEN (ADD_MONTHS (SYSDATE, 3), SYSDATE) FROM DUAL;

SELECT ROUND (MONTHS_BETWEEN (j.END_DATE, j.START_DATE)) 근무월,
       j.EMPLOYEE_ID
  FROM JOB_HISTORY j;

SELECT NEXT_DAY (SYSDATE, 1) FROM DUAL;

SELECT e.EMPLOYEE_ID, TO_CHAR (ROUND (e.SALARY), 'fml99,999')
  FROM EMPLOYEES e;

SELECT TO_CHAR ('3.14151738', '999,999.999000') FROM DUAL;

SELECT TO_CHAR (3999, 'rn') FROM DUAL;

SELECT TO_CHAR (1234, 'XXX') FROM DUAL;

SELECT TO_NUMBER ('1234567', '9999999') + 10
  FROM DUAL;

SELECT e.EMPLOYEE_ID,
       TO_CHAR (
          e.HIRE_DATE,
          'yyyy"년" mm"월" dd"일" dy ddd amhh24"시" mi"분" ss"초"')
  FROM EMPLOYEES e;

SELECT TO_CHAR (TO_DATE ('30', 'rr'), 'yyyy') FROM DUAL;

SELECT COALESCE (NULL, NULL, NULL) FROM DUAL;

SELECT *
  FROM JOBS j;

SELECT DECODE (e.JOB_ID, 'AC_ACCOUNT', e.salary * 1.5, e.salary)
          "이번달 월급"
  FROM EMPLOYEES e;

  SELECT e.DEPARTMENT_ID, ROUND (AVG (e.SALARY)), MAX (e.SALARY)
    FROM EMPLOYEES e
   WHERE e.DEPARTMENT_ID IS NOT NULL
GROUP BY e.DEPARTMENT_ID
  HAVING e.DEPARTMENT_ID > 50
ORDER BY e.DEPARTMENT_ID;

  SELECT j.JOB_TITLE,
         e1.FIRST_NAME || ' ' || e1.LAST_NAME 직원,
         e2.FIRST_NAME || ' ' || e2.LAST_NAME 매니저
    FROM EMPLOYEES e1, EMPLOYEES e2, jobs j
   WHERE e1.MANAGER_ID = e2.EMPLOYEE_ID(+) AND e1.JOB_ID = j.JOB_ID
ORDER BY e1.EMPLOYEE_ID;


-- ansi join sql 문(1999 syntax)

-- natural join 테이블들의 칼럼 이름이 동일한 경우

SELECT COUNT (*)
  FROM EMPLOYEES e JOIN DEPARTMENTS d                  --using (department_id)
                                     ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;

SELECT COUNT (*)
  FROM EMPLOYEES e, DEPARTMENTS d
 WHERE e.MANAGER_ID = d.MANAGER_ID AND e.DEPARTMENT_ID = d.DEPARTMENT_ID;

    SELECT LEVEL, e.MANAGER_ID, e.EMPLOYEE_ID
      FROM EMPLOYEES e
START WITH e.manager_id IS NULL
CONNECT BY PRIOR e.employee_id = e.manager_id
  ORDER BY LEVEL, e.MANAGER_ID, e.EMPLOYEE_ID;

-- rollup, cube

  SELECT CASE GROUPING (e.DEPARTMENT_ID)
            WHEN 1 THEN '모든 부서'
            ELSE NVL (TO_CHAR (e.DEPARTMENT_ID), '없음')
         END
            AS "부서",
         CASE GROUPING (e.JOB_ID) WHEN 1 THEN '모든 직책' ELSE e.JOB_ID END
            AS "직책",
         COUNT (*),
         ROUND (AVG (e.salary))
    FROM EMPLOYEES e
GROUP BY ROLLUP (e.department_id, e.job_id)
ORDER BY e.department_id, e.job_id;

  SELECT CASE GROUPING (e.DEPARTMENT_ID)
            WHEN 1 THEN '모든 부서'
            ELSE NVL (TO_CHAR (e.DEPARTMENT_ID), '없음')
         END
            AS "부서",
         CASE GROUPING (e.JOB_ID) WHEN 1 THEN '모든 직책' ELSE e.JOB_ID END
            AS "직책",
         COUNT (*),
         ROUND (AVG (e.salary))
    FROM EMPLOYEES e
GROUP BY CUBE (e.department_id, e.job_id)
ORDER BY e.department_id, e.job_id;

SELECT e.FIRST_NAME, e.SALARY
  FROM EMPLOYEES e
 WHERE e.SALARY > (SELECT AVG (e.SALARY)
                     FROM EMPLOYEES e);

SELECT e.FIRST_NAME, e.SALARY
  FROM EMPLOYEES e
 WHERE e.SALARY > ALL (SELECT e.SALARY
                         FROM EMPLOYEES e
                        WHERE e.JOB_ID = 'IT_PROG');

SELECT e.FIRST_NAME, e.SALARY
  FROM EMPLOYEES e
 WHERE     e.SALARY IN (SELECT e.SALARY
                          FROM EMPLOYEES e
                         WHERE e.JOB_ID = 'IT_PROG')
       AND e.JOB_ID <> 'IT_PROG';

select e.EMPLOYEE_ID, e.FIRST_NAME||' '||e.LAST_NAME, e.SALARY, e.DEPARTMENT_ID
	from EMPLOYEES e, (select e.department_id 부서, max(e.SALARY) 최고연봉
							from EMPLOYEES e
							where e.DEPARTMENT_ID is not null
							group by e.department_id) t1
	where e.DEPARTMENT_ID = t1."부서" and e.SALARY < t1."최고연봉"
	order by e.SALARY desc;

-- correlated
select e.EMPLOYEE_ID, e.FIRST_NAME||' '||e.LAST_NAME, e.SALARY, e.DEPARTMENT_ID
	from EMPLOYEES e
	where e.SALARY = (select max(t1.SALARY) 최고연봉
							from EMPLOYEES t1
							where e.DEPARTMENT_ID = t1.department_id);
							
select e.EMPLOYEE_ID, e.FIRST_NAME||' '||e.LAST_NAME, e.SALARY, e.DEPARTMENT_ID
	from EMPLOYEES e
	where e.SALARY < (select max(t1.SALARY) 최고연봉
							from EMPLOYEES t1
							where e.DEPARTMENT_ID = t1.department_id);

-- 앞에서 5개 뽑는 경우(top-k)
select t1.EMPLOYEE_ID, t1.salary
	from (select e.EMPLOYEE_ID, e.SALARY
				from EMPLOYEES e
				where e.HIRE_DATE like '06%'
				order by e.salary desc) t1
	where rownum <= 5;

-- 쓰레기(6번째부터 10번째를 뽑는 경우)
select rownum, t1.EMPLOYEE_ID, t1.salary
	from (select e.EMPLOYEE_ID, e.SALARY
				from EMPLOYEES e
				where e.HIRE_DATE like '06%'
				order by e.salary desc) t1
	where rownum >= 6 and rownum <= 10;
	
select *
	from (select rownum as rn, t1.EMPLOYEE_ID, t1.salary
				from (select e.EMPLOYEE_ID, e.SALARY
							from EMPLOYEES e
							where e.HIRE_DATE like '06%'
							order by e.salary desc) t1) t2
	where t2.rn >= 6 and t2.rn <= 10;


create table employees_back01
as (select * from employees where job_id = 'FI_ACCOUNT');

drop table employees_back01;









