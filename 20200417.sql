SELECT ���� ���� :
    ��¥ ����(+, -) : ��¥ + ����, -���� : ��¥���� +-������ �� ���� Ȥ�� �̷������� ����Ʈ Ÿ�� ��ȯ
    ���� ����(....) : ���� �ð��� �ٷ��� ����...
    ���ڿ� ����
        ���ͷ� : ǥ����
                ���� ���ͷ� : ���ڷ� ǥ��
                ���� ���ͷ� : java : "���ڿ�" /sql : 'sql'
                          SELECT table_name
                ���ڿ� ���� ����: +�� �ƴ϶� || (java ������ +)
                ��¥?? : TO_DATE('��¥���ڿ�', '��¥ ���ڿ��� ���� ����')
                    TO_DATE('20200417', 'yyyyMMdd')
                    
WHERE : ����� ���ǿ� �����ϴ� �ุ ��ȸ�ǵ��� ����

SELECT *
FROM users
WHERE userid = 'brown';

sal���� 1000���� ũ�ų� ����, 2000���� �۰ų� ���� ������ ��ȸ ==> BETWEEN AND;
�񱳴�� �÷� / �� BETWEEN ���۰� AND ���ᰪ
���۰��� ���ᰪ�� ��ġ�� �ٲٸ� ���� �������� ����


SELECT *
FROM emp
WHERE SAL BETWEEN 1000 AND 2000;

SELECT *
FROM emp
WHERE sal >= 1000
AND sal <= 2000;

SELECT *
FROM emp
WHERE sal >= 1000
AND sal <= 2000;


SELECT *
FROM emp
WHERE hiredate BETWEEN '19820101' AND '19830101';


IN ������
�÷� | Ư���� IN(��1, ��2, ....)
�÷��̳� Ư������ ��ȣ�ȿ� ���߿� �ϳ��� ��ġ�� �ϸ� true

SELECT *
FROM emp
WHERE deptno IN(10, 30);
==>deptno �� 10�̰ų� 30���� ����
deptno = 10 OR deptno = 30

SELECT *
FROM emp
WHERE deptno = 10
    OR deptno = 30;
    
    
SELECT userid "���̵�", usernm "�̸�", alias as "����"
FROM users
WHERE userid IN('brown', 'cony', 'sally');

���ڿ� ��Ī ���� : LIKE ���� / JAVA : .startswith(prefix), endswith(suffix)
����ŷ ���ڿ� : % - ��� ���ڿ�(���� ����)
            : _ - � ���ڿ��̵��� �� �ϳ��� ����
���ڿ��� �Ϻΰ� ������ TRUE
    
'cony' : cony �� ���ڿ�
'co%'  : ���ڿ��� co�� �����ϰ� �ڿ��� � ���ڿ��̵� �� �� �ִ� ���ڿ�
        'cony', 'con', 'co'
'%co%' : co�� �����ϴ� ���ڿ�
        'cony', 'sally cony'
'co__' : co�� �����ϰ� �ڿ� �ΰ��� ���ڰ� ���� ���ڿ�
'_on_' : ��� �α��ڰ� on�̰� �յڷ� � ���ڿ��̵��� �ϳ��� ���ڰ� �ü� �ִ� ���ڿ�

�÷�|Ư���� LIKE ���� ���ڿ�;
���� �̸��� �빮�� s�� �����ϴ� ������ ��ȸ
SELECT *
FROM emp
WHERE ename like 'S%';


SELECT MEM_ID, MEM_NAME
FROM member
WHERE MEM_NAME LIKE '��%';

SELECT MEM_ID, MEM_NAME
FROM member
WHERE MEM_NAME LIKE '%��%';

NULL ��
SQL �񱳿����� : =
    WHERE usernm = 'brown'
    
MGRĿ�� ���� ���� ��� ������ ��ȸ
SELECT *
FROM emp
WHERE mgr = null; <== x

SELECT *
FROM emp
WHERE mgr IS null;      <--------------------------------------------------------
                                                                                |
SQL���� NULL ���� ���� ��� �Ϲ������� �񱳿�����(=)�� ��� ���ϰ� IS�����ڸ� ������-

���� �ִ� ��Ȳ���� � �� : =, !=, <>
NULL : IS NULL, IS NOT NULL

emp���̺��� mgr �÷� ���� NULL�� �ƴ� ������ ��ȸ
SELECT *
FROM emp
WHERE mgr IS NOT null;

SELECT *
FROM emp
WHERE comm IS NOT NULL;

SELECT *
FROM emp
WHERE mgr = 7698
AND sal > 1000;

SELECT *
FROM emp
WHERE mgr = 7698
OR sal > 1000;

SELECT *
FROM emp
WHERE MGR NOT IN(7698,7839, NULL);

IN�����ڸ� �� �����ڷ� ����
SELECT *
FROM emp
WHERE MGR IN(7698,7839);
==>WHERE mgr = 7698 OR mr = 7839;

SELECT *
FROM emp
WHERE MGR NOT IN(7698,7839);
==>WHERE (mgr != 7698 AND mr != 7839);

SELECT *
FROM emp
WHERE MGR NOT IN(7698,7839)
OR mgr IS NULL;

SELECT *
  FROM emp
 WHERE 1=1
   AND JOB = 'SALESMAN' 
   AND hiredate > '19810601' 
   AND sal > 1300; 

SELECT *
  FROM emp
 WHERE deptno != 10
   AND hiredate > '19810601';
   
SELECT *
  FROM emp
 WHERE deptno NOT IN(10)
   AND hiredate > '19810601';
   
SELECT *
  FROM EMP
 WHERE DEPTNO IN (20, 30)
   AND HIREDATE > TO_DATE('19810601','yyyyMMdd');
   
   
SELECT *
  FROM EMP
 WHERE JOB = 'SALESMAN'
    OR HIREDATE > '19810601';
   
SELECT *
  FROM EMP
 WHERE JOB = 'SALESMAN'
    OR EMPNO LIKE '78%';
    
SELECT *
  FROM EMP
 WHERE JOB = 'SALESMAN'
    OR (empno >= 7800 AND empno < 7900);
    
SELECT *
  FROM EMP
 WHERE JOB = 'SALESMAN'
    OR EMPNO LIKE '78%'
   AND HIREDATE > '19810601'; 
   
   
   ���� : {a, b, c} == {a, c, b}
   
   table ���� ��ȸ , ����� ������ ����(�������� ����)
   ==> ���нð��� ���հ� ������ ����
   SQL������ �����͸� �����Ϸ��� ������ ������ �ʿ�
   ORDER BY �÷���(��������), �÷���2.....
   
   ������ ���� : ��������(DEFAULT) - ASC, �������� - DESC
   
   ���� �̸����� �������� ����
SELECT *
  FROM emp
   ORDER BY ename ASC;
   
   SELECT *
  FROM emp
   ORDER BY ename DESC;
   
   
   
   
    
   
   
   
   
   