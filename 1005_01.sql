--1. 이름의 성이 'King' 사원의 사번과 부서명을 출력 ( employees, departments )
SELECT  e.EMPLOYEE_ID , d.DEPARTMENT_NAME 
FROM employees e right outer join departments d
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
WHERE e.LAST_name ='King';


--2. 이름의 성이 'King' 사원의 사번과 부서명 그리고 업무명을 출력 ( employees, departments, jobs )
select e.EMPLOYEE_ID,d.DEPARTMENT_NAME, e.JOB_ID
from employees e right outer join departments d
on e.DEPARTMENT_ID = d.DEPARTMENT_ID
where e.last_name = 'King';
?

--3. 2007년 상반기에 입사한 사원들의 사번과 이름, 입사일 그리고 부서명을 출력
--(*) Grant는 아직 부서가 배정받지 못한 상태이지만 Grant도 출력되려면
select e.EMPLOYEE_ID,e.FIRST_NAME ||' '|| LAST_NAME  FULL_NAME, e.hire_date,d.DEPARTMENT_NAME
from employees e LEFT outer join departments d
on e.DEPARTMENT_ID = d.DEPARTMENT_ID
where to_char(hire_date,'YYYY/MM')<'2007/07' AND to_char(hire_date,'YYYY/MM')>'2007/01';
?
--4. 'Executive' 부서에서 사원과 해당 사원의 매니저(상사) 이름을 출력
--(*) 매니저(상사)가 없는 사원인 'King'이 출력되려면
SELECT  e1.EMPLOYEE_ID,e1.LAST_NAME , e1.MANAGER_ID, e2. LAST_NAME 
FROM employees e1 right outer join employees e2
ON e1.MANAGER_ID = e2.EMPLOYEE_ID;


