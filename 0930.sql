--------------------------------------EMP---------------------------------------------------------
-- 8000번 사원으로 <본인이름>과 급여 10000 을 저장하세요

INSERT INTO emp(empno, ename, sal) VALUES(8000, '홍길자', 10000);

SELECT *FROM emp;

--7788 사원으로 <본인이름>과 급여 10000 을 저장하세요

INSERT INTO emp(empno, ename, sal) VALUES(7788, '오경호', 10000);  --사번이 겹쳤기 때문에(키가 동일한 값이여서 충돌) 오류발생

INSERT INTO emp(empno, ename, sal, deptno) VALUES(8001, '홍길국', 10000, 20);

SELECT *FROM emp;

INSERT INTO emp(empno, ename, sal, deptno) VALUES(8002, '홍길동', 10000, 50);--dept(참조키)에 50이 존재하지 않음 오류발생

---------------------------------------------info-tab----------------------------------------------

INSERT INTO info_tab(tel, name, jumin, gender, age,home) VALUES('032' , '홍자', '801212', '남자', 33, '제주');    --info_tab에 정보 넣기

SELECT *FROM info_tab;

INSERT INTO info_tab VALUES('032' , '홍자', '801212', '남자', 33, '제주'); -- 전체 컬럼을 넣을 때 앞에 넣어야할 컬럼명을 안써도 된다, 단 순서대로 들어가게 된다. 그래서 권장하지 않음!, 그냥 다쓰는게 좋다!

INSERT INTO info_tab(TEL,NAME) VALUES('1001','홍길동' );

INSERT INTO info_tab(TEL,NAME) VALUES('1002','김길동' );

INSERT INTO info_tab(TEL,NAME) VALUES('1002','둘리' );

INSERT INTO info_tab(NAME, JUMIN) VALUES('김길동' , '901212-1234567');

INSERT INTO info_tab(GENDER, AGE) VALUES('남자', 22);

SELECT *FROM info_tab;


DELETE from INFO_TAB;
COMMIT;
ALTER TABLE info_tab ADD CONSTRAINT pk_info_tel PRIMARY KEY(tel);   --모든 제약 조건은 DATA DICTIONARY에 저장하는데, 제약 조건 이름을 의미 있게 부여하면 참조하기 쉽기에 규칙적인 제약조건이름을 권장한다.

INSERT INTO info_tab(TEL,NAME) VALUES('1001','홍길동' );

INSERT INTO info_tab(TEL,NAME) VALUES('1002','김길동' );

INSERT INTO info_tab(TEL,NAME) VALUES('1002','둘리' );    --TEL을 키로 잡아서 같은 값이 겹치기 때문에 입력되지 않음

INSERT INTO info_tab(NAME, JUMIN) VALUES('김길동' , '901212-1234567');--TEL이 없어서 입력 불가능

INSERT INTO info_tab(GENDER, AGE) VALUES('남자', 22);--TEL이 없어서 입력 불가능

SELECT *FROM info_tab;

DROP TABLE INFO_TAB;    --info_tab 자체의 뼈대 및 내용 삭제

-----------------------------------------------------------------------------------------------
-- ALTER TABLE info_tab ADD CONSTRAINT pk_info_tel PRIMARY KEY(tel);   --모든 제약 조건은 DATA DICTIONARY에 저장하는데, 제약 조건 이름을 의미 있게 부여하면 참조하기 쉽기에 규칙적인 제약조건이름(PK)을 권장한다.
-- PRIMARY KEY는 null값 허용하지 않고 유일하게 식별
-- PRIMARY 값은 반드시 있어야 입력가능
CREATE TABLE info_tab 
(
    name    varchar2(10) NOT NULL,  -- 무조건 입력해야 한다.(필수 입력사항)
    jumin   char(15),
    tel     varchar2(20),
    gender  varchar2(10),
    age     number(3),
    home    varchar2(20),
    CONSTRAINT pk_info_tel PRIMARY KEY (tel)
);

INSERT INTO info_tab(TEL,NAME) VALUES('1001','홍길동' );   --입력가능

INSERT INTO info_tab(TEL,NAME) VALUES('1002','김길동' );   --입력가능

INSERT INTO info_tab(TEL,NAME) VALUES('1002','둘리' );    --TEL을 PK 값이 겹치기 때문에 입력되지 않음

INSERT INTO info_tab(NAME, JUMIN) VALUES('김길동' , '901212-1234567');--PK(TEL)가 없어서 입력 불가능

INSERT INTO info_tab(GENDER, AGE) VALUES('남자', 22);     --PK(TEL)가 없어서 입력 불가능,이름에 NULL 입력 불가
INSERT INTO info_tab(TEL, GENDER, AGE) VALUES(9999,'남자', 22);   --이름에 NULL 입력 불가

DROP TABLE INFO_TAB; 

--------------------------------------------------------------------------------------
CREATE TABLE info_tab 
(
    name    varchar2(10), 
    jumin   char(15),
    tel     varchar2(20),
    gender  varchar2(10),
    age     number(3),
    home    varchar2(20),
    CONSTRAINT pk_info_tel PRIMARY KEY (tel)
);
--제약 조건 수정(name에 null 입력 불가)
ALTER  TABLE   info_tab  MODIFY  ( name varchar2(10) not null  );

--제약 조건 추가
ALTER TABLE info_tab ADD CONSTRAINT uq_info_jumin UNIQUE(jumin);

--UNIQUE은 입력하지 않아도 된다, 유일하게 식별하는 값만 허용 -> 중복허용안함,  ( PRIMARY KEY와 유사하나 null값 허용됨 )
--→UNIQUE는 NULL로 입력 가능(무조건 입력해야 하는 건 아님)하고, 단, 값이 겹치면 안된다. 
INSERT INTO info_tab(TEL,NAME, JUMIN) VALUES('20001' , '홍실이', '990101'); 
INSERT INTO info_tab(TEL,NAME, JUMIN) VALUES('20002' , '홍돌이', '990101'); --주민 번호에 UNIQUE를 걸어놓아서 충돌발생, 입력불가
INSERT INTO info_tab(TEL,NAME) VALUES('20003' , '홍홍이');--해당 경우에는 조건에 JUMIN을 넣지 않았고, JUMIN값을 NULL값으로 넣어도 되기 때문에 입력 가능

--CHECK 이용하기(제한적인 입력처리)
ALTER TABLE info_tab ADD CONSTRAINT ck_info_gender CHECK(gender in ('남성', '여성')); 

INSERT INTO info_tab(TEL,NAME, gender) VALUES('10001' , '홍돌이', '남성'); 
INSERT INTO info_tab(TEL,NAME, gender) VALUES('30001' , '홍숙이', '남자'); --'남성'만 들어갈 수 있도록 설정
INSERT INTO info_tab(TEL,NAME, gender) VALUES('30001' , '홍숙이', '여성');

ALTER TABLE info_tab MODIFY(gender varchar2(6) default '남성');

INSERT INTO info_tab(tel, name) VALUES('7777','홍이');

INSERT INTO info_tab( name, tel, jumin ) VALUES('갑순이', '02-777-4444', '990909-1234567');

INSERT INTO info_tab( name, tel, jumin, gender, age, home ) VALUES('갑갑이','03-555-5555', '880808-1234567', '남자', 27,'경기');-- CHECK 설정, 남자로 설정되어서 입력 불가

?
INSERT INTO info_tab( name, tel, jumin, gender, age, home ) VALUES('홍길동','03-031-0310', '900909-1234567', '남성', 27,'경기'); 

?
INSERT INTO info_tab( name, jumin) VALUES('홍길자', '550505-1234567'); --전화번호(PK)가 없어서 입력 불가

INSERT INTO info_tab( tel, jumin ) VALUES('031-777-7777', '700707-1234567');    --이름 입력 안해서 입력 불가

INSERT INTO info_tab( name, tel, jumin ) VALUES('갑동이', '031-000-0000', '700707-1234567'); --입력 가능

DROP TABLE INFO_TAB; 

------------------------------------------------------------------------------------------------
CREATE TABLE info_tab 
(
    name    varchar2(10) NOT NULL, 
    jumin   char(15),
    tel     varchar2(20),
    gender  varchar2(10) DEFAULT '남성',  -- 제약조건은 아니지만, 입력값이 없을 때 디폴트 설정값으로 자동 입력됨
    age     number(3),
    home    varchar2(20),
    deptno  number(2),
    CONSTRAINT pk_info_tel PRIMARY KEY (tel),   --tel을 pk설정
    CONSTRAINT uq_info_jumin UNIQUE (jumin),     -- jumin을 unique로 설정
    CONSTRAINT ck_info_gender CHECK (gender IN('남성', '여성')),    --GENDER를 CHECK 설정
    CONSTRAINT fk_info_deptno FOREIGN KEY (deptno) REFERENCES dept(deptno)  -- 다른 테이블의 PK를 참조
);

INSERT INTO info_tab(tel, name, deptno) VALUES('7777', '맹이', 20);
INSERT INTO info_tab(tel, name, deptno) VALUES('8888', '꽁이', 22);   --오류발생 DEPT에 22 값이 없음, 입력불가
INSERT INTO info_tab(tel, name) VALUES('9999', '짱이');  






