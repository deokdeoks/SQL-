SELECT ename, deptno
FROM emp;


--JOIN �� ���̺� �����ϴ� �۾�
--JOIN ����
-- 1.ANSI ����
--2. ORACLE ����

--Natural Join 
-- �� ���̺� �÷����� ���� �� �ش� �÷����� ���� (����)
--emp,dept ���̺��� deptno��� �÷��� ����
SELECT * 
FROM emp NATURAL JOIN dept;


--Natural join�� ���� ���� �÷� (deptno)�� ������(ex:���̺��, ���̺� ��Ī)�� ������� �ʰ�
-- �÷��� ����Ѵ�(dept.deptno --> deptno)
SELECT emp.empno, emp.ename, dept.dname, deptno
FROM emp NATURAL JOIN dept;

--���̺� ���� ��Ī�� ��밡��
SELECT emp.empno, emp.ename, d.dname, deptno
FROM emp NATURAL JOIN dept d;

-- ORACLE JOIN
-- FROM ���� ������ ���̺� ����� , �� �����Ͽ� �����Ѵ�.
-- ������ ���̺��� ���������� WHERE���� ����Ѵ�
-- emp, dept ���̺� �����ϴ� deptno Į���� [���� ��] ����
SELECT emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

EXPLAIN PLAN FOR
SELECT emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--����Ŭ ������ ���̺� ��Ī
SELECT e.empno, ename, d.dname, e.deptno
FROM emp e ,dept d 
WHERE e.deptno = d.deptno;

--ANSI : join with USING
--���� �Ϸ��� �ΰ��� ���̺� �̸��� ���� �÷��� �ΰ�������
--�ϳ��� �÷����θ� ������ �ϰ��� �Ҷ�
--�����Ϸ��� ���� �÷��� ���;
--emp,dept ���̺��� ���� �÷� : deptno;
SELECT emp.ename, dept.dname,deptno
FROM emp JOIN dept USING(deptno);

--JOINT WITH USING �� ORACLE�� ǥ���ϸ�?;

SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--ANSI : JOIN WITH ON
-- �����Ϸ��� �ϴ� ���̺��� �÷��� �̸��� ���� �ٸ���
SELECT emp.ename, dept.dname, emp.deptno
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

--JOIN WITH ON --> ORACLE 
SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--SELF JOIN : ���� ���̺��� ����
-- �� : emp ���̺��� �����Ǵ� ����� ������ ����� �̿��Ͽ� 
-- ������ �̸��� ��ȸ�Ҷ�;
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e JOIN emp m ON(e.mgr = m.empno);

--����Ŭ �������� �ۼ�
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

-- equal ���� :=
-- non-euqal ���� : !=, >,<, BETWEEN AND ; 

--����� �޿� ������ �޿� ��� ���̺��� �̿��Ͽ�
-- �ش����� �޿� ��������غ���;

SELECT ename, sal
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal
                    AND salgrade.hisal;

SELECT *
FROM salgrade;

--ANSI ������ �̿��Ͽ� ���� ���� ���� �ۼ�;
SELECT ename, sal
FROM emp JOIN salgrade ON emp.sal BETWEEN salgrade.losal AND salgrade.hisal; 

-- �ǽ� join0
SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
ORDER BY deptno;

--�ǽ� join0_1
SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno AND e.deptno != 20;


SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno AND e.deptno IN(10,20);


-- �ǽ� join0_2
SELECT e.empno, e.ename, e.sal ,d.deptno, d.dname
FROM emp e, dept d 
WHERE e.deptno = d.deptno AND e.sal > 2500
ORDER BY e.deptno;

--join 0_3

SELECT e.empno, e.ename, e.sal ,d.deptno, d.dname
FROM emp e, dept d 
WHERE e.deptno = d.deptno AND e.sal > 2500 and e.sal < 7600
ORDER BY e.deptno;

--join 0_4
SELECT e.empno, e.ename, e.sal ,d.deptno, d.dname
FROM emp e, dept d 
WHERE e.deptno = d.deptno 
AND e.sal > 2500 
AND e.empno > 7600 
AND d.dname = 'RESEARCH';

--PROD : PROD_LGU
--LPROD : LPROD_GU;
SELECT *
FROM prod;

--join 1 �ǽ�
SELECT *
FROM lprod;

SELECT lprod_gu, lprod_nm, prod_id , prod_name
FROM lprod , prod  
WHERE lprod_gu  = prod_lgu ;

--join 2 �ǽ�
SELECT *
FROM buyer;

SELECT buyer_id, buyer_name, prod_id,prod_name
FROM buyer, prod
WHERE buyer_lgu = prod_lgu;

--join3 �ǽ�
SELECT mem_id,mem_name,prod_id,pord_name,cart_qtv
FROM mem , prod
WHERE mem_lgu = prod_lgu;




