grp7]
dept ���̺��� Ȯ���ϸ� �� 4���� �μ� ������ ���� ===> ȸ�系�� �����ϴ� ��� �μ�����
emp���̺��� �����Ǵ� �������� ���� ���� �μ������� ���� ==> 10,20,30 ==? 3��

SELECT COUNT(*) cnt
FROM 
    (SELECT deptno  --deptno�÷��� 1�� ����, row�� 3���� ���̺�
    FROM emp
    GROUP BY deptno);
    
JOIN 
    -RDBMS�� �ߺ��� �ּ��ϴ� ������ ������ ���̽�
    -�ٸ� ���̺�� �����Ͽ� �����͸� ��ȸ;
    --RDBMS : Realational Data Base Management System(������ �����ͺ��̽� ���� �ý���)
    
SELECT *
FROM dept;

JOIN�� ����
    -Natural Join
        -�����ϰ��� �ϴ� ���̺��� �÷����� ���� �÷����� ����;
        
        
JOIN ������ ����
ANSI - ǥ��
�������� ����(ORACLE);

JOIN�� ��� �ٸ� ���̺��� �÷��� ����� �� �ֱ� ������;
SELECT �� �� �ִ� �÷��� ������ ��������(���� Ȯ��)

���տ��� ==> ����Ȯ��(���̸�������)���߿�...;

NATURAL JOIN :
    -�����Ϸ��� �� ���̺��� ����� �÷��� �̸��� ���� ���
    -emp, dept ���̺��� deptno ��� �����(������ �̸���, Ÿ�Ե� ����) ����� �÷��� ����
    -�ٸ� ANSI-SQL ������ ���ؼ� ��ü�� �����ϰ�, ���� ���̺���� �÷����� �������� ������
    ����� �Ұ����ϱ� ������ ���󵵴� �ټ� ����.;
    
    -emp ���̺� : 14��
    -dept ���̺� : 4��

���� �Ϸ��� �ϴ� �÷��� ���� ������� ����;
SELECT *
FROM emp NATURAL JOIN dept; --�� ���̺��� �̸��� ������ �÷����� �����Ѵ� ==> deptno
    
    
ORACLE ���� ������ ANSI ����ó�� ����ȭ ���� ����
����Ŭ ���� ����
1. ������ ���̺� ����� FROM ���� ����ϸ� �����ڴ� �ݷ�(,)
2. ����� ������ WHERE���� ����ϸ� �ȴ� (ex : WHERE emp.deptno = dept.deptno);

SELECT * 
FROM emp, dept
WHERE emp.deptno = dept.deptno;

deptno �� 10���� �����鸸 ��ȸ;
SELECT * 
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.deptno = 10;


ANSI-SQL : JOIN with USING
    -join�Ϸ��� ���̺� �̸��� ���� �÷��� 2�� �̻��϶�
    -�����ڰ� �ϳ��� �÷����θ� �����ϰ� ���� �� ���� �÷����� ���;
    
SELECT *
FROM emp JOIN dept USING (deptno);

ANSI-SQL : JOIN with ON
    - �����Ϸ��� �� ���̺� �÷����� �ٸ� ��
    - ON���� ����� ������ ���;
    
SELECT *
FROM emp JOIN dept ON(emp.deptno = dept.deptno);

ORACLE �������� �� SQL �� �ۼ�
SELECT *
FROM emp ,dept
WHERE emp.deptno = dept.deptno;



JOIN�� ������ ����
SELF JOIN : �����Ϸ��� ���̺��� ���� ���� ��
EMP ���̺��� ������ ������ ������ ��Ÿ���� ������ ������ mgr �÷��� �ش� ������ ������ ����� ����.
�ش� ������ �������� �̸��� �˰������

ANSI-SQL�� SQL ���� : 
�����Ϸ���  �ϴ� ���̺� EMP(����), EMP(������ ������)
            ����� �÷� : ����.MGR = ������.EMPNO
            ==> ���� �÷� �̸��� �ٸ���(MGR, EMPNO)
                ==>NATURAL JOIN, JOIN with USING �� ����� �Ұ����� ����
                    ==> JOIN with ON
                    
                    
                    
ANSI-SQL �� �ۼ�;
SELECT *
FROM emp e JOIN emp m ON(e.mgr = m.empno);


NONEUQI JOIN : ����� ������ = �� �ƴҶ�

SELECT emp.empno, emp.ename, emp.sal, salgrade.grade 
FROM emp JOIN salgrade ON(emp.sal BETWEEN salgrade.losal AND salgrade.hisal);

==> ORACLE ���� �������� ����

SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;


SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
ORDER BY d.dname;

SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e JOIN dept d ON(e.deptno = d.deptno)
ORDER BY d.deptno;

SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno AND (e.deptno = 10 OR e.deptno = 30);

SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e JOIN dept d ON((e.deptno = d.deptno)AND(e.deptno = 10 OR e.deptno = 30));

SELECT e.empno, e.ename, e.sal, e.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
AND e.sal > 2500
ORDER BY e.sal DESC;

SELECT e.empno, e.ename, e.sal, e.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
AND e.sal > 2500
AND e.empno > 7600
AND d.dname = 'ACCOUNTING'
ORDER BY e.sal DESC;

SELECT LPROD_GU, LPROD_NM, PROD_ID, PROD_NAME
FROM prod p , lprod l
WHERE p.PROD_LGU = l.LPROD_GU;


    
    