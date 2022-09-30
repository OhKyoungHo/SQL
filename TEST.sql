--1번
CREATE TABLE sawon
(
    sabun    number(6),
    sawon_name   varchar2(15),
    ubmu     varchar2(30),
    weolgub  number(10,2),
    buseo     number(3)
);
--2번  위의 테이블에서 sabun을 기본키로 설정
ALTER TABLE sawon ADD CONSTRAINT pk_sawon_sabun PRIMARY KEY(sabun);

--3번 최대 한글 10자리의 jiyeok 컬럼을 추가하되 NULL 값이 입력되지 않도록 지정
ALTER TABLE sawon  ADD( jiyeok varchar2(30) not null);

SELECT *FROM sawon;

--4번 weolgub 컬럼은 정수형 7자리로 변경
ALTER  TABLE  sawon  MODIFY  (  weolgub  number(7) );

--5번 ubmu컬럼은 ‘개발’, ‘유지보수’, ‘관리’ 만 데이터 값으로 입력되도록 지정
ALTER TABLE sawon ADD CONSTRAINT ck_sawon_ubmu CHECK(ubmu in ('개발', '유지보수', '관리')); 

SELECT *FROM sawon;

--6번 ubmu컬럼에 데이터가 입력이 안될 경우 디폴드값으로 ‘개발’을 설정
ALTER  TABLE   sawon  MODIFY  ( ubmu  varchar2(30) default '개발'  );

--7번 buseo 테이블을 생성하세요(buseo_no는 숫자 3자로 이루어진 번호로 기본키,buseo_name은 최대 한글 10자리)
CREATE TABLE buseo 
(
buseo_no number(3),
buseo_name varchar2(30),
CONSTRAINT pk_buseo_no PRIMARY KEY (buseo_no)
);

--8번 sawon 테이블의 buseo 컬럼을 buseo 테이블의 buseo_no를 참조하는 외래키로 설정
ALTER TABLE sawon ADD CONSTRAINT fk_sawon_buseo FOREIGN KEY (buseo) REFERENCES buseo(buseo_no);

--9번 buseo 테이블에 데이터 입력
INSERT INTO buseo(buseo_no, buseo_name) VALUES(101,'소프트웨어유지보수부');
INSERT INTO buseo(buseo_no, buseo_name) VALUES(202,'관리부'); 
INSERT INTO buseo(buseo_no, buseo_name) VALUES(303,'인적자원부'); 

--10번 sawon 테이블에 데이터 입력
INSERT INTO sawon(sabun, sawon_name, weolgub, buseo, jiyeok) VALUES(8001, '홍길동이군', 100000,101, '부산'); 
INSERT INTO sawon(sabun, sawon_name, ubmu, weolgub, buseo, jiyeok) VALUES(8002, '홍길자', '사무', 200000, 202, '인천'); --'사무'가 범위에 들어가지 않음
INSERT INTO sawon(sabun, sawon_name, ubmu,  buseo, jiyeok) VALUES(8003, '홍길순', '개발', 111, '대전'); --부서가 범위에 없어서 불가
INSERT INTO sawon(sabun, sawon_name,  weolgub,  jiyeok) VALUES(8004, '홍길석', 12345678,  '서울'); --숫자가 8자리라 불가 
INSERT INTO sawon(sabun, sawon_name, ubmu,  buseo, jiyeok) VALUES(8005, '홍길철', '유지보수', 303, '판교'); 

--11번 sawon 테이블에서 jiyeok 컬럼을 제거
ALTER TABLE sawon  DROP(jiyeok );

--12번 buseo 테이블에서 buseo 명이 ‘인적자원부’인 행을 삭제
--다른 자료도 buseo를 공유하고 있기때문에 삭제할 수 없다.★
DELETE FROM sawon WHERE buseo ='인적자원부';

--13번 sawon 테이블이 모든 내용을 삭제하고 저장공간을 해제
TRUNCATE TABLE sawon; 

--14번 1~8 단계까지를 각각의 테이블을 각각 하나의 CREATE 문으로 작성
CREATE TABLE sawon
(
    sabun    number(6) ,
    sawon_name   varchar2(15),
    ubmu     varchar2(30) default '개발',
    weolgub  number(7),
    buseo     number(3),
    jiyeok varchar2(30) not null,
    CONSTRAINT pk_sawon_sabun PRIMARY KEY(sabun),
    CONSTRAINT ck_sawon_ubmu CHECK(ubmu in ('개발', '유지보수', '관리')),
    CONSTRAINT fk_sawon_buseo FOREIGN KEY (buseo) REFERENCES buseo(buseo_no) --참조를 하기위해서는 해당 키가 기본키(PK)로 설정 되어 있어야 한다.
);

CREATE TABLE buseo 
(
buseo_no number(3),
buseo_name varchar2(30),
CONSTRAINT pk_buseo_no PRIMARY KEY (buseo_no)
);
-------------------
DROP TABLE sawon;
DROP TABLE buseo;


