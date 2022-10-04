--1. 2003년에 입사한 사원들의 사번, 이름, 입사일을 출력
SELECT  employee_id,FIRST_NAME ||' '|| LAST_NAME   AS FULL_NAME, hire_date
FROM employees
WHERE TO_CHAR(hire_date, 'YYYY') = 2003;
?
--2. 업무가 FI_ACCOUNT / FI_MGR / SA_MAN / SA_REP 인 사원들의 정보를 출력
SELECT *
FROM  employees
WHERE JOB_ID IN ('FI_ACCOUNT' , 'FI_MGR' , 'SA_MAN' , 'SA_REP' );

select      *   
from        employees
where       job_id = 'FI_ACCOUNT' or job_id = 'FI_MGR' or job_id = 'SA_MAN' or job_id = 'SA_REP'

SELECT *
FROM employees
WHERE lower(job_id) = 'fi_account' or lower(job_id) = 'ft_mgr' 
    or lower(job_id) = 'sa_man' or lower(job_id) = 'sa_rep';
?

--3. 커미션을 받는 사원들의 명단을 출력
SELECT *
FROM  employees
WHERE COMMISSION_PCT!=0 ;

SELECT *
FROM employees
WHERE commission_pct is not null;

?
--4.업무가 SA_MAN 또는 SA_REP이면 "판매부서"를 그 외는 "그 외 부서"라고 출력
SELECT  JOB_ID, decode( JOB_ID, 'SA_MAN', '판매부서', 'SA_REP' ,'판매부서', '그 외 부서') AS NEWDEPT
FROM employees;

SELECT job_id,
CASE job_id
    WHEN 'SA_MAN' THEN '판매부서'
    WHEN 'SA_REP' THEN '판매부서'
    ELSE '판매부서'
    END as job
FROM employees;

--5. 연도별로 입사자들의 최소급여, 최대 급여, 급여의 총합 그리고 평균 급여를 구하시오
SELECT to_char(hire_date, 'YYYY') year, min(SALARY) as MIN, max(SALARY)as MAX,  sum(SALARY) as SUM, ceil(AVG(SALARY)) as AVG
FROM  employees
GROUP BY TO_CHAR(HIRE_DATE,'YYYY')
ORDER BY TO_CHAR(HIRE_DATE,'YYYY') ASC;


--6. 부서별 평균 급여가 $10,000 이상인 부서만 구하시오. ( 평균급여가 높은 순으로 )
SELECT DEPARTMENT_ID, ceil(AVG(SALARY)) as AVG
FROM  employees
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY)>=10000
ORDER BY AVG(SALARY) DESC;
?
--7. 부서별 최대 급여를 구하시오
SELECT DEPARTMENT_ID, max(SALARY)as MAX
FROM  employees
GROUP BY DEPARTMENT_ID;



