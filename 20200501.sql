�����ð�;;;;
�Ѱ��� ��, �ϳ��� �÷��� �����ϴ� ��������
ex : ��ü ������ �޿� ��Դ� SMITH ������ ���� �μ��� �μ���ȣ

WHERE���� ��밡���� ������
WHERE deptno = 10
==> 

�μ���ȣ�� 10�� Ȥ�� 30���� ���
WHERE deptno IN(10, 30);
WHERE deptno = 10 OR deptno = 30;

������ ������
�������� ��ȸ�ϴ� ���������� ��� = �����ڸ� ���Ұ�
WHERE deptno IN (�������� ���� �����ϰ�, �ϳ��� �÷����� �̷���� ����);

SMITH = 20, ALLEN �� 30�� �μ��� ����

SMITH �Ǵ� ALLEN �� ���ϴ� �μ��� ������ ������ ��ȸ

SELECT deptno
FROM emp
WHERE ename IN ('SMITH', 'ALLEN');

���� ��������, �÷��� �ϳ��� 
==> ������������ ��밡���� ������ IN(���̾�, �߿�), (ANY, ALL, �󵵰� ����)

IN : ���������� ������� ������ ���� �ִ� �� TRUE
WHERE �÷�|ǥ���� IN(��������)

ANY : �����ڸ� �����ϴ� ���� �ϳ��� ���� �� TRUE
         WHERE �÷�|ǥ���� ������ ANY ( �������� )

ALL : ���������� ��� ���� �����ڸ� ������ �� TRUE
         WHERE �÷�|ǥ���� ������ ALL ( �������� )

SMITH�� ALLEN�� ���� �μ����� �ٹ��ϴ� ��� ������ ��ȸ

1. ���������� ������� ���� ��� : �ΰ��� ������ ����
1-1] SMITH, ALLEN�� ���� �μ��� �μ���ȣ�� Ȯ���ϴ� ����
SELECT deptno
FROM emp
WHERE ename IN ('SMITH','ALLEN');

1-2] 1-1]���� ���� �μ���ȣ��  IN������ ���� �ش� �μ��� ���ϴ� ���� ���� ��ȸ
SELECT *
FROM emp
WHERE deptno IN (20, 30);

==> ���������� �̿��ϸ� �ϳ��� SQL���� ���డ��
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                                 FROM emp
                              WHERE ename IN ('SMITH','ALLEN'));

sub3]
SMITH �� WARD ����� ���� �μ��� ��� ��������� ��ȸ�ϴ� ������ ������ ���� �ۼ��ϼ���.
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                                 FROM emp
                              WHERE ename IN('SMITH','WARD'));
                              
                              
                              
ANY, ALL
SMITH(800)�� WARD(1250) �λ���� �޿��� �ƹ� ������ ���� �޿��� �޴� ���� ��ȸ
==> sal < 1250 
SELECT *
FROM emp
WHERE sal < ANY(SELECT sal
                       FROM emp
                       WHERE ename IN ('SMITH', 'WARD'));


SMITH(800)�� WARD(1250) �λ���� �޿����� ���� �޿��� �޴� ���� ��ȸ
==> sal < 800 
SELECT *
FROM emp
WHERE sal > ALL(SELECT sal
                       FROM emp
                       WHERE ename IN ('SMITH', 'WARD'));

IN �������� ����
SELECT *
FROM emp
WHERE deptno NOT IN (20, 30);
NOT IN �����ڸ� ����� ��� ���������� ���� NULL�� �ִ��� ���ΰ� �߿�
==> ���������� �������� ����

�Ʒ��� ������ ��ȸ�ϴ� ����� � �ǹ��ΰ�?

NULL���� ���� ���� ����
SELECT *
FROM emp
WHERE empno NOT IN (SELECT mgr
                                        FROM emp
                                      WHERE mgr IS NOT NULL);
                                      
NULL ó�� �Լ��� ���� ������ ������ ���� �ʴ� ������ ġȯ
SELECT *
FROM emp
WHERE empno NOT IN (SELECT NVL(mgr, -1) --������ �ָ� �츮�� ���ϴ� ����� ������ ���� Ȯ���� ũ��.
                                        FROM emp);


���� �÷��� �����ϴ� ���������� ���� ���� ==> ���� �÷��� �����ϴ� ��������
PAIRWISE ���� (������) ==> ���ÿ� ����


SELECT empno, mgr, deptno
FROM emp
WHERE empno IN (7499, 7782);

7499, 7782����� ������ ���� �μ�, ���� �Ŵ����� ��� ���� ���� ��ȸ
�Ŵ����� 7698 �̸鼭 �ҼӺμ��� 30�� ���
�Ŵ����� 7839 �̸鼭 �ҼӺμ��� 10�� ���

mgr �÷��� deptno �÷��� �������� ����.
(mgr, deptno);

SELECT *
FROM emp
WHERE mgr IN (7698, 7839)
      AND deptno IN(10, 30);

PAIRWISE ���� ( ���� �������� ����� �Ѱ� ����)
SELECT *
fROM emp
WHERE (mgr, deptno) IN (SELECT mgr, deptno
                                        FROM emp
                                        WHERE empno IN (7499, 7782) );

�������� ���� - ��� ��ġ
SELECT - ��Į�� ���� ����
FROM - �ζ��� ��
WHERE - ��������

�������� ���� - ��ȯ�ϴ� ��, �÷��� ��
���� ��
    ���� �÷�(��Į�� ���� ����)
    ���� �÷�
���� ��
    ���� �÷�(���� ���� ����)
    ���� �÷�
    
    
 ��Į�� ��������
 SELECT ���� ǥ���Ǵ� ��������
 ������ ���� �÷��� �����ϴ� ���������� ��� ����
 ���� ������ �ϳ��� �÷� ó�� �ν�;
    
SELECT 'X', (SELECT SYSDATE FROM dual)
FROM dual;

��Į�� ���� ������ �ϳ��� ��, �ϳ��� �÷��� ��ȯ �ؾ� �Ѵ�.

���� �ϳ����� �÷��� 2������ ����
SELECT 'X', (SELECT empno, ename FROM emp WHERE ename = 'SMITH')
FROM dual; ==> x �ȵ�

������ �ϳ��� �÷��� �����ϴ� ��Į�� �������� ==> ����
SELECT 'X', (SELECT empno FROM emp)
FROM dual;


emp ���̺� ����� ��� �ش� ������ �Ҽ� �μ� �̸��� �� ���� ���� ==> ����
Ư�� �μ��� �μ� �̸��� ��ȸ�ϴ� ����
SELECT dname
FROM dept
WHERE deptno = 10;

�� ������ ��Į�� ���������� ����

JOIN ���� ����
SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

���������� ����
SELECT empno, ename, emp.deptno, (SELECT dname 
                                                            FROM dept
                                                          WHERE deptno = emp.deptno)dname
FROM emp, dept;

�������� ���� - ���������� �÷��� ������������ ����ϴ��� ���ֿ� ���� ����
��ȣ���� ��������(corelated sub query)
    -���� ������ ���� �Ǿ�� ���� ������ ������ �����ϴ�
���ȣ ���� ��������(non corelated sub query)
    -main ������ ���̺��� ���� ��ȸ �� ���� �ְ�
    sub ������ ���̺��� ���� ��ȸ �� ���� �ִ�.
    ==> ����Ŭ�� �Ǵ����� �� ���ɻ� ������ �������� ���� ������ ����

��� ������ �޿� ��� ���� ���� �޿��� �޴� ������ ��ȸ�ϴ� ������ �ۼ� �ϼ���(�������� �̿�)

SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
                       FROM emp);
�����غ� ����, ���� ������ ��ȣ ���� ���� �����ΰ�? ���ȣ ���� ���� �����ΰ�?


������ ���� �μ��� �޿� ��պ��� ���� �޿��� �޴� ����
��ü ������ �޿� ��� ==> ������ ���� �μ��� �޿� ���

Ư�� �μ�(10)�� �޿� ����� ���ϴ� SQL 

SELECT *
FROM emp e
WHERE sal > (SELECT AVG(sal)
                       FROM emp
                       WHERE deptno = e.deptno);
                       

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
�ƿ��� ����==> ������ ���еǴ��� �������� ���� ���̺��� �÷� ������ ��ȸ�� �ǵ��� �ϴ� ���� ���
table1 LEFT OUTER JOIN table2
==> table1�� �÷��� ���ο� �����ϴ��� ��ȸ�� �ȴ�.

SELECT *
    FROM dept;
    
INSERT INTO dept VALUES (99, 'ddit', 'daejeon');

emp���̺� ��ϵ� �������� 10, 20 ,30 �� �μ����� �Ҽ��� �Ǿ�����
���� �Ҽӵ��� ���� �μ��� : 40,  99

sub4]
dept ���̺��� �ű� ��ϵ� 99�� �μ��� ���� ����� ����
������ ������ ���� �μ��� ��ȸ�ϴ� ������ �ۼ��غ�����
SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                                        FROM emp
                                            WHERE emp.deptno = dept.deptno)
ORDER BY deptno DESC;

���������� �̟G�ƿ� IN�����ڸ� ���� ��ġ�ϴ� ���� �ִ��� �����Ҷ�
���� ������ �־ �������(����)


sub5]
cycle, product ���̺��� �̿��Ͽ� cid = 1�� ���� �������� �ʴ� ��ǰ�� ��ȸ�ϴ� ������ �ۼ��ϼ���
SELECT *
FROM product
WHERE pid NOT IN (SELECT pid
                                    FROM cycle
                                        WHERE cid =1);

sub6]
cycle ���̺��� �̿��Ͽ� cid = 1�� ���� �����ϴ� ��ǰ�� cid = 2�� ���� �����ϴ� ��ǰ�� ���������� ��ȸ�ϴ� ������ �ۼ��ϼ���
SELECT *
FROM cycle
WHERE pid IN (SELECT pid
                                FROM cycle
                                    WHERE cid = 2);

 
sub7]
customer, cycle, product ���̺��� �̿��Ͽ� cid = 1�� ���� �����ϴ� ��ǰ��
cid = 2�� ���� �����ϴ� ��ǰ�� ���������� ��ȸ�ϰ� ����� ��ǰ����� �����ϴ�
������ �ۼ��ϼ���
SELECT *
FROM customer;

������ �̿��� ���
SELECT c.cid, cnm, p.pid, pnm, day, cnt
FROM cycle c, customer cu, product p
WHERE c.cid = 1 
        AND p.pid = c.pid
        AND c.cid = cu.cid
        AND c.pid IN (SELECT pid
                                FROM cycle
                                    WHERE cid = 2);
                                    
��Į�� ���������� �̿��� ���
SELECT cid, (SELECT cnm FROM customer WHERE cid = cycle.cid) cnm
                    ,(SELECT pnm FROM product WHERE pid = cycle.pid) pnm
                    , pid, day, cnt
FROM cycle
WHERE cid = 1 
        AND pid IN (SELECT pid
                                FROM cycle
                                    WHERE cid = 2);






