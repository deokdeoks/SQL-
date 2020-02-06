--sub4

--dept 테이블에는 5건의 데이터가 존재
--emp 테이블에는 14며의 직원이 있고, 직원은 하나의 부서 속해 있다(deptno)
--부서중 직원이 속해 있지 않은 부서 정보를 조회
--서브쿼리에서 데이터의 조건이 맞는지 확인자 역할을 하는 서브쿼리 작성;
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
                    FROM emp); -- 중복제거
                    
--실습 sub5
SELECT *
FROM cycle;

SELECT *
FROM product;

SELECT *
FROM product
WHERE pid NOT IN (SELECT pid
                    FROM cycle
                    WHERE cid = 1);
                    
                    
--sub5를 조인 방식으로 풀어보기;

--sub6(실습)

SELECT *
FROM cycle
WHERE cid = 1 
AND pid IN(SELECT pid
                FROM cycle
                WHERE cid = 2);
                
                
                
--sub7(실습)
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

--매니저가 존재하는 직원을 조회 (king을 제외한 13명의 데이터가 조회)
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

--EXSITS 조건에 만족하는 행이 존재하는지 확인하는 연산자
--다른 연산자와 다르게 WHERE 절에 컬럼을 기술하지 않는다
 WHERE empno = 7369
 WHERE EXISTS (SELECT 'X'
                FROM .....);
                
-- 매니저가 존재하는 직원을 EXISTS 연산자를 통해 조회
-- 매니저도 직원;
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



--집합연산
--합집합 : UNION - 중복제거(집합개념) /UNION ALL - 중복을 제거하지 않음(속도 향상)
--교집합 : INTERSECT (집합개념)
--차집합 : MINUS(집합개념)
--집합연산 공통사항
-- 두 집합의 컬럼의 개수 , 타입이 일치 해야 한다.

--동일한 집합을 합집하기 때문에 중복되는 데이터는 한번만 적용된다.
SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698)

UNION ALL

SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698);

--집합 기술 순서가 영향이 가는 집합 연산자
A UNION B = B UNOIN A ==> 같음
A UNION ALL B  B UNION ALL A ==> 같음 
A INTERSECT B B INTERSECT A ==> 같음
A MINUS B     B MINUS A ==> 다름

---집합연산의 결과 컬럼 이름은 첫번째 집합의 컬럼명을 따른다;

SELECT 'X' fir. 'B' SEC
FROM dual

UNION 

SELECT 'Y','A'
FROM dual;
--정렬 (ORDER BY)는 집합연산 가장 마지막 집합 다음에 기술
SELECT deptno, dname, loc
FROM dept
WHERE deptno IN (10,20)

UNION

SELECT deptno, dname, loc
FROM dept
WHERE deptno IN(30,40)
ORDER BY DEPTNO;


--햄버거 도시 발전지수

SELECT *
FROM fastfood;

--시도,시군구,버거지수
--버거지수 값이 높은 도시가 먼저 나오도록 정렬

SELECT gb
from fastfood;
group by gb;

SELECT count(*)
FROM fastfood
WHERE gb = 'KFC';

SELECT g1.sido, g1.sigungu, ROUND(g1_/g2_,1)
FROM (SELECT sido,sigungu, COUNT(gb) g1_
FROM fastfood 
WHERE gb IN('맥도날드','KFC','버거킹')
GROUP BY sido,sigungu)g1,
(SELECT sido,sigungu, COUNT(gb) g2_
FROM fastfood 
WHERE gb IN('롯데리아')
GROUP BY sido,sigungu)g2
WHERE g1.sido = g2.sido AND g1.sigungu = g2.sigungu;

SELECT g1.sido,g1.sigungu,ROUND(g1_/g2_,1)
FROM (SELECT sido,sigungu ,COUNT(gb)g1_
FROM fastfood 
WHERE gb IN('KFC','맥도날드','버거킹')
GROUP BY sido,sigungu)g1,
(SELECT  sido,sigungu,COUNT(gb)g2_
FROM fastfood
WHERE gb IN('롯데리아')
GROUP BY sido,sigungu)g2
WHERE g1.sido = g2.sido AND g1.sigungu = g2.sigungu;

SELECT g1.sido,g1.sigungu,ROUND(g_1/g_2,1)
FROM (SELECT sido,sigungu,COUNT(gb)g_1
FROM fastfood
WHERE gb IN('맥도날드','KFC','버거킹')
GROUP BY sido,sigungu)g1,
(SELECT sido, sigungu, COUNT(gb)g_2
FROM fastfood
WHERE gb IN('롯데리아')
GROUP BY sido,sigungu)g2
WHERE g1.sido=g2.sido 
AND g1.sigungu = g2.sigungu;

--대전시 대덕구 버거지수 : 
--대전시 중구 버거지수 : 
--대전시 서구 버거지수 : 
--대전시 유성구 버거지수 : 
--대전시 동구 버거지수 : 

--분자(KFC, 버거킹, 맥도날드)
SELECT *
FROM
(SELECT sido, sigungu, COUNT(*)
FROM fastfood 
WHERE sido = '대전광역시'
AND GB IN ('KFC','맥도날드','버거킹')
GROUP BY sido, sigungu) a,;

--fastfood 테이블을 한번만 읽는 방식으로 작성하기;

SELECT sido, sigungu, ROUND(kfc+ BURGERKING + mac) / lot,2) burger_score
FROM 
(SELECT sido, sigungu,
NVL(SUM(DECODE(gb, 'kfc', 1)),0) kfc,
NVL(SUM(DECODE(gb, '버거킹', 1)),0) BURGERKING,
NVL(SUM(DECODE(gb, '맥도날드',1)),0) mac,
NVL(SUM(DECODE(gb, '롯데리아', 1)),1) lot
FROM fastfood
WHERE gb IN ('KFC','버거킹','맥도날드','롯데리아')
GROUP BY sido, sigungu)
ORDER BY buger_score DESC;


SELECT sido, sigungu, ROUND(sal/people) pri_sal
FROM tax
ORDER BY pri_sal DESC;

--햄버거지수 시도 , 햄버거지수 시군구, 햄버거지수, 세금 시도, 세금 시군구, 개인별 근로소득액
-- 지수, 개인별 근로소득 금액으로 정렬후 ROWNUM을 통해 순위 부여
--같은 행끼리 조인
서울특별시 중구5.67    서울특별시 강남구 70
서울특별시 도봉구 5    서울특별시 서초구 69
경기도 구리시 5       서울특별시 용산구 57
서울특별시 강남구 4.57  경기도 과천시 54
서울특별시 서초구 4        서울특별시 종로구 47

--ROWNUM 사용시 주의
--1. SELECT ==> ORDER BY
--정렬된 결과에 ROWNUM을 적용하기 위해서는 INLINE_VIEW
-- 1번부터 순차적으로 조회가 되는 조건에 대해서만 WERER 절에서 기술이 가능
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
WHERE gb IN('맥도날드','KFC','버거킹')
GROUP BY sido,sigungu)g1,
(SELECT sido, sigungu, COUNT(gb)g_2
FROM fastfood
WHERE gb IN('롯데리아')
GROUP BY sido,sigungu)g2
WHERE g1.sido=g2.sido 
AND g1.sigungu = g2.sigungu
ORDER BY ROUND(g_1/g_2,2)desc)bugger)


(SELECT ROWNUM,rowsaltax,saltax.*
FROM
(SELECT sido, sigungu, ROUND(sal/people) pri_sal 
FROM tax 
ORDER BY pri_sal DESC) saltax) saltax_2;
