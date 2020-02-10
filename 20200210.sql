--1. PRIMARY KEY ���� ���� ������ ����Ŭ dbms�� �ش� �÷����� unique index�� �ڵ����� �����Ѵ�.
--(***��Ȯ���� UNIQUE���࿡ ���� UNIQUE �ε����� �ڵ����� �����ȴ�
-- PRIMARY KEY = UNIQUE + NOT NULL)
--index : �ش� �÷����� �̸� ������ �س��� ��ü ������ �Ǿ��ֱ� ������ ã���� �ϴ� ���� �����ϴ��� ������ �˼��� �ִ�.
-- ���࿡ �ε����� ���ٸ� �����ο� �����͸� �Է��� �� �ߺ��Ǵ� ���� ã�� ���ؼ� �־��� ��� ���̺��� ��� �����͸� ã�ƾ� �Ѵ�.
-- ������ �ε����� ������ �̹� ������ �Ǿ��ֱ� ������ �ش� ���� ���� ������ ������ �˼��� �ִ�.

--2. FOREIGN KEY �������ǵ� 
--�����ϴ� ���̺� ���� �ִ����� Ȯ�� �ؾ��Ѵ�. 
--�׷��� �����ϴ� �÷��� �ε����� �־������ FOREIGN KEY ������ ������ ���� �ִ�. 



--FOREIGN KEY ������ �ɼ�
--FOREIGN KEY (���� ���Ἲ) : �����ϴ� ���̺��� �÷��� �����ϴ� ���� �Է� �� �� �ֵ��� ���� 
-- (EX : emp ���̺� ���ο� �����͸� �Է½� deptno �÷����� dept ���̺� �����ϴ� �μ���ȣ�� �Է� �� �� �ִ�)

-- FOREIGN KEY�� �����ʿ� ���� �����͸� ������ �� ������ 
-- � ���̺��� �����ϰ� �ִ� �����͸� �ٷ� ������ �ȵ�
-- ( EX : EMP.deptno ==> DEPT.deptno �÷��� �����ϰ� ���� ��
-- �μ� ���̺��� �����͸� ���� �� ���� ����)

SELECT * 
FROM emp test;

CREATE TABLE emp_test;

INSERT INTO dept_test VALUES(99,'ddit2','����');
INSERT INTO emp_test (empno,ename,deptno)VALUES(9999,'brown',99);
commit;

--emp : 9999,99
--dept : 98,99
-- ==> 98�� �μ��� �����ϴ� emp ���̺��� �����ʹ� ����
    -- 99�� �μ��� �����ϴ� emp ���̺��� �����ʹ� 9999�� brown ����� ����
    
--���࿡ ���� ������ �����ϰ� �Ǹ�
-- DELETE dept 
-- WHERE deptno = 99;

--emp ���̺��� �����ϴ� �����Ͱ� ���� 98�� �μ��� �����ϸ�??
DELETE dept_test
WHERE deptno = 98;

FOREIGN KEY �ɼ�
1. ON DELETE CASCADE : �θ� ������ ���(dept) �����ϴ� �ڽ� �����䵵 ���� �����Ѵ�(emp)
2. ON DELETE SET NULL : �θ� ������ ��� (deot) �����ϴ� �ڽ� �������� �÷� null�� ����

--emp_test ���̺��� DROP�� �ɼ��� ������ ���� ������ ���� �׽�Ʈ;

DROP TABLE emp_test;
CREATE TABLE emp_test(
    empno NUMBER(4),
    enmae VARCHAR2(10),
    deptno NUMBER(2),
    
    CONSTRAINT pk_emp_test PRIMARY KEY (empno),
    CONSTRAINT fk_emp_test_dept_test FOREIGN KEY (deptno) 
    REFERENCES dept_test(deptno) ON DELETE CASCADE  

);
INSERT INTO emp_test VALUES (9999, 'brown', 99);
commit;

emp_test ���̺��� deptno �÷��� dept_test ���̺��� deptno �÷��� ����(ON DELETE CASCADE)
�ɼǿ� ���� �θ����̺�(dept_test)������ �����ϰ� �ִ� �ڽ� �����͵� ���� �����ȴ�.
DELETE dept_test
WHERE deptno = 99;

�ɼǿ� �ο����� �������� ���� DELETE ������ ������ �߻�
�ɼǿ� ���� �����ϴ� �ڽ� ���̺��� �����Ͱ� ���������� ������ �Ǿ����� select Ȯ��;


FK ON DELETE SET NULL �ɼ� �׽�Ʈ ;
�θ� ���̺��� ������ ������ (dept_test) �ڽ����̺��� �����ϴ� ������ �� NULL�� ������Ʈ;

DROP TABLE emp_test;

CREATE TABLE emp_test(
    empno NUMBER(4),
    enmae VARCHAR2(10),
    deptno NUMBER(2),
    
    CONSTRAINT PK_emp_test PRIMARY KEY (empno),
    CONSTRAINT FK_emp_test_dept_test FOREIGN KEY (deptno) 
    REFERENCES dept_test(deptno) ON DELETE SET NULL

);
INSERT INTO emp_test VALUES (9999, 'brown', 99);
commit;

dept_test ���̺��� 99�� �μ��� �����ϰ� �Ǹ�(�θ� ���̺��� �����ϸ�)
99�� �μ��� �����ϴ� emp_test ���̺��� 9999��(brown) �������� deptno �÷��� 
FK �ɼǿ� ���� null�� �����Ѵ�;

DELEDTE dept_test
WHERE deptno = 99;

�θ� ���̺��� ������ ������ �ڽ� ���̺��� �����Ͱ� null�� ����Ǿ����� Ȯ��

select * 
from emp_test;


check �������� : �÷��� ���� ���� ������ ������ �� ���
EX: �޿� �÷��� ���ڷ� ���� �޿��� ������ �� �� ������?
�Ϲ����� ��� �޿����� > 0
CHECK ������ ����� ��� �޿����� 0���� ū ���� �˻� ����.
EMP���̺��� JOB�÷��� ���� ���� ���� 4������ ���� ����
'SALESMAN', ' PRESIDENT' 'ANALYST', 'MANAGER';

���̺� ������ �÷� ����� �Բ� CHECK ���� ����
emp_test ���̺��� sal �÷��� 0���� ũ�ٴ� CHECK �������� ����;

DROP TABLE emp_test;

CREATE TABLE emp_test(
empno NUMBER(4),
enmae VARCHAR2(10),
deptno NUMBER(2),
sal NUMBER CHECK (sal > 0),

CONSTRAINT pk_emp_test PRIMARY KEY (empno),
CONSTRAINT FK_emp_test_dept_test FOREIGN KEY (deptno)
   REFERENCES dept_test (deptno)
);

INSERT INTO emp_test VALUES(9999,'brown', 99 , 1000);
INSERT INTO emp_test VALUES(9999,'sally', 99 , -1000);

INSERT INTO dept_test VALUES (99, 'ddit','����');

--���ο� ���̺� ����
--CREATE TABLE ���̺�� (
-- �÷�1....
);
-- creat table ���̺�� AS 
-- select ����� ���ο� ���̺�� ����

--emp ���Ը��� �̿��ؼ� �μ���ȣ�� 10�� ����鸸 ��ȸ�Ͽ� �ش� �����ͷ�
--emp_test2 ���̺��� ����;

CREATE TABLE emp_test2 AS 
SELECT *
FROM emp
WHERE deptno = 10; 

select *
from emp_test2;

select * 
from emp_20200210;
CREATE TABLE emp_20200210 AS
select *
from emp;

TABLE ����
1.�÷��߰� 
2.�÷� ������ ����, Ÿ�Ժ���
3.�⺻�� ����
4.�÷����� RENAME 
5.�÷��� ����
6.�������� �߰�/����;

TABLE ���� 
1. �÷� �߰�; (HP varchar2(20) );
DROP TABLE emp_test;

CREATE TABLE emp_test (
    empno NUMBER(4),
    ename VARCHAR(10),
    deptno NUMBER(2),
    
    CONSTRAINT pk_emp_test PRIMARY KEY (empno),
    CONSTRAINT fk_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test (deptno)
    );

ALTER TABLE ���̺�� add (�ű��÷��� �ű��÷� Ÿ�� ); 

ALTER TABLE emp_test ADD (hp VARCHAR2(20));
DESC emp_test;

select * 
from emp_test;

TABLE ���� 2.�÷� ������ ����, Ÿ�� ����
ex : �÷� varchar2(20) ==> varchar2(5)
    ������ �����Ͱ� ������ ��� ���������� ������ �ȵ� Ȯ���� �ſ� ����
    �Ϲ������� �����Ͱ� �������� �ʴ� ���� , �� ���̺��� ������ ���Ŀ� �÷��� ������, Ÿ���� �߸� �� ���
    �÷� ������ , Ÿ���� ������.
    �����Ͱ� �Էµ� ���ķδ� Ȱ�뵵�� �ſ� ������ (������ �ø��°͸� ����)
    
DESC emp_test;
hp VARCHAR2(20) ==> hp VARCHAR2(30);

ALTER TABLE ���̺�� MODIFY (���� �÷��� �ű� �÷� Ÿ��(������));
ALTER TABLE emp_test MODIFY (hp VARCHAR2(30));
DESC emp_test;

�÷� Ÿ�� ����
hp VARCHAR2(30) ==> hp NUMBER;
ALTER TABLE emp_test MODIFY (hp NUMBER);

desc emp_test;

�÷� �⺻�� ���� ; 
ALTER TABLE ���̺�� MODIFY (�÷��� DEFAULT �⺻��);
-- HP NUMBER ==> HP (VARCHAR2(20) DEFAULT '010' ; 

ALTER TABLE emp_test MODIFY (hp VARCHAR2 (20) DEFAULT '010');
DESC emp_test;

hp �÷����� ���� ���� �ʾ����� DEFAULT ������ ���� '010' ���ڿ��� �⺻������ ����ȴ�;
INSERT INTO emp_test (empno, ename, deptno) VALUES (9999,'brown',99);

select*
from emp_test;

TABLE 4.����� �÷� ����
ALTER TABLE ���̺�� RENAME COLUMN ���� �÷��� TO �űԸ� �÷��� ;
hp ==> hp_n;

ALTER TABLE emp_test RENAME COLUMN hp TO hp_n;
SELECT *
FROM emp_test;

���̺� ���� 5. �÷� ����
ALTER TABLE ���̺�� DROP COLUMN �÷��� 
emp_test ���̺��� hp_n �÷� ����;

emp_test�� hp_n �÷��� �ִ� ���� Ȯ��;
SELECT * 
FROM emp_test;

ALTER TABLE emp_test DROP COLUMN hp_n;

emp_test hp_n �÷��� �����Ǿ� �ִ��� Ȯ��;
select *
from emp_test;



--���� 
1.emp_test ���̺��� drop �� enmae,empno,deptno, hp 4�� �÷����� ���̺� ����
2.empno, ename, deptno 3���� �÷����� (9999,'brown',99) �����ͷ� insert
3.emp_test ���̺��� hp �÷��� �⺻���� '010'���� ����
4.2�������� �Է��� �������� hp�÷� ���� ��� �ٲ���� Ȯ��

TABLE ���� 6. �������� �߰� / ���� ;
ALTER TABLE ���̺�� AND CONSTRAINT �������Ǹ� �������� Ÿ�� (PRIMARY KEY , FOREIGN KEY ( �ش��÷�);
ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ�;

1.emp_test ���̺� ������
2.�������� ���� ���̺��� ����
3.PRIMARY KEY, FOREIGN KEY ������ ALTER TABLE ������ ���� ����;

DROP TABLE emp_test;

CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2));


ALTER TABLE emp_test ADD CONSTRAINT pk_emp_test PRIMARY KEY (empno);
ALTER TABLE emp_test ADD CONSTRAINT fk_emp_test_dept_test FOREIGN KEY
                              (deptno) REFERENCES dept_test(deptno);

PRIMARY KEY �׽�Ʈ 
INSERT INTO emp_test VALUES (9999,'brown',99);
INSERT INTO emp_test VALUES (9999,'sally',99); -- ù��° insert ������ ���� �ߺ��ǹǷ� ����;

FOREIGN KEY �׽�Ʈ;
INSERT INTO emp_test VALUES (9999,'sally' ,97); 
dept_test ���̺� �������� �ʴ� �μ���ȣ�̹Ƿ� ����;

�������� ���� : PRIMARY KEY, FOREIGN KEY;
ALTER TABLE emp_test DROP CONSTRAINT pk_emp_test;
ALTER TABLE emp_test DROP CONSTRAINT fk_emp_test_dept_test;

���������� �����Ƿ� �ߺ��� empno�� �ߺ��� ���� �� �� �ְ�, dept_test ���̺� �������� �ʴ�
deptno ���� ���ư� ���� �ִ�.;

�ߺ��� empno ������ ������ �Է�;
INSERT INTO emp_test VALUES (9999,'brown',99);
INSERT INTO emp_test VALUES (9999,'sally',99);

�������� �ʴ� 98���μ��� ������ �Է�;
INSERT INTO emp_test VALUES (9998, 'sally', 98);

select * 
from emp_test;


NOT NULL ,CHECK , UNIQUE;

�������� Ȱ��ȭ / ��Ȱ��ȭ
ALTER TABLE ���̺�� ENABLE | DISABLE CONSTRAINT �������Ǹ�;

1.emp_test ���̺� ����
2.emp_test ���̺� ����
3.ALTER TABLE PRIMARY KEY(empno), FOREIGN KEY (dept_test_deptno) �������� ����
4.�ΰ��� ���������� ��Ȱ��ȭ
5.��Ȱ��ȭ�� �Ǿ����� INSERT�� ���� Ȯ��
6. ���������� ������ �����Ͱ� �� ���¿��� �������� Ȱ��ȭ;

DROP TABLE emp_test;

CREATE TABLE emp_test (
empno NUMBER(4),
enmae VARCHAR2(10),
deptno NUMBER(2));

ALTER TABLE emp_test ADD CONSTRAINT pk_emp_test PRIMARY KEY(empno);
ALTER TABLE emp_test ADD CONSTRAINT fk_emp_test_dept_test FOREIGN KEY(deptno)
                                                        REFERENCES dept_test(deptno);
                                                        
ALTER TABLE emp_test DISABLE CONSTRAINT pk_emp_test;

INSERT INTO emp_test VALUES (9999,'brown',99);
INSERT INTO emp_test VALUES (9999,'sally',98); -- �ܷ�Ű�� ��Ȱ��ȭ ������Ѵ�.
commit;
select *
from emp_test;

emp_test ���̺��� empno �÷��� ���� 9999�� ����� �θ� �����ϱ� ������
PRIMARY KEY ���������� Ȱ��ȭ �� ���� ����.
==> EMPNO �÷��� ���� �ߺ����� �ʵ��� �����ϰ� �������� Ȱ��ȭ �� �� �ִ�.

ALTER TABLE emp_test ENABLE CONSTRAINT pk_emp_test;
ALTER TABLE emp_test ENABLE CONSTRAINT fk_emp_test_dept_test;


SELECT *
from emp_test;

empno �ߺ� ������ ����;
DELETE emp_test
WHERE enmae = 'brewn';

PRIMARY KEY �������� Ȱ��ȭ;
ALTER TABLE emp_test ENABLE CONSTRAINT pk_emp_test;

dept_test ���̺� ���Ǥ������� �ʴ� �μ���ȣ98�� emp_test���� �����
1. dept_test ���̺� 98�� �μ��� ����ϰų�
2. sally�� �μ���ȣ�� 99������ �����ϰų�;

UPDATE emp_test SET deptno = 99
WHERE ename = 'sally';

ALTER TABLE emp_testt ENABLE CONSTRAINT fk_emp_test_dept_test;
