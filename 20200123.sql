SELECT *

FROM iprod;

SELECT buyer_id, buyer_name
FROM buyer;

SELECT *
FROM cart;

SELECT mem_id, mem_pass, mem_name
FROM member;

--users ���̺� ��ȸ
SELECT * 
FROM users;

-- ���̺� � �÷��� �ִ��� Ȯ���ϴ� ���
-- 1.SELECT * 
-- 2.TOOL�� ��� (�����-TABLES)
--3. DESC ���̺�� (DESC-DESCRIBE) 
DESC users;

SELECT *
FROM users;

--users ���̺��� userid, usernm, rog_dt �÷��� ��ȸ�ϴ� sql�� �ۼ��ϼ���
-- reg_dt �÷��� ��ȸ�ϴ� sql�� �ۼ��ϼ���
-- ��¥ ���� (reg_dt �÷��� date ������ ������ �ִ� Ÿ��)
-- SQL ��¥ �÷� + (���ϱ� ����)
--�������� ��Ģ������ �ƴѰ͵� (5+5)
-- String h = "hello";
-- String w = "world";
-- String hw = h+w; -- �ڹٿ����� �� ���ڿ��� ����
-- SQL���� ���ǵ� ��¥ ���� : ��¥ + ���� = ��¥���� ������ ���ڷ�
--                           ����Ͽ� ���� ��¥�� �ȴ� (2019/1/28 + 5  = 2019/02/02)
--reg_dt : ������� �÷�         
--null : ���� �𸣴� ����
--null�� ���� ���� ����� �׻� null
--AS ��Ī�� ����
SELECT userid u_id, usernm, reg_dt, 
              reg_dt + 5 AS reg_dt_after_5day
FROM users;

SELECT prod_id AS id, prod_name AS name
FROM prod;

SELECT lprod_gu AS gu, lprod_nm AS nm
FROM lprod;

SELECT buyer_id AS ���̾���̵�, buyer_name AS �̸�
FROM buyer;

--���ڿ� ����
-- �ڹ� ���� ���ڿ� ���� : + ("Hello" + "world")
-- SQL������ : ||  ('Hello' || 'world')
-- SQL������ : concat('Hello', 'world')
-- userid, usernm �÷��� ���� , ��Ī id_name
SELECT userid || usernm id_name,
       CONCAT(userid, usernm) concat_id_name
FROM users;

--���� , ���
--int a = 5; String msg = "Hello, world";

--// ������ �̿��� ���
--System.out.println(msg);

--//����� �̿��� ���
--System.out.println("Hello, World");

--SQL������ ������ ����
--(�÷��� ����� ����, pl/sql ���� ������ ����)
--SQL���� ���ڿ� ����� �̱� �����̼����� ǥ��
--"Hello, World" --> 'Hello, World'

--���ڿ� ����� �÷����� ����
--user id : brown
--user id : cony
SELECT 'user id : ' || userid AS ,"use rid"
FROM users;

SELECT table_name  ,'SELECT*FROM' || table_name AS queary
FROM USER_TABLES; 

-- || --> CONCAT

SELECT CONCAT( CONCAT('SELECT * FORM',table_name),';') queary
FROM user_tables;

--if ( a==5) (a�� ���� 5���� ��)
--sql������ ������ ������ ����. (
--sql = ---> 

--WHERE �� : ���̺��� �����͸� ��ȸ�Ҷ�
--           ���ǿ� �´� �ุ ��ȸ
-- ex : userid �÷��� ���� brown�� �ุ ��ȸ
--brown , 'brown' ����
--�÷�, ���ڿ� ���
SELECT * 
FROM users 
WHERE userid = 'brown';


-- userid�� brown�� �ƴ� �ุ ��ȸ (brown�� ������ 4��)
-- = ������ : = , �ٸ��� : !=, <> 

SELECT * 
FROM users
WHERE userid != 'brown';

-- emp ���̺� �����ϴ� �÷��� Ȯ���غ�����

SELECT *
FROM emp;

-- emp ���̺��� ename �÷� ���� JONES�� �ุ ��ȸ
-- *SQL KEY WORD�� ��ҹ��ڸ� ������ ������
-- �÷��� ���̳�, ���ڿ� ����� ��ҹ��ڸ� ������
--'JONES', 'jones'�� ���� �ٸ� ���
SELECT *
FROM emp
WHERE ename = 'JONES';

SELECT *
FROM emp; --emp
DESC epm;
5 > 10 --FALSE

--emp ���̺��� deptno(�μ���ȣ)��
-- 30���� ũ�ų� ���� ����鸸 ��ȸ
SELECT *
FROM emp;
WHERE deptno >= 30;

-- ���ڿ� : '���ڿ�'
-- ���� : 50
-- ��¥ : ??? ---> �Լ��� ���ڿ��� �����Ͽ� ǥ��
-- ���ڿ��� �̿��Ͽ� ǥ�� ���� ( �������� ����)
-- �������� ��¥ ǥ�� ���
-- �ѱ� : �⵵ 4�ڸ� - ��2�ڸ� -���� 2�ڸ�
-- �̱� : �� 2�ڸ� - ���� 2�ڸ� - �⵵ 4�ڸ�
-- �Ի����ڰ� 1980�� 12�� 17�� ������ ��ȸ

SELECT * 
FROM emp;
WHERE hirdete = '80/12/17';
-- TO_DATE : ���ڿ��� date Ÿ������ �����ϴ� �Լ�
SELECT * 
FROM emp
WHERE hiredate = '80/12/17';

--TO_DATE : ���ڿ��� date Ÿ������ �����ϴ� �Լ�
--TO_DATE(��¥���� ���ڿ�, ù��° ������ ����)
SELECT *
FROM emp
WHERE hiredate = TO_DATE('19801217','YYYYMMDD');

-- ��������
-- sal �÷��� ���� 1000���� 2000 ������ ���
-- sal >= 1000
-- sal <= 2000
SELECT *
FROM emp
WHERE sal >= 1000
AND sal <= 2000;

--���� �����ڸ� �ε�ȣ ��ſ� BETWEEN AND �����ڷ� ��ü
SELECT * 
FROM emp 
WHERE sal BETWEEN 1000 AND 2000;

--�ǽ�

SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('19820101','YYYY/MM/DD') AND TO_DATE('19830101','YYYY/MM/DD');
--WHERE2
-- WHERE ���� ����ϴ� ���ǿ� ������ ��ȸ ����� ������ ��ġ�� �ʴ´�.
-- SQL�� ������ ������ ���� �ִ�.
-- ���� : Ű�� 185CM �̻��̰� �����԰� 70kg �̻��� ������� ����
--       �����԰� 70KG �̻��̰� Ű�� 185CM �̻��� ������� ����
-- ������ Ư¡ : ���տ��� ������ ����.
--(1,5,10) --> (10,5,1) : �� ������ ���� �����ϴ�
-- ���̺��� ������ ������� ����
-- SELECT ����� ������ �ٸ����� ���� �����ϸ� ����
--> ���ı�� ����(ORDER BY)
-- �߻��� ����� ���� --> ����X
 
SELECT ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE('19820101','YYYY/MM/DD')
AND hiredate <= TO_DATE('19830101','YYYY/MM/DD') ;

-- IN ������
-- Ư�� ���տ� ���ԵǴ��� ���� Ȯ��
-- �μ���ȣ�� 10�� Ȥ�� 20���� ���ϴ� ���� ��ȸ 
SELECT empno, ename , deptno
FROM emp
WHERE deptno IN(10,20);
-- �μ���ȣ 10�� Ȥ�� 20���� ���ϴ� ���� ��ȸ�� �� �� �ִ�.

--IN �����ڸ� ������� �ʰ� OR ������ ���
*SELECT empno, ename, deptno
FROM emp
WHERE deptno = 10
OR    deptno = 20;

-- emp ���̺��� ����̸��� SMITH, JONES �� ������ ��ȸ (empno, ename deptno)
-- AND / OR 
-- ���� ��� 
SELECT empno, ename, deptno
FROM emp
WHERE ename IN('SMITH','JONES');
-- ����̸� ''�� �ٿ����Ѵ�.

-- IN �ǽ� 

SELECT userid ���̵� , usernm �̸�, alias ����
FROM users
WHERE userid IN('brown','cony','sally');


--���ڿ� ��Ī ������ : like, %,  _
--�̸��� BR�� �����ϴ� ����� ��ȸ
--�̸��� R ���ڿ��� ���� ����� ��ȸ
--��� �̸��� S�� �����ϴ� ��� ��ȸ
-- % � ���ڿ� (�ѱ���, ���� �������� �ְ�, ���� ���ڿ��� �ü��� �ִ�)
--SMITH,SMILE,SKC
SELECT * 
FROM emp
WHERE ename LIKE 'S%';

--���ڼ��� ������ ���� ��Ī
-- _ ��Ȯ�� �ѹ���
-- ���� �̸��� S�� �����ϰ� �̸��� ��ü ���̰� 5���� �� ����
-- S____
SELECT *
FROM emp
WHERE enmae LIKE 'S____';

--��� �̸��� S���ڰ� ���� ��� ��ȸ
-- ename Like '%S'
SELECT *
FROM emp
WHERE ename Like '%S%' ;

--�ǽ� WHERE4

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '��%' ;

--�ǽ� WHERE5

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE('%��%');


-- null �� ���� (IS)
-- comm �÷��� ���� null �����͸� ��ȸ (WHERE comm = null)
SELECT *
FROM emp
WHERE comm = null;


SELECT *
FROM emp
WHERE comm = '';

SELECT *
FROM emp
WHERE comm IS null;

--WHERE 6 �ǽ�

SELECT *
FROM emp
WHERE comm IS not null ;

-- ����� �����ڰ� 7698, 7839 �׸��� null�� �ƴѻ���� ��ȸ
-- NOT IN �����ڿ����� NULL ���� ���� ��Ű�� �ȵȴ�
SELECT *
FROM emp
WHERE mgr NOT IN (7698,7839,NULL);

-------->
SELECT *
FROM emp
WHERE mgr NOT IN (7698,7839);
AND mqr IS NOT NULL;

-----WHERE 7 �ǽ�

SELECT *
FROM emp
WHERE job = 'SALESMAN' AND hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD');

--WHERE 8 �ǽ�
SELECT * 
FROM emp
WHERE deptno IN (30,20)  AND hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD');

--WHERE 9 �ǽ�
SELECT *
FROM emp
WHERE deptno NOT IN (10) AND hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD');

--WHERE 10 �ǽ�
SELECT *
FROM emp
WHERE deptno IN (20,30) AND hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD');

--WHERE 11 �ǽ� 
SELECT *
FROM emp
WHERE job = 'SALESMAN' OR hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD');

--WHERE 12 �ǽ� 
SELECT *
FROM emp
WHERE job = 'SALESMAN' OR empno LIKE '78%'; 

--WHERE 13 �ǽ�
SELECT *
FROM emp
WHERE job = 'SALESMAN' OR (empno >= 7800 AND empno <7900); --�����ڸ� ����

--������ �켱����
--*,/ �����ڰ� +,- ���� �켱������ ����
--1+5*2 = 11 -> (1+5)*2 X
-- �켱���� ���� : ()
-- AND > OR
-- emp ���̺��� ��� �̸��� SMITH �̰ų� 
               --��� �̸��� ALLEN �̸鼭 �������� SALESMAN�� ��� ��ȸ
               
SELECT *
FROM emp
WHERE ename = 'SMITH' 
OR  ename ='ALLEN' 
AND job = 'SALESMAN';

-- ��� �̸��� SMITH �̰ų� ALLEN �̸� 
-- �������� SALESMAN�� ��� ��ȸ

SELECT * 
FROM emp
WHERE (ename = 'SMITH' OR ename = 'ALLEN')
AND job = 'SALESMAN';

--WHERE 14
SELECT * 
FROM emp
WHERE job = 'SALESMAN' OR empno LIKE '78%' AND hiredate  >= TO_DATE('1981/06/01','YYYY/MM/DD');

--����
--SELECT *
--FROM table
--(WHERE)
--ORDER BY Į�� (ASC | DESC)

--emp ���̺��� ��� ����� ename Į�� ���� �������� �������� ������ ����� ��ȸ �ϼ���.
SELECT * 
FROM emp
ORDER BY ename; 

SELECT * 
FROM emp
ORDER BY ename DESC;

DESC emp; -- DESC : DESCRIBE (�����ϴ�)
ORDER BY ename DESC -- DESC : DESCENDING (����)

-- emp ���̺��� ��� ������ ename �÷����� �������� 
SELECT * 
FROM emp
ORDER BY ename;

-- ename ���� ���� ��� mqr �÷����� ��������
SELECT * 
FROM emp
ORDER BY ename DESC, mgr;

--���Ľ� ��Ī�� ���
SELECT empno, ename nm , sal*12 year_sal
FROM emp
ORDER BY year_sal;

-- �÷� �ε����� ����
-- java array
SELECT empno, ename nm , sal*12 year_sal
FROM emp
ORDER BY 3;

--orderby1

SELECT *
FROM dept
ORDER BY dname ;

SELECT *
FROM dept
ORDER BY  deptno;

--ORDERBY 2

SELECT *
FROM emp
WHERE comm IS NOT NULL AND comm > 0 
ORDER BY comm desc;

--ORDERBY 3
SELECT*
FROM emp
WHERE mgr IS NOT NULL
ORDER BY job, empno desc




