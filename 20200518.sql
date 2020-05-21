sub_a2]
DROP TABLE dept_test;

SELECT *
FROM dept;

DROP dept
WHERE deptno NOT IN(10,20,30,40);

COMMIT;

CREATE TABLE dept_test AS
    SELECT *
    FROM dept;
    
INSERT INTO dept_test VALUES(99, 'it1', 'daejeon');
INSERT INTO dept_test VALUES(98, 'it2', 'daejeon');

SELECT *
FROM dept_test;

DELETE dept_test
WHERE deptno NOT IN (SELECT deptno FROM emp);

DELETE dept_test
WHERE NOT EXISTS ( SELECT 'X'
                     FROM emp
                    WHERE emp.deptno = dept_test.deptno);

ROLLBACK;


sub_a3]
SELECT *
FROM emp_test;

SELECT deptno, AVG(sal)
FROM emp_test
GROUP BY deptno;
WHERE deptno = e.deptno;

UPDATE emp_test e SET sal = CASE 
                                WHEN sal < (SELECT AVG(sal)
                                            FROM emp_test
                                            WHERE deptno = e.deptno)
                                THEN sal + 200
                                ELSE sal
                            END;

���Ŀ��� �ƴ�����, �˻� - ������ ���� ������ ǥ��
���������� ���� ���
1. Ȯ���� : ��ȣ���� �������� (EXISTS)
            ==> ���� �������� ���� ==> ���� ���� ����
2. ������ : ���������� ���� ����Ǽ� ���������� ���� �������ִ� ����

13�� : �Ŵ����� �����ϴ� ������ ��ȸ
SELECT *
FROM emp
WHERE mgr IN (SELECT empno
                    FROM emp);
                    
�������� ADVANCED (WITH)
�μ��� ��� �޿��� ���� ��ü�� �޿� ��պ��� ���� �μ��� �μ���ȣ�� �μ��� �޿� ��� �ݾ�

�μ��� ��� �޿�(�Ҽ��� �Ѷ� �ڸ����� ��������)
SELECT deptno, ROUND(AVG(sal),2)
FROM emp
GROUP BY deptno;

��ü �޿� ���
SELECT ROUND(AVG(sal),2)
FROM emp;

�Ϲ����� �������� ����
SELECT deptno, ROUND(AVG(sal),2)
FROM emp
GROUP BY deptno
HAVING ROUND(AVG(sal),2) > (SELECT ROUND(AVG(sal),2)
                            FROM emp);
                            
WITH �� : SQL���� �ݺ������� ������ QUERY BLOCK(SUBQUERY)�� ������ �����Ͽ�
            SQL ����� �ѹ��� �޸𸮿� �ε��ϰ� �ݺ������� ����� �� �޸� ������
            �����͸� Ȱ���Ͽ� �ӵ� ������ �� �� �ִ� KEYWORD
            ��, �ϳ��� sQL���� �ݺ����� SQL ���� ������ ���� �߸� �ۼ��� SQL ��
            ���ɼ��� ���� ������ �ٸ� ���·� ������ �� �ִ����� �����غ��� ���� ��õ.
WITH emp_avg_sal AS(SELECT ROUND(AVG(sal),2)
                    FROM emp)
SELECT deptno, ROUND(AVG(sal),2)
FROM emp
GROUP BY deptno
HAVING ROUND(AVG(sal),2) > (SELECT *
                            FROM emp_avg_sal);                            
                            
                            
��������
CONNECT BY LEVEL : ���� �ݺ��ϰ� ���� ����ŭ ������ ���ִ� ���
��ġ : FROM(WHERE)�� ������ ���
DUAL���̺�� ���� ���

���̺� ���� �Ѱ�, �޸𸮿��� ����
SELECT LEVEL
FROM dual
CONNECT BY LEVEL <= 5;

���� ���� ���� �̹� ��� KEYWORD�� �̿��Ͽ� �ۼ� ����
5�� �̻��� �����ϴ� ���̺��� ���� ���� ����
���࿡ �츮�� ������ �����Ͱ� 10000�� �̸��� 10000�ǿ� ���� DISK I/O�� �߻�
SELECT ROWNUM
FROM emp
WHERE ROWNUM <= 5;

1. �츮���� �־��� ���ڿ� ��� : 202005
    �־��� ����� �ϼ��� ���Ͽ� �ϼ���ŭ ���� ����
    
�޷��� �÷��� 7�� - �÷��� ������ ���� : Ư�����ڴ� �ϳ��� ���Ͽ� ����
SELECT TO_DATE('202005', 'YYYYMM') + (LEVEL - 1) dt
        --�Ͽ����̸� dt �÷�, �������̸� dt�÷�, .....������̸� dt�÷�
FROM dual
CONNECT BY LEVEL <= TO_NUMBER(TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')),'DD'), 99);

�Ʒ� ������� SQL�� �ۼ��ص� ������ �ϼ��ϴ°� �����ϳ�
������ ���鿡�� �ʹ� �����Ͽ� �ζ��κ並 �̿��Ͽ� ������ ���� �ܼ��ϰ� �����.
SELECT TO_DATE('202005', 'YYYYMM') + (LEVEL - 1) dt,
       DECODE(TO_CHAR(TO_DATE('202005', 'YYYYMM') + (LEVEL - 1), 'D'), '1'  , TO_DATE('202005', 'YYYYMM') + (LEVEL - 1)) sun,
       DECODE(TO_CHAR(TO_DATE('202005', 'YYYYMM') + (LEVEL - 1), 'D'), '2'  , TO_DATE('202005', 'YYYYMM') + (LEVEL - 1)) mon
FROM dual
CONNECT BY LEVEL <= TO_NUMBER(TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')),'DD'), 99);

SELECT TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')),'DD')
FROM dual

�÷��� ����ȭ �Ͽ� ǥ��
TO_DATE('202005', 'YYYYMM') + (LEVEL - 1) ==> dt;

SELECT iw
            , MIN(DECODE(d, 2, dt)) mon
            , MIN(DECODE(d, 3, dt)) tue, MIN(DECODE(d, 4, dt)) wen
            , MIN(DECODE(d, 5, dt)) tur, MIN(DECODE(d, 6, dt)) fri
            , MIN(DECODE(d, 7, dt)) sat, MIN(DECODE(d, 1, dt)) sun
FROM
    (SELECT TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1) dt, 
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1), 'D') d,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1), 'iw') iw
    FROM dual
    CONNECT BY LEVEL <= TO_NUMBER(TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')),'DD'), 99))
GROUP BY iw
ORDER BY iw;


SELECT ww
            , MIN(DECODE(d, 2, dt)) mon
            , MIN(DECODE(d, 3, dt)) tue, MIN(DECODE(d, 4, dt)) wen
            , MIN(DECODE(d, 5, dt)) tur, MIN(DECODE(d, 6, dt)) fri
            , MIN(DECODE(d, 7, dt)) sat, MIN(DECODE(d, 1, dt)) sun
FROM
    (SELECT TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1) dt, 
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1), 'D') d,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1), 'iw') iw,
            ROUND((TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1) - TO_DATE('201901', 'YYYYMM')) / 7, 0) + 1 ww
    FROM dual
    CONNECT BY LEVEL <= TO_NUMBER(TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')),'DD'), 99))
GROUP BY ww
ORDER BY ww;

SELECT (TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1) - TO_DATE('201901', 'YYYYMM'))
FROM dual
CONNECT BY LEVEL <= TO_NUMBER(TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')),'DD'), 99);




create table sales as 
select to_date('2019-01-03', 'yyyy-MM-dd') dt, 500 sales from dual union all
select to_date('2019-01-15', 'yyyy-MM-dd') dt, 700 sales from dual union all
select to_date('2019-02-17', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-02-28', 'yyyy-MM-dd') dt, 1000 sales from dual union all
select to_date('2019-04-05', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-04-20', 'yyyy-MM-dd') dt, 900 sales from dual union all
select to_date('2019-05-11', 'yyyy-MM-dd') dt, 150 sales from dual union all
select to_date('2019-05-30', 'yyyy-MM-dd') dt, 100 sales from dual union all
select to_date('2019-06-22', 'yyyy-MM-dd') dt, 1400 sales from dual union all
select to_date('2019-06-27', 'yyyy-MM-dd') dt, 1300 sales from dual;

�ǽ� calendar1]
SELECT (SELECT SUM(SALES) FROM sales WHERE TO_CHAR(dt, 'MM') = '01') JAN,
        (SELECT SUM(SALES) FROM sales WHERE TO_CHAR(dt, 'MM') = '02') FEB,
        (SELECT NVL(SUM(SALES), 0)FROM sales WHERE TO_CHAR(dt, 'MM') = '03') MAR,
        (SELECT SUM(SALES) FROM sales WHERE TO_CHAR(dt, 'MM') = '04') APR,
        (SELECT SUM(SALES) FROM sales WHERE TO_CHAR(dt, 'MM') = '05') MAY,
        (SELECT SUM(SALES) FROM sales WHERE TO_CHAR(dt, 'MM') = '06') JUN
FROM dual;

SELECT SUM(SALES) 
FROM sales 
WHERE TO_CHAR(dt, 'MM') = '01';

SELECT *
FROM sales;


���� �ǽ� calendar2]

SELECT iw
            , MIN(DECODE(d, 2, dt)) mon
            , MIN(DECODE(d, 3, dt)) tue, MIN(DECODE(d, 4, dt)) wen
            , MIN(DECODE(d, 5, dt)) tur, MIN(DECODE(d, 6, dt)) fri
            , MIN(DECODE(d, 7, dt)) sat, MIN(DECODE(d, 1, dt)) sun
FROM
       (SELECT TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1) dt, 
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1), 'D') d,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1), 'iw') iw
        FROM dual
        CONNECT BY LEVEL <= TO_NUMBER(TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')),'DD'), 99))
GROUP BY iw
ORDER BY iw;
