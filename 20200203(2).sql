SELECT *
FROM  countries;


SELECT * 
FROM regions;

SELECT *
FROM locations;

SELECT *
FROM departments;

--join 8

SELECT r.region_id, r.region_name, c.country_name
FROM regions r, countries c
WHERE r.region_id = 1 AND r.region_id = c.region_id; 


--join 9
SELECT r.region_id, r.region_name, c.country_name, l.city
FROM regions r, countries c, locations l
WHERE r.region_id = 1 AND r.region_id = c.region_id AND c.country_id = l.country_id;


--join10
SELECT r.region_id, r.region_name, c.country_name, l.city, d.department_name
FROM regions r, countries c, locations l, departments d
WHERE r.region_id = 1 AND r.region_id = c.region_id AND c.country_id = l.country_id AND l.country_id = department_name;

--CROSS JOIN ==> Cartsian product
--�����ϴ� �� ���̺��� ���� ������ �����Ǵ� ��� ������ ��� ���տ� ���� ����(����)�� �õ�
--dept(4��), emp(14)�� CROSS JOIN�� ����� 4*14 = 56��
SELECT dept.dname, emp.empno, emp.ename
FROM dept, emp
WHERE dept.deptno=10
AND dept.deptno = emp.deptno;

--crossjoin1
SELECT *
FROM customer, product;

SELECT c.cid,c.cnm,p.pid,p.pnm
FROM customer c , product p ;

--SUBQUERY
--> �����ȿ� �ٸ� ������ �� �ִ� ���
-- SUBQUERY�� ���� ��ġ�� ���� 3������ �з�
--SELECT �� : SCALAR SUBQURY : �ϳ��� ��, �ϳ��� �÷��� �����ؾ� ������ �߻����� ����
--FROM �� : INLINE - VIEW(VIEW)
--WHERE �� : SUBQURY QUERY

--���ϰ��� �ϴ°�
--SMITH�� ���� �μ��� ���ϴ� �������� ������ ��ȸ
--1.SMITH�� ���ϴ� �μ� ��ȣ�� ���Ѵ�
--2.1������ ���� �μ� ��ȣ�� ���ϴ� ������ ������ ��ȸ�Ѵ�.

--1�� SMITH�� ���ϴ� �μ���ȣ�� ���Ѵ�.
SELECT deptno
FROM emp
WHERE ename = 'SMITH';

--2. 1������ ���� �μ� ��ȣ�� ���ϴ� ������ ������ ��ȸ�Ѵ�.
SELECT *
FROM emp
WHERE deptno = 20;

--SUBQUERY�� �̿��ϸ� �ΰ��� ������ ���ÿ� �ϳ��� SQL�� ������ ����;



SELECT *
FROM emp;



SELECT *
FROM emp 
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE ename = 'SMITH');
                
--�ǽ� SUB1             
SELECT COUNT(*) 
FROM emp
WHERE sal > (SELECT avg (sal)
FROM emp);

--�ǽ� SUB2
SELECT * 
FROM emp
WHERE sal > (SELECT avg (sal)
FROM emp);
-- ������ ������
--IN : ���������� �������� ��ġ�ϴ� ���� ���� �� ��
--ANY (Ȱ�뵵�� �ټ� ������) : ���������� �������� �� ���̶� ������ ������ ��
--ALL (Ȱ�뵵�� �ټ� ������) : ���������� �������� ��� �࿡ ���� ������ ������ ��;

--SMITH�� ���ϴ� �μ��� ��� ������ ��ȸ
--SMITH�� WARD ������ ���ϴ� �μ��� ��� ������ ��ȸ

--�ǽ� SUB3
--���������� ����� ���� ���� ���� = �����ڸ� ������� ���Ѵ�.
SELECT *
FROM emp 
WHERE deptno IN (SELECT deptno
                FROM emp
                WHERE ename IN('SMITH','WARD'));
                
--SMITH, WARD ����� �޿����� �޿��� ���� ������ ��ȸ(SMITH,WARD�� �޿� 2���� ��ο� ���� ������)
--SMITH : 800
-- WARD : 1250
--> 800���� �޿��� ���� ���
--< 1250���� �޿��� �������
SELECT *
FROM emp 
WHERE sal < ANY(800,1250);


SELECT *
FROM emp
WHERE sal > ALL (SELECT sal
                FROM emp
                WHERE ename IN('SMITH','WARD'));
                
    --IN,NOT IN�� NULL�� ���õ� ���� ����;
    --������ ������ ����� 7566 �̰ų� NULL;
    --IN �����ڴ� OR �����ڷ� ġȯ ����
    SELECT *
    FROM emp
    WHERE mgr IN(7902, null);
  --NULL�񱳴� = �����ڰ� �ƴ϶� IS NULL�� �� �ؾ����� IN �����ڴ� =�� ����Ѵ�.  
    SELECT *
    FROM emp
    WHERE mgr = 7902
    OR mgr = null; --�Ѱ� ���� 2���� ���;���
    
    --NOT IN(7902,NULL)
-- �����ȣ�� 7902�� �ƴϸ鼭(AND) NULL�� �ƴ� ������

SELECT *
FROM emp 
WHERE empno NOT IN (7902,NULL);


--���� ���
SELECT * 
FROM emp
WHERE empno != 7902
AND empno IS NOT null;

-- 

-- pairwise (������) 
-- �������� ����� ���ÿ� ���� ��ų��;
--(mgr,deptno)
-- 7698,10 7698,30 7839,10 7839,30

SELECT mgr, deptno
FROM emp 
WHERE mgr IN (SELECT mgr
                        FROM emp
                        WHERE empno IN (7499 , 7782))
AND deptno IN (SELECT deptno
               FROM emp
               WHERE  empno IN (7499,7782));
               
    --��Į�� �������� : SELECT ���� ��� , 1���� ROW, 1���� COL�� ��ȸ�ϴ� ����
    --��Į�� ���������� MAIN ������ �÷��� ����ϴ°� �����ϴ�
    
    SELECT SYSDATE
    FROM dual;
    
    SELECT ( SELECT SYSDATE  FROM dual),dept.*
    FROM dept; 
    
    SELECT empno, ename, deptno, 
    (SELECT dname 
    FROM dept 
    WHERE deptno = emp.deptno) 
    FROM emp;
    
--INLINE VIEW : FROM ���� ����Ǵ� �������� ;

--MAIN ������ �÷��� SUBQUERY���� ����ϴ��� ������ ���� �з�
--����� ��� : correlated subqueury(��ȣ ���� ����),���������̸� �ܵ����� ���� �ϴ°� �Ұ���
            --��������� �������ִ� (main ==> sub)
--������� ������� : non-correlated subquery(���ȣ ���� ��������),(���������� �ܵ����� �����ϴ°� ����)
                           --��������� ������ ���� �ʴ�(main ==> sub, sub ==> main)

--��� ������ �޿� ��պ��� �޿��� ���� ����� ��ȸ
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
FROM emp);

--������ ���� �μ��� �޿� ��պ��� �޿��� ���� ����� ��ȸ
SELECT *
FROM emp m 
WHERE sal > (SELECT AVG(sal) 
            FROM emp s
            WHERE s.deptno = m.deptno);
            
--���� ������ ������ �̿��ؼ� Ǯ���
-- 1. ���� ���̺� ����
-- emp, �μ��� �޿� ���(inline view))

SELECT emp.*--emp.ename, sal ,dept_sal.*
FROM emp, (SELECT deptno, ROUND(AVG(sal)) avg_sal
            FROM emp
            GROUP BY deptno) dept_sal
WHERE emp.deptno = dept_sal.deptno
AND emp.sal > dept_sal.avg_sal;

--sub4;
--������ �߰�;
INSERT INTO dept VALUES (99, 'ddit', 'daejeon');

WHERE deptno = 99;
--DELETE dept;
SELECT *
FROM emp;

ROLLBACK ;-- Ʈ����� ���
COMMIT; --Ʈ����� Ȯ��
-- SUB �ǽ� 4
SELECT *
FROM emp
WHERE deptno NOT IN(SELECT deptno
                FROM dept
                WHERE deptno  =  ) ;