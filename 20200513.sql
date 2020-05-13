DDL INDEX �ǽ� 1]
CREATE TABLE dept_test2 AS
SELECT *
FROM dept
WHERE 1=1;

CREATE UNIQUE INDEX idx_dept_01 ON dept_test2 (deptno);
CREATE INDEX idx_dept_02 ON dept_test2 (dname);
CREATE INDEX idx_dept_03 ON dept_test2 (deptno, dname);

�ǽ� 2]
DROP UNIQUE INDEX idx_dept_01;
DROP INDEX idx_dept_02;
DROP INDEX idx_dept_03;

�ǽ� 3]
DROP INDEX idx_emp_01;
CREATE INDEX idx_emp_02 ON emp (empno, ename, deptno);
CREATE INDEX idx_emp_04 ON emp (deptno, sal);
CREATE INDEX idx_emp_05 ON emp (deptno, mgr, empno, hiredate, sal);

EXPLAIN PLAN FOR
SELECT B.*
FROM EMP A, EMP B
WHERE A.mgr = B.empno
AND A.deptno = :deptno;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE sal BETWEEN :st_sal AND :ed_sal
AND deptno = :deptno;

SELECT *
FROM TABLE(dbms_xplan.display);



�ǽ� 4] -����;




�����ȹ

�����ð��� ��� ����
==> ���� ���� ���¸� �̾߱� ��, ������� �̾߱Ⱑ �ƴ�
inner join : ���ο� �����ϴ� �����͸� ��ȸ�ϴ� ���� ���
outer join : ���ο� �����ص� ������ �Ǵ� ���̺��� �÷������� ��ȸ�ϴ� ���� ���
cross join : ������ ����(īƼ�� ������Ʈ), ���� ������ ������� �ʾƼ�
             ���� ������ ��� ����� ���� ���εǴ� ���
self join  : ���� ���̺��� �����ϴ� ����

�����ڰ� DBMS�� SQL�� ���� ��û�ϸ� DBMS�� SQL�� �м��ؼ�
��� �� ���̺��� ���������� ����, 3���� ����� ���ι��(������ ���� ���, ������� �̾߱�)
1. Nested Loop Join
2. Sort Merge Join : ���εǴ� ���̺��� ���� ����(������ ������ ������ �����ϹǷ� ���� => ���� ���������� => Hash Join���� ��ü)
3. Hash Join

OLTP OnLine Transaction Processing : �ǽð� ó�� 
                                ==> ������ ����� �ϴ� �ý���(�Ϲ����� �� ����)
OLAP OnLine Analysis Processing : �ϰ�ó�� ==> ��ü ó���ӵ��� �߿��� ���
                                        (�������ڰ��, ������ �ѹ��� ���)