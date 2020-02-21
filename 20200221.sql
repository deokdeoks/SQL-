--PL/SQL PRO_2
CREATE OR REPLACE PROCEDURE registdept_test (p_deptno IN dept_test.dname %TYPE, 
                                             p_dname IN dept_test.deptno %TYPE, 
                                             p_loc IN dept_test.deptno%TYPE) IS

BEGIN

INSERT INTO dept_test VALUES(p_deptno, p_dname, p_loc, 0);
END;
/
INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon',0);
 SELECT* 
FROM dept_test;
exec registdept_test(99, 'ddit', 'daejeon');



--PL/SQL PRO_3
CREATE OR REPLACE PROCEDURE registdept_test (p_deptno IN dept_test.dname %TYPE, 
                                             p_dname IN dept_test.deptno %TYPE, 
                                             p_loc IN dept_test.deptno%TYPE) IS

BEGIN

INSERT INTO dept_test VALUES(p_deptno, p_dname, p_loc, 0);
END;
/

UPDATE dept_test SET dname = 'ddit_m' , loc = 'daejeon'
WHERE deptno = 99;

CREATE OR REPLACE PROCEDURE updatedept_test(
                               p_deptno IN dept_test.deptno%TYPE,
                               p_dname IN dept_test.dname%TYPE,
                               p_loc IN dept_test.loc%TYPE) IS
BEGIN 
    UPDATE dept_test SET dname = p_dname , loc = p_loc
    WHERE deptno = p_deptno;
    
    COMMIT;
    
    END;
    /
    
    EXEC updatedept_test(96, 'ddit_m', 'daejon');
    
    
���պ��� %rowtype : Ư�� ���̺��� ���� ������ �� �ִ� ����
��� ��� : ������ ���̺��%ROWTYPE
;

DECLARE 
    v_dept_row dept%ROWTYPE;
BEGIN 
    SELECT * INTO v_dept_row
    FROM dept
    WHERE deptno = 10;
    
    DBMS_OUTPUT.PUT_LINE(v_dept_row.deptno || ' '  || v_dept_row.dname || ' ' || v_dept_row.loc);
END;
/

SET SERVEROUTPUT ON;

���պ��� RECORD
�����ڰ� ���� �������� �÷��� ������ �� �ִ� Ÿ���� �����ϴ� ���
JAVA�� �����ϸ� Ŭ�����������ϴ� ����
�ν��Ͻ��� ����� ������ ��������

����
TYPE Ÿ���̸�(�����ڰ� ����) IS RECORD(
������1 ����Ÿ��,
������2 ����Ÿ��,
);

������ Ÿ���̸�;

DECLARE
    TYPE dept_row IS RECORD(
        deptno NUMBER(2), 
        dname VARCHAR2(14)
    );
    
    v_dept_row dept_row;
BEGIN
    SELECT deptno, dname INTO v_dept_row
    FROM dept
    WHERE deptno= 10;
    
    DBMS_OUTPUT.PUT_LINE(v_dept_row.deptno || ' ' || v_dept_row.dname);

END;
/
SET SERVEROUTPUT ON;

table type ���̺� Ÿ��
�� : ��Į�� ����
�� : %ROWTYPE, record type
�� : table type
    � �� (%ROWTYPE, RECORD TYPE)�� ������ �� �ִ���
    �ε��� Ÿ���� ��������;
    
DEPT ���̺��� ������ ���� �� �ִ� table type�� ����
������ ��� ��Į�� Ÿ��, rowtype������ �� ���� ������ ���� �� �־�����
table Ÿ�� ������ �̿��ϸ� ���� ���� ������ ���� �� �ִ�.

PL/SQL ������ �ڹٿ� �ٸ��� �迭�� ���� �ε����� ������ �����Ǿ� ���� �ʰ�
���ڿ��� �����ϴ�.

�׷��� TABLE Ÿ���� ������ ���� �ε����� ���� Ÿ�Ե� ���� ���;
BINARY_INTEGER Ÿ���� PL/SQL������ ��� ������ Ÿ������
NUMBER Ÿ���� �̿��Ͽ� ������ ��� �����ϰ� ���� NUMBER Ÿ���� ���� Ÿ���̴�;

DECLARE 
    TYPE dept_tab IS TABLE OF dept%ROWTYPE INDEX BY BINARY_INTEGER;
    v_dept_tab dept_tab;
    BEGIN 
        SELECT * BULK COLLECT INTO v_dept_tab
        FROM dept;
        --���� ��Į�� ����, record Ÿ���� �ǽ��ÿ���
    --���ุ ��ȸ �ǵ��� where���� ���� �����Ͽ���
    --�ڹٿ����� �迭[�ε��� ��ȣ]
    --table ����(�ε��� ��ȣ)�� ����
    DBMS_OUTPUT.PUT_LINE(v_dept_tab(1).deptno || ' ' || v_dept_tab(1).dname);
    DBMS_OUTPUT.PUT_LINE(v_dept_tab(2).deptno || ' ' || v_dept_tab(2).dname);
    DBMS_OUTPUT.PUT_LINE(v_dept_tab(3).deptno || ' ' || v_dept_tab(3).dname);
    DBMS_OUTPUT.PUT_LINE(v_dept_tab(4).deptno || ' ' || v_dept_tab(4).dname);
    END;
    /


DECLARE 
    TYPE dept_tab IS TABLE OF dept%ROWTYPE INDEX BY BINARY_INTEGER;
    
    
�������� IF
����

IF ���ǹ� THEN
 ���๮;
 ELSIF ���ǹ� THEN
 ���๮;
 ELSE
 ;
 
 DECLARE
    p NUMBER(1) := 2; --���� ����� ���ÿ� ���� ����
BEGIN
    IF p = 1 THEN
        DBMS_OUTPUT.PUT_LINE('1�Դϴ�');
    ELSIF p = 2 THEN
        DBMS_OUTPUT.PUT_LINE('2�Դϴ�');
    ELSE
        DBMS_OUTPUT.PUT_LINE('�˷����� �ʾҽ��ϴ�');
    END IF;
END;
/

CASE ���� 
1. �Ϲ� ���̽�(java�� switch�� ����)
2. �˻� ���̽�(if, else if , else)

CASE expression 
    WHEN value THEN 
        ���๮;
    WHEN value THEN 
        ���๮;
    ELSE
        ���๮;
END CASE;

DECLARE
    p NUMBER(1) := 2;
BEGIN
    CASE p 
        WHEN 1 THEN
            DBMS_OUTPUT.PUT_LINE('1�Դϴ�.');
        WHEN 2 THEN
            DBMS_OUTPUT.PUT_LINE('2�Դϴ�.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('�𸣴� ���Դϴ�');
    END CASE;
END;
/

FOR Loop ����
FOR ��������/�ε������� in[REVERSE] ���۰�.. ���ᰪ LOOP
    �ݺ��� ����;
END LOOP;

1���� 5���� FOR LOOP �ݺ����� �̿��Ͽ� ���� ��� ;

DECLARE 
BEGIN 
    FOR i IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
END;
/

�ǽ� : 2~9�� ������ �������� ���;

DECLARE
BEGIN
    FOR i IN 2..9 LOOP
    FOR j IN 1..9 LOOP 
DBMS_OUTPUT.PUT_LINE(i || '*' || j || '=' ||i*j);
    END LOOP;
    END LOOP;
END;
/

While loop ����
WHILE ���� Loop
    �ݺ��������� ����;
END Loop;

DECLARE
    i NUMBER := 0;
BEGIN 
    WHILE i <= 5 Loop
        DBMS_OUTPUT.PUT_LINE(i);
        i := i+1;
    END LOOP;
END;
/


LOOP�� ���� ==> while(true)
LOOP    
    �ݺ������� ����;
END LOOP;
    �ݺ������� ����;
    EXIT ����;
END LOOP;


DECLARE
    i NUMBER  := 0;
BEGIN 
    LOOP
      
        EXIT WHEN i > 5;
        DBMS_OUTPUT.PUT_LINE(i);
        i := i + 1;
        END LOOP;
END;
/