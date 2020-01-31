SELECT ename, deptno
FROM emp;


--JOIN 두 테이블에 연결하는 작업
--JOIN 문법
-- 1.ANSI 문법
--2. ORACLE 문법

--Natural Join 
-- 두 테이블간 컬럼명이 같을 때 해당 컬럼으로 연결 (조인)
--emp,dept 테이블에는 deptno라는 컬럼이 존재
SELECT * 
FROM emp NATURAL JOIN dept;


--Natural join에 사용된 조언 컬럼 (deptno)는 한정자(ex:테이블명, 테이블 별칭)을 사용하지 않고
-- 컬럼명만 기술한다(dept.deptno --> deptno)
SELECT emp.empno, emp.ename, dept.dname, deptno
FROM emp NATURAL JOIN dept;

--테이블에 대한 별칭도 사용가능
SELECT emp.empno, emp.ename, d.dname, deptno
FROM emp NATURAL JOIN dept d;

-- ORACLE JOIN
-- FROM 절에 조인할 테이블 목록을 , 로 구분하여 나열한다.
-- 조인할 테이블의 연결조건을 WHERE절에 기술한다
-- emp, dept 테이블에 존재하는 deptno 칼럼이 [같을 때] 조언
SELECT emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

EXPLAIN PLAN FOR
SELECT emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--오라클 조인의 테이블 별칭
SELECT e.empno, ename, d.dname, e.deptno
FROM emp e ,dept d 
WHERE e.deptno = d.deptno;

--ANSI : join with USING
--조인 하려는 두개의 테이블에 이름이 같은 컬럼이 두개이지만
--하나의 컬럼으로만 조인을 하고자 할때
--조인하려는 기준 컬럼을 기술;
--emp,dept 테이블의 공통 컬럼 : deptno;
SELECT emp.ename, dept.dname,deptno
FROM emp JOIN dept USING(deptno);

--JOINT WITH USING 을 ORACLE로 표현하면?;

SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--ANSI : JOIN WITH ON
-- 조인하려고 하는 테이블의 컬럼의 이름이 서로 다를때
SELECT emp.ename, dept.dname, emp.deptno
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

--JOIN WITH ON --> ORACLE 
SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--SELF JOIN : 같은 테이블간의 조인
-- 예 : emp 테이블에서 관리되는 사원의 관리자 사번을 이용하여 
-- 관리자 이름을 조회할때;
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e JOIN emp m ON(e.mgr = m.empno);

--오라클 문법으로 작성
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

-- equal 조인 :=
-- non-euqal 조인 : !=, >,<, BETWEEN AND ; 

--사원의 급여 정보와 급여 등급 테이블을 이용하여
-- 해당사원의 급여 등급을구해보자;

SELECT ename, sal
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal
                    AND salgrade.hisal;

SELECT *
FROM salgrade;

--ANSI 문법을 이용하여 위의 조언 문을 작성;
SELECT ename, sal
FROM emp JOIN salgrade ON emp.sal BETWEEN salgrade.losal AND salgrade.hisal; 

-- 실습 join0
SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
ORDER BY deptno;

--실습 join0_1
SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno AND e.deptno != 20;


SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno AND e.deptno IN(10,20);


-- 실습 join0_2
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

--join 1 실습
SELECT *
FROM lprod;

SELECT lprod_gu, lprod_nm, prod_id , prod_name
FROM lprod , prod  
WHERE lprod_gu  = prod_lgu ;

--join 2 실습
SELECT *
FROM buyer;

SELECT buyer_id, buyer_name, prod_id,prod_name
FROM buyer, prod
WHERE buyer_lgu = prod_lgu;

--join3 실습
SELECT mem_id,mem_name,prod_id,pord_name,cart_qtv
FROM mem , prod
WHERE mem_lgu = prod_lgu;




