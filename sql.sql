--SQL-문제-1) 아래 스키마를 보고 평점이 3.0 이상인 학생들의 이름을 보여주는 SQL작성하시오
--
SELECT s.학번, MIN(이름)                --알파벳순으로 하기 위해서
FROM  student s, enroll e
WHERE s.학번 = e.학번
GROUP BY s.학번
HAVING AVG(e.학점)>=3.0;

SELECT e.deptno deptno, e.dname dname, d.deptno deptno, d.dname dname
FROM emp e FULL OUTER JOIN dept d
ON  e.deptno = d.deptno;