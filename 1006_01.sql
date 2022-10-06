-- 1. Zlotkey와 동일한 부서에 속한 모든 사원의 이름과 입사일을 표시하는 질의를 작성하십시오. 
-- Zlotkey는 제외하십시오.
SELECT * FROM employees WHERE DEPARTMENT_ID = 80;

SELECT FIRST_NAME ||' '|| LAST_NAME  FULL_NAME, hire_date
FROM employees
WHERE DEPARTMENT_ID in (SELECT DEPARTMENT_ID  FROM employees WHERE DEPARTMENT_ID = 80) AND LAST_NAME !='Zlotkey';

--2. 급여가 평균 급여보다 많은 모든 사원의 사원 번호와 이름을 표시하는 질의를 작성하고  결과를 급여에 대해 오름차순으로 정렬하십시오.
SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME  FULL_NAME, SALARY
FROM employees
WHERE SALARY>(SELECT AVG(SALARY)FROM employees)
ORDER BY SALARY;

--3. 이름에 u가 포함된 사원과 같은 부서에서 일하는 모든 사원의 사원 번호와 이름을 표시하는질의를 작성하십시오.
SELECT FIRST_NAME ||' '|| LAST_NAME  FULL_NAME FROM employees WHERE FIRST_NAME ||' '|| LAST_NAME like '%u%';

SELECT DEPARTMENT_ID, FIRST_NAME ||' '|| LAST_NAME  FULL_NAME
FROM employees
WHERE FIRST_NAME ||' '|| LAST_NAME  IN (SELECT FIRST_NAME ||' '|| LAST_NAME  FULL_NAME FROM employees WHERE FIRST_NAME ||' '|| LAST_NAME like '%u%');

--4. 부서 위치 ID가 1700인 모든 사원의 이름, 부서 번호 및 업무 ID를 표시하십시오.
SELECT e.DEPARTMENT_ID, d.LOCATION_ID FROM employees e, DEPARTMENTs d WHERE e.DEPARTMENT_ID =  d.DEPARTMENT_ID;
SELECT e.DEPARTMENT_ID, d.LOCATION_ID FROM employees e, DEPARTMENTs d WHERE d.LOCATION_ID=1700;

SELECT e.FIRST_NAME ||' '|| LAST_NAME  FULL_NAME, e.DEPARTMENT_ID, e.job_ID
FROM employees e
WHERE e.DEPARTMENT_ID in (SELECT e.DEPARTMENT_ID FROM employees e LEFT OUTER JOIN DEPARTMENTs d 
ON e.department_id = d.department_id WHERE d.LOCATION_ID=1700);


--5. King에게 보고하는 모든 사원의 이름과 급여를 표시하십시오.
SELECT e.first_name||' '||e.last_name name, salary
FROM employees e
WHERE manager_id 
    IN ( select employee_id from employees WHERE last_name = 'King' );
    
SELECT employee_id  FROM employees  WHERE manager_id = 100;

SELECT FIRST_NAME ||' '|| LAST_NAME  FULL_NAME, SALARY
FROM employees
WHERE employee_id in (SELECT employee_id  FROM employees  WHERE manager_id = 100);

--6. Executive 부서의 모든 사원에 대한 부서 번호, 이름 및 업무 ID를 표시하십시오.
SELECT e.department_id, e.first_name||' '||e.last_name name, job_id
FROM employees e
WHERE e.department_id
    IN ( select e.department_id 
         from employees e left outer join departments d
         on e.department_id = d.department_id
         WHERE d.department_name = 'Executive' );


SELECT * FROM employees WHERE DEPARTMENT_ID=90;

SELECT DEPARTMENT_ID, FIRST_NAME ||' '|| LAST_NAME  FULL_NAME, employee_id
FROM employees
WHERE department_id  =(SELECT department_id FROM departments WHERE department_name ='Executive');


--7. 평균 급여보다 많은 급여를 받고 이름에 u가 포함된 사원과 같은 부서에서 근무하는 
-- 모든 사원의 사원 번호, 이름 및 급여를 표시하는 질의를 작성하십시오.
SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME  FULL_NAME, SALARY
FROM employees
WHERE DEPARTMENT_ID in(SELECT  DEPARTMENT_ID FROM employees WHERE FIRST_NAME ||' '|| LAST_NAME like '%u%') 
and salary>(SELECT AVG(SALARY)FROM employees);





