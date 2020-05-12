EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7369;

SELECT *
FROM TABLE(dbms_xplan.display);

ROWID : ���̺� ���� ����� �����ּ�
              (java - �ν��Ͻ� ����
                c - ������ );

SELECT ROWID, emp.*
FROM emp;
 
 ����ڿ� ���� ROWID ���;
 EXPLAIN PLAN FOR
 SELECT *
 FROM emp
 WHERE ROWID ='AAAE5xAAFAAAAEUAAF';
 
 SELECT *
 FROM TABLE(dbms_xplan.display);
 
--------------------------------------------------------------------------------------
| Id  | Operation                   | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |        |     1 |    38 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP    |     1 |    38 |     1   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN         | PK_EMP |     1 |       |     0   (0)| 00:00:01 |
--------------------------------------------------------------------------------------
 
  
INDEX : ���̺��� �Ϻ� �÷��� �������� �����͸� ������ ��ü
            ���̺��� row�� ����Ű�� �ּҸ� �����ִ�(ROWID)
            
  
INDEX �ǽ�
emp ���̺� ���� ������ pk_emp PRIMARY KEY ���������� ����
ALTER TABLE emp DROP CONSTRAINT pk_emp;

�ε��� ���� empno ���� �̿��Ͽ� ������ ��ȸ
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);
  
2. emp���̺� empno �÷����� PRIMARY KEY �������� ������ ���
    (empno �÷����� ������ unique �ε����� ����);
    
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);
    
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;  
   

3. 2�� SQL�� ����(SELECT �÷��� ����);
   
2��
SELECT *
FROM emp
WHERE empno = 7782;  

3��;
EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno = 7782;  

SELECT *
FROM TABLE (dbms_xplan.display);

4. empno�÷��� non-unique �ε����� �����Ǿ� �ִ� ���
ALTER TABLE emp DROP CONSTRAINT pk_emp;

CREATE INDEX idx_emp_01 ON emp (empno);
CREATE UNIQUE INDEX idx_emp_01 ON emp (empno);


EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno='7782';

SELECT *
FROM TABLE(dbms_xplan.display);


5.emp ���̺��� job ���� ��ġ�ϴ� �����͸� ã�� ���� �� 
���� �ε���
idx_emp_01 : empno;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER';

SELECT *
FROM TABLE(dbms_xplan.display);

idx_emp_01 �� ��� ������ empno �÷� �������� �Ǿ� �ֱ� ������ job �÷��� �����ϴ�
SQL������ ȿ�������� ����� ���� ���� ������ TABLE ��ü �����ϴ� ������ �����ȹ�� ������

==> idx_emp_02(job) ������ �� �� ���� ��ȹ ��
CREATE INDEX idx_emp_02 ON emp(job);

SELECT job, ROWID
FROM emp;


6. emp���̺��� job='MANAGER'�̸鼭 ename �� C�� �����ϴ� ����� ��ȸ(��ü �÷� ��ȸ)
�ε��� ��Ȳ
idx_emp_01 : empno
idx_emp_02 : job;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job='MANAGER'
AND ename like 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);



7. emp���̺��� job='MANAGER'�̸鼭 ename �� C�� �����ϴ� ����� ��ȸ(��ü �÷� ��ȸ)
�� ���ο� �ε��� �߰� : idx_emp_03 : job, ename
CREATE INDEX idx_emp_03 ON emp(job, ename);

�ε��� ��Ȳ
idx_emp_01 : empno
idx_emp_02 : job;
idx_emp_03 : job, ename;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job='MANAGER'
AND ename like 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);


8. emp���̺��� job='MANAGER'�̸鼭 ename �� C�� ������ ����� ��ȸ(��ü �÷� ��ȸ)

�ε��� ��Ȳ
idx_emp_01 : empno
idx_emp_02 : job;
idx_emp_03 : job, ename;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job='MANAGER'
AND ename like '%C';

SELECT *
FROM TABLE(dbms_xplan.display);


RULE BASED OPTIMIZER : ��Ģ��� ����ȭ�� (9i) ==> ���� ī�޶�
COST BASED OPTIMIZER : ����� ����ȭ�� (10g)==> �ڵ� ī�޶�

9. ���� �÷� �ε����� �÷� ������ �߿伺
�ε��� ���� �÷� : (job, ename) VS (ename, job)
*** �����ؾ� �ϴ� sql�� ���� �ε��� �÷� ������ �����ؾ��Ѵ�.

���� sql: job='MANAGER', ename �� C�� �����ϴ� ��� ������ ��ȸ(��ü �÷�)
�ε��� �ű� ����
idx_emp_04 : ename, job
CREATE INDEX idx_emp_04 ON emp(ename, job);
���� �ε��� ���� : idx_emp_03
DROP INDEX idx_emp_03;

�ε��� ��Ȳ
idx_emp_01 : empno
idx_emp_02 : job;
idx_emp_04 : ename, job;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);


���ο����� �ε���
idx_emp_01����(pk_emp �ε����� �ߺ�)
DROP INDEX idx_emp_01;

emp���̺� empno �÷��� PRIMARY KEY �� �������� ����
pk_emp : empno
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);

�ε��� ��Ȳ
pk_emp : empno
idx_emp_01 : empno
idx_emp_02 : job;
idx_emp_04 : ename, job;




