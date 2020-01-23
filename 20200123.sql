SELECT *

FROM iprod;

SELECT buyer_id, buyer_name
FROM buyer;

SELECT *
FROM cart;

SELECT mem_id, mem_pass, mem_name
FROM member;

--users 테이블 조회
SELECT * 
FROM users;

-- 테이블에 어떤 컬럼이 있는지 확인하는 방법
-- 1.SELECT * 
-- 2.TOOL의 기능 (사용자-TABLES)
--3. DESC 테이블명 (DESC-DESCRIBE) 
DESC users;

SELECT *
FROM users;

--users 테이블에서 userid, usernm, rog_dt 컬럼만 조회하는 sql을 작성하세요
-- reg_dt 컬럼만 조회하는 sql을 작성하세요
-- 날짜 연산 (reg_dt 컬럼은 date 정보를 담을수 있는 타입)
-- SQL 날짜 컬럼 + (더하기 연산)
--수학적인 사칙연산이 아닌것들 (5+5)
-- String h = "hello";
-- String w = "world";
-- String hw = h+w; -- 자바에서는 두 문자열을 결합
-- SQL에서 정의된 날짜 연산 : 날짜 + 정수 = 날짜에서 정수를 일자로
--                           취급하여 더한 날짜가 된다 (2019/1/28 + 5  = 2019/02/02)
--reg_dt : 등록일자 컬럼         
--null : 값을 모르는 상태
--null에 대한 연산 결과는 항상 null
--AS 별칭을 구분
SELECT userid u_id, usernm, reg_dt, 
              reg_dt + 5 AS reg_dt_after_5day
FROM users;

SELECT prod_id AS id, prod_name AS name
FROM prod;

SELECT lprod_gu AS gu, lprod_nm AS nm
FROM lprod;

SELECT buyer_id AS 바이어아이디, buyer_name AS 이름
FROM buyer;

--문자열 결합
-- 자바 언어에서 문자열 결합 : + ("Hello" + "world")
-- SQL에서는 : ||  ('Hello' || 'world')
-- SQL에서는 : concat('Hello', 'world')
-- userid, usernm 컬럼을 결합 , 별칭 id_name
SELECT userid || usernm id_name,
       CONCAT(userid, usernm) concat_id_name
FROM users;

--변수 , 상수
--int a = 5; String msg = "Hello, world";

--// 변수를 이용한 출력
--System.out.println(msg);

--//상수를 이용한 출력
--System.out.println("Hello, World");

--SQL에서의 변수는 없음
--(컬럼이 비슷한 역할, pl/sql 변수 개념이 존재)
--SQL에서 문자열 상수는 싱글 쿼테이션으로 표현
--"Hello, World" --> 'Hello, World'

--문자열 상수와 컬럼간의 결합
--user id : brown
--user id : cony
SELECT 'user id : ' || userid AS ,"use rid"
FROM users;

SELECT table_name  ,'SELECT*FROM' || table_name AS queary
FROM USER_TABLES; 

-- || --> CONCAT

SELECT CONCAT( CONCAT('SELECT * FORM',table_name),';') queary
FROM user_tables;

--if ( a==5) (a의 값이 5인지 비교)
--sql에서는 대입의 개녑이 없다. (
--sql = ---> 

--WHERE 절 : 테이블에서 데이터를 조회할때
--           조건에 맞는 행만 조회
-- ex : userid 컬럼의 값이 brown인 행만 조회
--brown , 'brown' 구분
--컬럼, 문자열 상수
SELECT * 
FROM users 
WHERE userid = 'brown';


-- userid가 brown이 아닌 행만 조회 (brown을 제외한 4건)
-- = 같을때 : = , 다를때 : !=, <> 

SELECT * 
FROM users
WHERE userid != 'brown';

-- emp 테이블에 존재하는 컬럼을 확인해보세요

SELECT *
FROM emp;

-- emp 테이블에서 ename 컬럼 값이 JONES인 행만 조회
-- *SQL KEY WORD는 대소문자를 가리지 않지만
-- 컬럼의 값이나, 문자열 상수는 대소문자를 가린다
--'JONES', 'jones'는 값이 다른 상수
SELECT *
FROM emp
WHERE ename = 'JONES';

SELECT *
FROM emp; --emp
DESC epm;
5 > 10 --FALSE

--emp 테이블에서 deptno(부서번호)가
-- 30보다 크거나 같은 사원들만 조회
SELECT *
FROM emp;
WHERE deptno >= 30;

-- 문자열 : '문자열'
-- 숫자 : 50
-- 날짜 : ??? ---> 함수와 문자열을 결합하여 표현
-- 문자열만 이용하여 표현 가능 ( 권장하지 않음)
-- 국가별로 날짜 표기 방법
-- 한국 : 년도 4자리 - 월2자리 -일자 2자리
-- 미국 : 월 2자리 - 일자 2자리 - 년도 4자리
-- 입사일자가 1980년 12월 17일 직원만 조회

SELECT * 
FROM emp;
WHERE hirdete = '80/12/17';
-- TO_DATE : 문자열을 date 타입으로 변경하는 함수
SELECT * 
FROM emp
WHERE hiredate = '80/12/17';

--TO_DATE : 문자열을 date 타입으로 변경하는 함수
--TO_DATE(날짜형식 문자열, 첫번째 인자의 형식)
SELECT *
FROM emp
WHERE hiredate = TO_DATE('19801217','YYYYMMDD');

-- 범위연산
-- sal 컬럼의 값이 1000에서 2000 사이인 사람
-- sal >= 1000
-- sal <= 2000
SELECT *
FROM emp
WHERE sal >= 1000
AND sal <= 2000;

--범위 연산자를 부등호 대신에 BETWEEN AND 연산자로 대체
SELECT * 
FROM emp 
WHERE sal BETWEEN 1000 AND 2000;

--실습

SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('19820101','YYYY/MM/DD') AND TO_DATE('19830101','YYYY/MM/DD');
--WHERE2
-- WHERE 절에 기술하는 조건에 순서는 조회 결과에 영향을 미치지 않는다.
-- SQL은 집합의 개념을 갖고 있다.
-- 집합 : 키가 185CM 이상이고 몸무게가 70kg 이상인 사람들의 모임
--       몸무게가 70KG 이상이고 키가 185CM 이상인 사람들의 모임
-- 집합의 특징 : 집합에는 순서가 없다.
--(1,5,10) --> (10,5,1) : 두 집합은 서로 동일하다
-- 테이블에는 순서가 보장되지 않음
-- SELECT 결과가 순서가 다르더라도 값이 동일하면 정답
--> 정렬기능 제공(ORDER BY)
-- 잘생긴 사람의 모임 --> 집합X
 
SELECT ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE('19820101','YYYY/MM/DD')
AND hiredate <= TO_DATE('19830101','YYYY/MM/DD') ;

-- IN 연산자
-- 특정 집합에 포함되는지 여부 확인
-- 부서번호가 10번 혹은 20번에 속하는 직원 조회 
SELECT empno, ename , deptno
FROM emp
WHERE deptno IN(10,20);
-- 부서번호 10번 혹은 20번에 속하는 직원 조회를 알 수 있다.

--IN 연산자를 사용하지 않고 OR 연산자 사용
*SELECT empno, ename, deptno
FROM emp
WHERE deptno = 10
OR    deptno = 20;

-- emp 테이블에서 사원이름이 SMITH, JONES 인 직원만 조회 (empno, ename deptno)
-- AND / OR 
-- 문자 상수 
SELECT empno, ename, deptno
FROM emp
WHERE ename IN('SMITH','JONES');
-- 사원이름 ''를 붙여야한다.

-- IN 실습 

SELECT userid 아이디 , usernm 이름, alias 별명
FROM users
WHERE userid IN('brown','cony','sally');


--문자열 매칭 연산자 : like, %,  _
--이름이 BR로 시작하는 사람만 조회
--이름에 R 문자열이 들어가는 사람만 조회
--사원 이름이 S로 시작하는 사원 조회
-- % 어떤 문자열 (한글자, 글자 없을수도 있고, 여러 문자열이 올수도 있다)
--SMITH,SMILE,SKC
SELECT * 
FROM emp
WHERE ename LIKE 'S%';

--글자수를 제한한 패턴 매칭
-- _ 정확히 한문자
-- 직원 이름이 S로 시작하고 이름의 전체 길이가 5글자 인 직원
-- S____
SELECT *
FROM emp
WHERE enmae LIKE 'S____';

--사원 이름에 S글자가 들어가는 사원 조회
-- ename Like '%S'
SELECT *
FROM emp
WHERE ename Like '%S%' ;

--실습 WHERE4

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '신%' ;

--실습 WHERE5

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE('%이%');


-- null 비교 연산 (IS)
-- comm 컬럼의 값이 null 데이터를 조회 (WHERE comm = null)
SELECT *
FROM emp
WHERE comm = null;


SELECT *
FROM emp
WHERE comm = '';

SELECT *
FROM emp
WHERE comm IS null;

--WHERE 6 실습

SELECT *
FROM emp
WHERE comm IS not null ;

-- 사원의 관리자가 7698, 7839 그리고 null이 아닌사람만 조회
-- NOT IN 연산자에서는 NULL 값을 포함 시키면 안된다
SELECT *
FROM emp
WHERE mgr NOT IN (7698,7839,NULL);

-------->
SELECT *
FROM emp
WHERE mgr NOT IN (7698,7839);
AND mqr IS NOT NULL;

-----WHERE 7 실습

SELECT *
FROM emp
WHERE job = 'SALESMAN' AND hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD');

--WHERE 8 실습
SELECT * 
FROM emp
WHERE deptno IN (30,20)  AND hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD');

--WHERE 9 실습
SELECT *
FROM emp
WHERE deptno NOT IN (10) AND hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD');

--WHERE 10 실습
SELECT *
FROM emp
WHERE deptno IN (20,30) AND hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD');

--WHERE 11 실습 
SELECT *
FROM emp
WHERE job = 'SALESMAN' OR hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD');

--WHERE 12 실습 
SELECT *
FROM emp
WHERE job = 'SALESMAN' OR empno LIKE '78%'; 

--WHERE 13 실습
SELECT *
FROM emp
WHERE job = 'SALESMAN' OR (empno >= 7800 AND empno <7900); --반쪽자리 정답

--연산자 우선순위
--*,/ 연산자가 +,- 보다 우선순위가 높다
--1+5*2 = 11 -> (1+5)*2 X
-- 우선순위 변경 : ()
-- AND > OR
-- emp 테이블에서 사원 이름이 SMITH 이거나 
               --사원 이름이 ALLEN 이면서 담당업무가 SALESMAN인 사원 조회
               
SELECT *
FROM emp
WHERE ename = 'SMITH' 
OR  ename ='ALLEN' 
AND job = 'SALESMAN';

-- 사원 이름이 SMITH 이거나 ALLEN 이면 
-- 담당업무가 SALESMAN인 사원 조회

SELECT * 
FROM emp
WHERE (ename = 'SMITH' OR ename = 'ALLEN')
AND job = 'SALESMAN';

--WHERE 14
SELECT * 
FROM emp
WHERE job = 'SALESMAN' OR empno LIKE '78%' AND hiredate  >= TO_DATE('1981/06/01','YYYY/MM/DD');

--정렬
--SELECT *
--FROM table
--(WHERE)
--ORDER BY 칼럼 (ASC | DESC)

--emp 테이블의 모든 사원을 ename 칼럼 값을 기준으로 오름차순 정렬한 결과를 조회 하세요.
SELECT * 
FROM emp
ORDER BY ename; 

SELECT * 
FROM emp
ORDER BY ename DESC;

DESC emp; -- DESC : DESCRIBE (설명하다)
ORDER BY ename DESC -- DESC : DESCENDING (내림)

-- emp 테이블에서 사원 정보를 ename 컬럼으로 내림차순 
SELECT * 
FROM emp
ORDER BY ename;

-- ename 값이 같을 경우 mqr 컬럼으로 오름차순
SELECT * 
FROM emp
ORDER BY ename DESC, mgr;

--정렬시 별칭을 사용
SELECT empno, ename nm , sal*12 year_sal
FROM emp
ORDER BY year_sal;

-- 컬럼 인덱스로 정렬
-- java array
SELECT empno, ename nm , sal*12 year_sal
FROM emp
ORDER BY 3;

--orderby1

SELECT *
FROM dept
ORDER BY dname ;

SELECT *
FROM dept
ORDER BY  deptno;

--ORDERBY 2

SELECT *
FROM emp
WHERE comm IS NOT NULL AND comm > 0 
ORDER BY comm desc;

--ORDERBY 3
SELECT*
FROM emp
WHERE mgr IS NOT NULL
ORDER BY job, empno desc




