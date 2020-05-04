������

��Ģ ������ : +, -, *, / : ���� ������
���� ������ : ?  1==1? true�� �� ���� : false�� �� ����

SQL ������ 
= : �÷�|ǥ���� = �� ==> ���� ������

IN : �÷�|ǥ���� IN (����)
    deptno IN (10,30) 
    
EXISTS ������
����� : EXISTS (��������)
���������� ��ȸ ����� �Ѱ��̶� ������ TRUE
�߸��� ����� : WHERE deptno EXISTS (��������)

���������� ���� ������� ���������� ���� ����� �׻� �����ϱ� ������
emp ���̺��� ��� �����Ͱ� ��ȸ �ȴ�.;

�Ʒ� ������ ���ȣ ��������
�Ϲ������� EXISTS �����ڴ� ��ȣ���� ���������� ���� ���

EXISTS �������� ����
�����ϴ� ���� �ϳ��� �߰��� �ϸ� ���̻� Ž���� ���� �ʰ� �ߴ�.
���� ���� ���ο� ������ ���� �� ���

SELECT *
FROM emp
WHERE EXISTS (SELECT 'X'
                                FROM dept);

�Ŵ����� ���� ���� : KING
�Ŵ��� ������ �����ϴ� ���� : 14 - KING = 13���� ����
EXISTS �����ڸ� Ȱ���Ͽ� ��ȸ

SELECT * 
FROM emp
WHERE mgr IS NOT NULL;

SELECT *
FROM emp e
WHERE EXISTS (SELECT 'X'
                            FROM emp m
                            WHERE e.mgr = m.empno);

JOIN
SELECT e.*
FROM emp e, emp m
WHERE e.mgr = m.empno;


sub9]
SELECT * 
FROM product
WHERE EXISTS (SELECT 'X'
                            FROM cycle
                            WHERE cid = 1
                            AND cycle.pid = product.pid);
sub10]
SELECT *
FROM product
WHERE NOT EXISTS (SELECT 'X' 
                            FROM cycle
                            WHERE cycle.cid  = 1
                            AND cycle.pid = product.pid);



���� ����
 ������
(1,5,3) U (2, 3) = (1,2,3,5)

SQL���� �����ϴ� UNION ALL(�ߺ� �����͸� �������� �ʴ´�)
(1,5,3) U (2, 3) = (1, 5, 3, 2, 3)

(1,5,3) ������ (2, 3) = (3)

(1,5,3) ������ (2, 3) = (1, 5)

SQL������ ���տ���
������ : UNION, UNION ALL, INTERSECT, MINUS
�ΰ��� SQL�� �������� ���� Ȯ��(��, �Ʒ��� ������ �ȴ�)

UNION ������ : �ߺ����� (������ ������ ���հ� ����);

SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698, 7369)

UNION

SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698);

UNION ALL ������ : �ߺ����;

SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698, 7369)

UNION ALL

SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698);


INTERSECT ������ : �����հ� �ߺ��Ǵ� ��Ҹ� ��ȸ
SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698, 7369)

INTERSECT

SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698);

MINUS ������ : ���� ���տ��� �Ʒ��� ���� ��Ҹ� ����
SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698, 7369)

MINUS

SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698);

SQL ���տ������� Ư¡

1.���� �̸� : ù�� SQL�� �÷��� ���󰣴�.

SELECT ename nm, empno no
FROM emp
WHERE empno IN (7369)
UNION
SELECT ename, empno
FROM emp
WHERE empno IN (7698);

2.������ �ϰ���� ��� �������� ���� ����
 ���� SQL���� ORDER BY �Ұ�(�ζ��� �並 ����Ͽ� ������������  ORDER BY�� ������� ������ ����)
SELECT ename nm, empno no
FROM emp
WHERE empno IN (7369)
--ORDER BY nm, �߰� ������ ���ĺҰ�
UNION

SELECT ename, empno
FROM emp
WHERE empno IN (7698)
ORDER BY nm;


3. SQL�� ���� �����ڴ� �ߺ��� �����Ѵ�(������ ���� ����� ����), �� UNION ALL�� �ߺ����

4. �ΰ��� ���տ��� �ߺ��� �����ϱ� ���� ������ ������ �����ϴ� �۾��� �ʿ�
    ==> ����ڿ��� ����� �����ִ� �������� ������
        ==> UNION ALL �� ����� �� �ִ� ��Ȳ�� ��� UNION �� ������� �ʾƾ� �ӵ�����
                ���鿡�� �����ϴ�.
    
�˰���(����-��ǰ, ���� ����, �������� , .....
                 �ڷ� ���� : Ʈ������(���� Ʈ��, �뷱�� Ʈ��)
                                heap
                                stack, queue
                                list
                                
���տ��꿡�� �߿��� ���� : �ߺ�����

���ù�������
--(����ŷ�� ���� + �Ƶ������� ���� + KFC �� ����) / �Ե������� ����
SELECT *
FROM FASTFOOD;

SELECT sido, sigungu, NVL(COUNT(*) , 0) a
FROM FASTFOOD
WHERE GB = '�Ե�����'
GROUP BY SIDO, SIGUNGU
ORDER BY a DESC;

SELECT *
FROM FASTFOOD
WHERE sigungu = '������'
AND sido = '��⵵';


SELECT ROWNUM ����, aa.*
FROM (SELECT a.sido, a.sigungu, ROUND(b.big3 / a.�Ե�����, 2) ���ù�������
        FROM (SELECT sido, sigungu, COUNT(*) �Ե�����
                    FROM FASTFOOD
                    WHERE GB = '�Ե�����'
                    GROUP BY SIDO, SIGUNGU) a
                    ,(SELECT sido, sigungu, COUNT(*) big3
                    FROM FASTFOOD
                    WHERE GB IN ('����ŷ','�Ƶ�����','KFC')
                    GROUP BY SIDO, SIGUNGU) b
        WHERE a.sigungu = b.sigungu
        AND a.sido = b.sido
        ORDER BY ���ù������� DESC) aa;


�ʼ�
����1] fastfood ���̺�� tax ���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� SQL �ۼ�
    1. �õ� �ñ����� ���ù��������� ���ϰ� (������ ���� ���ð� ������ ����)
    2.�δ� ���� �Ű���� ���� �õ� �ñ������� ������ ���Ͽ�
    3. ���ù��������� �δ� �Ű�� ������ ���� ������ ���� �����Ͽ� �Ʒ��� ���� �÷��� ��ȸ�ǵ��� SQL �ۼ�
    
����, �ܹ��� �õ�, �ܹ��� �ñ���, �ܹ��� ���ù�������, ����û �õ�, ����û �ñ���, ����û �������� �ݾ�1�δ� �Ű��

�ɼ�      
 ����2]
 �ܹ��� ���ù��� ������ ���ϱ� ���� 4���� �ζ��� �並 ����Ͽ��µ� (fastfood ���̺��� 4�� ���)
 �̸� �����Ͽ� ���̺��� �ѹ��� �д� ���·� ������ ����(fastfood ���̺��� 1���� ���)
 CASE, DECODE

����3]
�ܹ������� SQL�� �ٸ����·� �����ϱ�