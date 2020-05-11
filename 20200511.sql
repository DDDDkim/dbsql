�θ�-�ڽ� ���̺� ����

1.���̺� ������ ����
    1.�θ�(dept)
    2.�ڽ�(emp)
    
2.������ ������(insert) ����
    1.�θ�(dept)
    2.�ڽ�(emp)
    
3.������ ����(delete) ����
    1.�ڽ�(emp)
    2.�θ�(dept)
    
    
    
���̺� �����(���̺��� �̹� �����Ǿ� �ִ°��) �������� �߰� ����

DROP TABLE emp_test;

CREATE TABLE emp_test(
	empno NUMBER(4),
	ename VARCHAR2(10),
	deptno NUMBER(2)
);

���̺� ������ ���������� Ư���� �������� ����

���̺� ������ ���� PRIMARY KEY �߰�

���� : ALTER TABLE ���̺�� ADD CONSTRAINT �������Ǹ� ��������Ÿ�� (������ �÷�[,]);
�������� Ÿ�� : PRIMARY KEY, UNIQUE, FOREIGN KEY, CHECK

ALTER TABLE emp_test ADD CONSTRAINT pk_emp_test PRIMARY KEY (empno);


���̺� ����� �������� ����
���� : ALTER TABLE  ���̺�� DROP CONSTRAINT �������Ǹ�;

������ �߰��� �������� pk_emp_test ����
ALTER TABLE emp_test DROP CONSTRAINT pk_emp_test;

���̺� �������� �ܷ�Ű �������� �߰� �ǽ�
emp_test.deptno ==> dept_test.deptno

dept_test ���̺��� deptno �� �ε��� ���� �Ǿ��ִ��� Ȯ��

ALTER TABLE emp_test ADD CONSTRAINT �������Ǹ� ��������Ÿ�� (�÷�) REFERENCES �������̺�� (�������̺��÷���);

ALTER TABLE emp_test ADD CONSTRAINT fk_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test (deptno);

������ ����;

�������� Ȱ��ȭ ��Ȱ��ȭ.
���̺� ������ ���������� �����ϴ� ���� �ƴ϶� ��� ����� ����, Ű�� ����

���� : ALTER TABLE ���̺�� ENABLE | DISABLE CONSTRAINT �������Ǹ�;

������ ������ fk_emp_test_dept_test FOREIGN KEY  ���������� ��Ȱ��ȭ;
ALTER TABLE emp_test DISABLE CONSTRAINT fk_emp_test_dept_test;

dept(�θ�)���̺��� 99�� �μ��� �����ϴ� ��Ȳ
SELECT *
FROM dept_test;

fk_emp_test_dept_test ���������� ��Ȱ��ȭ�Ǿ� �ֱ� ������ emp_Test ���̺��� 99�� �μ� �̿��� ���� �Է� ������ ��Ȳ

dept_test ���̺� 88�� �μ��� ������ �Ʒ� ������ ���������� ����
INSERT INTO emp_test VALUES (9999, 'brown', 88);


���� ��Ȳ : emp_test ���̺� dept_test ���̺� �������� �ʴ� 88�� �μ��� ����ϰ� �ִ� ��Ȳ
                fk_emp_test_dept_test ���������� ��Ȱ��ȭ�� ����
                
�������� ���Ἲ�� ���� ���¿��� fk_emp_test_dept_test �� Ȱ��ȭ ���Ѹ�??
==> ������ ���Ἲ�� ��ų �� �����Ƿ� Ȱ��ȭ �� �� ����.

ALTER TABLE emp_test ENABLE CONSTRAINT fk_emp_test_dept_test;


emp, dept ���̺��� ���� PRIMARY KEY, FOREIGN KEY ������ �ɷ� ���� ���� ��Ȳ
emp���̺��� empno�� key��
dept ���̺��� deptno�� key�� �ϴ�  PRIMARY KEY  ������ �߰��ϰ�

emp.deptno ==> dept.deptno�� �����ϵ��� FOREIGN KEY �� �߰�

�������� ���� �����ð��� �ȳ��� ������� ���

ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);

ALTER TABLE dept ADD CONSTRAINT pk_dept PRIMARY KEY (deptno);

ALTER TABLE emp ADD CONSTRAINT fk_emp_dept FOREIGN KEY (deptno) REFERENCES dept (deptno);


�������� Ȯ��
������ �������ִ� �޴�(���̺� ���� ==> �������� tab);
USER_CONSTRAINTS : �������� ����(MASTER);

USER_CONS_COLUMNS : �������� �÷� ����(��);

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'EMP';


�÷�Ȯ��
��
SELECT *
DESC;
USER_TAB_COLUMNS (data dictionary, ����Ŭ���� ���������� �����ϴ� view);

SELECT *
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'EMP';


SELECT 'SELECT * FROM ' || TABLE_NAME || ';'
FROM USER_TABLES;


���̺�, �÷� �ּ� : USER_TAB_COMMENTS, USER_COL_COMMENTS;

SELECT *
FROM user_tab_comments;

���� ���񽺿��� ���Ǵ� ���̺��� ���� ���ʰ��� ������ �ʴ� ��찡 ����.

���̺��� �ּ� �����ϱ�
���� : COMMENT ON TABLE ���̺�� IS '�ּ�';

emp ���̺� �ּ� �����ϱ�
COMMENT ON TABLE emp IS '�ǳ����°ŤѤ�';

SELECT *
FROM user_tab_comments
WHERE TABLE_NAME = 'EMP';

�÷� �ּ� ����
COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�';

empno : ���, ename : �̸�, hiredate : �Ի����� ������ user_col_commnets �� ���� Ȯ��;

COMMENT ON COLUMN emp.empno IS '���';
COMMENT ON COLUMN emp.ename IS '�̸�';
COMMENT ON COLUMN emp.hiredate IS '�Ի�����';

SELECT *
FROM user_col_comments
WHERE TABLE_NAME = 'EMP';

TABLE-comments �ǽ� 
comment1];
SELECT utc.*, column_name, ucc.comments col_comment
    FROM user_tab_comments utc, user_col_comments ucc
 WHERE utc.table_name = ucc.table_name 
       AND (utc.TABLE_NAME IN ('CUSTOMER', 'PRODUCT', 'CYCLE', 'DAILY'));



View�� ������
������ ������ ���� = SQL
�������� ������ ������ �ƴϴ�

view ��� �뵵
    . ������ ����(���ʿ��� �÷� ������ ����)
    . ���ֻ���ϴ� ������ ���� ����
        . IN-LINE VIEW�� ����ص� ������ ����� ����� �� �� ������
         MAIN ������ ������� ������ �ֵ�.

view�� �����ϱ� ���ؼ��� CREATE VIEW ������ ���� �־�� �Ѵ�. (DBA ����)

SYSTEM ������ ����
GRANT CREATE VIEW TO ����������� �ο��� ����;

���� : CREATE [OR REPLACE] VIEW ���̸� [�÷� ��Ī1, �÷���Ī2...] AS
    SELECT ����;
    
    
emp ���̺��� sal, comm �÷��� ������ 6���� �÷��� ��ȸ�� ������ v_emp view �� ����
    
    
CREATE OR REPLACE VIEW v_emp AS
SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp;


view (v_emp)�� ���� ������ ��ȸ;
SELECT *
FROM v_emp;

v_emp view�� DDDD���� ����
HR�������� �λ� �ý��� ������ ���ؼ� EMP ���̺��� �ƴ� SAL, COMM��ȸ�� ���ѵ�
v_emp view�� ��ȸ�Ҽ� �ֵ��� ������ �ο�

[hr�������� ����]���Ѻο��� hr �������� v_emp ��ȸ
SELECT *
FROM DDDD.v_emp;

[DDDD�������� ����]DDDD�������� hr�������� v_emp_view �� ��ȸ�� �� �ִ� ���� �ο�
GRANT SELECT ON v_emp TO hr;

[hr�������� ����]v_emp view ������ hr ������ �ο��� �̿� ��ȸ �׽�Ʈ.;
SELECT *
FROM DDDD.v_emp;



�ǽ�
v-emp_dept �並 ����
emp, dept ���̺��� deptno �÷����� �����ϰ�
emp.empno, ename, dept.deptno, dname 4���� �÷����� ����

CREATE OR REPLACE VIEW v_emp_dept AS
    SELECT emp.empno, emp.ename, dept.deptno, dept.dname
    FROM emp, dept
    WHERE emp.deptno = dept.deptno;

SELECT *
FROM v_emp_dept;\

VIEW ����
���� : DROP VIEW ������ ���̸�;
DROP VIEW v_emp;



