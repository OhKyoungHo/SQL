
CREATE TABLE dept AS SELECT * FROM scott.dept;
ALTER TABLE dept
ADD CONSTRAINT pk_dept_deptno PRIMARY KEY ( deptno );

CREATE TABLE student
(
    no       number(4),
    name     varchar2(9)  not null,
    gender   varchar2(10),
    addr     varchar2(30),   
    jumin    varchar2(15) not null,
   deptno     number(2)
);

--학번 컬럼에 기본키(primary key) 제약조건 추가
ALTER TABLE student ADD CONSTRAINT pk_student_no PRIMARY KEY(no);
--주민번호 컬럼에서 NOT NULL 제약조건 삭제
ALTER TABLE student MODIFY(  jumin    varchar2(14) );
--주소 컬럼에 디폴트 제약조건으로 “서울” 추가
ALTER TABLE student MODIFY(addr     varchar2(21) DEFAULT'서울');
--성별 컬럼에 체크 제약조건으로 “남성”, “여성” 추가
ALTER TABLE student ADD CONSTRAINT ck_STUDENT_GENDER CHECK(gender in ('남성','여성')); 

INSERT INTO student(no, name, gender, addr, jumin ) VALUES('1111', '김태희', '여성', '서울시 강남구', '801212-1234567' );
INSERT INTO student(no, name, jumin ) VALUES('2222', '송혜교', '881212-1234567');

INSERT INTO student(no, name, jumin ) VALUES('1111', '강동원', '881212-1234567');

INSERT INTO student(no, name, gender, jumin ) VALUES('3333', '하정우', '남자', '830303-1234567');

INSERT INTO student(no, name, addr, jumin ) VALUES('4444', '김새론', '서울시 서초구', '990909-1234567');

INSERT INTO student(no, name, addr, deptno ) VALUES('8888', ‘이병헌', '서울시 한강', 50);   --주소 50 존재하지 않은

CREATE TABLE library
(
    rent_id       number(2),
    book_id     varchar2(10)  not null,
    hakbun        number(4),
    CONSTRAINT pk_library_rent_id PRIMARY KEY(rent_id),
    CONSTRAINT fk_library_no FOREIGN KEY(hakbun) REFERENCES student(no)
);

INSERT INTO library ( rent_id, book_id, hakbun ) VALUES( 1, 'bk001', '1111' );
INSERT INTO library ( rent_id, book_id, hakbun ) VALUES( 2, 'bk002', '2222' );
INSERT INTO library ( rent_id, book_id, hakbun ) VALUES( 3, 'bk003', '3333' );
INSERT INTO library ( rent_id, book_id, hakbun ) VALUES( 4, 'bk004', '4444' );
INSERT INTO library ( rent_id, book_id, hakbun ) VALUES( 5, 'bk005', '5555' );



DROP TABLE student;
DROP TABLE library;
DROP TABLE dept;
------------------------------------------------------------

CREATE TABLE DEPT(

DEPTID NUMBER(5), 
DEPTNAME VARCHAR(50), 
CONSTRAINT PK_DEPT_DEPTID PRIMARY KEY(DEPTID)
);

?

CREATE TABLE EMP(

EMPID NUMBER(5) , 
NAME VARCHAR2(20) , 
RESID CHAR(14) , 
GENDER VARCHAR2(10) , 
AGE NUMBER(5) , 
DEPTID NUMBER(5) NOT NULL, 
CONSTRAINT PK_EMP_EMPID PRIMARY KEY (EMPID), 
CONSTRAINT UK_EMP_RESID UNIQUE (RESID), 
CONSTRAINT EMP_CK_GENDER CHECK (GENDER IN ('남성', '여성')), 
CONSTRAINT FK_DEPTNO FOREIGN KEY (DEPTID) 
REFERENCES DEPT(DEPTID) ON DELETE CASCADE
--ON DELETE CASCADE : 옵션을 적용하면 부모 테이블에서 row 를 삭제할 경우 연결된 자식 테이블의 row 가 함께 삭제됩니다

);

-- INSERT (TABLE: DEPT)

INSERT INTO DEPT(DEPTID, DEPTNAME) VALUES (10001, 'IT팀');

INSERT INTO DEPT(DEPTID, DEPTNAME) VALUES (10002, '생산운영팀');

INSERT INTO DEPT(DEPTID, DEPTNAME) VALUES (10003, '생산기술팀');

-- INSERT (TABLE: EMP)

INSERT INTO EMP(EMPID, NAME, RESID, GENDER, AGE, DEPTID) 
VALUES (30001, '최가은', '881012-1187527', '여성', 32, 10001);

INSERT INTO EMP(EMPID, NAME, RESID, GENDER, AGE, DEPTID)
VALUES (30002, '김효준', '850712-1000007', '남성', 35, 10002);

INSERT INTO EMP(EMPID, NAME, RESID, GENDER, AGE, DEPTID)
VALUES (30003, '서종균', '881112-1187527', '남성', 32, 10003);

?-- TEST DML (DELETE)
DELETE FROM DEPT WHERE DEPTID = 10003;     --부서 이름 다 사라짐

?-- SELECT ALL (BOTH)
SELECT * FROM DEPT;
SELECT * FROM EMP;

-- DROP (BOTH)
DROP TABLE EMP;
DROP TABLE DEPT;

CREATE TABLE DEPT(

DEPTID NUMBER(5), 
DEPTNAME VARCHAR(50), 
CONSTRAINT PK_DEPT_DEPTID PRIMARY KEY(DEPTID)
);

?

CREATE TABLE EMP(

EMPID NUMBER(5) , 
NAME VARCHAR2(20) , 
RESID CHAR(14) , 
GENDER VARCHAR2(10) , 
AGE NUMBER(5) , 
DEPTID NUMBER(5) NOT NULL,
CONSTRAINT PK_EMP_EMPID PRIMARY KEY (EMPID), 
CONSTRAINT UK_EMP_RESID UNIQUE (RESID), 
CONSTRAINT EMP_CK_GENDER CHECK (GENDER IN ('남성', '여성')), 
CONSTRAINT FK_DEPTNO FOREIGN KEY (DEPTID) 
REFERENCES DEPT(DEPTID) ON DELETE CASCADE
);
-------------------------------------
CREATE TABLE DEPT(

DEPTID NUMBER(5)

, DEPTNAME VARCHAR(50)

, CONSTRAINT PK_DEPT_DEPTID PRIMARY KEY(DEPTID)

);

?

CREATE TABLE EMP(

EMPID NUMBER(5) 

, NAME VARCHAR2(20) 

, RESID CHAR(14) 

, GENDER VARCHAR2(10) 

, AGE NUMBER(5) 

, DEPTID NUMBER(5) 

, CONSTRAINT PK_EMP_EMPID PRIMARY KEY (EMPID)

, CONSTRAINT UK_EMP_RESID UNIQUE (RESID)

, CONSTRAINT EMP_CK_GENDER CHECK (GENDER IN ('남성', '여성'))

, CONSTRAINT FK_DEPTNO FOREIGN KEY (DEPTID) 

REFERENCES DEPT(DEPTID) ON DELETE SET NULL  --하위테이블의 reference값이  NULL 값으로 변경되면서 참조무결성을 유지
);


?

-- INSERT (TABLE: DEPT)

INSERT INTO DEPT(DEPTID, DEPTNAME)

VALUES (10001, 'IT팀');

INSERT INTO DEPT(DEPTID, DEPTNAME)

VALUES (10002, '생산운영팀');

INSERT INTO DEPT(DEPTID, DEPTNAME)

VALUES (10003, '생산기술팀');

?

-- INSERT (TABLE: EMP)

INSERT INTO EMP(EMPID, NAME, RESID, GENDER, AGE, DEPTID)

VALUES (30001, '최가은', '881012-1187527', '여성', 32, 10001);

INSERT INTO EMP(EMPID, NAME, RESID, GENDER, AGE, DEPTID)

VALUES (30002, '김효준', '850712-1000007', '남성', 35, 10002);

INSERT INTO EMP(EMPID, NAME, RESID, GENDER, AGE, DEPTID)

VALUES (30003, '서종균', '881112-1187527', '남성', 32, 10003);


-- SELECT ALL (BOTH)

SELECT * FROM DEPT;

SELECT * FROM EMP;

-- TEST DML (DELETE)

DELETE FROM DEPT WHERE DEPTID = 10003;  --부서 번호만 null로 바뀜






