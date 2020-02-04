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
 
 --join7 ����
 
 
-- OUTER JOIN
 --�� ���̺��� �����Ҷ� ���� ������ ���� ��Ű�� ���ϴ� �����͸�
 -- �������� ������ ���̺��� �����͸��̶� ��ȸ �ǰԲ� �ϴ� ���� ���;
 --�������� : e.mgr = m.empno : KONG�� NGR NULL �̱� ������ ���ο� �����Ѵ�.
 -- EMP ���̺��� �����ʹ� �� 14�������� �Ʒ��� ���� ���������� ����� 13���� �ȴ� (1���� ���ν���)
 
 SELECT e.empno, e.ename, e.mgr, m.ename
 FROM emp e, emp m 
 WHERE e.mgr = m.empno;
 
 --ANSI OUTER
 -- 1.���ο� �����ϴ��� ��ȸ���� ���̺��� ���� (�Ŵ��� ������ ��� ��������� �����Բ�);
 
 --RIGHT OUTER�� ����
 SELECT e.empno, e.ename, e.mgr, m.ename
 FROM emp m RIGHT OUTER JOIN emp e ON e.mgr = m.empno;
 
 -- ORACLE OUTER JOIN
 -- �����Ͱ� ���� ���� ���̺� �÷� �ڿ� (+) ��ȣ�� �ٿ��ش�;
 
 SELECT e.empno, e.ename, e.mgr, m.ename
 FROM emp e, emp m 
 WHERE e.mgr = m.empno(+);
 
 --���� SQL�� ANSI SQL(OUTER JOIN)���� �����غ�����
  --�Ŵ��� �μ���ȣ�� 10���� ������ ��ȸ
 SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
 FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno)
 WHERE m.deptno =10;
 
 --����Ŭ OUTER JOIN;
-- ����Ŭ OUTER JOIN�� ���� ���̺��� �ݴ��� ���̺��� ��� �÷��� (+)�� �ٿ��� 
--�������� OUTER JOIN���� �����Ѵ�
-- �� �÷��̶� (+)�� �����ϸ� INER �������� ����
-- �Ʒ� ORACLE OUTER ������ INNER �������� ���� : m.deptno �÷��� (+)�� ���� ����
SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno 
 FROM emp e, emp m 
 WHERE e.mgr = m.empno(+)
 AND m.deptno = 10;
 
 SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno 
 FROM emp e, emp m 
 WHERE e.mgr = m.empno(+)
 AND m.deptno = 10;
 
 --��� - �Ŵ����� RIGHT OUTER JOIN 
 
 SELECT empno, ename, mgr
 FROM emp e; 
 
 SELECT empno, ename, mgr
 FROM emp m;
 
 SELECT e.empno, e.ename, e.mgr, m.ename, m.empno
 FROM emp e RIGHT OUTER JOIN emp m ON (e.mgr = m.empno);
 
 --FULL OUTER LEFT OUTER + RIGHT OUTER - �ߺ� ����
 
 SELECT e.empno, e.ename, e.mgr, m.ename, m.empno
 FROM emp e FULL OUTER JOIN emp m ON (e.mgr = m.empno);
 
 --outer join �ǽ�1 
 
 SELECT b.buy_date, b.buy_prod, p.prod_id, p.prod_name, b.buy_qty
 FROM buyprod b RIGHT OUTER JOIN prod p ON b.buy_prod = p.prod_id 
 AND b.buy_date = TO_DATE('2005/01/25','YYYY/MM/DD');
 
 
 