��������
1. PRIMARY KEY
2. UNIQUE
3. FOREIGN KEY
4. CHECK
        .NOT NULL
5. NOT NULL
        CHECK ���� ���������� ���� ����ϱ� ������ ������ KEY WORD �� ����
        
        
NOT NULL ��������
: �÷��� ���� NULL�� ������ ���� �����ϴ� ���� ����



DROP TABLE dept_test;

CREATE TABLE dept_test (
	deptno NUMBER(2, 0),
	dname VARCHAR2(14) NOT NULL,
	loc VARCHAR2(13)
);

dname �÷��� ������ NOT NULL �������ǿ� ���� �Ʒ� INSERT ������ �����Ѵ�
INSERT INTO dept_test VALUES (99, NULL, 'daejeon');

���ڿ��� ���  ''�� NULL�� �ν��Ѵ�
�Ʒ��� INSERT ������ ����
INSERT INTO dept_test VALUES (99, ' ', 'daejeon');

SELECT *
FROM dept_test;


UNIQUE ����
�ش� �÷��� ������ ���� �ߺ����� �ʵ��� ����
���̺��� ��� ���� �ش� �÷��� ���� �ߺ����� �ʰ� �����ؾ���
EX : ���� ���̺��� ��� �÷�, �л� ���̺��� �ѹ� �÷�


DROP TABLE dept_test;

CREATE TABLE dept_test (
	deptno NUMBER(2, 0),
	dname VARCHAR2(14) UNIQUE,
	loc VARCHAR2(13)
);

dept_test ���̺��� dname �÷��� UNIQUE ������ �ֱ� ������ ������ ���� �� �� ����.
INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (98, 'ddit', '����');


���� �÷��� ���� UNIQUE ���� ����
DROP TABLE dept_test;

CREATE TABLE dept_test (
	deptno NUMBER(2, 0),
	dname VARCHAR2(14),
	loc VARCHAR2(13),
    
    CONSTRAINT u_dept_test UNIQUE(dname, loc)
);

dname�÷��� loc �÷��� ���ÿ� ������ ���̾�߸� �ߺ����� �ν�
�ؿ� �ΰ��� ������ ������ �ߺ��� �ƴϹǷ� ���� ����
INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (98, 'ddit', '����');

�Ʒ������� UNIQUE ���� ���ǿ� ���� �Էµ��� �ʴ´�.
INSERT INTO dept_test VALUES (97, 'ddit', '����');

SELECT *
FROM dept_test;


FOREIGN KEY ��������
�Է��ϰ��� �ϴ� �����Ͱ� �����ϴ� ���̺� ������ ���� �Է� ���
ex : emp Ƽ���� �����͸� �Է��� �� deptno �÷��� ���� 
      dept ���̺� �����ϴ� deptno ���̾�� �Է°���
      
������ �Է½�(emp) �����ϴ� ���̺�(dept)�� ������ ���� ������ ������ �˱����ؼ�
�����ϴ� ���̺�(dept)�� �÷�(deptno)�� �ε����� �ݵ�� �����Ǿ� �־�߸�
FOREIGN KEY ���������� �߰� �� �� �ִ�.


UNIQUE ���������� ������ ��� �ش� �÷��� �� �ߺ� üŬ�� ������ �ϱ� ���ؼ�
����Ŭ������ �ش� �÷��� �ε����� ���� ��� �ڵ����� �����Ѵ�.

PRIMARY KEY �������� : UNIQUE ���� + NOT NULL
PRIMARY KEY �������Ǹ� �����ص� �ش� �÷����� �ε����� ���� ���ش�


FOREIGN KEY ���������� �����ϴ� ���̺��� �ֱ� ������ �ΰ��� ���̺� �����Ѵ�.

DROP TABLE dept_test;

CREATE TABLE dept_test (
	deptno NUMBER(2, 0) PRIMARY KEY,
	dname VARCHAR2(14),
	loc VARCHAR2(13)
);

INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');
COMMIT;


CREATE TABLE emp_test (
	empno NUMBER(4, 0) PRIMARY KEY,
	ename VARCHAR2(10),
	deptno NUMBER(2, 0) REFERENCES dept_test(deptno)
);

���� �μ� ���̺��� 99�� �μ��� ����
foreign key �������ǿ� ���� emp ���̺��� deptno �÷����� 99�� �̿��� �μ���ȣ�� �Էµ� �� ����.

99�� �μ��� �����ϹǷ� ���������� �Է� ����
INSERT INTO emp_test VALUES (9999, 'brown', 99);

98�� �μ��� �������� �����Ƿ� ���������� �Է��� �� ����
INSERT INTO emp_test VALUES (9999, 'brown', 98);


FOREIGN KEY �������� ���̺� �������� ���
DROP TABLE emp_test;

CREATE TABLE emp_test (
	empno NUMBER(4, 0) PRIMARY KEY,
	ename VARCHAR2(10),
	deptno NUMBER(2, 0),
    
    CONSTRAINT fk_emp_test_dept_test FOREIGN KEY (deptno) REFERENCE dept_test (deptno)
);








