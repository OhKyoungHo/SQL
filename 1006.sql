-- 전체 사원들 중 평균 급여보다 낮은 급여를 받는 사원의 명단을 조회
--평균 급여 구하기
select round(avg(sal)) from emp;

--그 평균 급여보다 낮은 사원 정보 조회
select ename, sal from emp 
where sal < (select round(avg(sal)) from emp );
--서브쿼리는 ()로 묶어주는게 좋다
--서브쿼리는 오른쪽에 써주는게 좋다.
--서브쿼리는 단일 행인 경우만 비교연산자 가능
--복수행인 경우 IN, NOT IN, ANY, ALL, EXISTS

-- 월급이 가장 많은 사원의 정보 조회
select MAX(sal) from emp;

select * 
from emp 
where SAL >=(select MAX(sal) from emp);

-- 평균 급여보다 높고 최대 급여보다 낮은 월급을 받는 사원의 정보를 조회
select * 
from emp 
where SAL >(select round(avg(sal)) from emp ) and SAL <(select MAX(sal) from emp);
--from에 가상테이블을 넣어서 join하는 식으로 (from에 서브쿼리 넣는 방식)
select e.*
from emp e, (select round(avg(sal)) avg, MAX(sal) max from emp) ext
where e.sal>ext.avg and e.sal <ext.max;

-- 월급순으로 상위 10명의 명단을 출력
SELECT*
FROM(SELECT ename, sal FROM emp ORDER BY sal desc) e
WHERE rownum<11;

select * 
from (select ename, sal from emp WHERE SAL !=0 ORDER BY SAL DESC) ext
WHERE rownum<11;

select * 
from  (select nvl(sal,0) from emp WHERE NVL(SAL,0)!=0 ORDER BY SAL DESC) ext
WHERE rownum<11;

select rownum, e.* 
from emp e
WHERE rownum<11 and SAL !=0
ORDER BY SAL DESC;

?

--1. SCOTT의 급여보다 많은 사원의 정보를 사원번호, 이름, 담당업무, 급여를 출력
SELECT   empno , ename , job , sal 
FROM    emp
WHERE   sal > (select sal from emp where ename = 'SCOTT');

SELECT empno, ename, job, sal
FROM emp
WHERE SAL >3000;
?
--?2. 30번 부서의 최소 급여보다 각부서의 최소 급여가 높은 부서를 출력
SELECT deptno, min(sal)
FROM emp
GROUP BY deptno
HAVING min(sal) >(SELECT min(sal) FROM emp WHERE deptno=30);

--3.업무별로 평균 급여 중에서 가장 적은 급여를 가진 직업을 출력
SELECT job, avg(sal)
FROM emp
GROUP BY job
HAVING avg(sal) = (SELECT min(avg(sal)) FROM emp GROUP BY job);

SELECT s.job, round(min(s.avg),2) min
FROM ( SELECT job, avg(sal) avg FROM emp GROUP BY job ORDER BY avg(sal) ) s 
WHERE ROWNUM = 1
GROUP BY s.job;

SELECT  e.JOB, s.MIN(s.avg)
FROM emp e, (SELECT avg(sal) avg FROM emp GROUP BY JOB )s;

-- 4. 사원번호가 7521의 업무와 같고 사번 7934인 직원보다 급여를 많이 받는 사원의 정보를 출력
SELECT e.*
FROM emp e, ( SELECT job FROM emp WHERE empno = 7521 ) e1, ( SELECT sal FROM emp WHERE empno = 7934 ) e2
WHERE e.job = e1.job AND e.sal > e2.sal;


--?5. 'WARD'와 부서와 업무가 같은 사원 명단 출력
SELECT e.*
FROM emp e, 
    ( SELECT * FROM emp WHERE ename ='WARD' ) s1
WHERE e.deptno = s1.deptno AND e.job= s1.job;

-- 업무별로 최소 급여를 받는 사원의 정보를 사원번호, 이름, 담당업무, 급여를 출력
SELECT empno, ename, job, sal
FROM emp e
WHERE  (job,sal) in( SELECT job,min(sal) FROM emp GROUP BY JOB ) ;

INSERT INTO emp(empno, ename, job, sal) VALUES(9999,'테스트', 'CLERK', 1250);
    
-- 10번 부서 사원들의 업무와 동일한 직원들 검색
SELECT job FROM emp WHERE deptno=10;
SELECT ename, job
FROM emp
WHERE job in (SELECT job FROM emp WHERE deptno=10);

SELECT job FROM emp WHERE deptno=10;
SELECT ename, job
FROM emp
WHERE job = any(SELECT job FROM emp WHERE deptno=10);

-- 적어도 한명의 사원으로부터 보고를 받을 수 있는 사원의 정보를 사원번호, 이름, 업무를 출력
SELECT e1.ename ,e1.mgr, e2.ename, e2.empno FROM emp e1, emp e2 WHERE e1.mgr = e2.empno;

SELECT empno, ename, job
FROM emp e1
WHERE exists (SELECT * FROM emp e2 WHERE e1.empno = e2.mgr);
--ford/blake/king/jones/scott/clark
SELECT e3.empno, e3.ename, e3.job
FROM emp e3
WHERE e3.empno in (SELECT e2.empno FROM emp e1,emp e2 WHERE e1.mgr = e2.empno);

SELECT e3.empno, e3.ename, e3.job
FROM emp e3
WHERE e3.empno in (SELECT e1.empno FROM emp e1,emp e2 WHERE e2.mgr = e1.empno);
--비교는 1대1 대응
--서브쿼리에서 두개를 뽑아내면 비교대상이 많아져서 TOO MANY VALUES 오류 발생 

--일반 사원을 출력
SELECT empno, ename, job
FROM emp e1
WHERE not exists (SELECT * FROM emp e2 WHERE e1.empno = e2.mgr);

SELECT e3.empno, e3.ename, e3.job
FROM emp e3
WHERE e3.empno not in (SELECT e1.empno FROM emp e1,emp e2 WHERE e2.mgr = e1.empno);



