SELECT empno, ename, sal, NVL(comm, 0)
FROM emp;

SELECT empno, ename, job, sal, deptno,
        DECODE(job, 'SALESMAN', sal*1.05,
                    'MANAGER', DECODE(deptno, 10, sal*1.30, sal*1.10),
                    'PRESIDENT', sal*1.20,
                    sal*1) BONUS
FROM emp;


���� A = (10, 15, 18, 23, 24, 25, 29, 30, 35, 37)
Prime Number �Ҽ� : ( 23,29,37) : COUNT-3, MAX-37, MIN-23, AVG-29.66, SUM-89
    --> �Է��� ������ ����� �Ѱ� --> multi row function
��Ҽ� : ( 10, 15, 18, 24, 25, 30, 35)

SELECT *
FROM emp;


GROUP FUNCTION
�������� �����͸� �̿��Ͽ� ���� �׷쳢�� ���� �����ϴ� �Լ�
�������� �Է¹޾� �ϳ��� ������ ����� ���δ�.
EX : �μ��� �޿� ���
    emp ���̺��� 14���� ������ �ְ�,  14���� ���� 3���� �μ�(10, 20, 30)�� ���� �ִ�.
    �μ��� �޿� ����� 3���� ������ ����� ��ȯ�ȴ�.

GROUP BY ����� ���ǻ��� : SELECT ����� �� �ִ� �÷��� ���ѵ�

SELECT �׷��� ���� �÷�, �׷��Լ�
FROM ���̺�
GROUP BY �׷��� ���� �÷�
[ORDER BY];

�μ����� ���� ���� �޿���
SELECT deptno, MIN(ename), MAX(sal)
FROM emp
GROUP BY deptno;

SELECT deptno, --> �÷����� �����ʾƵ� �����ϴ�(�̹� GROUP BY���� ������ ������, �ٸ� �÷����� ���� �������ȴ�.)
        MAX(sal),--�μ����� ���� ���� �޿� ��
        MIN(sal),--�μ����� ���� ���� �޿� ��
        ROUND(AVG(sal),2),--�μ��� �޿� ���
        SUM(sal),--�μ��� �޿� ��
        COUNT(sal),--�μ��� �޿� �Ǽ�(sal Ŀ���� ���� null�� �ƴ� row�� ��)
        COUNT(*),
        COUNT(mgr)
FROM emp
GROUP BY deptno;


*�׷� �Լ��� ���� �μ���ȣ �� ���� ���� �޿��� ���� ���� ������
 ���� ���� �޿��� �޴� ����� �̸��� �� ���� ����
 ==> ���� WINDOW FUNCTION�� ���� �ذᰡ��


*emp ���̺��� �׷� ������ �μ���ȣ�� �ƴ� ��ü �������� �����ϴ� ���
SELECT  MAX(sal),--��ü������ ���� ���� �޿� ��
        MIN(sal),--��ü������ ���� ���� �޿� ��
        ROUND(AVG(sal),2),--��ü������ �޿� ���
        SUM(sal),--��ü������ �޿� ��
        COUNT(sal),--��ü������ �޿� �Ǽ�(sal Ŀ���� ���� null�� �ƴ� row�� ��)
        COUNT(*),--��ü���Ǽ�
        COUNT(mgr)--��mgr �÷��� null�� �ƴ� �Ǽ�
FROM emp;

GROUP BY ���� ����� �ø� 
    SELECT ���� ������ ������ ???
    
GROUP BY ���� ������� ���� �÷���
    SELECT ���� ������ ???;


SELECT deptno, 'TEST', 1,
        MAX(sal),--�μ����� ���� ���� �޿� ��
        MIN(sal),--�μ����� ���� ���� �޿� ��
        ROUND(AVG(sal),2),--�μ��� �޿� ���
        SUM(sal),--�μ��� �޿� ��
        COUNT(sal),--�μ��� �޿� �Ǽ�(sal Ŀ���� ���� null�� �ƴ� row�� ��)
        COUNT(*),
        COUNT(mgr)
FROM emp
GROUP BY deptno;

GROUP �Լ� ����� NULL ���� ���ܰ��ȴ�.
30�� �μ�����  NULL���� ���� ���� ������ SUM(COMM)�� ���� ���������� ���� �� Ȯ�� �� �� �ִ�
SELECT deptno, SUM(comm) 
FROM emp
GROUP BY deptno;

10,20�� �μ��� SUM(COMM)�÷��� NULL�� �ƴ϶� 0�̳������� ó��
*Ư���� ������ �ƴϸ� �׷��Լ� ������� NULLó���� �ϴ� ���� ���ɻ� ����

NVL(SUM)COMM), 0) : COMM�÷��� SUM�׷��Լ��� �����ϰ� ���� ����� NVL�� ����(1ȸȣ��)
SUM(NVL(COMM, 0)) : ��� COMM�÷��� NVL �Լ��� ������(�ش� �׷��� ROW����ŭ ȣ��) SUM �׷��Լ� ����

SELECT deptno, NVL(SUM(comm),0)
FROM emp
GROUP BY deptno;


single row �Լ��� where ���� ����� �� ������
multi row �Լ�(group �Լ�) �� where���� ����� �� ����
GROUP BY �� ���� HAVING ���� ������ ���

sing row �Լ��� where���� ��밡��
SELECT *
FROM emp
WHERE LOWER(ename) = 'smith';

�μ��� �޿� ���� 5000�� �Ѵ� �μ��� ��ȸ
SELECT deptno, SUM(sal)
FROM emp
WHERE SUM(sal) > 9000 ===>>�ȵ�
GROUP BY deptno;

SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno
HAVING SUM(sal) > 9000;

SELECT MAX(sal) max_sal, 
        MIN(sal) min_sal, 
        ROUND(AVG(sal),2) avg_sal, 
        SUM(sal) sum_sal, 
        COUNT(sal) count_sal,
        COUNT(mgr) count_mgr, 
        COUNT(*) count_all
FROM emp;

SELECT deptno,
        MAX(sal) max_sal, 
        MIN(sal) min_sal,
        ROUND(AVG(sal),2) avg_sal,
        SUM(sal) sum_sal,
        COUNT(sal) count_sal,
        COUNT(mgr) count_mr,
        COUNT(*) count_all
FROM emp
GROUP BY deptno;

SELECT DECODE(deptno, 10,  'ACCOUNTING',
                        20, 'RESEARCH',
                        30, 'SALES',
                        40, 'OPERATIONS', 'DDIT') dname,
        MAX(sal) max_sal, 
        MIN(sal) min_sal,
        ROUND(AVG(sal),2) avg_sal,
        SUM(sal) sum_sal,
        COUNT(sal) count_sal,
        COUNT(mgr) count_mr,           
        COUNT(*) count_all
FROM emp
GROUP BY deptno;
                        
SELECT hiredate
FROM emp;
                        
SELECT TO_CHAR(hiredate,'YYYYMM') hire_yyyymm,
        COUNT(hiredate) cnt
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYYMM')
ORDER BY TO_CHAR(hiredate,'YYYYMM');

SELECT TO_CHAR(hiredate,'YYYY') hire_yyyy,
        COUNT(hiredate) cnt
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYY')
ORDER BY TO_CHAR(hiredate,'YYYY');

SELECT COUNT(*) cnt
FROM dept;

SELECT COUNT(COUNT(deptno)) cnt
FROM emp
GROUP BY deptno;








