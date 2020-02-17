



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


1.�ش� ���� 1���ڰ� ���� ���� �Ͽ��� ���ϱ�
2.�ش� ���� ������ ���ڰ� ���� ���� ����� ���ϱ� 
3. 2-1�� �Ͽ� �� �ϼ� ���ϱ�

20200401 => 20200329(�Ͽ���)
20200430 ==> 20200502(�����)
������ ���ڷ� ǥ���� �� �ִ�.
������ 7��(1~7);
���� : �������� 1�� , ������ ��¥ : �ش���� ������ ����;
SELECT TO_DATE('202002','YYYYMMDD') + (LEVEL-1)
FROM dual;
CONNECT BY LEVEL <= 29;

���� : �������� : �ش���� 1���ڰ� ���� ���� �Ͽ���
    ������ ��¥ : �ش���� ������ ���ڰ� ���� ���� �����
    
SELECT TO_DATE('202002', 'YYYYMM') + (LEVEL-1)
FROM dual
CONNECT BY LEVEL <= 35;

SELECT 
 TO_DATE(:dt, 'yyyymm') - (TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) st,
 LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')),'D'))ed,
 LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')),'D'))
 -(TO_DATE(:dt, 'yyyymm') - (TO_CHAR(TO_DATE(:dt, 'yyyymm'),'D'))) daycnt
 
FROM dual


--�ǽ� calendar1 



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


1.dt (����) ==> ��, �������� sum(sales) ==> ���� ����ŭ �࿩ �׷��� �ȴ�.;
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

insert into dept_h values ('dept0', 'XXȸ��', '');
insert into dept_h values ('dept0_00', '�����κ�', 'dept0');
insert into dept_h values ('dept0_01', '������ȹ��', 'dept0');
insert into dept_h values ('dept0_02', '�����ý��ۺ�', 'dept0');
insert into dept_h values ('dept0_00_0', '��������', 'dept0_00');
insert into dept_h values ('dept0_01_0', '��ȹ��', 'dept0_01');
insert into dept_h values ('dept0_02_0', '����1��', 'dept0_02');
insert into dept_h values ('dept0_02_1', '����2��', 'dept0_02');
insert into dept_h values ('dept0_00_0_0', '��ȹ��Ʈ', 'dept0_01_0');
commit;

����Ŭ ������ ���� ����
SELECT ....
FROM ....
WHERE 
START WITH ���� : � ���� ���������� ������

CONNECT BY ��� ���� �����ϴ� ����
        PRIOR : �̹� ������
        "  " : ������ ���� ��;
����� : ���� �������� �ڽĳ��� ���� (�� ==> �Ʒ�);

XXȸ��(�ֻ��� ����)���� �������Ͽ� ���� �μ��� �������� ���� ����;

SELECT dept_h.*, level, LPAD(' ' , (LEVEL-1)*4, ' ') || deptnm
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR p_deptcd = deptcd;
��� ���� ���� ���� (PRIOR XXȸ�� -3���� �� (�����κ� , ������ȹ��, �����ý��ۺ�) 
PRIOR XXȸ��.deptcd = �����κ�.p_deptcd
PRIOR �����κ�.deptcd = ��������.deptcd 


PRIOR XXȸ��.deptcd = ������ȹ��.P_deptcd 
PRIOR ������ȹ��.deptcd  = ��ȹ��.P_deptcd 
PRIOR 








