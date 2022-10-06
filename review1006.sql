--1. 사원명에 ‘L’자가 있는 사원에 대해 이름, 업무, 부서명, 위치를 출력
--일반버전
SELECT e.ename ename, e.job job, d.dname danme, d.loc loc
FROM emp e, dept d
WHERE e.deptno = d.deptno and e.ename LIKE '%L%';
--GROUP BY
--HAVING 
--ORDER BY
--표준화버전
?SELECT e.ename ename, e.job job, d.dname danme, d.loc loc
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
WHERE e.ename LIKE '%L%';

?
--2. 관리자보다 먼저 입사한 사원에 대해 이름, 입사일, 관리자 이름, 관리자 입사일을 출력
--일반버전
SELECT e1.ename, e1.hiredate, e2.ename , e2.hiredate
FROM emp e1,emp e2
WHERE e1.mgr = e2.empno and e1.hiredate< e2.hiredate;
--표준화
SELECT e1.ename, e1.hiredate, e2.ename , e2.hiredate
FROM emp e1 INNER JOIN  emp e2
ON e1.mgr = e2.empno and e1.hiredate< e2.hiredate;
??

--3. 아래의 결과를 출력 ( 관리자가 없는 KING을 포함하여 모든 사원을 출력 )
--일반
SELECT e1.empno, e1.ename , e1.mgr , e2.empno , e2.ename 
FROM emp e1,emp e2
WHERE e1.mgr = e2.empno(+) ;
--표준화
SELECT e1.empno empno, e1.ename ename, e1.mgr mgr, e2.empno empno , e2.ename ename
FROM emp e1 LEFT OUTER JOIN emp e2
ON e1.mgr = e2.empno;








?