OUTER JOIN
���̺� ���� ������ �����ص�, �������� ���� ���̺��� �÷��� ��ȸ�� �ǵ��� �ϴ� ���� ���
<==> 
INNER JOIN(�츮�� ���ݱ��� ��� ���)

LEFT OUTER JOIN     : ������ �Ǵ� ���̺��� JOIN Ű���� ���ʿ� ��ġ
RIGHT OUTER JOIN     : ������ �Ǵ� ���̺��� JOIN Ű���� �����ʿ� ��ġ
FULL OUTER JOIN     : LEFT OUTER JOIN + RIGHT OUTER JOIN - (�ߺ��Ǵ� �����Ͱ� �ѰǸ� ������ ó��)

emp���̺��� �÷��� mgr�÷��� ���� �ش� ������ ������ ������ ã�ư� �� �ִ�.
������ KING ������ ��� ����ڰ� ���� ������ �Ϲ����� inner ���� ó����
���ο� �����ϱ� ������ KING�� ������ 13���� �����͸� ��ȸ�� ��.

INNER ���� ����
����� ���, ����� �̸�, ���� ���, ���� �̸�

������ �����ؾ����� �����Ͱ� ��ȸ�ȴ�
==> KING�� ����� ����(mgr)��  NULL�̱� ������ ���ο� �����ϰ�
        KING�� ������ ������ �ʴ´� (emp���̺� �Ǽ� 14�� ==> ���� ��� 13��)

(HR...)
SELECT e.manager_id, m.first_name||m.last_name manager_name, e.employee_id, e.first_name||e.last_name name
FROM employees e, jobs j, employees m
WHERE e.job_id = j.job_id
      AND e.manager_id = m.employee_id;
      
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

ANSI-SQL
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e JOIN emp m ON(e.mgr = m.empno);

���� ������ OUTER �������� ����
(KING ������ ���ο� �����ص� ���� ������ ���ؼ��� ��������
, ������ ����� ������ ���� ������ ������ �ʴ´�.);

SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno);

SELECT m.empno, m.ename, e.empno, e.ename
FROM emp m LEFT OUTER JOIN emp e ON (e.mgr = m.empno);

ORACLE-SQL : OUTER
oracle join
1.FROM ���� ������ ���̺� ���(�޸��� ����)
2.WHERE ���� ���� ������ ���
3. ���� �÷�(�����) �� ������ �����Ͽ� �����Ͱ� ���� ���� �÷��� (+)�� �ٿ��ش�
    ==> ������ ���̺� �ݴ��� �� ���̺��� �÷�

SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e, emp m 
WHERE e.mgr = m.empno(+);

OUTER ������ ���� ��� ��ġ�� ���� ��� ��ȭ

������ ����� �̸�, ���̵� �����ؼ� ��ȸ
��, ������ �Ҽ� �μ��� 10���� ���ϴ� �����鸸 �����ؼ�;

������ ON���� ������� ��
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e LEFT OUTER JOIN emp m ON ( e.mgr = m.empno AND e.deptno = 10); ==> o

������ WHERE���� ������� ��
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e LEFT OUTER JOIN emp m ON ( e.mgr = m.empno ) ==> x
WHERE e.deptno = 10;


OUTER ������ �ϰ� ���� ���׶�� ������ ON���� ����ϴ°� �´�

ORACLE-SQL
SELECT m.empno, m.ename, e.empno, e.ename
    FROM emp e, emp m 
 WHERE e.mgr = m.empno(+)
       AND e.deptno = 10;


SELECT * 
FROM buyprod;
WHERE buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD');
SELECT *
FROM prod;

outer join �ǽ�1]
SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty
FROM buyprod b RIGHT OUTER JOIN prod p 
ON(p.prod_id = b.buy_prod(+) 
AND buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD'));


outer join �ǽ�2]
SELECT NVL(buy_date, '2005/01/25'), buy_prod, prod_id, prod_name, buy_qty
    FROM buyprod b RIGHT OUTER JOIN prod p 
        ON(p.prod_id = b.buy_prod(+)
      AND buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD'));
      

outer join �ǽ�3]
SELECT NVL(buy_date, '2005/01/25') buy_date, buy_prod, prod_id, prod_name, NVL(buy_qty, 0) buy_qty
    FROM buyprod b RIGHT OUTER JOIN prod p 
        ON(p.prod_id = b.buy_prod(+)
      AND buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD'));


outer join �ǽ�4]
SELECT p.pid, p.pnm, NVL(cid, 1), NVL(day, 0), NVL(cnt, 0)
FROM cycle c, product p
WHERE c.pid(+) = p.pid
AND c.cid(+) = 1;

SELECT p.pid, p.pnm, NVL(c.cid, 1), NVL(day, 0), NVL(cnt, 0)
FROM cycle c RIGHT OUTER JOIN product p
ON( c.pid = p.pid
AND cid = 1);

outer join �ǽ�5]
SELECT p.pid, p.pnm, NVL(c.cid, 1) cid, cnm, NVL(day, 0) day, NVL(cnt, 0) cnt
FROM cycle c, product p, customer cu
WHERE c.pid(+) = p.pid
AND cu.cnm = 'brown'
AND c.cid(+) = 1
ORDER BY pid DESC;

SELECT p.pid, p.pnm, NVL(c.cid, 1), NVL(day, 0), NVL(cnt, 0)
FROM cycle c JOIN product p
ON( c.pid = p.pid
AND cid = 1) ;


SELECT *
FROM product, cycle, customer
WHERE product.pid = cycle.pid;

CROSS JOIN
���� ������ ������� ���� ���
��� ������ ���� �������� ����� ��ȸ�ȴ�.

SELECT *
FROM emp CROSS JOIN dept;

ORACLE (���� ���̺� ������ WHERE ���� ������ ������� �ʴ´�.)
SELECT *
FROM emp, dept;

cross join �ǽ�1]
SELECT *
FROM customer, product;

���� <==> ����
���������� �ٸ� ���� �ȿ��� �ۼ��� ����
�������� ������ ��ġ
1. SELECT
        SCALAR SUB QUERY
        * ��Į�� ���������� ��ȸ�Ǵ� ���� 1���̰�, �÷��� �Ѱ��� �÷��̾�� �Ѵ�.
        EX) DUAL ���̺�
2. FROM
        INLINE-VIEW
        SELECT ������ ��ȣ�� ������
3. WHERE
        SUB QUERY
       WHERE ���� ���� ����
       
SMITH �� ���� �μ��� ���� �������� ����������?

1.SMITH �� ���� �μ��� ���?
2. 1������ �˾Ƴ� �μ���ȣ�� ���ϴ� ������ ��ȸ

==> �������� 2���� ������ ���� ����
        �ι�° ������ ù��°�� ������ ����� ���� ���� �ٸ��� �����;� �Ѵ�.
        (SMITH(20) => WARD(30) ==> �ι�° ���� �ۼ��� 20������ 30������ ������ ����)
        ==>�������� ���鿡�� ��������;
        
ù��° ����;
SELECT deptno
   FROM emp
WHERE ename = 'SMITH';

�ι�° ����;
SELECT *
   FROM emp
WHERE deptno = 20;

���������� ���� ���� ����
SELECT *
   FROM emp
WHERE deptno = (SELECT deptno
                                FROM emp
                             WHERE ename = :ename);
                             
�������� (�ǽ� sub1)]
SELECT ROUND(AVG(sal),2)
FROM emp;

SELECT COUNT(*)
FROM emp
WHERE sal >(SELECT ROUND(AVG(sal),2)
                         FROM emp);
�������� (�ǽ� sub2)]                         
SELECT *
FROM emp
WHERE sal >(SELECT ROUND(AVG(sal),2)
                         FROM emp);
                         






