SELECT *
FROM emp 
WHERE deptno IN(10,30) AND sal >= 1500
ORDER BY ename desc ;

----ROWNUM : ���ȣ�� ��Ÿ���� �÷�
SELECT ROWNUM, empno, ename
FROM emp
WHERE deptno IN(10,30)
AND sal > 1500;

--ROWNUM�� WHERE�������� ��밡��
--�����ϴ°� : (1�� �ǰ�, 2�� �ȵ�) ROWNUM =1, ROWNUM <=2 --> ROWNUM=1, ROWNUM <= N
--����ȭ�� �ʴ°� : ROWNUM-=2, ROUWNUM >=2 --> ROUWNUM=N(N�� 1�� �ƴ�����), RIWNUM >= N(N�� 1�� �ƴ� ����)
--ROWNUM �̹� ���� �����Ϳ��ٰ� ������ �ο�
--���� ���� ������ ���� (ROWNUN�� �ο����� ���� ��)�� ��ȸ�� ���� ����.
--������ 1, ���� ���� ������ ����(ROWNUM)�� �ο����� ���� ���� ��ȸ�� �� �� ����.
--������ 2, ORDER BY ���� SELECT �� ���Ŀ� ����
--���뵵 : ����¡ ó��
-- ���̺� �ִ� ��� ���� ��ȭ�ϴ� ���� �ƴ϶� �츮�� ���ϴ� �������� �ش��ϴ� �� �����͸� ��ȸ�� �Ѵ�.
--����¡ ó���� ������� : 1�������� �Ǽ�, ���� ����
--emp���̺� �� row �Ǽ� : 14
--����¡�� 5���� �����͸� ��ȸ
--1page : 1~5
--2page : 6~10
--3page : 11~15


SELECT ROWNUM rn, empno, ename
FROM emp
ORDER BY ename;


--���ĵ� ����� ROWNUM�� �ο��ϱ� ���ؼ��� IN LIVE VIEW�� ����Ѵ�.
--�������� : 1.���� , 2.ROWNUM �ο�
-- SELECT * �� ����� ��� �ٸ� EXPRESSION�� ǥ��
--�ϱ� ���ؼ� ���̺��. * ���̺��Ī.*�� ǥ���ؾ��Ѵ�.
-- ROWNUM -> rn
-- *page size : 5, ���ı����� ename
-- 1page : rn 1~5
-- 2page : rn 6~10
-- 3page : rn 11~15
-- n page : rn (n-1)*pageSize +1  ~ n* pageSize
SELECT*
FROM
(SELECT ROWNUM rn , a.*
FROM
(SELECT empno, ename
FROM emp
ORDER BY ename) a)
WHERE rn >= 1 AND rn <=10;

--�������̶� �γ��� ���� ���� �������� ����Ʈ ���Ŀ� ������ �ȴ�.

-- ���� �÷� ROWNUM �ǽ� row1

SELECT*
FROM
(SELECT ROWNUM rn , e.*
FROM
(SELECT empno, ename
FROM emp) e)
WHERE rn >= 1 AND rn <=10;

--row 1 
SELECT ROWNUM rn, empno, ename
FROM emp
WHERE rn <= 10;

SELECT *
FROM 
 (SELECT ROWNUM rn, empno, ename
 FROM emp)
 WHERE rn <=10;
 
 ---row 2 
 SELECT *
 FROM 
    (SELECT ROWNUM rn, empno, ename
    FROM emp)
    WHERE rn BETWEEN 11 AND 20;
    
--row 3 
-- Ǯ���� ���Ѻ� ����
SELECT * 
FROM
(SELECT ROWNUM rn, a.*
FROM
(SELECT empno, ename
FROM emp
ORDER BY ename) a)
WHERE rn BETWEEN (:page -1 )*10+1 AND :page * :pageSize;

SELECT * 
FROM
(SELECT ROWNUM rn, a.*
FROM
(SELECT empno, ename
FROM emp
ORDER BY ename) a)
WHERE rn BETWEEN 11 AND 14;

-- DUAL ���̺� : �����Ϳ� ���� ����, �Լ��� �׽�Ʈ �غ� �������� ���
-- ���ڿ� ��ҹ��� : LOWER, UPPER, INITCAP
SELECT LOWER('Hello, World'),UPPER('Hello, World'),INITCAP('Hello, World') 
FROM dual;

SELECT LOWER('Hello, World'),UPPER('Hello, World'),INITCAP('Hello, World') 
FROM emp;

--�Լ��� WHERE �� ������ ��� ����
-- ��� �̸��� SMITH�� ����� ��ȸ
SELECT *
FROM emp
WHERE ename = 'SMITH';

-- SQL �ۼ��� �Ʒ� ���´� �����ؾ��Ѵ�.
--���̺��� �÷��� �������� �ʴ� ���·� sql�� �ۼ��Ѵ�.
SELECT * 
FROM emp
WHERE LOWER(ename) = :ename;

SELECT CONCAT('Hello', ' , World') CONCAT,
    SUBSTR('Hello, World' , 1,5), -- 1~5
    LENGTH('Hello, World')len, --���ڼ�
    INSTR('Hello, World','o') ins,
    INSTR('Hello, World','o',6) ins2, -- 6��° ���Ŀ� ������ o�� ���° ����?
    LPAD('Hello, World',15, '*')LP, -- �е����� 15���ڷ� ä����
    RPAD('Hello, World',15, '*')RP,  -- LP���� RP ������ �е�
    REPLACE('Hello,World','H','T')REP,
    TRIM('     Hello, World       ') TR, -- ������ ����
    TRIM('d'  FROM  'Hello, World') TR -- ������ �ƴ� �ҹ��� d����
    FROM dual;
    
    --���� �Լ�
    --ROUND : �ݿø� (10.6�� �Ҽ��� ù��° �ڸ����� �ݿø� -> 11)
    --TRUNC : ����(����) (10.6�� �Ҽ��� ù��° �ڸ����� ���� --> 10)
    --ROUND, TURNC : ���° �ڸ����� �ݿø� / ����
    --MOD :  ������ (���� �ƴ϶� ������ ������ �� ������ ��) (13/5 --> ��:2 , ������ :3)

--ROUND (���,����,���� ��� �ڸ�)
SELECT ROUND(105.54,1), --�ݿø� ����� �Ҽ��� ù��° �ڸ� ���� �������� --> �ι�° �ڸ����� �ݿø�
       ROUND(105.55,1), --�ݿø� ����� �Ҽ��� ù��° �ڸ� ���� �������� --> �ι�° �ڸ����� �ݿø�
       ROUND(105.55,0),  --�ݿø� ����� �����θ� �������� --> �Ҽ��� ù��° �ڸ� �ݿø�
       ROUND(105.55,-1), -- �ݿø� ����� ���� �ڸ����� --> ���� �ڸ����� �ݿø� 
       ROUND(105.55)
    FROM dual;
    
SELECT TRUNC(105.54,1), --������ ����� �Ҽ��� ù��° �ڸ����� �������� -> �ι�° �ڸ����� ����
       TRUNC(105.55,1), --������ ����� �Ҽ��� ù��° �ڸ����� �������� -> �ι�° �ڸ����� ����
       TRUNC(105.55,0) -- ������ ����� ������(���� �ڸ�)���� �������� --> �Ҽ��� ù��° �ڸ����� ����
FROM dual;

--EMP���̺��� ����� �޿�(sal)�� 1000����
--�������� ��
SELECT ename,sal, TRUNC(sal/1000), --���� ���غ�����
                MOD(sal,1000) -- ��mod�� ����� divisor���� �׻��۴�
                              --0~999
FROM emp;
DESC emp;

--�⵵ 2�ڸ� / ��2�ڸ� / ���� 2�ڸ�
SELECT ename, hiredate
FROM emp;

--SYSDATE : ���� ����Ŭ ������ �ú��ʰ� ���Ե� ��¥ ������ �����ϴ� Ư�� �Լ�
--�Լ��� (����1, ����2)
-- date + ���� = ���� ����
-- 2020/01/28 + 5

--���� ǥ�� : ����
--���� ǥ�� : ��� �����̼� + ���ڿ� + �̱� �����̼� --> '���ڿ�'
--��¥ ǥ�� : TO_DATE('���ڿ� ��¥ ��', '���ڿ� ��¥ ���� ǥ�� ����') 
            --> TO_DATE('2020-01-28','YYYY-MM-DD') 

SELECT SYSDATE + 5 , SYSDATE + 1/24
FROM dual;

SELECT to_date('2019/12/31','YYYY/MM/DD')
,to_date('2019/12/31','YYYY/MM/DD')-5,
sysdate 
FROM dual;

SELECT TO_CHAR(SYSDATE,'YYYY-MM/DD HH24:MI:SS')

