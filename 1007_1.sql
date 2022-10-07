--VIEW
CREATE OR REPLACE VIEW v_emp  AS select empno, ename, deptno from emp;

SELECT * FROM v_emp;
DESC v_emp;

INSERT INTO v_emp VALUES(1000,'홍길동',20); 
SELECT * FROM v_emp;
SELECT * FROM emp;
--가상테이블에 내용을 입력해도 원본 테이블에 내용이 들어간다.

INSERT INTO v_emp VALUES(1000,'홍홍이',20); --원본의 PK 조건에 걸려서 입력 불가
INSERT INTO v_emp VALUES(1000,'홍홍이',90); --원본의 FK 조건에 걸려서 입력 불가

--VIEW

CREATE OR REPLACE VIEW v_emp  AS 
select empno, ename, deptno from emp
WITH READ ONLY;

INSERT INTO v_emp VALUES(1000,'홍홍이',30); --READ ONLY(읽기전용)이 되어서 입력 불가


--[ 연습 ] EMP 테이블에서 30번 부서만 EMPNO를 EMP_NO로 ENAME을 NAME로 SAL를 SALARY로 바꿔서 EMP_30 뷰를 생성하시오

CREATE OR REPLACE VIEW emp_30  AS 
select empno EMP_NO, ename NAME, SAL SALARY
from emp WHERE deptno=30
WITH READ ONLY;

SELECT * FROM emp_30;

Create or replace view v_emp_info as
select e.empno empno, e.ename ename, d.dname dname 
from emp e, dept d
where e.deptno=d.deptno;

SELECT * FROM v_emp_info;

INSERT INTO v_emp_info(empno, ename, dname) VALUES(3333,'맹꽁이',30);  
--v_emp_info는 두 테이블이 합쳐져서 나온 것이라 하나의 뷰에서 두개의 테이블에 영향 줄 수 없음

INSERT INTO v_emp_info(empno, ename) VALUES(3333,'맹꽁이');  
DELETE FROM v_emp_info WHERE empno=7788;
--view에서 데이터 삭제한 경우 원본 테이블에서도 삭제됨
-- view는 읽기 전용으로 만드는게 좋다!

--[ 연습 ] 부서별로 부서명, 최소급여, 최대 급여, 부서의 평균 급여를 포함하는 V_DEPT_SUM 뷰를 생성하여라.
Create or replace view V_DEPT_SUM as
select  d.dname 부서명, min(e.sal) 최소급여, max(e.sal) 최대급여, round(avg(e.sal)) 부서의_평균급여
from emp e, dept d
where e.deptno=d.deptno
GROUP BY d.dname
WITH READ ONLY;

SELECT * FROM V_DEPT_SUM;

INSERT INTO emp(empno,ename,sal,deptno) VALUES(4444,'호이', 9900,20); 
--VIEW는 원본의 테이블을 참조하는 것이라는 것을 볼 수 있다.

CREATE  SEQUENCE   seq_temp;
SELECT seq_temp.NEXTVAL FROM DUAL;  --다음의 시퀄스 값
SELECT seq_temp.CURRVAL FROM DUAL;  --현재의 시퀄스 값

--5000번부터 10씩 증가하는 자동증가수(시퀀스)
CREATE  SEQUENCE   seq_temp2
start with 5000 
increment by 10;

INSERT INTO emp(empno, ename) VALUES(seq_temp2.NEXTVAL,'박씨');

SELECT seq_temp2.CURRVAL FROM DUAL;

--INDEX
DESC EMP;
select empno, ename, job, rowid from emp;

CREATE TABLE emp_copy2 as select*from emp;


