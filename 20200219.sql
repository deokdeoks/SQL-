--쿼리 실행 결과 11건
--페이징 처리(페이지당 10건의 게시글)
1페이지 : 1~10
2페이징 : 11~20
바인드 변수 : page, :pageSize;


--어제 과제
SELECT part_b.deptno, part_b.ename,part_a.lv
FROM
(SELECT part1.* , rownum a
FROM
(SELECT a.*
FROM
(SELECT *
FROM
(SELECT LEVEL lv
FROM dual
CONNECT BY LEVEL <= 14)) a,

(SELECT deptno, count(*) cnt
FROM emp
GROUP BY deptno) b

WHERE b.cnt >= a.lv
ORDER BY b.deptno, a.lv) part1) part_a, 


(SELECT deptno, ename, rownum a
FROM
(select *
FROM emp e
order by deptno, sal desc, ename)) part_b
WHERE part_a.a = part_b.a;

위에 쿼리를 분석함수를 사용해서 표현하면..?

SELECT ename, sal, deptno, RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) rank
FROM emp;


SELECT ename, sal, deptno, ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal DESC) rank
FROM emp;


SELECT a.*, ROWNUM rn
FROM 
(SELECT seq, LAPD(' ' , (LEVEL-1)*4) || title title, DECODE(parent_seq, NULL, seq, parent_seq)root
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY root DESC, seq ASC) a)
WHERE rn BETWEEN (:page -1)*:pageSize + 1 AND 

분석함수 문법
분석함수명(인자) OVER ([PARTITON BY 컬럼] [ORDER BY 컬럼] [WINDOWING])
PARTITION BY 컬럼 : 해당 컬럼이 같은 ROW 끼리 하나의 그룹으로 묶는다
ORDER BY 컬럼 : PARTITION BY에 의해 묶은 그룹 내에서 ORDER BY 컬럼으로 정렬;

ROW_NUMBER() OVER(PARTION BY deptno ORDER BY sal DESC) rank;

순위 관련 분석함수
RANK() : 같은 값을 가질때 중복 순위를 인정, 후순위는 중복 값만큼 떨어진 값부터 시작
        2등이 2명이면 3등은 없고 4등부터 후순위기
DENSE_RANK() : 같은 값을 가질때 중복 순위를 인정, 후순위는 중복순위 다음부터 시작
            2등이 2명이더라도 후순위는 3등부터 시작
ROW_NUMBER() : ROWNUM과 유사, 중복된 값을 허용하지 않음;

부서별, 급여 순위를 3개의 랭킹 관련함수를 적용;
SELECT ename, sal , deptno,
        RANK() OVER (PARTITION BY deptno ORDER BY sal) sal_rank,
        DENSE_RANK() OVER (PARTITION BY deptno ORDER BY sal) sal_dense_rank,
         ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal) sal_row_number
FROM emp;

--실습 ana1 
SELECT ename, sal , deptno, 
        RANK() OVER (ORDER BY sal) sal_rank,
        DENSE_RANK() OVER (ORDER BY sal) sal_dense_rank,
         ROW_NUMBER() OVER (ORDER BY sal) sal_row_number 
FROM emp;

--실습 ana2
SELECT * 
FROM(
SELECT   empno , ename,  deptno, COUNT(*) 
from emp
GROUP BY deptno, ename, empno );




그룹함수 : 전체 직원수
SELECT COUNT(*)
FROM emp;

ana1 : 사원전체 급여 순위
분석함수 에서 그룹 : PARTITION BY ==> 기술하지 않으면 전체행을 대상으로;

통계관련 분석함수 (GROUP 함수에서 제공하는 함수 종류와 동일)
SUM(컬럼)
COUNT(*), COUNT(컬럼)
MIN(컬럼)
MAX(컬럼)
AVG(컬럼)

no_ana2를 분석함수를 사용하여 작성
부서별 직원 수 ;

SELECT empno, ename, deptno, COUNT(*) OVER (PARTITION BY deptno) cnt
FROM emp;

--실습 ana2

SELECT empno, ename, deptno, ROUND(AVG(sal) OVER (PARTITION BY deptno),2) avg_sal
FROM emp;


--실습 3 

SELECT empno, ename, deptno, MIN(sal) OVER (PARTITION BY deptno) max_sal
FROM emp;


급여가 내림차순 정렬하고, 급여가 같을 때는 입사일자가 빠른 사람이 높은 우선순위가 되도록 정렬라혀
현재행의 다음행(LEAD)의 SAL 컬럼을 수하는 쿼리 작성

SELECT empno, ename, hiredate, sal, LEAD(sal) OVER(ORDER BY sal DESC , hiredate) lead_sal
FROM emp;

--실습 ana5
SELECT empno,ename,hiredate,job, LAG(sal) 
OVER(PARTITION BY job ORDER BY sal DESC , hiredate) lag_sal
FROM emp;

--실습 no_ana3

SELECT empno,ename,sal, SUM(sal) 
OVER(ORDER BY sal ASC) c_sum 
FROM emp;

SELECT a.empno, a.ename, a.sal, SUM(b.sal) C_SUM
FROM 
    (SELECT a.*, rownum rn
    FROM 
        (SELECT *
        FROM emp
        ORDER BY sal)a)a,
    (SELECT a.*, rownum rn
    FROM 
        (SELECT *
        FROM emp
        ORDER BY sal, empno)a)b
WHERE a.rn >= b.rn
GROUP BY a.empno, a.ename, a.sal, a.rn
ORDER BY a.rn, a.empno ;


no_ana3을 분석함수를 이용하여 SQL 작성;

SELECT empno, ename, sal ,SUM(sal) OVER (ORDER BY sal, empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) cumm_sal
FROM emp;

현재행을 기준으로 이전 한행부터 이후 한행까지 총 3개행의 sal 합계 구하기;
SELECT empno, ename, sal, SUM(sal) OVER (ORDER BY sal, empno ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) c_sum
FROM emp;

-- 실습 ana7
SELECT empno, ename, deptno, sal, SUM(sal) OVER (PARTITION BY deptno ORDER BY sal, empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) c_sum
FROM emp
ORDER BY deptno,sal,c_sum ;

ana7 부서별로 급여, 사원번호 오름차순 정렬 했을 때 , 자긴의 급여와 선행하는(이전) 사원들의 급여합을 조회하는 쿼리 작성
컬럼 : ename, empno, deptno, sal 누적합
ORDER BY 기술후 WINDOWING 절을 기술하지 않을 경우 다음 WINDOWING이 기본 값으로 적용 된다
RANGE UNBOUNDED 

WINDOWING의 RANGE, ROW비교
RANGE : 논리적인 행위 단위, 같은 값을 가지는 컬럼까지 자신의 행으로 취급
ROWS : 물리적인 행의 단위;

SELECT empno, ename, deptno, sal,
        SUM(sal) OVER (PARTITION BY deptno ORDER BY sal ROWS UNBOUNDED PRECEDING) row_,
        SUM(sal) OVER (PARTITION BY deptno ORDER BY sal range UNBOUNDED PRECEDING) range_,
        SUM(sal) OVER (PARTITION BY deptno ORDER BY sal)default_
FROM emp;
