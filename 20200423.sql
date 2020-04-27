NVL(expr1, expr2)
expr1 == null
    return expr2
expr1 != null
    return expr1;

NVL2(expr1, expr2, expr3)
if( expr1 != null
    return expr2
else
    return expr3;

SELECT empno, ename, sal, comm, NVL2(comm, 100, 200)
FROM emp;

NULLIF(expr1, expr2)
if expr1 == expr2
    return null
else
    return expr1

SELECT empno, ename, sal, NULLIF(sal, 3000)
FROM emp;

�������� : �Լ��� ������ ������ ������ ���� ����
          �������ڵ��� Ÿ���� ���� �ؾ���
���ڵ� �߿� ���� ���������� null�� �ƴ� ���� ���� ����
coalesce(expr1, expr2, expr3....)
if expr1 != null
    return expr1
else
    coalesce(expr2, expr3........)

mgr �÷� null
comm �÷� null

SELECT empno, ename, comm, sal, coalesce(comm, sal)
FROM emp;

SELECT empno, ename, mgr, NVL(mgr, 9999), NVL2(mgr, mgr, 9999), coalesce(mgr, 9999)
FROM emp;

SELECT userid, usernm, reg_dt,nvl(reg_dt, SYSDATE) n_reg_dt 
FROM USERS
WHERE userid !='brown';

condition
���ǿ� ���� �÷� Ȥ�� ǥ������ �ٸ� ������ ��ü
java if,witch ���� ����
1. case ����
2. decode �Լ�

1.CASE 
CASE 
    WHEN��/������ �Ǻ��Ҽ� �ִ� �� THEN ������ ��
    [WHEN��/������ �Ǻ��Ҽ� �ִ� �� THEN ������ ��]
    [ELSE ������ �� (�Ǻ����� ���� WHEN ���� ���� ��� ����)]
END

emp���̺��� ��ϵ� �����鿡�� ���ʽ��� �߰������� ������ ����
�ش� ������ job�� SALESMAN�� ��� SAL���� 5% �λ�� �ݾ��� ���ʽ��� ����(ex : sal 100 -> 105)
�ش� ������ job�� MANAGER�� ��� SAL���� 10% �λ�� �ݾ��� ���ʽ��� ����
�ش� ������ job�� PRESIDENT�� ��� SAL���� 20% �λ�� �ݾ��� ���ʽ��� ����
�׿� �������� sal ��ŭ�� ����

SELECT empno, ename, job, sal,
    CASE
        WHEN �� ������ �����Ҽ� �ִ� ���� THEN ��ȯ�� ��
    END
FROM emp;

SELECT empno, ename, job, sal,
    CASE
        WHEN job = 'SALESMAN' THEN sal* 1.05
        WHEN job = 'MANAGER' THEN sal* 1.10
        WHEN job = 'PRESIDENT' THEN sal* 1.20
        ELSE sal * 1
    END bonus
FROM emp;

2. DECODE(EXPR1,search1, return1, search2, return2, search3, return3.......,[ default])
if EXPR1 == search1
    return return1
else if EXPR1 == search2
    return return2
else if EXPR1 == search3
    return return3
    ......
else
    return default;


SELECT empno, ename, job, sal,
        DECODE(job, 'SALESMAN', sal *1.05,
                    'MANAGER',sal*1.10,
                    'PRESIDENT', sal *1.20,
                    sal) bonus
FROM emp;

SELECT empno, ename, deptno,
        CASE
            WHEN deptno = 10 THEN 'ACCOUNTING'
            WHEN deptno = 20 THEN 'RESEARCH'
            WHEN deptno = 30 THEN 'SALES'
            WHEN deptno = 40 THEN 'OPERATIONS'
            ELSE 'DDIT'
        END DNAME
FROM emp;

SELECT empno, ename, deptno,
        DECODE(deptno, 10, 'ACCOUNTING',
                       20, 'RESEARCH',
                       30, 'SALES',
                       40, 'OPERATIONS',
                       'DDIT') DNAME
FROM emp;




SELECT empno, ename, hiredate,
        CASE
            WHEN MOD(TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(hiredate,  'YYYY'), 2) = 0 THEN '�ǰ����� �����'
            ELSE '�ǰ����� ������'
        END contact_to_doctor
FROM emp;

SELECT userid, usernm, alias, reg_dt,
    CASE
--        WHEN MOD(TO_CHAR(SYSDATE + 365, 'YYYY') - TO_CHAR(reg_dt, 'YYYY'), 2) = 0 THEN '�ǰ����� �����'
        WHEN MOD(TO_CHAR(SYSDATE,'YYYY'), 2) != MOD(TO_CHAR(reg_dt,'YYYY'), 2) THEN '�ǰǰ�'
        ELSE '�ǰ����� ������'
    END contact_to_doctor
FROM users;



