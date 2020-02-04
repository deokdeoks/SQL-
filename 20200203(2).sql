SELECT *
FROM  countries;


SELECT * 
FROM regions;

SELECT *
FROM locations;

SELECT *
FROM departments;

--join 8

SELECT r.region_id, r.region_name, c.country_name
FROM regions r, countries c
WHERE r.region_id = 1 AND r.region_id = c.region_id; 


--join 9
SELECT r.region_id, r.region_name, c.country_name, l.city
FROM regions r, countries c, locations l
WHERE r.region_id = 1 AND r.region_id = c.region_id AND c.country_id = l.country_id;


--join10
SELECT r.region_id, r.region_name, c.country_name, l.city, d.department_name
FROM regions r, countries c, locations l, departments d
WHERE r.region_id = 1 AND r.region_id = c.region_id AND c.country_id = l.country_id AND l.country_id = department_name;

--CROSS JOIN ==> Cartsian product
--조인하는 두 테이블의 연결 조건이 누락되는 경우 가능한 모든 조합에 대해 연걸(조인)이 시도
--dept(4건), emp(14)의 CROSS JOIN의 결과는 4*14 = 56건
SELECT dept.dname, emp.empno, emp.ename
FROM dept, emp
WHERE dept.deptno=10
AND dept.deptno = emp.deptno;

--crossjoin1
SELECT *
FROM customer, product;

SELECT c.cid,c.cnm,p.pid,p.pnm
FROM customer c , product p ;

--SUBQUERY
--> 쿼리안에 다른 쿼리가 들어가 있는 경우
-- SUBQUERY가 사용된 위치에 따라 3가지로 분류
--SELECT 절 : SCALAR SUBQURY : 하나의 행, 하나의 컬럼만 리턴해야 에러가 발생하지 않음
--FROM 절 : INLINE - VIEW(VIEW)
--WHERE 절 : SUBQURY QUERY

--구하고자 하는것
--SMITH가 속한 부서에 속하는 직원들의 정보를 조회
--1.SMITH가 속하는 부서 번호를 구한다
--2.1번에서 구한 부서 번호에 속하는 직원들 정보를 조회한다.

--1번 SMITH가 속하는 부서번호를 구한다.
SELECT deptno
FROM emp
WHERE ename = 'SMITH';

--2. 1번에서 구한 부서 번호에 속하는 직원들 정보를 조회한다.
SELECT *
FROM emp
WHERE deptno = 20;

--SUBQUERY를 이용하면 두개의 쿼리를 동시에 하나의 SQL로 실행이 가능;



SELECT *
FROM emp;



SELECT *
FROM emp 
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE ename = 'SMITH');
                
--실습 SUB1             
SELECT COUNT(*) 
FROM emp
WHERE sal > (SELECT avg (sal)
FROM emp);

--실습 SUB2
SELECT * 
FROM emp
WHERE sal > (SELECT avg (sal)
FROM emp);
-- 다중행 연산자
--IN : 서브쿼리의 여러행중 일치하는 값이 존재 할 때
--ANY (활용도는 다소 떨어짐) : 서브쿼리의 여러행중 한 행이라도 조건을 만족할 때
--ALL (활용도는 다소 떨어짐) : 서브쿼리의 여러행중 모든 행에 대한 조건을 만족할 때;

--SMITH가 속하는 부서의 모든 직원을 조회
--SMITH와 WARD 직원이 속하는 부서의 모든 직원을 조회

--실습 SUB3
--서브쿼리의 결과가 여러 행일 때는 = 연산자를 사용하지 못한다.
SELECT *
FROM emp 
WHERE deptno IN (SELECT deptno
                FROM emp
                WHERE ename IN('SMITH','WARD'));
                
--SMITH, WARD 사원의 급여보다 급여가 작은 직원을 조회(SMITH,WARD의 급여 2가지 모두에 대해 작을떄)
--SMITH : 800
-- WARD : 1250
--> 800보다 급여가 작은 사람
--< 1250보다 급여가 높은사람
SELECT *
FROM emp 
WHERE sal < ANY(800,1250);


SELECT *
FROM emp
WHERE sal > ALL (SELECT sal
                FROM emp
                WHERE ename IN('SMITH','WARD'));
                
    --IN,NOT IN의 NULL과 관련된 유의 사항;
    --직원의 관리자 사번이 7566 이거나 NULL;
    --IN 연산자는 OR 연산자로 치환 가능
    SELECT *
    FROM emp
    WHERE mgr IN(7902, null);
  --NULL비교는 = 연산자가 아니라 IS NULL로 비교 해야지만 IN 연산자는 =로 계산한다.  
    SELECT *
    FROM emp
    WHERE mgr = 7902
    OR mgr = null; --한개 나옴 2개가 나와야함
    
    --NOT IN(7902,NULL)
-- 사원번호가 7902가 아니면서(AND) NULL이 아닌 데이터

SELECT *
FROM emp 
WHERE empno NOT IN (7902,NULL);


--옳은 방법
SELECT * 
FROM emp
WHERE empno != 7902
AND empno IS NOT null;

-- 

-- pairwise (순서쌍) 
-- 순서쌍의 결과를 동시에 만족 시킬때;
--(mgr,deptno)
-- 7698,10 7698,30 7839,10 7839,30

SELECT mgr, deptno
FROM emp 
WHERE mgr IN (SELECT mgr
                        FROM emp
                        WHERE empno IN (7499 , 7782))
AND deptno IN (SELECT deptno
               FROM emp
               WHERE  empno IN (7499,7782));
               
    --스칼리 서브쿼리 : SELECT 절에 기술 , 1개의 ROW, 1개의 COL를 조회하는 쿼리
    --스칼라 서브쿼리는 MAIN 쿼리의 컬럼을 사용하는게 가능하다
    
    SELECT SYSDATE
    FROM dual;
    
    SELECT ( SELECT SYSDATE  FROM dual),dept.*
    FROM dept; 
    
    SELECT empno, ename, deptno, 
    (SELECT dname 
    FROM dept 
    WHERE deptno = emp.deptno) 
    FROM emp;
    
--INLINE VIEW : FROM 절에 기술되는 서브쿼리 ;

--MAIN 쿼리의 컬럼을 SUBQUERY에서 사용하는지 유무에 따른 분류
--사용할 경우 : correlated subqueury(상호 연관 쿼리),서브쿼리미만 단독으로 실행 하는게 불가능
            --실행순서가 정해져있다 (main ==> sub)
--사용하지 않을경우 : non-correlated subquery(비상호 연관 서브쿼리),(서브쿼리만 단독으로 실행하는게 가능)
                           --실행순서가 정해져 있지 않다(main ==> sub, sub ==> main)

--모든 직원의 급여 평균보다 급여가 높은 사람을 조회
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
FROM emp);

--직원이 속한 부서의 급여 평균보다 급여가 높은 사람을 조회
SELECT *
FROM emp m 
WHERE sal > (SELECT AVG(sal) 
            FROM emp s
            WHERE s.deptno = m.deptno);
            
--위의 문제를 조인을 이용해서 풀어보자
-- 1. 조인 테이블 선정
-- emp, 부서별 급여 평균(inline view))

SELECT emp.*--emp.ename, sal ,dept_sal.*
FROM emp, (SELECT deptno, ROUND(AVG(sal)) avg_sal
            FROM emp
            GROUP BY deptno) dept_sal
WHERE emp.deptno = dept_sal.deptno
AND emp.sal > dept_sal.avg_sal;

--sub4;
--데이터 추가;
INSERT INTO dept VALUES (99, 'ddit', 'daejeon');

WHERE deptno = 99;
--DELETE dept;
SELECT *
FROM emp;

ROLLBACK ;-- 트랜잭션 취소
COMMIT; --트랜잭션 확정
-- SUB 실습 4
SELECT *
FROM emp
WHERE deptno NOT IN(SELECT deptno
                FROM dept
                WHERE deptno  =  ) ;