SELECT *
FROM USER_TAB_COMMENTS t, USER_COL_COMMENTS c
WHERE t.table_name = c.table_name
AND t.table_name IN ('CUSTOMER', 'PRODUCT', 'CYCLE', 'DAILY');

SELECT * 
FROM emp;

EXPLAIN PLAN FOR
SELECT*
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';
--------------------------------------------------------------------------------------------
| Id  | Operation                   | Name         | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |              |     1 |    87 |     2   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS BY INDEX ROWID| EMP          |     1 |    87 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_N_EMP_01 |     1 |       |     1   (0)| 00:00:01 |
--------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("ENAME" LIKE 'C%')
   2 - access("JOB"='MANAGER')
 
Note
-----
   - dynamic sampling used for this statement (level=2)


EXPLAIN PLAN FOR
SELECT*
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

SELECT*
FROM TABLE (dbms_xplan.display);

Plan hash value: 1112338291
 
--------------------------------------------------------------------------------------------
| Id  | Operation                   | Name         | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |              |     1 |    87 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP          |     1 |    87 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_N_EMP_02 |     1 |       |     1   (0)| 00:00:01 |
--------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
  
Note
-----
   - dynamic sampling used for this statement (level=2)

  2 - access("JOB"='MANAGER' AND "ENAME" LIKE 'C%')
       filter("ENAME" LIKE 'C%')


1.table full
2. idx0 : empno
3. idx1 : job; <---�̰ɷ� �����Ѵ�.
4. idx2 : job + ename 
5. idx3 : enmae + job ;

CREAT INDEX idx_n_emp_04 ON emp (ename, job);

SELECT ename, job, rowid
FROM emp
ORDER BY ename, job;
3��° �ε����� ������
3,4��° �ε����� �÷� ������ �����ϰ� ������ �ٸ���;

DROP INDEX idx_n_emp_03;


EXPLAIN PLAN FOR 
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

SELECT * 
FROM TABLE(dbms_xplan.display);
Plan hash value: 1112338291
 
--------------------------------------------------------------------------------------------
| Id  | Operation                   | Name         | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |              |     1 |    87 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP          |     1 |    87 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_N_EMP_02 |     1 |       |     1   (0)| 00:00:01 |
--------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("JOB"='MANAGER' AND "ENAME" LIKE 'C%')
       filter("ENAME" LIKE 'C%')
 
Note
-----
   - dynamic sampling used for this statement (level=2)
   
   emp - table full, pk_emp(empno)
   dept - table full, pk_dept(deptno)
   
   
   (emp - table full, dept - table full)
   (dept-table full, emp -table full)
   
   (emp - table full, dept-pk-dept) 
   (dept-pk_dept, emp -table full)
   
    (emp-pk_emp, dept-pk-dept) 
   (dept-pk_dept, emp-pk_emp)
   
   1.����
   
   
ORACLE - �ǽð� ���� : OLTP (ON LINE TRANSACTION PROCESSING)
        ��ü ó���ð� : OLAP (ON LINE ANALYSIS PROCESSING)
        
2. �� ���̺� ����
������ ���̺� �ε��� 5���� �ִٸ� 
�����̺� ���� ���� : 6
36 * 2 = 72;
   
   
 --�ǽ� idx1
 CREATE TABLE dept_test2 AS SELECT * FROM dept where 1 = 1;
 
 --ALTER TABLE dept_test2 ADD CONSTRAINT pk_dept_test2(dept)
 CREATE UNIQUE INDEX dept_u_test2_deptno ON dept_test2(deptno);
 CREATE INDEX dept_test2_dname ON dept_test2(dname);
 CREATE INDEX dept_test2_dname_deptno ON dept_test2(deptno,dname);


  
  DELETE dept_test2
  WHERE DNAME IS NULL;
  COMMIT;
  
  desc dept_test2;
 
 CTAS 
 �������� ���簡 NOT NULL�� �ȴ�;
 
 CREAT TABLE dept_test2 AS
 SELECT *
 FROM dept 
 WHERE 1 = 1;
 
 deptno �÷����� unique index
 dname �÷����� non unique index ; 
 deptno , dname �÷����� non unique index ; 
 
 CREATE UNIQUE INDEX idx_u_dept_test2_01 ON dept_test2 (deptno);
 CREATE INDEX idx_n_dept_test_02 ON dept_test2 (dname);
 CREATE  INDEX idx_u_dept_test2_01 ON dept_test2 (deptno,dname);
 
--�ǽ� IDX 2 ; 
 DROP INDEX dept_u_test2_deptno ;
 DROP INDEX dept_test2_dname;
 DROP INDEX dept_test2_dname_deptno;
 
 --�ǽ� idx3
  CREATE TABLE emp_test2 AS SELECT * FROM dept where 1 = 1;
 

 
  CREATE UNIQUE INDEX idx_u_emp_empno_01 ON idx_emp(empno);
  CREATE INDEX idx_emp_emname_02 ON idx_emp(ename);
  CREATE UNIQUE INDEX idx_u_dept_01 ON idx_dept(deptno);
 
 
 EXPLAIN PLAN for
 SELECT* 
 FROM emp, dept
 WHERE emp.deptno_dept.deptno
 AND emp.deptno = dept.deptno
 AND emp.deptno = :deptno
 AND emp.empno LIKE : empno || '&';
  SELECT *
  FROM table(dbms_xpaln.display);
 

access pattarn

empno(=)
ename(=)
deptno(=), empno(LIKE ������ȣ%)
deptno(=), sal (BETWEEN)

SELECT B.*
FROM EMP A ,EMP B
WHERE A.mgr = B.empno
AND A.deptno = :deptno;

deptno(=), empno(LIKE ������ȣ%)
deptno(=), sal (BETWEEN)
deptno(=) / mgr �����ϸ� ����,
deptno, hiredate�� �ε��� �����ϸ� ����;

deptno, sal , mgr , hiredate

   