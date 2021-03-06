파라미터로 yyyymm형식의 문자열을 사용하여 (ex: yyyymm = 201912)해당 년월에 해당하는 일자수를 구해보세요
주어진것 : 년월을 담고있는 문자열
문자열      ==>         날짜      ==>     마지막날짜로변경     ==>          일자
        TO_DATE('201912', 'YYYYMM')         TO_CHAR

SELECT :yyyymm param, TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'yyyyMM')), 'DD') dt
FROM dual;

SELECT '201912' param, 

트랜잭션 : 여러 단계의 과정을 하나의 작업 행위로 묶는 단위(ATM)
트랜잭션의 원자성 : 트랜잭션 내의 작업이 실행되거나 / 안되거나(ALL or Nothing)

EXPLAIN PLAN FOR
SELECT * 
  FROM emp
 WHERE empno = '7369';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);



Plan hash value: 3956160932
 실행계획을 보는 순서(id)
 *들여쓰기 되어 있으면 자식 오퍼레이션
 1.위에서아래로
  *단 자식 오퍼레이션이 있으면 자식부터 읽는다.
  
  1==> 0
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    38 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    38 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("EMPNO"=7369);


EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE TO_CHAR(empno) = 7300 + '69';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);


SELECT ename, sal, TO_CHAR(sal, 'L009,999.00')
FROM emp;


NULL과 관련된 함수
NVL 
NVL2
NULLIF
COALESCE;

왜 null 처리를 해야할까?
NULL에 대한 연산결과는 NULL이다.

예를 들어서 emp 테이블에 존재하는 sal, comm 두개의 컬럼 값을 합한 값을 알고 싶어서
다음과 같이 SQL을 작성.

SELECT empno, ename, sal, comm, sal + comm AS sal_plus_comm
FROM emp;

NVL(expr1, expr2)
expr1 이 null이면 expr2값을 리턴하고
expr1 이 null이 아니면 expr1을 리턴..

SELECT empno, ename, sal, comm, sal+ NVL(comm, 0) sal_plus_comm
  FROM emp;
  
REG_DT컬럼이 NULL일 경우 현재 날짜가 속한 월의 마지막 일자로 표현
SELECT userid, usernm, reg_dt
FROM users;

SELECT userid, usernm, NVL(reg_dt, LAST_DAY(SYSDATE)) reg_dt
FROM users;




