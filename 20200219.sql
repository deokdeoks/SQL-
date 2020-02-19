--���� ���� ��� 11��
--����¡ ó��(�������� 10���� �Խñ�)
1������ : 1~10
2����¡ : 11~20
���ε� ���� : page, :pageSize;


--���� ����
SELECT part_b.deptno, part_b.ename,part_a.lv
FROM
(SELECT part1.* , rownum a
FROM
(SELECT a.*
FROM
(SELECT *
FROM
(SELECT LEVEL lv
FROM dual
CONNECT BY LEVEL <= 14)) a,

(SELECT deptno, count(*) cnt
FROM emp
GROUP BY deptno) b

WHERE b.cnt >= a.lv
ORDER BY b.deptno, a.lv) part1) part_a, 


(SELECT deptno, ename, rownum a
FROM
(select *
FROM emp e
order by deptno, sal desc, ename)) part_b
WHERE part_a.a = part_b.a;

���� ������ �м��Լ��� ����ؼ� ǥ���ϸ�..?

SELECT ename, sal, deptno, RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) rank
FROM emp;


SELECT ename, sal, deptno, ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal DESC) rank
FROM emp;


SELECT a.*, ROWNUM rn
FROM 
(SELECT seq, LAPD(' ' , (LEVEL-1)*4) || title title, DECODE(parent_seq, NULL, seq, parent_seq)root
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY root DESC, seq ASC) a)
WHERE rn BETWEEN (:page -1)*:pageSize + 1 AND 

�м��Լ� ����
�м��Լ���(����) OVER ([PARTITON BY �÷�] [ORDER BY �÷�] [WINDOWING])
PARTITION BY �÷� : �ش� �÷��� ���� ROW ���� �ϳ��� �׷����� ���´�
ORDER BY �÷� : PARTITION BY�� ���� ���� �׷� ������ ORDER BY �÷����� ����;

ROW_NUMBER() OVER(PARTION BY deptno ORDER BY sal DESC) rank;

���� ���� �м��Լ�
RANK() : ���� ���� ������ �ߺ� ������ ����, �ļ����� �ߺ� ����ŭ ������ ������ ����
        2���� 2���̸� 3���� ���� 4����� �ļ�����
DENSE_RANK() : ���� ���� ������ �ߺ� ������ ����, �ļ����� �ߺ����� �������� ����
            2���� 2���̴��� �ļ����� 3����� ����
ROW_NUMBER() : ROWNUM�� ����, �ߺ��� ���� ������� ����;

�μ���, �޿� ������ 3���� ��ŷ �����Լ��� ����;
SELECT ename, sal , deptno,
        RANK() OVER (PARTITION BY deptno ORDER BY sal) sal_rank,
        DENSE_RANK() OVER (PARTITION BY deptno ORDER BY sal) sal_dense_rank,
         ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal) sal_row_number
FROM emp;

--�ǽ� ana1 
SELECT ename, sal , deptno, 
        RANK() OVER (ORDER BY sal) sal_rank,
        DENSE_RANK() OVER (ORDER BY sal) sal_dense_rank,
         ROW_NUMBER() OVER (ORDER BY sal) sal_row_number 
FROM emp;

--�ǽ� ana2
SELECT * 
FROM(
SELECT   empno , ename,  deptno, COUNT(*) 
from emp
GROUP BY deptno, ename, empno );




�׷��Լ� : ��ü ������
SELECT COUNT(*)
FROM emp;

ana1 : �����ü �޿� ����
�м��Լ� ���� �׷� : PARTITION BY ==> ������� ������ ��ü���� �������;

������ �м��Լ� (GROUP �Լ����� �����ϴ� �Լ� ������ ����)
SUM(�÷�)
COUNT(*), COUNT(�÷�)
MIN(�÷�)
MAX(�÷�)
AVG(�÷�)

no_ana2�� �м��Լ��� ����Ͽ� �ۼ�
�μ��� ���� �� ;

SELECT empno, ename, deptno, COUNT(*) OVER (PARTITION BY deptno) cnt
FROM emp;

--�ǽ� ana2

SELECT empno, ename, deptno, ROUND(AVG(sal) OVER (PARTITION BY deptno),2) avg_sal
FROM emp;


--�ǽ� 3 

SELECT empno, ename, deptno, MIN(sal) OVER (PARTITION BY deptno) max_sal
FROM emp;


�޿��� �������� �����ϰ�, �޿��� ���� ���� �Ի����ڰ� ���� ����� ���� �켱������ �ǵ��� ���Ķ���
�������� ������(LEAD)�� SAL �÷��� ���ϴ� ���� �ۼ�

SELECT empno, ename, hiredate, sal, LEAD(sal) OVER(ORDER BY sal DESC , hiredate) lead_sal
FROM emp;

--�ǽ� ana5
SELECT empno,ename,hiredate,job, LAG(sal) 
OVER(PARTITION BY job ORDER BY sal DESC , hiredate) lag_sal
FROM emp;

--�ǽ� no_ana3

SELECT empno,ename,sal, SUM(sal) 
OVER(ORDER BY sal ASC) c_sum 
FROM emp;

SELECT a.empno, a.ename, a.sal, SUM(b.sal) C_SUM
FROM 
    (SELECT a.*, rownum rn
    FROM 
        (SELECT *
        FROM emp
        ORDER BY sal)a)a,
    (SELECT a.*, rownum rn
    FROM 
        (SELECT *
        FROM emp
        ORDER BY sal, empno)a)b
WHERE a.rn >= b.rn
GROUP BY a.empno, a.ename, a.sal, a.rn
ORDER BY a.rn, a.empno ;


no_ana3�� �м��Լ��� �̿��Ͽ� SQL �ۼ�;

SELECT empno, ename, sal ,SUM(sal) OVER (ORDER BY sal, empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) cumm_sal
FROM emp;

�������� �������� ���� ������� ���� ������� �� 3������ sal �հ� ���ϱ�;
SELECT empno, ename, sal, SUM(sal) OVER (ORDER BY sal, empno ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) c_sum
FROM emp;

-- �ǽ� ana7
SELECT empno, ename, deptno, sal, SUM(sal) OVER (PARTITION BY deptno ORDER BY sal, empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) c_sum
FROM emp
ORDER BY deptno,sal,c_sum ;

ana7 �μ����� �޿�, �����ȣ �������� ���� ���� �� , �ڱ��� �޿��� �����ϴ�(����) ������� �޿����� ��ȸ�ϴ� ���� �ۼ�
�÷� : ename, empno, deptno, sal ������
ORDER BY ����� WINDOWING ���� ������� ���� ��� ���� WINDOWING�� �⺻ ������ ���� �ȴ�
RANGE UNBOUNDED 

WINDOWING�� RANGE, ROW��
RANGE : ������ ���� ����, ���� ���� ������ �÷����� �ڽ��� ������ ���
ROWS : �������� ���� ����;

SELECT empno, ename, deptno, sal,
        SUM(sal) OVER (PARTITION BY deptno ORDER BY sal ROWS UNBOUNDED PRECEDING) row_,
        SUM(sal) OVER (PARTITION BY deptno ORDER BY sal range UNBOUNDED PRECEDING) range_,
        SUM(sal) OVER (PARTITION BY deptno ORDER BY sal)default_
FROM emp;
