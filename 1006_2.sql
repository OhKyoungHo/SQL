create table stat_salary ( 

stat_date date not null, -- 날짜

dept_no number, -- 부서

emp_count number, -- 사원수

tot_salary number, -- 급여총액

avg_salary number ); -- 급여평균

desc stat_salary;

select sysdate, deptno FROM emp GROUP BY deptno;

INSERT INTO stat_salary(stat_date, dept_no)
SELECT sysdate, deptno FROM emp GROUP BY deptno;

SELECT* FROM stat_salary;

--사원수 
SELECT COUNT(*), SUM(sal), round(AVG(sal),1)
FROM emp
GROUP BY deptno;

UPDATE stat_salary ss
SET(emp_count, tot_salary, avg_salary)
= (SELECT COUNT(*), SUM(sal), round(AVG(sal),1)
FROM emp e
WHERE e.deptno = ss.dept_no 
GROUP BY deptno   );

CREATE TABLE emp_cp as select*from emp;
SELECT*FROM emp_cp;

--부서면이 'SALES'인 사원의 정보 삭제(EMP_CP)
DELETE FROM emp_cp e WHERE e.deptno=(SELECT d.deptno FROM dept d WHERE d.dname ='SALES');   

--사원테이블에 존재하는 사원이면 사원의 급여를 10% 인상하고, 존재하지 않는 사원이면 사원테이블에 정보를 입력한다
merge into emp_cp ec
using emp e
on (ec.ename = e.ename)
when matched then
update set ec.sal = nvl(ec.sal*1.1,0)
when not matched then
insert(ec.empno, ec.deptno,ec.sal)values(e.empno, e.deptno, e.sal);

SELECT e.empno, e.ename, e.sal, d.dname, d.loc 
FROM emp e, dept d 
WHERE e.deptno =d.deptno and e.deptno =20; 





