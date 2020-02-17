



SELECT DECODE(d, 1, iw+1, iw) i,
       MIN(DECODE(d, 1, dt)) sun,
       MIN(DECODE(d, 2, dt)) mon,
       MIN(DECODE(d, 3, dt)) tue,
       MIN(DECODE(d, 4, dt)) wed,
       MIN(DECODE(d, 5, dt)) tur,
       MIN(DECODE(d, 6, dt)) fri,
       MIN(DECODE(d, 7, dt)) sat
FROM 
(SELECT TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) + (level-1) dt,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1)  + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1)  + (LEVEL-1), 'iw') iw
 FROM dual
 CONNECT BY LEVEL <=  last_day(to_date(:dt,'yyyymm'))+(7-to_char(last_day(to_date(:dt,'yyyymm')),'D'))
                    -to_date(:dt,'yyyymm')-(to_char(to_date(:dt,'yyyymm'),'D')-1)  )
 GROUP BY DECODE(d, 1, iw+1, iw)
 ORDER BY DECODE(d, 1, iw+1, iw);  
 
 
 
 SELECT DECODE(d, 1, iw+1, iw) i,
       MIN(DECODE(d, 1, dt)) sun,
       MIN(DECODE(d, 2, dt)) mon,
       MIN(DECODE(d, 3, dt)) tue,
       MIN(DECODE(d, 4, dt)) wed,
       MIN(DECODE(d, 5, dt)) tur,
       MIN(DECODE(d, 6, dt)) fri,
       MIN(DECODE(d, 7, dt)) sat
FROM 
(SELECT TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) + (level-1) dt,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1)  + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1)  + (LEVEL-1), 'iw') iw
 FROM dual
 CONNECT BY LEVEL <=  last_day(to_date(:dt,'yyyymm'))+(7-to_char(last_day(to_date(:dt,'yyyymm')),'D'))
                    -to_date(:dt,'yyyymm')-(to_char(to_date(:dt,'yyyymm'),'D')-1)  )
 GROUP BY DECODE(d, 1, iw+1, iw)
 ORDER BY DECODE(d, 1, iw+1, iw)


1.해당 월의 1일자가 속한 주의 일요일 구하기
2.해당 월의 마지막 일자가 속한 주의 토요일 구하기 
3. 2-1을 하여 총 일수 구하기

20200401 => 20200329(일요일)
20200430 ==> 20200502(토요일)
요일을 숫자로 표현할 수 있다.
일주일 7개(1~7);
기존 : 시작일자 1일 , 마지막 날짜 : 해당월의 마지막 일자;
SELECT TO_DATE('202002','YYYYMMDD') + (LEVEL-1)
FROM dual;
CONNECT BY LEVEL <= 29;

변경 : 시작일자 : 해당월의 1일자가 속한 주의 일요일
    마지막 날짜 : 해당월의 마지막 일자가 속한 주의 토요일
    
SELECT TO_DATE('202002', 'YYYYMM') + (LEVEL-1)
FROM dual
CONNECT BY LEVEL <= 35;

SELECT 
 TO_DATE(:dt, 'yyyymm') - (TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) st,
 LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')),'D'))ed,
 LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')),'D'))
 -(TO_DATE(:dt, 'yyyymm') - (TO_CHAR(TO_DATE(:dt, 'yyyymm'),'D'))) daycnt
 
FROM dual


--실습 calendar1 



SELECT 
 TO_DATE(:dt, 'yyyymm') - (TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) st,
 LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')),'D'))ed,
 LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')),'D'))
 -(TO_DATE(:dt, 'yyyymm') - (TO_CHAR(TO_DATE(:dt, 'yyyymm'),'D'))) daycnt;
 
FROM dual;
SELECT (DECODE (to_date(dt,'MM'),01,)) 
FROM sales;

SELECT dt,sales,
FROM sales
WHERE; 


1.dt (일자) ==> 월, 월단위별 sum(sales) ==> 월의 수만큼 행여 그룹핑 된다.;
 SELECT NVL(SUM(jan),0) jan, NVL(SUM(feb),0) feb,
        NVL(SUM(mar),0) mar, SUM (NVL,(mar, 0)) mar,
        NVL(SUM(apr),0)apr,
        NVL(SUM(may),NVL(SUM)(jun),0)jun       
 FROM
 SELECT DECODE(d, 1, iw+1, iw) i,
       (DECODE(TO_CHAR(dt,'MM'), '01', SUM(SALES)) JAN,
      (DECODE(TO_CHAR(dt,'MM'), '01', SUM(SALES)) FEB,
       (DECODE(TO_CHAR(dt,'MM'), '01', SUM(SALES)) MAR,
    (DECODE(TO_CHAR(dt,'MM'), '01', SUM(SALES)) APR,
        (DECODE(TO_CHAR(dt,'MM'), '01', SUM(SALES)) MAY,
    (DECODE(TO_CHAR(dt,'MM'), '01', SUM(SALES)) JUN
FROM 
(SELECT TO_CHAR(dt, 'MM'),SUM(sales) m_s
FROM sales
GROUP BY TO_CHAR(dt,'MM'))
;
----dept sql 
create table dept_h (
    deptcd varchar2(20) primary key ,
    deptnm varchar2(40) not null,
    p_deptcd varchar2(20),
    
    CONSTRAINT fk_dept_h_to_dept_h FOREIGN KEY
    (p_deptcd) REFERENCES  dept_h (deptcd) 
);

insert into dept_h values ('dept0', 'XX회사', '');
insert into dept_h values ('dept0_00', '디자인부', 'dept0');
insert into dept_h values ('dept0_01', '정보기획부', 'dept0');
insert into dept_h values ('dept0_02', '정보시스템부', 'dept0');
insert into dept_h values ('dept0_00_0', '디자인팀', 'dept0_00');
insert into dept_h values ('dept0_01_0', '기획팀', 'dept0_01');
insert into dept_h values ('dept0_02_0', '개발1팀', 'dept0_02');
insert into dept_h values ('dept0_02_1', '개발2팀', 'dept0_02');
insert into dept_h values ('dept0_00_0_0', '기획파트', 'dept0_01_0');
commit;

오라클 계층형 쿼리 문법
SELECT ....
FROM ....
WHERE 
START WITH 조건 : 어떤 행을 시작점으로 삼을지

CONNECT BY 행과 행을 연결하는 기준
        PRIOR : 이미 읽은행
        "  " : 앞으로 읽을 행;
하향식 : 가장 상위에서 자식노드로 연결 (위 ==> 아래);

XX회사(최상위 조직)에서 시작을하여 하위 부서로 내려가는 계층 쿼리;

SELECT dept_h.*, level, LPAD(' ' , (LEVEL-1)*4, ' ') || deptnm
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR p_deptcd = deptcd;
행과 행의 연결 조건 (PRIOR XX회사 -3가지 부 (디자인부 , 정보기획부, 정보시스템부) 
PRIOR XX회사.deptcd = 디자인부.p_deptcd
PRIOR 디자인부.deptcd = 디자인팀.deptcd 


PRIOR XX회사.deptcd = 정보기획부.P_deptcd 
PRIOR 정보기획부.deptcd  = 기획팀.P_deptcd 
PRIOR 








