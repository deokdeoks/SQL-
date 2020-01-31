--cond1 실습

SELECT empno,ename,
 CASE 
 WHEN deptno = 10 THEN 'ACCONTING' 
 WHEN deptno = 20 THEN 'RESEARCH' 
 WHEN deptno = 30 THEN 'S1ALES'
 WHEN deptno = 40 THEN 'OPERATIONS'
 else 'DDIT'
 END dname
FROM emp;

--cond2 실습
--올해년도가 짝수이면
--   입사년도가 짝수일 때 건감검진 대상자
--   입사년도가 홀수일 때 건감검진 대상자
--올해년도가 홀수이면
-- 입사년도가 짝수일 때 건감검진 대상자
-- 입사년도가 홀수일 때 건감검진 대상자
SELECT empno,ename,hiredate
 FROM emp;
 
 --올해년도가 짝수인지, 홀수인지 확인
 --DATE 타입 -> 문자열(여러가지 포맷, YYYY-MM-DD HH24:MI:SS)
 --짝수 -> 2로 나눴을때 나머지0
 --홀수 -> 2로 나눴을때 나머지
 SELECT empno,ename,hiredate, 
 MOD(TO_NUMBER(TO_CHAR(hiredate,'YYYY')),2) hire,
 MOD(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')),2),
 CASE
   WHEN MOD(TO_NUMBER(TO_CHAR(hiredate,'YYYY'),2) = MOD(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')),2)
   THEN '건강검진 대상자'
   ELSE '건강검진 비대상자'
END concat_to_doctor
 DECODE(MOD(TO_NUMBER(TO_CHAR(hiredate,'YYYY')),2) = MOD(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')),2)
 
 
 FROM emp;

SELECT  empno,ename,hiredate,
DECODE(MOD(TO_NUMBER,
FROM emp;


SELECT *
FROM emp;

--GROUP BY 행을 묶을 기준
-- 부서번호 같은 ROW끼리 묶는 경우: GROUP BY deptno
-- 담당업무가 같은 ROW끼리 묶는 경우 : GROUP BY job
-- MGR가 같고 담당업무가 같은 ROW끼리 묶는 경우 : GROUP BY mgr, job 

-- 그룹함수의 종류
-- SUM : 합계
-- COUNT : 갯수 -NULL값이 아닌 ROW의 갯수)
-- MAX : 최대값
-- MIN : 최소값
-- AVG : 평균

--그룹함수의 특징
--해당 컬럼에 NULL값을 갖는 ROW가 존재할 경우 해당 값은 무시하고 계산한다 (NULL 연산의 결과는 NULL)

--부서별 급여 합

--그룹함수 주의점
--GROUP BY 절에 나온 컬럼이외의 다른컬럼이 SELECT절에 표현되면 에러 (중요)
SELECT deptno, SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal),ROUND(AVG(sal),2), COUNT(sal) 
FROM emp
GROUP BY deptno, ename;

--GROUP BY 절이 없는 상태에서 그룹함수를 사용할 경우
--전체행을 하나의 행으로 묶는다

--GROUP BY의 기준이 empno이면 결과수가 몇건?
--그룹화와 관련없는 임의의 문자열, 함수, 숫자등은 SELECT 절에 나오는 것이 가능
SELECT 1, SYSDATE, SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal),ROUND(AVG(sal),2), 
COUNT(sal), -- sal 컬럼의 값이 null이 아닌 row의 갯수
COUNT(comm), -- cmm 컬럼의 값이 null이 아닌 row의 갯수
COUNT(*) -- 몇건의 데이터가 있는지
FROM emp
GROUP BY empno;

--SINGLE ROW FUNCTION의 경우 WHERE 절에서 사용하는 것이 가능하나
-- MULTI ROW FUNCTION(GROUP FUNCTION)의 경우 WHERE 절에서 사용하는 것이 불가능 하고
-- HAVING 절에서 조건을 기술한다

-- 부서별 급여 함 조회 , 단 급여합이 9000이상인 row만 조회
-- deptno, 급여함
SELECT deptno, SUM(sal) sum_sal
FROM emp
GROUP BY deptno
HAVING SUM(sal) > 9000;

--group fuction 실습 grp1

SELECT MAX(sal) max_sal , MIN(sal) min_sal ,AVG(sal) avg_sal,SUM(sal) sum_sal ,
COUNT(sal) count_sal, --직원 중 급여가 있는 직원의 수 (null 제외)
COUNT(mgr) count_mgr , -- 직원중 상급자가 있는 직원의 수 (null 제외)
COUNT(*) count_all --전체 직원의 수
FROM emp;

-- group function 실습 grp
SELECT deptno, MAX(sal) max_sal , MIN(sal) min_sal ,ROUND(avg(sal),2), avg_sal, SUM(sal) ,
COUNT(sal) , 
COUNT(mgr) ,
COUNT(*)
FROM emp
GROUP BY deptno;

SELECT 
    (CASE 
     WHEN deptno =  10 THEN 'ACCOUNTING'
     WHEN deptno =  20 THEN 'RESEARCH'
     WHEN deptno =  30 THEN 'SALES'
    END)dname, 
    MAX(sal) max_sal, MIN(sal) min_sal, ROUND(avg(sal),2) avg_sal, SUM(sal), COUNT(sal), COUNT(mgr), COUNT(*)
FROM emp
GROUP BY deptno;


--function(group function 실습 grp4)  
SELECT TO_CHAR(hiredate,'YYYYMM'), COUNT(*) cnt
FROM emp
GROUP BY  TO_CHAR(hiredate, 'YYYYMM');

--function(group function 실습 grp5)
SELECT TO_CHAR(hiredate,'YYYY'), COUNT(*) cnt
FROM emp
GROUP BY  TO_CHAR(hiredate, 'YYYY');

--function (group function 실습 grp6)
SELECT COUNT(*) cnt
FROM dept;




SELECT COUNT(*) 
FROM
(SELECT deptno
FROM emp
GROUP BY deptno);


SELECT *
FROM emp;