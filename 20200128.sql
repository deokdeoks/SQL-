SELECT *
FROM emp 
WHERE deptno IN(10,30) AND sal >= 1500
ORDER BY ename desc ;

----ROWNUM : 행번호를 나타내는 컬럼
SELECT ROWNUM, empno, ename
FROM emp
WHERE deptno IN(10,30)
AND sal > 1500;

--ROWNUM을 WHERE절에서도 사용가능
--동작하는거 : (1은 되고, 2는 안됨) ROWNUM =1, ROWNUM <=2 --> ROWNUM=1, ROWNUM <= N
--동작화지 않는거 : ROWNUM-=2, ROUWNUM >=2 --> ROUWNUM=N(N은 1이 아닌정수), RIWNUM >= N(N은 1이 아닌 정수)
--ROWNUM 이미 읽은 데이터에다가 순서를 부여
--읽지 않은 상태의 값을 (ROWNUN이 부여되지 않은 행)은 조회할 수가 없다.
--유의점 1, 읽지 않은 상태의 값은(ROWNUM)이 부여되지 않은 행은 조회할 수 가 없다.
--유의점 2, ORDER BY 절은 SELECT 절 이후에 실행
--사용용도 : 페이징 처리
-- 테이블에 있는 모든 행을 소화하는 것이 아니라 우리가 원하는 페이지에 해당하는 행 데이터만 조회를 한다.
--페이징 처리시 고려사항 : 1페이지당 건수, 정렬 기준
--emp테이블 총 row 건수 : 14
--페이징당 5건의 데이터를 조회
--1page : 1~5
--2page : 6~10
--3page : 11~15


SELECT ROWNUM rn, empno, ename
FROM emp
ORDER BY ename;


--정렬된 결과에 ROWNUM을 부여하기 위해서는 IN LIVE VIEW를 사용한다.
--요점정리 : 1.정렬 , 2.ROWNUM 부여
-- SELECT * 를 기술할 경우 다른 EXPRESSION을 표기
--하기 위해서 테이블명. * 테이블명칭.*로 표현해야한다.
-- ROWNUM -> rn
-- *page size : 5, 정렬기준은 ename
-- 1page : rn 1~5
-- 2page : rn 6~10
-- 3page : rn 11~15
-- n page : rn (n-1)*pageSize +1  ~ n* pageSize
SELECT*
FROM
(SELECT ROWNUM rn , a.*
FROM
(SELECT empno, ename
FROM emp
ORDER BY ename) a)
WHERE rn >= 1 AND rn <=10;

--오더바이랑 로넘을 같이 쓰면 오더바이 셀렉트 이후에 실행이 된다.

-- 가상 컬럼 ROWNUM 실습 row1

SELECT*
FROM
(SELECT ROWNUM rn , e.*
FROM
(SELECT empno, ename
FROM emp) e)
WHERE rn >= 1 AND rn <=10;

--row 1 
SELECT ROWNUM rn, empno, ename
FROM emp
WHERE rn <= 10;

SELECT *
FROM 
 (SELECT ROWNUM rn, empno, ename
 FROM emp)
 WHERE rn <=10;
 
 ---row 2 
 SELECT *
 FROM 
    (SELECT ROWNUM rn, empno, ename
    FROM emp)
    WHERE rn BETWEEN 11 AND 20;
    
--row 3 
-- 풀어사람 시켜봄 복습
SELECT * 
FROM
(SELECT ROWNUM rn, a.*
FROM
(SELECT empno, ename
FROM emp
ORDER BY ename) a)
WHERE rn BETWEEN (:page -1 )*10+1 AND :page * :pageSize;

SELECT * 
FROM
(SELECT ROWNUM rn, a.*
FROM
(SELECT empno, ename
FROM emp
ORDER BY ename) a)
WHERE rn BETWEEN 11 AND 14;

-- DUAL 테이블 : 데이터와 관계 없이, 함수를 테스트 해볼 목적으로 사용
-- 문자열 대소문자 : LOWER, UPPER, INITCAP
SELECT LOWER('Hello, World'),UPPER('Hello, World'),INITCAP('Hello, World') 
FROM dual;

SELECT LOWER('Hello, World'),UPPER('Hello, World'),INITCAP('Hello, World') 
FROM emp;

--함수는 WHERE 절 에서도 사용 가능
-- 사원 이름이 SMITH인 사람만 조회
SELECT *
FROM emp
WHERE ename = 'SMITH';

-- SQL 작성시 아래 형태는 지양해야한다.
--테이블의 컬럼을 가공하지 않는 형태로 sql을 작성한다.
SELECT * 
FROM emp
WHERE LOWER(ename) = :ename;

SELECT CONCAT('Hello', ' , World') CONCAT,
    SUBSTR('Hello, World' , 1,5), -- 1~5
    LENGTH('Hello, World')len, --글자수
    INSTR('Hello, World','o') ins,
    INSTR('Hello, World','o',6) ins2, -- 6번째 이후에 나오는 o는 몇번째 인지?
    LPAD('Hello, World',15, '*')LP, -- 패딩으로 15글자로 채워줌
    RPAD('Hello, World',15, '*')RP,  -- LP왼쪽 RP 오른쪽 패딩
    REPLACE('Hello,World','H','T')REP,
    TRIM('     Hello, World       ') TR, -- 공백을 제거
    TRIM('d'  FROM  'Hello, World') TR -- 공백이 아닌 소문자 d제거
    FROM dual;
    
    --숫자 함수
    --ROUND : 반올림 (10.6을 소수점 첫번째 자리에서 반올림 -> 11)
    --TRUNC : 절삭(버림) (10.6을 소수점 첫번째 자리에서 절삭 --> 10)
    --ROUND, TURNC : 몇번째 자리에서 반올림 / 절식
    --MOD :  나머지 (몫이 아니라 나누기 연산을 한 나머지 값) (13/5 --> 몫:2 , 나머지 :3)

--ROUND (대상,숫자,최종 결과 자리)
SELECT ROUND(105.54,1), --반올림 결과가 소수점 첫번째 자리 까지 나오도록 --> 두번째 자리에서 반올림
       ROUND(105.55,1), --반올림 결과가 소수점 첫번째 자리 까지 나오도록 --> 두번째 자리에서 반올림
       ROUND(105.55,0),  --반올림 결과가 정수부만 나오도록 --> 소수점 첫번째 자리 반올림
       ROUND(105.55,-1), -- 반올림 결과가 십의 자리까지 --> 일의 자리에서 반올림 
       ROUND(105.55)
    FROM dual;
    
SELECT TRUNC(105.54,1), --절삭의 결과가 소수점 첫번째 자리까지 나오도록 -> 두번째 자리에서 절삭
       TRUNC(105.55,1), --절삭의 결과가 소수점 첫번째 자리까지 나오도록 -> 두번째 자리에서 절삭
       TRUNC(105.55,0) -- 절삭의 결과가 정수부(일의 자리)까지 나오도록 --> 소수점 첫번째 자리에서 절삭
FROM dual;

--EMP테이블에서 사원의 급여(sal)를 1000으로
--나눴을때 몫
SELECT ename,sal, TRUNC(sal/1000), --몫을 구해보세요
                MOD(sal,1000) -- ㅡmod의 결과는 divisor보다 항상작다
                              --0~999
FROM emp;
DESC emp;

--년도 2자리 / 월2자리 / 일자 2자리
SELECT ename, hiredate
FROM emp;

--SYSDATE : 현재 오라클 서버의 시분초가 포함된 날짜 정보를 리턴하는 특수 함수
--함수명 (인지1, 인지2)
-- date + 정수 = 일자 연산
-- 2020/01/28 + 5

--숫자 표기 : 숫자
--문자 표기 : 상급 쿼테이션 + 문자열 + 싱글 쿼테이션 --> '문자열'
--날짜 표기 : TO_DATE('문자열 날짜 값', '문자열 날짜 값의 표기 형식') 
            --> TO_DATE('2020-01-28','YYYY-MM-DD') 

SELECT SYSDATE + 5 , SYSDATE + 1/24
FROM dual;

SELECT to_date('2019/12/31','YYYY/MM/DD')
,to_date('2019/12/31','YYYY/MM/DD')-5,
sysdate 
FROM dual;

SELECT TO_CHAR(SYSDATE,'YYYY-MM/DD HH24:MI:SS')

