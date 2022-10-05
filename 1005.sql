-----JOIN-----
--사원테이블(EMP)에 사원명과 부서테이블(DEPT)에 그 사원의 부서명을 출력
SELECT ename, dname
FROM  emp, dept;

SELECT emp.ename, dept.dname, dept.deptno
FROM emp,dept;

--JOIN : 연결고리가 같은 것끼리 묶어서
SELECT emp.ename, dept.dname, dept.deptno
FROM emp,dept
WHERE emp.deptno = dept.deptno;
--별칭으로 써도 문제없음
SELECT e.ename, d.dname, d.deptno
FROM emp e,dept d
WHERE e.deptno = d.deptno;

--내부조인 : 양쪽의 조건을 갖췄을때 레코드 되는 것(교집합)
--예전방식
SELECT e.ename ename, d.dname dname, d.deptno deptno
FROM emp e,dept d
WHERE e.deptno = d.deptno;
--표준화 방식
SELECT e.ename ename, d.dname dname, d.deptno deptno
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno;
--WHERE(조건이 있을 경우)

--외부조인 (합집합) : 없는 데이터를 포함하여 조인
--예전 방식
SELECT e.ename ename, d.dname dname, d.deptno deptno
FROM emp e,dept d
WHERE e.deptno = d.deptno(+);

SELECT e.ename ename, d.dname dname, d.deptno deptno
FROM emp e,dept d
WHERE e.deptno(+) = d.deptno;

--양쪽다 +를 붙일 경우 오류 발생
SELECT e.ename ename, d.dname dname, d.deptno deptno
FROM emp e,dept d
WHERE e.deptno(+) = d.deptno(+);

--표준화 방식
--'+'가 오른쪽에 있을때
SELECT e.ename ename, d.dname dname, d.deptno deptno
FROM emp e LEFT OUTER JOIN dept d
ON  e.deptno = d.deptno;

--'+'가 왼쪽에 있을때
SELECT e.ename ename, d.dname dname, d.deptno deptno
FROM emp e RIGHT OUTER JOIN dept d
ON  e.deptno = d.deptno;

--양쪽다 +를 붙일 경우도 가능
SELECT e.ename ename, d.dname dname, d.deptno deptno
FROM emp e FULL OUTER JOIN dept d
ON  e.deptno = d.deptno;

-- 사원테이블(emp)에 각 사원의 매니저를 조회
-- EMP 테이블이 두개 있다고 생각해서 해보자
--  테이블 두개를 연결해서 사용

--내부조인(MGR 없는 사람은 포함되지 않음)
SELECT e1.empno, e1.ename, e1.mgr,e2.empno, e2.ename
FROM emp e1, emp e2
WHERE e1.mgr=e2.empno;

SELECT e1.empno empno, e1.ename ename, e1.mgr mgr,e2.empno empno, e2.ename ename
FROM emp e1 INNER JOIN emp e2
ON e1.mgr=e2.empno;

--외부조인(MGR 없는 사람까지 포함)
SELECT e1.empno, e1.ename , e1.mgr ,e2.empno , e2.ename
FROM emp e1 , emp e2
WHERE e1.mgr=e2.empno(+);

SELECT e1.empno empno, e1.ename ename, e1.mgr mgr,e2.empno empno, e2.ename ename
FROM emp e1 LEFT OUTER JOIN emp e2
ON e1.mgr=e2.empno;

-----집합------
--합집합
SELECT empno, ename, job, deptno FROM emp WHERE job='CLERK' --SMITH, ADAMS, JAMES, MILLER
    UNION
SELECT empno, ename, job, deptno FROM emp WHERE deptno=10; --CLARK, KING, MILLER
--합집합에 중복되는 교집합 두번 출력
SELECT empno, ename, job, deptno FROM emp WHERE job='CLERK' --SMITH, ADAMS, JAMES, MILLER
    UNION ALL
SELECT empno, ename, job, deptno FROM emp WHERE deptno=10; --CLARK, KING, MILLER
--교집합
SELECT empno, ename, job, deptno FROM emp WHERE job='CLERK' --SMITH, ADAMS, JAMES, MILLER
   INTERSECT
SELECT empno, ename, job, deptno FROM emp WHERE deptno=10; --CLARK, KING, MILLER
--차집합
SELECT empno, ename, job, deptno FROM emp WHERE job='CLERK' --SMITH, ADAMS, JAMES, MILLER
    MINUS
SELECT empno, ename, job, deptno FROM emp WHERE deptno=10; --CLARK, KING, MILLER



--1. EMP 테이블에서 사원번호, 이름, 업무, 부서번호와 DEPT 테이블에서 부서명, 근무지를 출력
SELECT e.empno empno, e.ename ename, e.job job, e.deptno deptno, d.dname dname, d.loc loc
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno;

SELECT e.empno empno, e.ename ename, e.job job, e.deptno deptno, d.dname dname, d.loc loc
FROM emp e LEFT OUTER JOIN dept d
ON e.deptno = d.deptno;

SELECT e.empno empno, e.ename ename, e.job job, e.deptno deptno, d.dname dname, d.loc loc
FROM emp e RIGHT OUTER JOIN dept d
ON e.deptno = d.deptno;

SELECT e.empno , e.ename e, e.job , e.deptno , d.dname , d.loc 
FROM emp e , dept d
WHERE e.deptno(+) = d.deptno;

SELECT e.empno , e.ename e, e.job , e.deptno , d.dname , d.loc 
FROM emp e , dept d
WHERE e.deptno = d.deptno(+);


--2. SALESMAN 사원만 사원번호, 이름, 급여, 부서명, 근무지를 출력
SELECT e.empno empno, e.ename ename, e.sal sal, e.job job,  d.dname dname, d.loc loc
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
WHERE JOB ='SALESMAN';

SELECT e.empno empno, e.ename ename, e.sal sal, e.job job,  d.dname dname, d.loc loc
FROM emp e LEFT OUTER JOIN dept d
ON e.deptno = d.deptno
WHERE JOB ='SALESMAN';

SELECT e.empno, e.ename , e.sal , e.job,  d.dname , d.loc 
FROM emp e ,dept d
WHERE e.deptno = d.deptno AND JOB ='SALESMAN';

SELECT e.empno, e.ename , e.sal , e.job,  d.dname , d.loc 
FROM emp e ,dept d
WHERE e.deptno(+) = d.deptno AND JOB ='SALESMAN';

SELECT e.empno, e.ename , e.sal , e.job,  d.dname , d.loc 
FROM emp e ,dept d
WHERE e.deptno= d.deptno(+)  AND JOB ='SALESMAN';


--3. 보너스(comm)를 받는 사원에 대해 이름, 부서명, 위치를 출력
SELECT  e.ename ename, d.dname dname, d.loc loc
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
WHERE COMM !=0;

SELECT  e.ename , d.dname , d.loc 
FROM emp e , dept d
WHERE e.deptno = d.deptno AND COMM !=0;

--4. 부서별 부서명과 급여 합계를 출력
SELECT   d.dname dname, sum(sal) as sum
FROM emp e, dept d
WHERE e.deptno = d.deptno
GROUP BY d.dname;

-- 5. 업무가 ‘MANAGER’인 사원의 정보를 이름, 업무, 부서명, 근무지를 출력 
SELECT  e.ename ename,e.JOB JOB, d.dname dname, d.loc loc 
FROM emp e, dept d
WHERE job ='MANAGER';



