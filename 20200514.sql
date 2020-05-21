�����ȹ : SQL�� ���������� � ������ ���ļ� �������� ������ �ۼ�
        * ����ϴµ� ��� ���� ����� �ʿ�(�ð�)
        
2���� ���̺��� �����ϴ�  SQL
2���� ���̺� ���� �ε����� 5���� �ִٸ�
������ �����ȹ ���� �? ������ ���� ==> ª�� �ð��ȿ� �س��� �Ѵ�(������ ���� �ؾ��ϹǷ�)

���� ������ SQL�� ����� ��� ������ �ۼ��� �����ȹ�� ������ ���
���Ӱ� ������ �ʰ� ��Ȱ���� �Ѵ�(���ҽ� ����)

���̺� ���� ��� : ���̺� ��ü(1), ������ �ε���(5)
����� �� : 36�� * 2�� = 72��

������ SQL �̶� : SQL ������ ��ҹ��� ������� ��ġ�ϴ� SQL
�Ʒ� �ΰ��� sql�� ���� �ٸ� SQL�� �ν��Ѵ�;
SELECT * FROM emp;
Select * FROM emp;

Ư�������� ������ ��ȸ�ϰ� ������ : ����� �̿��ؼ�
Select /* 202004_B */ *
FROM emp
WHERE empno=:empno;


SELECT *
FROM V$SQL
WHERE SQL_TEXT LIKE '%202004_B%';

SELECT *
FROM DDDD.v_emp;

DDDD.v_emp ==> v_emp;

SELECT *
FROM v_emp;

SYNONYM : ��ü�� ��Ī�� �����ؼ� ��Ī�� ���� ���� ��ü�� ���
���� : CREATE SYNONYM �ó�� �̸� FOR ��� ������Ʈ;

DDDD.v_emp ==> v_emp �ó������ ����
CREATE SYNONYM v_emp FOR DDDD.v_emp;

v_emp�� ���� ���� ��ü�� DDDD.v_emp �� ����� �� �ִ�.

SELECT *
FROM v_emp;

SQL CATEGORY
DML
DDL
DCL
TCL;


 Data Dictionary : �ý��� ������ �� �� �ִ� view, ����Ŭ�� ��ü������ ����
 category (���ξ�)
 USER : �ش� ����ڰ� �����ϰ� �ִ� ��ü ���
 ALL : �ش� ����� ���� + ������ �ο����� ��ü ���
 DBA : ��� ��ü ���
 V$ : ����, �ý��۰���
 
 
 SELECT *
 FROM user_tables;
 
 SELECT *
 FROM ALL_tables;
 
 Multiple insert : �������� �����͸� ���ÿ� �Է��ϴ� insert�� Ȯ�屸��
 
 1. unconditional insert : ������ ���� ���� ���̺� �Է��ϴ� ���
 ���� : 
        INSERT ALL
            INTO ���̺��
            [,INTO ���̺��]
        VALUES (...) | SELECT QUERY;
        
SELECT *
FROM emp_test;

emp_test ���̺��� �̿��Ͽ� emp_test2 ���̺� ����
CREATE TABLE emp_test2 AS 
    SELECT *
    FROM emp_test
    WHERE 1=2;
    
SELECT *
FROM emp_Test2;

EMPNO, ENAME, DEPTNO;

emp_test, emp_test2 ���̺� ���ÿ� �Է�
INSERT ALL
    INTO emp_test
    INTO emp_test2
SELECT 9998, 'brown', 88 FROM dual UNION ALL
SELECT 9997, 'cony', 88 FROM dual;
    
    
SELECT *
FROM emp_test;

SELECT *
FROM emp_test2;

2. conditional insert : ���ǿ� ���� �Է��� ���̺��� ����


����
INSERT ALL 
    WHEN ����....THEN
        INTO �Է� ���̺� VALUES
    WHEN ����....THEN
        INTO �Է� ���̺� VALUES
    ELSE
        INTO �Է� ���̺� VALUES
        
SELECT ����� ���� ���� EMPNO=9998�̸� EMP_TEST���� �����͸� �Է�
                      �׿ܿ��� EMP_TEST2�� �����͸� �Է�;
INSERT ALL
    WHEN empno=9999 THEN
        INTO emp_test VALUES (empno, ename, deptno)
    ELSE
        INTO emp_test2 (empno, deptno) VALUES (empno, deptno)
SELECT 9998 empno, 'brown' ename, 88 deptno FROM dual UNION ALL
SELECT 9997, 'cony', 88 FROM dual;

ROLLBACK;

conditional insert (all)==> first;

INSERT FIRST
    WHEN empno <= 9998 THEN
        INTO emp_test VALUES (empno, ename, deptno)
    WHEN empno <= 9997 THEN
        INTO emp_test2 VALUES (empno, ename, deptno)
SELECT 9998 empno, 'brown' ename, 88 deptno FROM dual UNION ALL
SELECT 9997, 'cony', 88 FROM dual;


SELECT *
FROM emp_test;

SELECT *
FROM emp_test2;


MERGE : �ϳ��� ������ ���� �ٸ� ���̺�� �����͸� �ű� �Է�, �Ǵ� ������Ʈ �ϴ� ����
���� : 
MERGE INTO ���� ���(emp_test)
USING (�ٸ� ���̺� | VIEW | subquery)
ON (�������� USING ���� ���� ���� ���)
WHEN NOT MATCHED THEN
    INSERT (col1, col2...) VALUES (value1, value2...)
WHEN MATCHED THEN
    UPDATE SET col1=value1, col2=value2

1.�ٸ� �����ͷκ��� Ư�� ���̺�� �����͸� �����ϴ� ���

2. KEY�� ������� INSERT
    KEY�� ���� �� UPDATE
    
    
emp���̺��� �����͸� emp_test���̺�� ����
emp���̺��� �����ϰ� emp_test���̺��� �������� �ʴ� ������ �ű� �Է�
emp���̺��� �����ϰ� emp_test���̺��µ� �����ϴ� ������ �̸� ����;


9999	brown	88
9998	brown	88
9997	cony	88
7369	cony	88

INSERT INTO emp_test VALUES(7369, 'cony', 88);
SELECT *
FROM emp_test;

emp���̺��� 14�ǵ����͸� emp_test ���̺� ������ empno�� �����ϴ��� �˻��ؼ�
������ empno�� ������ insert-empno, ename, ������ empno�� ������ update-ename;
MERGE INTO emp_test
USING emp
ON (emp_test.empno = emp.empno)
WHEN NOT MATCHED THEN
    INSERT (empno, ename) VALUES(emp.empno, emp.ename)
WHEN MATCHED THEN
    UPDATE SET ename = emp.ename;


���� �ó������� �ϳ��� ���̺��� �ٸ� ���̺��� �����ϴ� ���

9999�� ������� �ű� �Է��ϰų�, ������Ʈ�� �ϰ� ���� ��
(����ڰ� 999��, james ����� ����ϰų�, ������Ʈ �ϰ� ���� ��)
���� ���� ���̺� ==> �ٸ� ���̺�� ����

������ ==> Ư�� ���̺�� ����
(9999, james)

MERGE ������ ������� ������

������ ���� ������ ���� SELECT ����
SELECT *
FROM emp_Test
WHERE empno=9999;

�����Ͱ� ������ ==> UPDATE
�����Ͱ� ������ ==> INSERT

MERGE INTO emp_test
USING dual
    ON (emp_test.empno = 9999)
WHEN NOT MATCHED THEN
    INSERT (empno, ename) VALUES (9999, 'james')
WHEN MATCHED THEN
    UPDATE SET ename='james';   
    
MERGE INTO emp_test
USING (SELECT 9999 eno, 'james' enm
        FROM dual) a
    ON (emp_test.empno = a.eno)
WHEN NOT MATCHED THEN
    INSERT (empno, ename) VALUES (a.eno, a.enm)
WHEN MATCHED THEN
    UPDATE SET ename=a.enm;   


emp���̺��� 7698�� ������ �̸��� 
emp_test ���̺��� 9999�� ������ �̸����� ������Ʈ�ϴ� merge���� �ۼ�
���� 9999�� ������ emp_test�� ������ empno=9999, ename=emp���̺��� 7698 ������ �̸�, deptno=null

MERGE INTO emp_test
USING (SELECT 9999 eno, (SELECT ename FROM emp WHERE empno=7698) enm
        FROM dual) a
    ON (emp_test.empno=a.eno)
WHEN NOT MATCHED THEN
    INSERT (empno, ename) VALUES (9999, a.enm)
WHEN MATCHED THEN
    UPDATE SET ename=a.enm;
    
SELECT *
FROM emp_test;


REPORT GROUP FUNCTION
emp���̺��� �̿��Ͽ� �μ���ȣ�� ������ �޿��հ�, ��ü������ �޿����� ��ȸ�ϱ� ����
GROUP BY�� ����ϴ� �ΰ��� SQL�� ������ �ϳ��� ��ġ��(UNION ==> UNION ALL) �۾��� ����;

SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno

UNION ALL

SELECT null, SUM(sal)
FROM emp;


Ȯ��� GROUP BY 3����
1. GROUP BY ROLLUP
���� : GROUP BY ROLLUP (�÷�, �÷�2...)
���� : ����׷��� ������ִ� �뵵
���� �׷� ���� ��� : ROLLUP ���� ����� �÷��� �����ʿ������� �ϳ��� �����ϸ鼭 ����׷��� ����
������ ����׷��� UNION�� ����� ��ȯ

SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY ROLLUP (job, deptno);

����׷� :   1.GROUP BU job, deptno
            UNION
            2. GROUP BY job
            UNION
            3. ��ü�� GROUP BY

SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY job, deptno

UNION ALL

SELECT job, null, SUM(sal) sal
FROM emp
GROUP BY job

UNION ALL

SELECT null, null, SUM(sal) sal
FROM emp;



SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno

UNION ALL

SELECT null, SUM(sal)
FROM emp;

SELECT deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (deptno);




