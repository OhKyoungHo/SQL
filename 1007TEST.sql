
CREATE TABLE employee as select*from emp;

--[����1] �Ʒ��� employee ���̺��� ��� ����Դϴ�. �޿��� 2000 �̻� 3000 ������ ����� �̸��� �����ȣ, �Ի���, �޿��� ����ϵ� �̸���  �������� �����ϼ���.
SELECT ename, eno, hiredate, salary
FROM employee
WHERE SALARY>=2000 AND SALARY<=3000
ORDER BY ename ASC;

--[����2] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���. Ŀ�̼��� NULL �� ����̸���, �Ի��� �μ���ȣ�� ����ϵ� 
--�μ���ȣ�� �������� �����ϵ� �μ���ȣ�� ���� �׸��� ���� ��� �̸��� ������������ �����ϼ���.
SELECT DISTINCT dno, ename, hiredate
FROM employee
WHERE commission IS NULL
ORDER BY dno, ename ASC ;

--[����3] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
-- Ŀ�̼��� 300 �̰ų� 500 �̰ų� 1400�� ����� �����ȣ�� �̸�, ����, Ŀ�̼��� ��� �ϵ� Ŀ�̼��� �������� �����ϼ���.
-- IN �����ڸ� ����ؼ� ��� �ϼ���.

SELECT eno �����ȣ, ename �̸�, salary ����, commission Ŀ�̼�
FROM employee
WHERE commission in (300,500,1400)
ORDER BY commission desc ;

--[����4] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
--�̸��� ù ���ڰ� ��S���� �����ϴ� ����� �̸��� ����ϼ���.
SELECT ename
FROM employee
WHERE ename like 'S%';

--[����5] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
--LIKE �����ڿ� ���ϵ� ī�带 ����ؼ� '81'�⵵�� �Ի����� ���� ����� �̸��� �Ի����� ����ϼ���.
SELECT ename,hiredate
FROM employee
WHERE hiredate  NOT like '81%';

--[����6] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
-- �μ� ��ȣ�� �ߺ� ������ ������������ �����ؼ� ����ϼ���.
SELECT DISTINCT DNO
FROM employee
ORDER BY DNO ASC;

--[����7] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
--�̸��� ��A��  �� ��E�� �� ��� �����ϴ� ����� �̸��� ����ϼ���.
SELECT ename
FROM employee
WHERE ename like '%A%E%';

--[����8] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
-- substr �Լ��� ����ؼ� 12�� �޿� �Ի��� ����� �����ȣ, �̸�, �Ի����� ����ϼ���.
SELECT eno, ename, hiredate
FROM  employee
WHERE substr(hiredate,4,2) = '12';

--[����9] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
-- NVL �Լ��� ����ؼ� ����� ������ ����ؼ� ����̸�, ����, Ŀ�̼� , ������ ����ϵ� ������ ���� ������� ����ϼ���.
SELECT ename ����̸�, salary ����, NVL(commission,0) Ŀ�̼�, (salary * 12) + NVL(commission,0) AS ����
FROM  employee
ORDER BY (salary * 12) + NVL(commission,0) desc;

--[����10] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
--NVL2 �Լ��� ����ؼ� ����� ������ ����ؼ� ����̸�, ����, Ŀ�̼� , ������ ����ϵ� ������ ���� ������� ����ϼ���.

SELECT ename ����̸�, salary ����, NVL(commission,0) Ŀ�̼�, NVL2(commission,salary * 12 +commission,salary*12) AS ����
FROM  employee
ORDER BY NVL2(commission,salary * 12 +commission,salary*12) desc;

--[����11] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
--������� �޿� �Ѿ� , ��վ�, �ְ��, �ּҾ��� ��� �ϼ���. �� �÷��� ���޿��Ѿס�, ����վ�, ���ְ�ס�, ���ּҾס����� ��Ī�̸����� ����ϼ���.
SELECT sum(salary) �޿��Ѿ�, round(avg(salary)) ��վ�, max(salary) �ְ��, min(salary) �ּҾ�
FROM  employee;

--[����12] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
--���� ������ ������ ��� �ϼ���.  ����÷��� ������ ������ �������� ��Ī�̸����� ��� �ϼ���.
SELECT count(DISTINCT job) ����_������_����
FROM  employee;

--[����13] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
--�� �μ��� ��� ������ ���ؼ� �μ���ȣ�� ��� ������ ��� �ϵ�  ���� ���μ���ȣ��, ����տ��ޡ� ���� ��Ī�̸����� ����ϼ���.
SELECT dno �μ���ȣ, round(avg(salary)) ��տ���
FROM  employee
GROUP BY DNO;

--[����14] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
--��� ������ ������ ����� ���� ���Ͻÿ�. (���� , count �Լ� ���)
SELECT  job ������, count(*) �����
FROM  employee
GROUP BY job;


--[����15] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
-- ���޺� ����� ���� �޿��� ����Ͻÿ�, �����ڸ� �˼� ���� ��� �� ���� �޿��� 2000 �̸��� �׷��� ���� ��Ű�� ����� �޿��� ���� ������������ �����Ͽ� ��� �ϼ���.
SELECT  job, min(salary) �����޿�
FROM  employee
WHERE manager is not null 
HAVING min(salary)>2000
GROUP BY job
ORDER BY min(salary) desc;


--[����16] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
--���� ������ ����ؼ� �����ȣ�� 7788�� ����� �������� ���� ����� ��� �Ͻÿ�  <����̸�, ������> ��� �Ͻÿ�
SELECT job FROM employee WHERE eno=7788 

SELECT   ename ����̸�, job ������
FROM  employee
WHERE  job =(SELECT job FROM employee WHERE eno=7788) ;

SELECT ENAME,JOB
FROM EMPLOYEE
WHERE JOB IN (SELECT JOB FROM EMPLOYEE WHERE ENO = 7788);


--[����17] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
--���� ������ ����ؼ� �������� 7499 �� ������� �޿��� ���� ����� ��� �Ͻÿ�. <����̸�, ������> ��� �Ͻÿ�.
SELECT salary FROM employee WHERE eno =7499;

SELECT ename ����̸�, job ������
FROM  employee
WHERE  salary >(SELECT salary FROM employee WHERE eno =7499) ;

--[����18] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
--���� ������ ����ؼ� �� �μ��� �ּ� �޿��� �޴� ����� �̸� , �޿�, �μ���ȣ�� ����Ͻÿ�.
SELECT min(salary) FROM employee;

SELECT ename ����̸�, salary �޿�, dno �μ���ȣ
FROM employee
WHERE salary in (select min(salary) from employee group by dno);

--[����19] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
--���� ������ ����ؼ� �޿��� ��� �޿����� ���� ������� �����ȣ�� �̸��� ǥ���ϵ� ����� �޿��� ���ؼ� ������������ �����Ͻÿ�.
SELECT avg(salary) FROM employee;

SELECT eno �����ȣ, ename �̸�, salary �޿�
FROM employee
WHERE salary >(SELECT avg(salary) FROM employee)
ORDER BY salary asc;

--[����20] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
-- ���� ������ ����ؼ� DEPT ���̺� �ִ� �μ��� DNAME �÷�����  ��RESEARCH�� �μ��� �μ���ȣ, ����̸� �� ��� ������ ǥ���Ͻÿ�.

CREATE TABLE DEPT_COPY as select*from DEPT;

SELECT dno FROM DEPT_COPY  WHERE dname ='RESEARCH';

SELECT eno �μ���ȣ, ename ����̸�, job ������
FROM employee
WHERE dno =(SELECT dno FROM DEPT_COPY  WHERE dname ='RESEARCH');


