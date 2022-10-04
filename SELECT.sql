-----숫자형 함수-----
-- 사원명, 급여, 월급(급여/12)를 출력하되 월급은 십단위에서 반올림하여 출력
--ROUND (n, i )N을 소숫점 I자리에서 반올림
SELECT ename, sal, ROUND(sal/12,-2) as wolgub   --12를 정수 2자리에서 반올림
FROM emp;
--정수부분에서 반올림을 원하면 -로 표현

-- 사원명, 급여, 세금(급여의 3.3%)를 원단위 절삭하고 출력
-- TRUNC (n, i ) : 숫자 n을 소숫점 i자리에서 자름
SELECT ename, sal,  TRUNC(sal*0.033,-1) as TAX  --sal*0.033를 정수 1자리에서 반올림
FROM emp;

SELECT ename, sal, sal*0.033, TRUNC(sal*0.033,-1) as TAX  
FROM emp;

-----문자형 함수-----
-- smith의 정보를 사원번호, 성명, 담당업무(소문자) 출력
--LOWER(str) : 알파벳을 소문자로 변환
--UPPER(str) : 알파벳을 대문자로 변환
SELECT empno, ename,  LOWER (JOB) as job
FROM emp
WHERE ENAME= 'SMITH';

SELECT empno, ename,  LOWER (JOB) as job
FROM emp
WHERE ENAME= UPPER('SMITH');

SELECT empno, ename,  LOWER (JOB) as job
FROM emp
WHERE LOWER(ENAME)= LOWER('smith');

-- 사원번호, 사원명(첫글자만 대문자), 담당업무(첫글자만 대문자)로 출력
--INITCAP(str) : 첫번째 글자만 대문자로 변환
SELECT empno,INITCAP (ename) , INITCAP(JOB) 
FROM emp;

-- 이름의 첫글자가 ‘K’보다 크고 ‘Y’보다 작은 사원의 정보( 사원번호, 이름, 업무, 급여, 부서번호)를 출력하되 이름순으로 정렬
----SUBSTR(str,i,n) : 문자열 중 i번째에서 n개의 일부 문자를 선택
SELECT empno, ename, sal, deptno
FROM emp
WHERE substr(ename, 1,1)>'K' AND substr(ename, 1,1)<'Y'
order by ename;     --오름차순으로...(안써도 자동으로 오름차순 정렬됨)

SELECT empno, ename, sal, deptno
FROM emp
WHERE ename>'K' AND ename<'Y';--해당 경우에는 KING까지 나와서 문제의 의도와 맞지 않음

--info_tab에서 성별 
SELECT name,substr(jumin, 8,1) as gender
FROM info_tab; 

--info_tab에서 생년월일 
SELECT name,substr(jumin, 1,6) as birth_year
FROM info_tab; 

-- 이름이 5글자 이상인 사원들을 출력
--LENGTH(str) : 문자열의 길이
SELECT *
FROM emp
WHERE LENGTH(ename)>=5;


-- 이름을 15자로 맞추고 글자는 왼쪽에 오른쪽에는 ‘*’로 채운다
-- LPAD / RPAD (str, n, ch) : n 자리수 만큼 확보 후 빈 공백에 특정 문자로 채움
SELECT RPAD(ename,15,'*')
FROM emp;

-- 급여는 10자로 맞추고 숫자는 오른쪽에 왼쪽엔 ‘-‘로 채운다
SELECT LPAD(sal,10,'-')
FROM emp;

- 양쪽 공백을 제거

select '-' || trim(' 이순신 ') || '-' as col1, 
       '-' || ltrim(' 이순신 ') || '-' as col2, 
       '-' || rtrim(' 이순신 ') || '-' as col3 
from dual;
--(*) dual : dummy 테이블로 sys user가 owner이고 모든 사용자가 사용가능.
--           임의의 값을 알고자 할 경우 유용하게 사용하는 테이블.

SELECT sysdate
FRON dual;

-- 급여를 숫자에서 ‘영일이삼사오육칠팔구’ 글자로 대체
--TRANSLATE ( column, str1, str2 ) : 문자열에서 str1을 str2로 대체
SELECT sal, TRANSLATE(SAL,'0123456789','영일이삼사오육칠팔구') as kor_sal
FROM emp;

SELECT sal, REPLACE(SAL,'0123456789','영일이삼사오육칠팔구') as kor_sal
FROM emp;-- 바뀌지 않음

-- 급여의 숫자에서 0을 ‘$’로 바꾸어 출력
--REPLACE ( column, str1, str2 ) : 문자열에서 str1을 str2로 대신
SELECT sal, REPLACE ( SAL, 0, '$') as char_sal
FROM emp;

--*****모든 공백 제거
--TRIM / LTRIM / RTRIM  : 문자를 제거  (*)양쪽 공백 제거에 사용
SELECT '    이     순     신     ' as ename
FROM dual;

select REPLACE('    이     순     신     ',' ','') as ename 
from dual;

-----날짜형 함수-----
-- 시스템의 날짜를 가져오는 함수 : SYSDATE, CURRENT_DATE, SYSTIMESTAMP, CURRENT_TIMESTAMP
-- 현재까지 근무일 수가 많은 사람 순으로 출력
SELECT *
FROM emp
ORDER BY hiredate;

--현재까지 근무일 수가 적은 사람 순으로 출력
SELECT *
FROM emp
ORDER BY hiredate desc;

SELECT ename, hiredate, sysdate - NVL(hiredate,SYSDATE)
FROM emp
ORDER BY sysdate-hiredate desc;

--ceil : 가장 큰 정수
--FLOOR : 가장 작은 정수
SELECT ename, hiredate, ceil(sysdate - hiredate)     
FROM emp
ORDER BY sysdate-hiredate desc NULLS LAST;

-- 현재까지 근무일 수가 몇 주 몇 일인가를 출력(ex, 100일 = 14주 + 2일)
--TRUNC : 날짜를 절삭
-- MOD(N2,N1) : N2에서 N1을 나눈 나머지 연산
SELECT  ename, hiredate, TRUNC((sysdate - hiredate)/7,0) as work_week,
floor(mod(sysdate - hiredate, 7)) as work_days  
FROM emp;

-- 10번 부서의 사원의 현재까지의 근무 월수를 계산 
-- MONTHS_BETWEEN : 두날짜 사이의 월수를 계산
SELECT ename, hiredate, CEIL(MONTHS_BETWEEN (sysdate,hiredate)),
                    floor(MONTHS_BETWEEN (sysdate,hiredate)),
FROM emp
WHERE DEPTNO=10;

-- 현재 날짜에서 3개월 후의 날짜 구하기
-- ADD_MONTHS : 월을 날짜에 더함
SELECT SYSDATE, ADD_MONTHS(SYSDATE,3)
FROM dual;

-- 현재 날짜에서 돌아오는 ‘월’요일의 날짜 구하기
-- NEXT_DAY : 다음요일에 대한 날짜
SELECT SYSDATE, NEXT_DAY(SYSDATE,'월요일')
FROM dual;

SELECT SYSDATE, NEXT_DAY(SYSDATE,2)
FROM dual;

SELECT SYSDATE, NEXT_DAY(SYSDATE,'mon')
FROM dual;  --monday , mon은 되지 않음

-- 현재 날짜에서 해당 월의 마지막 날짜 구하기
-- LAST_DAY : 월의 마지막 날을 계산
SELECT SYSDATE, LAST_DAY(SYSDATE)
FROM dual;

-----변환함수-----
--TO_CHAR
--:날짜를 뽑아낼때, 'YYYY', 'MM', 'DD'형태를 조합해서 사용
-- 입사일자에서 입사년도를 출력
SELECT ename, HIREDATE, EXTRACT(year from HIREDATE) as hire_year
FROM emp;

SELECT ename, hiredate, TO_CHAR(hiredate,'YYYY') as hire_year
FROM emp;

-- 입사일자를 ‘1999년 1월 1일’ 형식으로 출력
SELECT  hiredate, TO_CHAR(hiredate,'YYYY"년" MM"월" DD"일"') as hire_year
FROM emp;

-- 1981년도에 입사한 사원 검색
SELECT *
FROM emp
WHERE  TO_CHAR(hiredate,'YYYY') = 1981;

SELECT * 
FROM emp
WHERE EXTRACT(year from HIREDATE)=1981;

-- 5월에 입사한 사원 검색
SELECT *
FROM emp
WHERE  TO_CHAR(hiredate,'MM') = 5;

SELECT * 
FROM emp
WHERE EXTRACT(MONTH from HIREDATE)=5;

--81년 2월에 입사한 사원 검색
SELECT *
FROM emp
WHERE  TO_CHAR(hiredate,'YYYY/MM') = '1981/02';

--81년에 입사하지 않은 사원 검색
SELECT *
FROM emp
WHERE  TO_CHAR(hiredate,'YYYY') != 1981;

SELECT * 
FROM emp
WHERE NOT EXTRACT (year from HIREDATE)=1981;

--81년 하반기에 입사한 사원 검색
SELECT *
FROM emp
WHERE  TO_CHAR(hiredate,'YYYY/MM') > '1981/06' AND TO_CHAR(hiredate,'YYYY') < 1982 ;

SELECT *
FROM emp
WHERE  TO_CHAR(hiredate,'YYYY/MM') > '1981/06' AND TO_CHAR(hiredate,'YYYY/MM') <= '1981/12' ;

SELECT *
FROM emp
WHERE  TO_CHAR(hiredate,'YYYY/MM') > '1981/06' AND TO_CHAR(hiredate,'YYYY/MM') < '1982/01' ;

SELECT *
FROM emp
WHERE  TO_CHAR(hiredate,'YYYY/MM') BETWEEN '1981/07' AND '1981/12' ;

-- 급여 앞에 $를 삽입하고 3자리 마다 ,를 출력
SELECT ename, sal, TO_CHAR(sal,'$999,999,999,999') as dollar
FROM  emp;


-----주민번호에서 성별 구하기------
--조건문 형태
SELECT jumin, decode( substr(jumin, 8, 1), '1', '남자', '3', '남자', '여자') AS gender 
FROM info_tab;

SELECT jumin, CASE substr( jumin, 8, 1) 
    WHEN '1' THEN '남자'
    WHEN '3' THEN '남자'
    ELSE '여자'
    END as gender
FROM info_tab;

-- 부서번호가 10이면 영업부, 20이면 관리부, 30이면 IT부 그 외는 기술부로 출력
SELECT  ename, decode( deptno, 10, '영업부', 20, '관리부', 30, 'IT부', '기술부') AS NEWDEPT 
FROM emp;

SELECT  ename, CASE  deptno
    WHEN 10 THEN '영업부'
    WHEN 20 THEN '관리부'
    WHEN 30 THEN 'IT부'
    ELSE '기술부'
    END as NEWDEPT
FROM emp;


-- 업무(job)이 analyst이면 급여 증가가 10%이고 clerk이면 15%, manager이면 20%인 경우 사원번호, 사원명, 업무, 급여, 증가한 급여를 출력
SELECT  empno, ename,job, sal, decode( job, 'ANALYST', NVL(SAL,0)*1.1, 'CLERK', NVL(SAL,0)*1.15, 'MANAGER', NVL(SAL,0)*1.20) AS NEWSAL 
FROM emp;

SELECT  empno, ename,job, sal, CASE  JOB
    WHEN 'ANALYST' THEN  SAL*1.1
    WHEN 'CLERK' THEN  SAL*1.15
    WHEN 'MANAGER' THEN  SAL*1.20
    END as NEWSAL 
FROM emp;


-----------------------------------------
SELECT emp;

SELECT all job from emp;

SELECT distinct job from emp;

desc emp;
SELECT rownum, empno, ename, job from emp;
SELECT rownum, empno, ename, job from emp WHERE rownum<=5;
--ROWNUM : SELECT해온 데이터에 일련번호를 붙이는 것, 특정 집합에서 원하는 만큼의 행만 가져오고 싶을때,
-- 행의 개수를 제한 하는 용도

--업무가 'salesman'인 사람들의 월급의 평균, 총합, 최소값, 최대값을 구하기
SELECT  avg(sal) as avg, sum(sal) as sum, min(sal) min, max(sal)as max
FROM emp
WHERE job ='SALESMAN';

INSERT INTO emp(empno, ename, job) VALUES(9001, '홍길국', 'SALESMAN');

--커미션을 받는 사람들의 수
--COUNT 함수를 사용하면 NULL이 데이터로 포함되어 있을 경우, NULL데이터는 반환갯수에서 제외
SELECT COUNT(COMM) 
FROM emp
WHERE comm!=0 ;

-----데이터그룹-----
--(#) 출력 컬럼은 그룹핑하는 컬럼과 집계함수만 가능

-- 부서별로 인원수, 평균급여, 최저급여, 최고급여, 급여의 합을 구하기
SELECT deptno, COUNT(*), ceil(AVG(sal)) as AVG, min(sal) as MIN, max(sal)as MAX, sum(sal) as SUM
FROM  emp
GROUP BY DEPTNO;

SELECT deptno, COUNT(*), ROUND(AVG(sal),-2) as AVG, min(sal) as MIN, max(sal)as MAX, sum(sal) as SUM
FROM  emp
GROUP BY DEPTNO;

-- 부서별로 인원수, 평균급여, 최저급여, 최고급여, 급여의 합을 구하기 ( 부서별 급여의 합이 높은 순으로
SELECT deptno, COUNT(*), ceil(AVG(sal)) as AVG, min(sal) as MIN, max(sal)as MAX, sum(sal) as SUM
FROM  emp
GROUP BY DEPTNO 
ORDER BY sum(sal) DESC;

SELECT deptno, COUNT(*), ROUND(AVG(sal),-2) as AVG, min(sal) as MIN, max(sal)as MAX, sum(sal) as SUM
FROM  emp
GROUP BY DEPTNO 
ORDER BY sum(sal) DESC;

-- 부서별 업무별 그룹하여 부서번호, 업무, 인원수, 급여의 평균, 급여의 합을 구하기
SELECT deptno,JOB, COUNT(*), ceil(AVG(sal)) as AVG, sum(sal) as SUM
FROM  emp
GROUP BY DEPTNO, JOB ;

SELECT deptno,JOB, COUNT(*), ROUND(AVG(sal),-2) as AVG, sum(sal) as SUM
FROM  emp
GROUP BY DEPTNO, JOB ;

-- 최대 급여가 2900 이상인 부서에 대해 부서번호, 평균 급여, 급여의 합을 출력
SELECT deptno, ceil(AVG(sal)) as AVG, sum(sal) as SUM
FROM  emp
GROUP BY DEPTNO
HAVING max(sal)>=2900 ;

SELECT deptno, ROUND(AVG(sal),-2), sum(sal) as SUM
FROM  emp
GROUP BY DEPTNO
HAVING max(sal)>=2900 ;

-- 업무별 급여의 평균이 3000이상인 업무에 대해 업무명, 평균 급여, 급여의 합을 출력
SELECT JOB, ceil(AVG(sal)) as AVG, sum(sal) as SUM
FROM  emp
GROUP BY JOB
HAVING AVG(sal)>=3000 ;

SELECT JOB, ROUND(AVG(sal),-2) as AVG, sum(sal) as SUM
FROM  emp
GROUP BY JOB
HAVING AVG(sal)>=3000 ;


-- 전체 합계 급여가 5000를 초과하는 각 업무에 대해서 업무와 급여 합계를 출력
--단, SALESMAN은 제외하고 급여 합계가 높은 순으로 정렬
SELECT JOB, sum(sal) as SUM
FROM  emp
WHERE JOB!='SALESMAN'
GROUP BY JOB
HAVING sum(sal)>5000 ;

SELECT JOB, sum(sal) as SUM
FROM  emp
GROUP BY JOB
HAVING sum(sal)>5000 AND JOB not like 'SA_%' ;

-- 업무별 최고 급여와 최소 급여의 차이를 구하라
SELECT JOB, max(sal) - min(sal) AS GAP 
FROM  emp
GROUP BY JOB;

-- 부서 인원이 4명 보다 많은 부서의 부서번호, 인원수, 급여의 합을 출력
SELECT deptno, COUNT(*), sum(sal) as SUM
FROM  emp
GROUP BY DEPTNO
HAVING COUNT(*)>4;


