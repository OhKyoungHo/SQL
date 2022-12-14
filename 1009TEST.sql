--4
CREATE TABLE SCOTT_EMP 
(
    ENO         NUMBER(4),
    ENAME       VARCHAR2(10),
    JOB         VARCHAR2(19),
    MANAGER     NUMBER(4),
    HIREDATE    DATE,
    SALARY      NUMBER(7,2),
    COMMISSION  NUMBER(7,2),
    DNO         NUMBER(2),
    CONSTRAINT pk_scott_emp_eno PRIMARY KEY(eno),
    CONSTRAINT fk_scott_emp_dno FOREIGN KEY (dno) REFERENCES scott_dept(dno)
);

CREATE TABLE SCOTT_DEPT 
(
    DNO     NUMBER(2),
    DNAME   VARCHAR2(14),
    LOC     VARCHAR2(13),
    CONSTRAINT pk_scott_dept_dno PRIMARY KEY(dno)
);
--5
CREATE TABLE SCOTT_SALG
(
    GRADE     NUMBER,
    LOSAL     NUMBER,
    HISAL     NUMBER
);
--6
INSERT INTO SCOTT_DEPT(DNO, DNAME, LOC) VALUES(10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO SCOTT_DEPT(DNO, DNAME, LOC) VALUES(20, 'RESEARCH', 'DALLAS');
INSERT INTO SCOTT_DEPT(DNO, DNAME, LOC) VALUES(30, 'SALES', 'CHICAGO');
INSERT INTO SCOTT_DEPT(DNO, DNAME, LOC) VALUES(40, 'OPERATIONS', 'BOSTON');

--7
INSERT INTO SCOTT_EMP(ENO, ENAME, JOB, MANAGER, HIREDATE, SALARY, COMMISSION, DNO) VALUES(7369, 'SMITH','CLERK',7902, '80/12/17',800, NULL,20);

--8
INSERT INTO SCOTT_SALG(GRADE, LOSAL, HISAL) VALUES(1, 700, 1200);

--9
DELETE from SCOTT_EMP;
DELETE from SCOTT_DEPT;
DELETE from SCOTT_SALG;

TRUNCATE TABLE SCOTT_EMP;
TRUNCATE TABLE SCOTT_DEPT;
TRUNCATE TABLE SCOTT_SALG;

--10
DROP TABLE SCOTT_EMP;
DROP TABLE SCOTT_DEPT;
DROP TABLE SCOTT_SALG;
