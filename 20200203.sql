SELECT  customer.cnm,cycle.cid,cycle.pid,cycle.day,cycle.cnt 
FROM cycle,customer
WHERE 
customer.cid = cycle.cid
 AND customer.cnm IN('brown','sally');

SELECT *
FROM product;

SELECT * 
FROM customer;

SELECT *
FROM cycle;
--join 5

SELECT customer.cnm, cycle.cid, product.pid,product.pnm, cycle.day, cycle.cnt
FROM customer,product,cycle
WHERE
customer.cid = cycle.cid 
AND customer.cnm IN('brown','sally');


--join 6
SELECT customer.cnm, cycle.cid,product.pid,product.pnm,cycle.cnt,SUM(cycle.cnt)
 FROM customer, cycle, product
 WHERE cycle.cid = cycle.cid 
 AND cycle.pid = product.pid
 GROUP BY customer.cid, customer.cnm, cycle.pid, product.pnm;
 
 --join7 과제
 
 
-- OUTER JOIN
 --두 테이블을 조인할때 연결 조건을 만족 시키지 못하는 데이터를
 -- 기준으로 지정한 테이블의 데이터만이라도 조회 되게끔 하는 조인 방식;
 --연결조건 : e.mgr = m.empno : KONG의 NGR NULL 이기 때문에 조인에 실패한다.
 -- EMP 테이블의 데이터는 총 14건이지만 아래와 같은 쿼리에서는 결과가 13건이 된다 (1건이 조인실패)
 
 SELECT e.empno, e.ename, e.mgr, m.ename
 FROM emp e, emp m 
 WHERE e.mgr = m.empno;
 
 --ANSI OUTER
 -- 1.조인에 실패하더라도 조회가될 테이블을 선정 (매니저 정보가 없어도 사원정보는 나오게끔);
 
 --RIGHT OUTER로 변경
 SELECT e.empno, e.ename, e.mgr, m.ename
 FROM emp m RIGHT OUTER JOIN emp e ON e.mgr = m.empno;
 
 -- ORACLE OUTER JOIN
 -- 데이터가 없는 쪽의 테이블 컬럼 뒤에 (+) 기호를 붙여준다;
 
 SELECT e.empno, e.ename, e.mgr, m.ename
 FROM emp e, emp m 
 WHERE e.mgr = m.empno(+);
 
 --위의 SQL을 ANSI SQL(OUTER JOIN)으로 변경해보세요
  --매니저 부서번호가 10번인 직원만 조회
 SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
 FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno)
 WHERE m.deptno =10;
 
 --오라클 OUTER JOIN;
-- 오라클 OUTER JOIN시 기준 테이블의 반대편 테이블의 모든 컬럼에 (+)를 붙여야 
--정상적인 OUTER JOIN으로 동작한다
-- 한 컬럼이라도 (+)를 누락하면 INER 조인으로 동작
-- 아래 ORACLE OUTER 조인은 INNER 조인으로 동작 : m.deptno 컬럼에 (+)가 붙지 않음
SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno 
 FROM emp e, emp m 
 WHERE e.mgr = m.empno(+)
 AND m.deptno = 10;
 
 SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno 
 FROM emp e, emp m 
 WHERE e.mgr = m.empno(+)
 AND m.deptno = 10;
 
 --사원 - 매니저간 RIGHT OUTER JOIN 
 
 SELECT empno, ename, mgr
 FROM emp e; 
 
 SELECT empno, ename, mgr
 FROM emp m;
 
 SELECT e.empno, e.ename, e.mgr, m.ename, m.empno
 FROM emp e RIGHT OUTER JOIN emp m ON (e.mgr = m.empno);
 
 --FULL OUTER LEFT OUTER + RIGHT OUTER - 중복 제거
 
 SELECT e.empno, e.ename, e.mgr, m.ename, m.empno
 FROM emp e FULL OUTER JOIN emp m ON (e.mgr = m.empno);
 
 --outer join 실습1 
 
 SELECT b.buy_date, b.buy_prod, p.prod_id, p.prod_name, b.buy_qty
 FROM buyprod b RIGHT OUTER JOIN prod p ON b.buy_prod = p.prod_id 
 AND b.buy_date = TO_DATE('2005/01/25','YYYY/MM/DD');
 
 
 