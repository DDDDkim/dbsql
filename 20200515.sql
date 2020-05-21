ROLLUP : ����׷� ���� - ����� �÷��� �����ʿ������� ���������� GROUP BY�� ����

�Ʒ� ������ ����׷�
1. GROUP BY job, deptno
2. GROUP BY job
3. GROUP BY ==> ��ü;

ROLLUP ���� �����Ǵ� ����׷��� ���� : ROLLUP�� ����� �÷��� + 1;

GROUP_AD2]
SELECT NVL(job, '�Ѱ�'), deptno, GROUPING(job), GROUPING(deptno), SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

SELECT CASE 
            WHEN GROUPING(job) = 1 THEN '�Ѱ�'
            ELSE job
        END job
        , deptno, GROUPING(job), GROUPING(deptno), SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

GROUP_AD2]
SELECT CASE 
            WHEN GROUPING(job) = 1 THEN '��'
            ELSE job
        END job
        , CASE 
            WHEN GROUPING(job) = 1 THEN '��'
            WHEN GROUPING(deptno) = 1 THEN '�Ұ�'
            ELSE TO_CHAR(deptno)
        END deptno
        , SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

GROUP_AD3];
SELECT deptno, job, SUM(sal)
FROM emp
GROUP BY ROLLUP (deptno, job);

GROUP_AD4];
SELECT d.dname, e.job, SUM(sal) sal
FROM emp e RIGHT OUTER JOIN dept d ON(e.deptno=d.deptno)
GROUP BY ROLLUP (d.dname, e.job);


SELECT NVL(dept.dname,'����')dname, a.job, a.sum_sal
FROM
(SELECT deptno, job, SUM(sal) sum_sal
FROM emp
GROUP BY ROLLUP (deptno, job) )a, dept
WHERE a.deptno = dept.deptno(+);



GROUP_AD5];
SELECT dept.dname, a.job, a.sum_sal
FROM
(SELECT deptno, job, SUM(sal) sum_sal
FROM emp
GROUP BY ROLLUP (deptno, job) )a, dept
WHERE a.deptno = dept.deptno(+);


2.GROUPING SETS
ROLLUP �� ���� : ���ɾ��� ����׷쵵 �����ؾ��Ѵ�.
                ROLLUP���� ����� �÷��� �����ʿ��� ���������� ������
                ���� �߰������� �ִ� ����׷��� ���ʿ��� ��� ����.
GROUPING SETS : �����ڰ� ���� ������ ����׷��� ���
���� : GROUP BY GROUPING SETS (col1, col2)


SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY GROUPING SETS(job, deptno);

�׷������
1.job, deptno
2.mgr

GROUP BY GROUPING SETS ( (job, deptno), mgr)

SELECT job, deptno, SUM(sal)
FROm emp
GROUP BY GROUPING SETS ( (job, deptno), mgr);


REPORT GROUP FUCTION ==> Ȯ��� GROUP BY
REPORT GROUP FUNCTION�� ����� ���ϸ�
�������� SQL�ۼ�, UNION ALL�� ���ؼ� �ϳ��� ����� ��ġ�� ����
==> ���� ���ϰ� �ϴ°� REPORT GROUP FUNCTION

3.CUBE
���� : GROUP BY CUBE (col1, col2....)
����� �÷��� ������ ��� ���� (������ ��Ų��)

GROUP BY CUBE(job, deptno);
    1       2
  job,   deptno
  job,      x
   X,    deptno
   X,       X
   
SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY CUBE (job, deptno);


�������� REPORT GROUP ����ϱ�
SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);

**�߻� ������ ������ ���
  1     2       3
job  deptno     mgr ==> GROUP BY job, deptno, mgr
job  X          mgr ==> GROUP BY job, mgr
job  deptno     X ==> GROUP BY job, deptno
job  X          X ==> GROUP BY job

SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY job, ROLLUP(job, deptno), CUBE(mgr);


��ȣ���� �������� ������Ʈ
1. emp���̺��� �̿��Ͽ� emp_test ���̺� ����
DROP TABLE emp_test;

CREATE TABLE emp_test AS
SELECT *
FROM emp;
2. emp_test ���̺� dname �÷� �߰�(dept ���̺� ����)
DESC dept;

ALTER TABLE emp_test ADD (dname VARCHAR2(14));
3.subquery�� �̿��Ͽ� emp_test���̺� �߰��� dname�÷��� ������Ʈ���ִ� ������ �ۼ�
emp_test���̺��� deptno���� Ȯ���ؼ� dept���̺��� deptno���̶� ��ġ�ϴ� dname �÷����� ������ update

UPDATE emp_test SET dname = (SELECT dname
                             FROM dept
                             WHERE emp_test.deptno = dept.deptno);

SELECT *
FROM emp_test;


DROP TABLE dept_test;

CREATE TABLE dept_test AS
SELECT *
FROM dept;

ALTER TABLE dept_test ADD (empcnt NUMBER);

UPDATE dept_test SET empcnt = (SELECT COUNT(*)
                                FROM emp
                                WHERE dept_test.deptno = emp.deptno);

SELECT *
FROM dept_test

SELECT ��� ��ü�� ������� �׷� �Լ��� ������ ���
���Ǵ� ���� ������ 0���� ����

SELECT COUNT(*)
FROM emp
WHERE 1=2;

GROUP BY ���� ����� ��� ����� �Ǵ� ���� ���� ��� ��ȸ�� ���� ����.
SELECT COUNT(*)
FROM emp
WHERE 1=2
GROUP BY deptno;
