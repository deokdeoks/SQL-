SELECT DECODE (GROUPING(job) || GROUPING(deptno), '11','��',
                                                 '00',job,
                                                 '01',job)job,
      DECODE (GROUPING(job) || GROUPING(deptno), '11','��',
                                                 '00',deptno,
                                                 '01','�Ұ�')deptno,
        SUM(sal + NVL(comm, 0)) sal
        FROM emp
        GROUP BY ROLLUP (job, deptno);
        
        
MERGE : SELECT�ϰ��� �����Ͱ� ��ȸ��� UPDATE
        SELECT�ϰ��� �����Ͱ� ��ȸ���� ������ INSERT
        
SELECT + UPDATE / SELECT + INSERT ==> MERGE;

REPORT GROUP FUNCTION 
1. ROLLUP
    -GROUP BY ROLLUP (�÷�1, �÷�2)
    -ROLLUP���� ����� �÷��� �����ʿ��� �ϳ��� ������ �÷����� SUBGROUP
    -GROUP BY �÷�1, �÷�2
    UNION
    GROUP BY �÷�1
    UNION 
    GROUP BY
�ǽ�
--AD3
SELECT deptno,job,
SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY ROLLUP (job,deptno);

--AD4
SELECT d.dname , e.job , SUM(sal + NVL(comm, 0)) sal
FROM emp e,dept d
WHERE e.deptno = d.deptno
GROUP BY ROLLUP (dname,job);
 
--AD5
SELECT NVL(d.dname ,'����') e.job ,dname, SUM(e.sal) sal
FROM emp e,dept d
WHERE e.deptno = d.deptno 
GROUP BY ROLLUP (d.dname,e.job);

Ȱ�뵵
3, 1 >>>>>>>>>>>>>>>>>>>CUBE;

GROUPING SETS
������ ������� ���� �׷��� ����ڰ� ���� ����
����� : GROUP BY GROUPING SETS(coll,col2...)
==>
GROUP BY coll
UNION ALL
GROUP BY col2

GROUPING SETS�� ��� �÷� ��� ������ ����� ������ ��ġ�� �ʴ´�
GROUP BY GROUPING SETS ( (col1, col2), col3, col4)
==>

GROUP BY col1,col2
UNION ALL
GROUP BY col3
UNION ALL
GROUP BY col4;

GROUP BY GROUPING SETS ( (col1, col2), col3, col4)
GROUP BY GROUPING SETS ( (col4, col1), col2, col1)


GROUP BY col1;

SELECT job,deptno,SUM(sal) sal
FROM emp
GROUP BY GROUPING SETS(job, deptno);

GROUP BY GROUPING SETS(job,deptno)
==>
GROUP BY job
UNION
GROUP BY deptno;

job, deptno�� GROUP BY �� �����
mgr�� GROUP BY �� ����� ��ȸ�ϴ� SQL�� GROUPING SETS�� �޿����� SUM(sal)�ۼ�;

SELECT job,deptno,mgr, SUM(sal)sal
FROM emp
GROUP BY GROUPING SETS ((job,deptno),mgr);

CUBE 
������ ��� �������� �÷��� ������ SUB GROUP�� �����Ѵ�
�� ����� �÷��� ������ ��Ų��;

EX : GROUP BY CUBE(col1, col2);
(col1, col2) == > 
(null, col2) == > GROUP BY col2;
(null, null) == > GROUP BY ��ü
(col1, null) == > GROUP BY col1
(col1, col2) == > GROUP BY col1,col2;

���� �÷�3���� CUBE���� ����� ��� ���ü� �ִ� �������� ??;

SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY CUBE (job, deptno);


ȥ��;

SELECT jobm deptno, mgr, SUM(sal) sal
FROM emp
GROUP BY job, rollup(depnto), CUBE(mgr);

GROUP BY job, deptno, mgr ==  GROUP BY job, deptno , mgr
GROUP BY job, deptno ==  GROUP BY job, deptno 
GROUP BY job, null, mgr  ==  GROUP BY job,mgr
GROUP BY job, null, null ==  GROUP BY job

�������� UPDATE 
1. emp_test ���̺��� drop
2. emp ���̺��� �̿��ؼ� emp_test ���̺���� (��� �࿡ ���� ctas)
3. emp_test ���̺� dnames VARCHAR2(14) �÷��߰�
4. emp_test.dname �÷��� dept ���̺��� �̿��ؼ� �μ����� ������Ʈ;
DROP TABLE emp_test;

CREATE TABLE emp_test AS
SELECT * 
FROM emp;

DESC DEPT;

ALTER TABLE emp_test ADD (dname VARCHAR2(14));

SELECT *
FROM emp_test; 

UPDATE emp_test SET dname = (SELECT dname
                            FROM dept
                            WHERE dept.deptno =  emp_test.deptno);
                            
--�ǽ� sub_a1
DROP TABLE dept_test;

CREATE TABLE dept_test AS
select *
from dept;

ALTER TABLE dept_test ADD(empcnt NUMBER);

UPDATE dept_test SET empcnt = (SELECT COUNT(*) cnt
                                    FROM emp
                                    WHERE deptno = dept_test.deptno
                                    GROUP BY deptno);

SELECT deptno, COUNT(*) cnt
FROM emp
WHERE deptno = 10
GROUP BY deptno;

SELECT*
FROM dept_test;

sub_a2
dept_test���̺� �ִ� �μ��߿� ������ ������ ���� �μ� ������ ����
*dept_test.empcnt �÷��� ������� �ʰ�
emp ���̺��� �̿��Ͽ� ����;
INSERT INTO dept_test VALUES(99, 'it1', 'daejeon',0);
INSERT INTO dept_test VALUES(98, 'it2', 'daejeon',0);
COMMIT;

select * 
from dept_test;

SELECT * 
FROM dept_test
WHERE deptno = 10;


������ ������ ���� �μ� ���� ��ȸ?
���� �ִ� ����...?
10�� �μ��� ������ �ִ� ����???;

select *
from dept_test
WHERE 0 = (SELECT COUNT(*)
            FROM emp
            WHERE deptno = dept_test.deptno);
            
DELETE dept_test            
 select *
from dept_test
WHERE 0 = (SELECT COUNT(*)
            FROM emp
            WHERE deptno = dept_test.deptno);

--sub_a3 �ǽ�

UPDATE emp_test a SET sal = sal + 200
WHERE sal < (SELECT AVG(SAL)
                FROM emp_test b
                WHERE a.deptno = b.deptno);
                                    
                
            SELECT *
            FROM emp_test;
            
WITH ��
�ϳ��� �������� �ݺ��Ǵ� SUBQUERTY�� ���� ��
�ش� SUBQUERY�� ������ �����Ͽ� ����.;

MAIN������ ����� �� WITH ������ ���� ���� �޸𸮿� �ӽ������� ����
--> MAIN ������ ���� �Ǹ� �޸� ����

SUBQUERY �ۼ��ÿ��� �ش� SUBQUERY�� ����� ��ȸ�ϱ� ���ؼ� I/O �ݺ������� �Ͼ����
WITH���� ���� �����ϸ� �ѹ��� SUBQUERY�� ����ǰ� �� ����� �޸𸮿� ������ ���� ����
��, �ϳ��� �������� ������ SUBQUERY�� �ݺ������� �����°Ŵ� �߸� �ۼ��� SQL�� Ȯ���� ����;

WITH ��������̸� AS(
��������
)

SELECT = 
FROM ���� ��� �̸�;


������ �μ��� �޿� ����� ��ȸ�ϴ� ��������� WITH���� ���� ����;

WITH sal_avg_dept AS (
        SELECT deptno, ROUND(AVG(sal),2) sal
        FROM emp
        GROUP BY deptno
),
dept_empcnt AS(
SELECT deptno, COUNT(*) empcnt
FROM emp
GROUP BY deptno)

SELECT*
FROM sal_avg_dept a, dept_empcnt b
WHERE a.deptno = b.deptno;

WITH temp AS (
        SELECT sysdate -1 FROM dual UNION ALL
          SELECT sysdate -2 FROM dual UNION ALL
            SELECT sysdate -3 FROM dual)
            SELECT * 
            FROM temp;
            
�޷¸����
CONNECT BY LECEL <= ���� 
�ش� ���̺��� ���� ���� ��ŭ �����ϰ�, ������ ���� �����ϱ� ���ؼ� LEVEL�� �ο�
LEVEL�� 1���� ����;

SELECT dummy, LEVEL
FROM dual
CONNECT BY LEVEL <= 10;

SELECT *
FROM dept
CONNECT BY LEVEL <= 5;


2020�� 2���� �޷��� ����
:dt = 202002, 202003
1.
SELECT SYSDATE + LEVEL
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST DAY(TO_DATE('202002', 'YYYYMM')) , 'DD');
�޷�
�� �� ȭ �� �� �� ��
SELECT TO_DATE('202002', 'YYYYMM') + (LEVEL -1)
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202002', 'YYYYMM')) , 'DD');

SELECT TO_DATE('202002', 'YYYYMM') + (LEVEL -1)
     TO_CHAR(TO_DATE('202002', 'YYYYMM')) +(LEVEL -1), 'D'),
     DECODE(TO_CHAR(LAST_DAY(TO_DATE('202002', 'YYYYMM')) +(LEVEL -1), 'D'),
     1, TO_DATE('202002', 'YYYYMM') + (LEVEL -1)) m,
      DECODE(TO_CHAR(LAST_DAY(TO_DATE('202002', 'YYYYMM')) +(LEVEL -1), 'D'),
     2, TO_DATE('202002', 'YYYYMM') + (LEVEL -1)) t,
      DECODE(TO_CHAR(LAST_DAY(TO_DATE('202002', 'YYYYMM')) +(LEVEL -1), 'D'),
     3, TO_DATE('202002', 'YYYYMM') + (LEVEL -1)) w,
     FROM dual
     CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202002','YYYYMM')),'DD');