/*
    SELECT 검색할 항목
    FROM  테이블명
    WHERE 조건 ;
*/

--모든 사원의 사원명과 급여, 급여와 보너스를 더한 합계 출력
--연산자나 추가함수가 생긴경우에는 별칭을 지어주도록!
SELECT     ename, sal, sal+nvl(comm,0) AS total_sal    --as를 써서 별칭이랑 헷갈리지 않도록 꼭쓰자!
FROM       emp;
--WHERE   (모든 사원이라서 생략)    

SELECT ename ||' '||job AS staff
FROM emp;
--WHERE

SELECT distinct JOB FROM emp;       --job이 빠진 상태로 출력

--1- 20번 부서에서 근무하는 사원의 사원번호, 이름, 부서번호 출력

SELECT empno, ename, deptno
FROM    emp
WHERE   deptno=20;

-- 2- 입사일이 81/01/01에서 81/06/09인 사원의 사원번호, 이름, 입사일을 출력
--BETWEEN 사용(대상 BETWEEN A AND B)
SELECT empno, ename, hiredate
FROM    emp
WHERE  hiredate BETWEEN '81/01/01' and '81/06/09' ;

SELECT empno, ename, hiredate
FROM    emp
WHERE   hiredate >='81/01/01' and hiredate <='81/06/09' ;

-- 3- 담당업무가 salesman, clerk인 사원들의 이름과 업무를 출력

--IN 연산자로 표현(3개이상일때쓰면 좋음)
SELECT ENAME, JOB
FROM    emp
WHERE   JOB IN ('SALESMAN' ,'CLERK') ;

--소문자를 대문자로 바꿔주기
SELECT ENAME, JOB
FROM    emp
WHERE   JOB  = UPPER('salesman')  OR JOB  = UPPER('clerk') ;

--내용이 대문자이기 때문에 대문자로 입력하는 것이다!
SELECT ENAME, JOB
FROM    emp
WHERE   JOB  = 'SALESMAN'  OR JOB = 'CLERK' ;

-- 4- 업무가 president이고 급여가 1500이상이거나 업무가 salesman인 사원의 정보를 출력

SELECT *
FROM    emp
WHERE   (JOB ='PRESIDENT' AND SAL>=1500)        --해당경우에는 헷갈리지 않게 ()해주기
         OR JOB ='SALESMAN';
        
-- 5- 업무가 president 또는 salesman이고 급여가 1500이상인 사원의 정보를 출력
SELECT *
FROM    emp
WHERE   (JOB ='PRESIDENT' OR JOB ='SALESMAN')   --해당경우에는 헷갈리지 않게 ()해주기 AND가 연산순위가 높아서 오류 발생할 수도 있음    
        AND SAL>=1500 ;
        
-- 6- 커미션(comm)이 없는 사원의 이름, 급여, 커미션을 출력
SELECT ename, sal, comm
FROM    emp
WHERE   comm is NULL OR COMM =0;

--  7- 사원명, 급여, 커미션, 총급여( 급여 + 커미션)을 출력
SELECT ename, sal, comm , sal+nvl(comm,0) AS total_sal
FROM    emp;

-- 8- 이름 A로 시작하는 사원명 출력
SELECT ename
FROM    emp
WHERE  ENAME LIKE 'A%';
--'%'(와일드카드) : 길이와 상관없이(문자없는 경우도 포함) 모든 문자 데이터를 의미 
--               : 특정문자 또는 문자열을 대체학거나 문자열 데이터의 패턴을 표기하는 특수문자 

-- 9- 이름이 두번째 문자가 L인 사원명 출력
SELECT ename
FROM    emp
WHERE  ENAME LIKE '_L%';
-- '-' : 어떤 값이든 상관없이 한개의 문자 데이터를 의미

-- 10- 이름에 L이 두 번 이상 포함된 사원명 출력
SELECT ename
FROM    emp
WHERE  ENAME LIKE '%L%L%';
--%LL%인 경우 'LL'(LL이 연속으로)이 들어간 사람만 나온다.
-- 11- 커미션(COMM)이 NULL이 아닌 사원의 모든 정보를 출력
SELECT *
FROM    emp
WHERE  COMM IS NULL OR COMM=0;

-- 12- 보너스가 급여보다 10%이상 많은 모든 사원에 대해 이름, 급여, 보너스를 출력
SELECT ENAME, SAL, COMM
FROM    emp
WHERE  COMM >=SAL*1.1;

-- 13- 업무가 clerk이거나 analyst이고 급여가 1000, 3000, 5000이 아닌 모든 사원의 정보를 출력
SELECT *
FROM    emp
WHERE  (JOB ='CLERK' OR JOB ='ANALYST')
        AND SAL NOT IN(1000,3000,5000);

SELECT *
FROM    emp
WHERE  (JOB ='CLERK' OR JOB ='ANALYST')
        AND SAL !=1000 AND SAL != 3000 AND SAL !=5000;        

-- 14- 부서가 30이거나 또는 관리자가 7782인 사원의 모든 정보를 출력
SELECT *
FROM    emp
WHERE  DEPTNO =30 OR MGR =7782;

