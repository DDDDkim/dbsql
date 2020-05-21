dt �÷��� ����� ������ �ߺ��� �����ؼ� ��ȸ�ϰ��

dt�÷����� �����Ͱ� 5/8 ~ 6/7�� �ش��ϴ� ����Ʈ Ÿ�� �ڷᰡ ����Ǿ� �ִµ�
5/1 ~ 5/31�� �ش��ϴ� ��¥(�����)�� �ߺ����� ��ȸ�ϰ� �ʹ�.
���ϴ� ��� : 5/8 ~ 5/31
SELECT TO_CHAR(dt, 'YYYYMMDD') dt, COUNT(*)
FROM gis_dt
WHERE dt BETWEEN TO_DATE('20200508', 'YYYYMMDD') AND TO_DATE('20200531 23:59:59' , 'YYYYMMDD HH24:MI:SS')
GROUP BY TO_CHAR(dt, 'YYYYMMDD');
ORDER BY dt DESC;

�츮�� ���ϴ� ���� �ִ� ���� ��� : 24�� ==> 31���� ���� �ִ� ��

SELECT TO_CHAR(d, 'YYYYMMDD')
FROM
(SELECT TO_DATE('20200501', 'YYYYMMDD') + (LEVEL - 1) d
 FROM dual
 CONNECT BY LEVEL <= 31) a
 WHERE EXISTS (SELECT 'X'
                FROM gis_dt
                WHERE dt BETWEEN TO_DATE(TO_CHAR(d, 'YYYYMMDD') || '00:00:00', 'YYYYMMDDHH24:MI:SS') AND
                                TO_DATE(TO_CHAR(d, 'YYYYMMDD') || '23:59:59', 'YYYYMMDDHH24:MI:SS'));
                                
                                
ȣ��ȣ
10��, 1~2ȸ�簡 PL/SQLȸ�縦 ��ȣ
PL/SQL ==> PL/SQL�� �����ϴ� ���� ����Ŭ ��ü
            �ڵ� ��ü�� ����Ŭ�� ����(����Ŭ ��ü�ϱ�)
            ������ �ٲ� �Ϲ� ���α׷��� ���� ������ �ʿ䰡 ����
SQL ==> SQL ������ �Ϲ� ���� ����(java)
        .���� sql�� ���õ� ������ �ٲ�� java������ ������ ���ɼ��� ŭ
 
PL/SQL : Procedual Language / Structured Query Language
SQL : ������, ������ ����(�̺��ϰ� ����, CASE, DECODE....)

������ �ϴٺ��� � ���ǿ� ���� ��ȸ�ؾ��� ���̺� ��ü�� �ٲ�ų�, ������ ��ŵ�ϴ� ����
�������� �κ��� �ʿ��� ���� ����

�������� : �ҵ��� 25%�� �ſ�ī�� + ���ݿ����� + üũī��� �Һ� �ؾ���
        �Һ� �ݾ��� �ҵ��� 25%�� �ʰ��ϴ� �ݾ׿� ���ؼ�
        �ſ�ī�� ���� : 20%, ���ݿ����� : 30%, üũī�� : 25%�� �����ϴµ�
        �� �����ݾ��� 300������ ���� �� ����
        �� ���߱��뿡 ���� �߰������� 100������ ���� ���� �� �ְ�
        ������忡 ���ݾ׿� ���ؼ��� �߰������� 100������ �������� �� �ִ�;
        
DBMS�󿡼� ���� ���� ������ ������ SQL�� �ۼ��ϴµ��� ������ ����(��������)
�Ϲ����� ���α׷��� ���� ����ϴ� ��������(if, case), �ݺ���(for, while), �������� Ȱ���� �� �ִ�
PL/SQL �� ����

*���� : �򰥸� ����

���� ������
java =
pl/sql :=


java���� sysout ==> console�� ���
PL/SQL ���� ����
SET SERVEROUTPUT ON; �α׸� �ܼ�â�� ��°����ϰԲ� �ϴ� ����
SET SERVEROUTPUT ON;

PL/SQL block�� �⺻����
DECLARE : ����� (���� ���� ����, ��������)
BEGIN : ����� (������ �����Ǵ� �κ�)
EXCEPTION : ���ܺ�(���ܰ� �߻����� �� CATCH�Ͽ� �ٸ� ������ �����ϴ� �κ�(java try-catch)


PL/SQL �͸�(�̸��� ����, ��ȸ��) ���;

������ Ÿ�� ����
v_deptno, v_dname �ΰ��� ���� ���� ==> dept ���̺��� �÷� ���� �������� ����
                                ==> dept���̺��� �÷� ������ Ÿ�԰� �����ϰ� �����ϰ� ���� ��Ȳ
������ Ÿ���� ���� �������� �ʰ� ���̺��� �÷� Ÿ���� �����ϵ��� ���� �� �� �ִ�.
==>���̺� ������ �ٲ� pl/sql ��Ͽ� ����� ������ Ÿ���� �������� �ʾƵ� �ڵ����� ����ȴ�.

���̺��.�÷���%TYPE;

DECLARE
     /*JAVA : ����TYPE ������
     PL/SQL : ������ ����TYPE*/
     
     v_deptno dept.deptno%TYPE;
     v_dname dept.dname%TYPE;
BEGIN
    --dept ���̺��� 10�� �μ��� �ش��ϴ� �μ���ȣ, �μ����� DECLARE���� ������ �ΰ��� ������ ���
    
    SELECT deptno, dname INTO v_deptno, v_dname
    FROM dept
    WHERE deptno = 10;
    
    --JAVA�� SYSOUT
    DBMS_OUTPUT.PUT_LINE(v_deptno || '     ' || v_dname);
END;
/
     
     
     
DECLARE
     v_deptno dept.deptno%TYPE;
     v_dname dept.dname%TYPE;
BEGIN
    SELECT deptno, dname INTO v_deptno, v_dname
    FROM dept
    WHERE deptno = 10;
    
    DBMS_OUTPUT.PUT_LINE(v_deptno || '     ' || v_dname);
END;
/     
     
��¥�� �Է¹޾� ==> ��ȸ���� ������ �������� 5�ϵ��� ��¥�� �����ϴ� �Լ�
    ȸ�縸�� Ư���� ������ �ʿ��� ��� �Լ��� ���� �� �ֵ�.
    
    
PROCEDURE : �̸��� �ִ� PL/SQL ���, ���ϰ��� ����
            ������ ���� ó���� �����͸� �ٸ� ���̺� �Է��ϴ� ����
            �����Ͻ� ������ ó���� �� ���
            ����Ŭ ��ü ==> ����Ŭ ������ ������ �ȴ�
            ������ �ִ� ������� ���ν��� �̸��� ���� ������ ����;
            
            
CREATE OR REPLACE PROCEDURE printdept (p_deptno IN dept.deptno%TYPE)IS
--�����
    v_deptno dept.deptno%TYPE;
    v_dname dept.dname%TYPE;
BEGIN
    SELECT deptno, dname INTO v_deptno, v_dname
    FROM dept
    WHERE deptno= p_deptno;
    
    DBMS_OUTPUT.PUT_LINE(v_deptno || '      ' || v_dname);
END;
/

���ν��� ������ : EXEC ���ν��� �̸�;
EXEC printdept(30);

PL/SQL������ SELECT ������ ���� ���� �� �����Ͱ� �Ѱǵ� �ȳ��� ��� NO_DATA_FOUND ���ܸ� ������;

CREATE OR REPLACE PROCEDURE printemp (p_empno IN emp.empno%TYPE) IS
    v_empno emp.empno%TYPE;
    v_ename emp.ename%TYPE;
    v_dname dept.dname%TYPE;
BEGIN
    SELECT empno, ename, dept.dname INTO v_empno, v_ename, v_dname
    FROM emp,dept
    WHERE emp.deptno = dept.deptno
      AND empno = p_empno;
    
    DBMS_OUTPUT.PUT_LINE(v_empno || '     ' || v_ename || '     ' ||v_dname);
END;
/

EXEC printemp(7698);

SELECT *
FROM dept_test;

CREATE OR REPLACE PROCEDURE registdept_test (p_deptno IN dept_test.deptno%TYPE, p_dname IN dept_test.dname%TYPE
                                            ,p_loc IN dept_test.loc%TYPE) IS
BEGIN
    INSERT INTO dept_test VALUES(p_deptno, p_dname, p_loc);
END;
/

EXEC registdept_test(99, 'ddit', 'daejeon');


CREATE OR REPLACE PROCEDURE UPDATEdept_test (p_deptno IN dept_test.deptno%TYPE, p_dname IN dept_test.dname%TYPE
                                            ,p_loc IN dept_test.loc%TYPE) IS
BEGIN
    UPDATE dept_test SET deptno = p_deptno;
    UPDATE dept_test SET dname = p_dname;
    UPDATE dept_test SET loc = p_loc;
END;
/

EXEC UPDATEdept_test(98, 'dddddit', 'daejeon');

ROLLBACK;


���պ���
��ȸ����� �÷��� �ϳ��� ������ ��� �۾� ���ŷӴ� ==> ���պ����� ����Ͽ� �������� �ؼ�

0. %TYPE : �÷�
1. %ROWTYPE : Ư�� ���̺��� ���� ��� �÷��� ������ �� �ִ� ���� ���� Ÿ��
    (���� %TYPE - Ư�� ���̺��� �÷� Ÿ���� ����)
2. PL/SQL RECORD : ���� ������ �� �ִ� Ÿ��, �÷��� �����ڰ� ���� ���
                    ���̺��� ��� �÷��� ����ϴ°� �ƴ϶� �÷��� �Ϻθ� ����ϰ� ���� ��
3. PL/SQL TABLE TYPE : �������� ��, �÷��� ������ �� �ִ� Ÿ��

%ROWTYPE
�͸������ dept ���̺��� 10�� �μ������� ��ȸ�Ͽ� %ROWTYPE���� ������ ������
������� �����ϰ� DBMS_OUTPUT.PUT_LINE�� �̿��Ͽ� ���;



DECLARE
    v_dept_row dept%ROWTYPE;
BEGIN
    SELECT * INTO v_dept_row
    FROM dept
    WHERE deptno = 10;
    
    DBMS_OUTPUT.PUT_LINE(v_dept_row.deptno || ' / ' || v_dept_row.dname || ' / ' || v_dept_row.loc);
END;
/


2. record : ���� ������ �� �ִ� ����Ÿ��, �÷� ������ �����ڰ� ���� ������ �� �ִ�
dept���̺��� deptno, dname �ΰ� �÷��� ������� �����ϰ� ���� ��

SELECT deptno, dname
FROM dept
WHERE deptno = 10;

DECLARE
--    deptno, dname �÷� �ΰ��� ���� ������ �� �ִ� TYPE�� ����
    TYPE dept_rec IS RECORD(
        deptno dept.deptno%TYPE,
        dname dept.dname%TYPE);
        
--    ���Ӱ� ���� Ÿ������ ������ ����(class ����� �ν��Ͻ� ����)
    v_dept_rec dept_rec;
BEGIN
    SELECT deptno, dname INTO v_dept_rec
    FROM dept
    WHERE deptno = 10;
    
    DBMS_OUTPUT.PUT_LINE(v_dept_rec.deptno || ' / ' || v_dept_rec.dname);
END;
/


�������� ������ �� ��;
SELECT ����� �������̱� ������ �ϳ��� �� ������ ���� �� �ִ� ROWTYPE ��������
���� ���� ���� ���� ���� �߻�
==> �������� ������ �� �ִ� TABLE TYPE ���

DECLARE
    v_dept_row dept%ROWTYPE;
BEGIN
    SELECT * INTO v_dept_row
    FROM dept
    WHERE deptno = 10;
    
    DBMS_OUTPUT.PUT_LINE(v_dept_row.deptno || ' / ' || v_dept_row.dname || ' / ' || v_dept_row.loc);
END;
/

TABLE TYPE : ���� ���� ������ �� �ִ� Ÿ��;
���� : TYPE Ÿ�Ը� IS TABLE OF ��Ÿ�� INDEX BY �ε�����Ÿ��;

dept���̺��� �� ������ �����Ҽ� �ִ� ���̺� TYPE
    List<dept> dept_tab = new ArrayList<>();
    TYPE dept_tab IS TABLE OF dept%ROWTYPE INDEX BY BINARY_INTEGER
    
    
DECLARE
   TYPE dept_tab IS TABLE OF dept%ROWTYPE INDEX BY BINARY_INTEGER;
   v_dept dept_tab;
BEGIN
    SELECT * BULK COLLECT INTO v_dept
    FROM dept;
END;
/