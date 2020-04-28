grp7]
dept 테이블을 확인하면 총 4개의 부서 정보가 존재 ===> 회사내에 존재하는 모든 부서정보
emp테이블에서 관리되는 직원들이 실제 속한 부서정보의 갯수 ==> 10,20,30 ==? 3개

SELECT COUNT(*) cnt
FROM 
    (SELECT deptno  --deptno컬럼이 1개 존재, row는 3개인 테이블
    FROM emp
    GROUP BY deptno);
    
JOIN 
    -RDBMS는 중복을 최소하는 형태의 데이터 베이스
    -다른 테이블과 결합하여 데이터를 조회;
    --RDBMS : Realational Data Base Management System(관계형 데이터베이스 관리 시스템)
    
SELECT *
FROM dept;

JOIN의 종류
    -Natural Join
        -조인하고자 하는 테이블의 컬럼명이 같은 컬럼끼리 연결;
        
        
JOIN 문법의 종류
ANSI - 표준
벤더사의 문법(ORACLE);

JOIN의 경우 다른 테이블의 컬럼을 사용할 수 있기 때문에;
SELECT 할 수 있는 컬럼의 개수가 많아진다(가로 확장)

집합연산 ==> 세로확장(행이많아진다)나중에...;

NATURAL JOIN :
    -조인하려는 두 테이블의 연결고리 컬럼의 이름이 같을 경우
    -emp, dept 테이블에는 deptno 라는 공통된(동일한 이름의, 타입도 동일) 연결고리 컬럼이 존재
    -다른 ANSI-SQL 문법을 통해서 대체가 가능하고, 조인 테이블들의 컬럼명이 동일하지 않으면
    사용이 불가능하기 때문에 사용빈도는 다소 낮다.;
    
    -emp 테이블 : 14건
    -dept 테이블 : 4건

조인 하려고 하는 컬럼을 별도 기술하지 않음;
SELECT *
FROM emp NATURAL JOIN dept; --두 테이블의 이름이 동일한 컬럼으로 연결한다 ==> deptno
    
    
ORACLE 조인 문법을 ANSI 문법처럼 세분화 하지 않음
오라클 조인 문법
1. 조인할 테이블 목록을 FROM 절에 기술하며 구분자는 콜론(,)
2. 연결고리 조건을 WHERE절에 기술하면 된다 (ex : WHERE emp.deptno = dept.deptno);

SELECT * 
FROM emp, dept
WHERE emp.deptno = dept.deptno;

deptno 가 10번인 직원들만 조회;
SELECT * 
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.deptno = 10;


ANSI-SQL : JOIN with USING
    -join하려는 테이블간 이름이 같은 컬럼이 2개 이상일때
    -개발자가 하나의 컬럼으로만 조인하고 싶을 때 조인 컬럼명을 기술;
    
SELECT *
FROM emp JOIN dept USING (deptno);

ANSI-SQL : JOIN with ON
    - 조인하려는 두 테이블간 컬럼명이 다를 때
    - ON절에 연결고리 조건을 기술;
    
SELECT *
FROM emp JOIN dept ON(emp.deptno = dept.deptno);

ORACLE 문법으로 위 SQL 을 작성
SELECT *
FROM emp ,dept
WHERE emp.deptno = dept.deptno;



JOIN의 논리적인 구분
SELF JOIN : 조인하려는 테이블이 서로 같을 때
EMP 테이블의 한행은 직원의 정보를 나타내고 직원의 정보중 mgr 컬럼은 해당 직원의 관리자 사번을 관리.
해당 직원의 관리자의 이름을 알고싶을때

ANSI-SQL로 SQL 조인 : 
조인하려고  하는 테이블 EMP(직원), EMP(직원의 관리자)
            연결고리 컬럼 : 직원.MGR = 관리자.EMPNO
            ==> 조인 컬럼 이름이 다르다(MGR, EMPNO)
                ==>NATURAL JOIN, JOIN with USING 은 사용이 불가능한 형태
                    ==> JOIN with ON
                    
                    
                    
ANSI-SQL 로 작성;
SELECT *
FROM emp e JOIN emp m ON(e.mgr = m.empno);


NONEUQI JOIN : 연결고리 조건이 = 이 아닐때

SELECT emp.empno, emp.ename, emp.sal, salgrade.grade 
FROM emp JOIN salgrade ON(emp.sal BETWEEN salgrade.losal AND salgrade.hisal);

==> ORACLE 조인 문법으로 변경

SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;


SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
ORDER BY d.dname;

SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e JOIN dept d ON(e.deptno = d.deptno)
ORDER BY d.deptno;

SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno AND (e.deptno = 10 OR e.deptno = 30);

SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e JOIN dept d ON((e.deptno = d.deptno)AND(e.deptno = 10 OR e.deptno = 30));

SELECT e.empno, e.ename, e.sal, e.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
AND e.sal > 2500
ORDER BY e.sal DESC;

SELECT e.empno, e.ename, e.sal, e.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
AND e.sal > 2500
AND e.empno > 7600
AND d.dname = 'ACCOUNTING'
ORDER BY e.sal DESC;

SELECT LPROD_GU, LPROD_NM, PROD_ID, PROD_NAME
FROM prod p , lprod l
WHERE p.PROD_LGU = l.LPROD_GU;


    
    