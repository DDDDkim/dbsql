SELECT 에서 연산 :
    날짜 연산(+, -) : 날짜 + 정수, -정수 : 날짜에서 +-정수를 한 과거 혹은 미래일자의 데이트 타입 변환
    정수 연산(....) : 수업 시간에 다루진 않음...
    문자열 연산
        리터럴 : 표기방법
                숫자 리터럴 : 숫자로 표현
                문자 리터럴 : java : "문자열" /sql : 'sql'
                          SELECT table_name
                문자열 결합 연산: +가 아니라 || (java 에서는 +)
                날짜?? : TO_DATE('날짜문자열', '날짜 문자열에 대한 포맷')
                    TO_DATE('20200417', 'yyyyMMdd')
                    
WHERE : 기술한 조건에 만족하는 행만 조회되도록 제한

SELECT *
FROM users
WHERE userid = 'brown';

sal값이 1000보다 크거나 같고, 2000보다 작거나 같은 직원만 조회 ==> BETWEEN AND;
비교대상 컬럼 / 값 BETWEEN 시작값 AND 종료값
시작값과 종료값의 위치를 바꾸면 정상 동작하지 않음


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


IN 연산자
컬럼 | 특정값 IN(값1, 값2, ....)
컬럼이나 특정값이 괄호안에 값중에 하나라도 일치를 하면 true

SELECT *
FROM emp
WHERE deptno IN(10, 30);
==>deptno 가 10이거나 30번인 직원
deptno = 10 OR deptno = 30

SELECT *
FROM emp
WHERE deptno = 10
    OR deptno = 30;
    
    
SELECT userid "아이디", usernm "이름", alias as "별명"
FROM users
WHERE userid IN('brown', 'cony', 'sally');

문자열 매칭 연산 : LIKE 연산 / JAVA : .startswith(prefix), endswith(suffix)
마스킹 문자열 : % - 모든 문자열(공백 포함)
            : _ - 어떤 문자열이든지 딱 하나의 문자
문자열의 일부가 맞으면 TRUE
    
'cony' : cony 인 문자열
'co%'  : 문자열이 co로 시작하고 뒤에는 어떤 문자열이든 올 수 있는 문자열
        'cony', 'con', 'co'
'%co%' : co를 포함하는 문자열
        'cony', 'sally cony'
'co__' : co로 시작하고 뒤에 두개의 문자고 오는 문자열
'_on_' : 가운데 두글자가 on이고 앞뒤로 어떤 문자열이든지 하나의 문자가 올수 있는 문자열

컬럼|특정값 LIKE 패턴 문자열;
직원 이름이 대문자 s로 시작하는 직원만 조회
SELECT *
FROM emp
WHERE ename like 'S%';


SELECT MEM_ID, MEM_NAME
FROM member
WHERE MEM_NAME LIKE '신%';

SELECT MEM_ID, MEM_NAME
FROM member
WHERE MEM_NAME LIKE '%이%';

NULL 비교
SQL 비교연산자 : =
    WHERE usernm = 'brown'
    
MGR커럼 값이 없는 모든 직원을 조회
SELECT *
FROM emp
WHERE mgr = null; <== x

SELECT *
FROM emp
WHERE mgr IS null;      <--------------------------------------------------------
                                                                                |
SQL에서 NULL 값을 비교할 경우 일반적으로 비교연산자(=)를 사용 못하고 IS연산자를 사용용용용-

값이 있는 상황에서 등가 비교 : =, !=, <>
NULL : IS NULL, IS NOT NULL

emp테이블에서 mgr 컬럼 값이 NULL이 아닌 직원을 조회
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

IN연산자를 비교 연산자로 변경
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
   
   
   집합 : {a, b, c} == {a, c, b}
   
   table 에는 조회 , 저장시 순서가 없다(보장하지 않음)
   ==> 수학시간의 집합과 유사한 개념
   SQL에서는 데이터를 정렬하려면 별도의 구문이 필요
   ORDER BY 컬럼명(정렬형태), 컬럼명2.....
   
   정렬의 형태 : 오름차순(DEFAULT) - ASC, 내림차순 - DESC
   
   직원 이름으로 오름차순 정렬
SELECT *
  FROM emp
   ORDER BY ename ASC;
   
   SELECT *
  FROM emp
   ORDER BY ename DESC;
   
   
   
   
    
   
   
   
   
   