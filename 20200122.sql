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


