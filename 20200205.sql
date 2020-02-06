--sub4

--dept ���̺��� 5���� �����Ͱ� ����
--emp ���̺��� 14���� ������ �ְ�, ������ �ϳ��� �μ� ���� �ִ�(deptno)
--�μ��� ������ ���� ���� ���� �μ� ������ ��ȸ
--������������ �������� ������ �´��� Ȯ���� ������ �ϴ� �������� �ۼ�;
SELECT * 
FROM dept
WHERE deptno NOT IN(10,20,30);

SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                    FROM emp
                    GROUP BY deptno);
                    
SELECT *
FROM dept
WHERE deptno NOT IN (SELECT DISTINCT deptno
                    FROM emp); -- �ߺ�����
                    
--�ǽ� sub5
SELECT *
FROM cycle;

SELECT *
FROM product;

SELECT *
FROM product
WHERE pid NOT IN (SELECT pid
                    FROM cycle
                    WHERE cid = 1);
                    
                    
--sub5�� ���� ������� Ǯ���;

--sub6(�ǽ�)

SELECT *
FROM cycle
WHERE cid = 1 
AND pid IN(SELECT pid
                FROM cycle
                WHERE cid = 2);
                
                
                
--sub7(�ǽ�)
SELECT cy.cnt, p.pnm , cy.cid, cy.day, p.pid
FROM cycle cy ,customer c,product p  
WHERE cy.cid = 1 
AND cy.pid IN(SELECT pid
                FROM cycle
                WHERE cid = 2);
                
                SELECT * 
                FROM cycle;
                
                SELECT *
                FROM product;
                
                SELECT * 
                FROM customer;
                
                
SELECT a.cid , customer.cnm, a.pid, product.pnm, a.day, a.cnt
FROM
(SELECT *
FROM cycle
WHERE cid = 1 
AND pid IN(SELECT pid
                FROM cycle
                WHERE cid = 2))a, customer, product
    WHERE a.cid = customer.cid
    AND a.pid = product.pid;
    
SELECT cycle.cid, customer.cnm, cycle.pid , product.pnm, cycle.day, cycle.cnt
FROM cycle,customer,product
WHERE cycle.cid = 1 
AND cycle.pid IN(SELECT pid
                FROM cycle
                WHERE cid = 2)
AND cycle.cid = customer.cid
AND cycle.pid = product.pid;

--�Ŵ����� �����ϴ� ������ ��ȸ (king�� ������ 13���� �����Ͱ� ��ȸ)
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

--EXSITS ���ǿ� �����ϴ� ���� �����ϴ��� Ȯ���ϴ� ������
--�ٸ� �����ڿ� �ٸ��� WHERE ���� �÷��� ������� �ʴ´�
 WHERE empno = 7369
 WHERE EXISTS (SELECT 'X'
                FROM .....);
                
-- �Ŵ����� �����ϴ� ������ EXISTS �����ڸ� ���� ��ȸ
-- �Ŵ����� ����;
SELECT * 
FROM emp e
WHERE EXISTS (SELECT 'X'
             FROM emp m 
             WHERE e.mgr = m.empno);
             
--sub9
SELECT *
FROM product p 
WHERE EXISTS (SELECT 'X'
                FROM cycle c 
                WHERE cid=1 AND c.pid = p.pid  ); 


SELECT *
FROM cycle;

SELECT*
FROM product;

--sub10
SELECT *
FROM product p 
WHERE NOT EXISTS (SELECT 'X' pid
                FROM cycle c 
                WHERE cid=1 
                AND c.pid = p.pid ); 
                
SELECT *
from product p
WHERE NOT EXISTS(SELECT 'X' pid
                FROM cycle c
                WHERE cid=1
                AND c.pid = p.pid);



--���տ���
--������ : UNION - �ߺ�����(���հ���) /UNION ALL - �ߺ��� �������� ����(�ӵ� ���)
--������ : INTERSECT (���հ���)
--������ : MINUS(���հ���)
--���տ��� �������
-- �� ������ �÷��� ���� , Ÿ���� ��ġ �ؾ� �Ѵ�.

--������ ������ �����ϱ� ������ �ߺ��Ǵ� �����ʹ� �ѹ��� ����ȴ�.
SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698)

UNION ALL

SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698);

--���� ��� ������ ������ ���� ���� ������
A UNION B = B UNOIN A ==> ����
A UNION ALL B  B UNION ALL A ==> ���� 
A INTERSECT B B INTERSECT A ==> ����
A MINUS B     B MINUS A ==> �ٸ�

---���տ����� ��� �÷� �̸��� ù��° ������ �÷����� ������;

SELECT 'X' fir. 'B' SEC
FROM dual

UNION 

SELECT 'Y','A'
FROM dual;
--���� (ORDER BY)�� ���տ��� ���� ������ ���� ������ ���
SELECT deptno, dname, loc
FROM dept
WHERE deptno IN (10,20)

UNION

SELECT deptno, dname, loc
FROM dept
WHERE deptno IN(30,40)
ORDER BY DEPTNO;


--�ܹ��� ���� ��������

SELECT *
FROM fastfood;

--�õ�,�ñ���,��������
--�������� ���� ���� ���ð� ���� �������� ����

SELECT gb
from fastfood;
group by gb;

SELECT count(*)
FROM fastfood
WHERE gb = 'KFC';

SELECT g1.sido, g1.sigungu, ROUND(g1_/g2_,1)
FROM (SELECT sido,sigungu, COUNT(gb) g1_
FROM fastfood 
WHERE gb IN('�Ƶ�����','KFC','����ŷ')
GROUP BY sido,sigungu)g1,
(SELECT sido,sigungu, COUNT(gb) g2_
FROM fastfood 
WHERE gb IN('�Ե�����')
GROUP BY sido,sigungu)g2
WHERE g1.sido = g2.sido AND g1.sigungu = g2.sigungu;

SELECT g1.sido,g1.sigungu,ROUND(g1_/g2_,1)
FROM (SELECT sido,sigungu ,COUNT(gb)g1_
FROM fastfood 
WHERE gb IN('KFC','�Ƶ�����','����ŷ')
GROUP BY sido,sigungu)g1,
(SELECT  sido,sigungu,COUNT(gb)g2_
FROM fastfood
WHERE gb IN('�Ե�����')
GROUP BY sido,sigungu)g2
WHERE g1.sido = g2.sido AND g1.sigungu = g2.sigungu;

SELECT g1.sido,g1.sigungu,ROUND(g_1/g_2,1)
FROM (SELECT sido,sigungu,COUNT(gb)g_1
FROM fastfood
WHERE gb IN('�Ƶ�����','KFC','����ŷ')
GROUP BY sido,sigungu)g1,
(SELECT sido, sigungu, COUNT(gb)g_2
FROM fastfood
WHERE gb IN('�Ե�����')
GROUP BY sido,sigungu)g2
WHERE g1.sido=g2.sido 
AND g1.sigungu = g2.sigungu;

--������ ����� �������� : 
--������ �߱� �������� : 
--������ ���� �������� : 
--������ ������ �������� : 
--������ ���� �������� : 

--����(KFC, ����ŷ, �Ƶ�����)
SELECT *
FROM
(SELECT sido, sigungu, COUNT(*)
FROM fastfood 
WHERE sido = '����������'
AND GB IN ('KFC','�Ƶ�����','����ŷ')
GROUP BY sido, sigungu) a,;

--fastfood ���̺��� �ѹ��� �д� ������� �ۼ��ϱ�;

SELECT sido, sigungu, ROUND(kfc+ BURGERKING + mac) / lot,2) burger_score
FROM 
(SELECT sido, sigungu,
NVL(SUM(DECODE(gb, 'kfc', 1)),0) kfc,
NVL(SUM(DECODE(gb, '����ŷ', 1)),0) BURGERKING,
NVL(SUM(DECODE(gb, '�Ƶ�����',1)),0) mac,
NVL(SUM(DECODE(gb, '�Ե�����', 1)),1) lot
FROM fastfood
WHERE gb IN ('KFC','����ŷ','�Ƶ�����','�Ե�����')
GROUP BY sido, sigungu)
ORDER BY buger_score DESC;


SELECT sido, sigungu, ROUND(sal/people) pri_sal
FROM tax
ORDER BY pri_sal DESC;

--�ܹ������� �õ� , �ܹ������� �ñ���, �ܹ�������, ���� �õ�, ���� �ñ���, ���κ� �ٷμҵ��
-- ����, ���κ� �ٷμҵ� �ݾ����� ������ ROWNUM�� ���� ���� �ο�
--���� �ೢ�� ����
����Ư���� �߱�5.67    ����Ư���� ������ 70
����Ư���� ������ 5    ����Ư���� ���ʱ� 69
��⵵ ������ 5       ����Ư���� ��걸 57
����Ư���� ������ 4.57  ��⵵ ��õ�� 54
����Ư���� ���ʱ� 4        ����Ư���� ���α� 47

--ROWNUM ���� ����
--1. SELECT ==> ORDER BY
--���ĵ� ����� ROWNUM�� �����ϱ� ���ؼ��� INLINE_VIEW
-- 1������ ���������� ��ȸ�� �Ǵ� ���ǿ� ���ؼ��� WERER ������ ����� ����
ROWNUM = 1 (O)
ROWNUM = 2 (X)
ROWNUM < 10 (O)
ROWNUM > 10 (O)

SELECT b.sido, b.sigungu,b.buger_score,a.sido,a.sigungu,a.pri_sal
FROM
(SELECT ROWNUM,rn,b.*
FROM
(SELECT sido, sigungu, ROUND(sal/people) pri_sal 
FROM tax 
ORDER BY pri_sal DESC)a)a,

SELECT g1.sido,g1.sigungu,ROUND(g_1/g_2,1)
FROM (SELECT sido,sigungu,COUNT(gb)g_1
FROM fastfood
WHERE gb IN('�Ƶ�����','KFC','����ŷ')
GROUP BY sido,sigungu)g1,
(SELECT sido, sigungu, COUNT(gb)g_2
FROM fastfood
WHERE gb IN('�Ե�����')
GROUP BY sido,sigungu)g2
WHERE g1.sido=g2.sido 
AND g1.sigungu = g2.sigungu
ORDER BY ROUND(g_1/g_2,2)desc)bugger)


(SELECT ROWNUM,rowsaltax,saltax.*
FROM
(SELECT sido, sigungu, ROUND(sal/people) pri_sal 
FROM tax 
ORDER BY pri_sal DESC) saltax) saltax_2;
