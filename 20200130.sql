--cond1 �ǽ�

SELECT empno,ename,
 CASE 
 WHEN deptno = 10 THEN 'ACCONTING' 
 WHEN deptno = 20 THEN 'RESEARCH' 
 WHEN deptno = 30 THEN 'S1ALES'
 WHEN deptno = 40 THEN 'OPERATIONS'
 else 'DDIT'
 END dname
FROM emp;

--cond2 �ǽ�
--���س⵵�� ¦���̸�
--   �Ի�⵵�� ¦���� �� �ǰ����� �����
--   �Ի�⵵�� Ȧ���� �� �ǰ����� �����
--���س⵵�� Ȧ���̸�
-- �Ի�⵵�� ¦���� �� �ǰ����� �����
-- �Ի�⵵�� Ȧ���� �� �ǰ����� �����
SELECT empno,ename,hiredate
 FROM emp;
 
 --���س⵵�� ¦������, Ȧ������ Ȯ��
 --DATE Ÿ�� -> ���ڿ�(�������� ����, YYYY-MM-DD HH24:MI:SS)
 --¦�� -> 2�� �������� ������0
 --Ȧ�� -> 2�� �������� ������
 SELECT empno,ename,hiredate, 
 MOD(TO_NUMBER(TO_CHAR(hiredate,'YYYY')),2) hire,
 MOD(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')),2),
 CASE
   WHEN MOD(TO_NUMBER(TO_CHAR(hiredate,'YYYY'),2) = MOD(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')),2)
   THEN '�ǰ����� �����'
   ELSE '�ǰ����� ������'
END concat_to_doctor
 DECODE(MOD(TO_NUMBER(TO_CHAR(hiredate,'YYYY')),2) = MOD(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')),2)
 
 
 FROM emp;

SELECT  empno,ename,hiredate,
DECODE(MOD(TO_NUMBER,
FROM emp;


SELECT *
FROM emp;

--GROUP BY ���� ���� ����
-- �μ���ȣ ���� ROW���� ���� ���: GROUP BY deptno
-- �������� ���� ROW���� ���� ��� : GROUP BY job
-- MGR�� ���� �������� ���� ROW���� ���� ��� : GROUP BY mgr, job 

-- �׷��Լ��� ����
-- SUM : �հ�
-- COUNT : ���� -NULL���� �ƴ� ROW�� ����)
-- MAX : �ִ밪
-- MIN : �ּҰ�
-- AVG : ���

--�׷��Լ��� Ư¡
--�ش� �÷��� NULL���� ���� ROW�� ������ ��� �ش� ���� �����ϰ� ����Ѵ� (NULL ������ ����� NULL)

--�μ��� �޿� ��

--�׷��Լ� ������
--GROUP BY ���� ���� �÷��̿��� �ٸ��÷��� SELECT���� ǥ���Ǹ� ���� (�߿�)
SELECT deptno, SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal),ROUND(AVG(sal),2), COUNT(sal) 
FROM emp
GROUP BY deptno, ename;

--GROUP BY ���� ���� ���¿��� �׷��Լ��� ����� ���
--��ü���� �ϳ��� ������ ���´�

--GROUP BY�� ������ empno�̸� ������� ���?
--�׷�ȭ�� ���þ��� ������ ���ڿ�, �Լ�, ���ڵ��� SELECT ���� ������ ���� ����
SELECT 1, SYSDATE, SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal),ROUND(AVG(sal),2), 
COUNT(sal), -- sal �÷��� ���� null�� �ƴ� row�� ����
COUNT(comm), -- cmm �÷��� ���� null�� �ƴ� row�� ����
COUNT(*) -- ����� �����Ͱ� �ִ���
FROM emp
GROUP BY empno;

--SINGLE ROW FUNCTION�� ��� WHERE ������ ����ϴ� ���� �����ϳ�
-- MULTI ROW FUNCTION(GROUP FUNCTION)�� ��� WHERE ������ ����ϴ� ���� �Ұ��� �ϰ�
-- HAVING ������ ������ ����Ѵ�

-- �μ��� �޿� �� ��ȸ , �� �޿����� 9000�̻��� row�� ��ȸ
-- deptno, �޿���
SELECT deptno, SUM(sal) sum_sal
FROM emp
GROUP BY deptno
HAVING SUM(sal) > 9000;

--group fuction �ǽ� grp1

SELECT MAX(sal) max_sal , MIN(sal) min_sal ,AVG(sal) avg_sal,SUM(sal) sum_sal ,
COUNT(sal) count_sal, --���� �� �޿��� �ִ� ������ �� (null ����)
COUNT(mgr) count_mgr , -- ������ ����ڰ� �ִ� ������ �� (null ����)
COUNT(*) count_all --��ü ������ ��
FROM emp;

-- group function �ǽ� grp
SELECT deptno, MAX(sal) max_sal , MIN(sal) min_sal ,ROUND(avg(sal),2), avg_sal, SUM(sal) ,
COUNT(sal) , 
COUNT(mgr) ,
COUNT(*)
FROM emp
GROUP BY deptno;

SELECT 
    (CASE 
     WHEN deptno =  10 THEN 'ACCOUNTING'
     WHEN deptno =  20 THEN 'RESEARCH'
     WHEN deptno =  30 THEN 'SALES'
    END)dname, 
    MAX(sal) max_sal, MIN(sal) min_sal, ROUND(avg(sal),2) avg_sal, SUM(sal), COUNT(sal), COUNT(mgr), COUNT(*)
FROM emp
GROUP BY deptno;


--function(group function �ǽ� grp4)  
SELECT TO_CHAR(hiredate,'YYYYMM'), COUNT(*) cnt
FROM emp
GROUP BY  TO_CHAR(hiredate, 'YYYYMM');

--function(group function �ǽ� grp5)
SELECT TO_CHAR(hiredate,'YYYY'), COUNT(*) cnt
FROM emp
GROUP BY  TO_CHAR(hiredate, 'YYYY');

--function (group function �ǽ� grp6)
SELECT COUNT(*) cnt
FROM dept;




SELECT COUNT(*) 
FROM
(SELECT deptno
FROM emp
GROUP BY deptno);


SELECT *
FROM emp;