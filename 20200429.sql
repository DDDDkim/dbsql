OUTER JOIN
테이블 연결 조건이 실패해도, 기준으로 삼은 테이블의 컬럼은 조회가 되도록 하는 조인 방식
<==> 
INNER JOIN(우리가 지금까지 배운 방식)

LEFT OUTER JOIN     : 기준이 되는 테이블이 JOIN 키워드 왼쪽에 위치
RIGHT OUTER JOIN     : 기준이 되는 테이블이 JOIN 키워드 오른쪽에 위치
FULL OUTER JOIN     : LEFT OUTER JOIN + RIGHT OUTER JOIN - (중복되는 데이터가 한건만 남도록 처리)

emp테이블의 컬럼중 mgr컬럼을 통해 해당 직원의 관리자 정보를 찾아갈 수 있다.
하지만 KING 직원의 경우 상급자가 없기 때문에 일반적인 inner 조인 처리시
조인에 실패하기 때문에 KING을 제외한 13건의 데이터만 조회가 됨.

INNER 조인 복습
상급자 사번, 상급자 이름, 직원 사번, 직원 이름

조인이 성공해야지만 데이터가 조회된다
==> KING의 상급자 정보(mgr)는  NULL이기 때문에 조인에 실패하고
        KING의 정보는 나오지 않는다 (emp테이블 건수 14건 ==> 조인 결과 13건)

(HR...)
SELECT e.manager_id, m.first_name||m.last_name manager_name, e.employee_id, e.first_name||e.last_name name
FROM employees e, jobs j, employees m
WHERE e.job_id = j.job_id
      AND e.manager_id = m.employee_id;
      
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

ANSI-SQL
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e JOIN emp m ON(e.mgr = m.empno);

위의 쿼리를 OUTER 조인으로 변경
(KING 직원이 조인에 실패해도 본인 정보에 대해서는 나오도록
, 하지만 상급자 정보는 없기 때문에 나오지 않는다.);

SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno);

SELECT m.empno, m.ename, e.empno, e.ename
FROM emp m LEFT OUTER JOIN emp e ON (e.mgr = m.empno);

ORACLE-SQL : OUTER
oracle join
1.FROM 절에 조인할 테이블 기술(콤마로 구분)
2.WHERE 절에 조인 조건을 기술
3. 조인 컬럼(연결고리) 중 조인이 실패하여 데이터가 없는 쪽의 컬럼에 (+)을 붙여준다
    ==> 마스터 테이블 반대편 쪽 테이블의 컬럼

SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e, emp m 
WHERE e.mgr = m.empno(+);

OUTER 조인의 조건 기술 위치에 따른 결과 변화

직원의 상급자 이름, 아이디를 포함해서 조회
단, 직원의 소속 부서가 10번에 속하는 직원들만 한정해서;

조건을 ON절에 기술했을 때
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e LEFT OUTER JOIN emp m ON ( e.mgr = m.empno AND e.deptno = 10); ==> o

조건을 WHERE절에 기술했을 때
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e LEFT OUTER JOIN emp m ON ( e.mgr = m.empno ) ==> x
WHERE e.deptno = 10;


OUTER 조인을 하고 싶은 것잉라면 조건을 ON절에 기술하는게 맞다

ORACLE-SQL
SELECT m.empno, m.ename, e.empno, e.ename
    FROM emp e, emp m 
 WHERE e.mgr = m.empno(+)
       AND e.deptno = 10;


SELECT * 
FROM buyprod;
WHERE buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD');
SELECT *
FROM prod;

outer join 실습1]
SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty
FROM buyprod b RIGHT OUTER JOIN prod p 
ON(p.prod_id = b.buy_prod(+) 
AND buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD'));


outer join 실습2]
SELECT NVL(buy_date, '2005/01/25'), buy_prod, prod_id, prod_name, buy_qty
    FROM buyprod b RIGHT OUTER JOIN prod p 
        ON(p.prod_id = b.buy_prod(+)
      AND buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD'));
      

outer join 실습3]
SELECT NVL(buy_date, '2005/01/25') buy_date, buy_prod, prod_id, prod_name, NVL(buy_qty, 0) buy_qty
    FROM buyprod b RIGHT OUTER JOIN prod p 
        ON(p.prod_id = b.buy_prod(+)
      AND buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD'));


outer join 실습4]
SELECT p.pid, p.pnm, NVL(cid, 1), NVL(day, 0), NVL(cnt, 0)
FROM cycle c, product p
WHERE c.pid(+) = p.pid
AND c.cid(+) = 1;

SELECT p.pid, p.pnm, NVL(c.cid, 1), NVL(day, 0), NVL(cnt, 0)
FROM cycle c RIGHT OUTER JOIN product p
ON( c.pid = p.pid
AND cid = 1);

outer join 실습5]
SELECT p.pid, p.pnm, NVL(c.cid, 1) cid, cnm, NVL(day, 0) day, NVL(cnt, 0) cnt
FROM cycle c, product p, customer cu
WHERE c.pid(+) = p.pid
AND cu.cnm = 'brown'
AND c.cid(+) = 1
ORDER BY pid DESC;

SELECT p.pid, p.pnm, NVL(c.cid, 1), NVL(day, 0), NVL(cnt, 0)
FROM cycle c JOIN product p
ON( c.pid = p.pid
AND cid = 1) ;


SELECT *
FROM product, cycle, customer
WHERE product.pid = cycle.pid;

CROSS JOIN
조인 조건을 기술하지 않은 경우
모든 가능한 행의 조합으로 결과가 조회된다.

SELECT *
FROM emp CROSS JOIN dept;

ORACLE (조인 테이블만 기술라고 WHERE 절에 조건을 기술하지 않는다.)
SELECT *
FROM emp, dept;

cross join 실습1]
SELECT *
FROM customer, product;

서브 <==> 메인
서브쿼리는 다른 쿼리 안에서 작성된 쿼리
서브쿼리 가능한 위치
1. SELECT
        SCALAR SUB QUERY
        * 스칼라 서브쿼리는 조회되는 행이 1행이고, 컬럼이 한개의 컬럼이어야 한다.
        EX) DUAL 테이블
2. FROM
        INLINE-VIEW
        SELECT 쿼리는 괄호로 묶은것
3. WHERE
        SUB QUERY
       WHERE 절에 사용된 쿼리
       
SMITH 가 속한 부서에 속한 직원들은 누가있을까?

1.SMITH 가 속한 부서가 몇번?
2. 1번에서 알아낸 부서번호에 속하는 직원을 조회

==> 독립적인 2개의 쿼리를 각각 실행
        두번째 쿼리는 첫번째의 쿼리의 결과에 따라 값을 다르게 가져와야 한다.
        (SMITH(20) => WARD(30) ==> 두번째 쿼리 작성시 20번에서 30번으로 조건을 변경)
        ==>유지보수 측면에서 좋지않음;
        
첫번째 쿼리;
SELECT deptno
   FROM emp
WHERE ename = 'SMITH';

두번째 쿼리;
SELECT *
   FROM emp
WHERE deptno = 20;

서브쿼리를 통한 쿼리 통한
SELECT *
   FROM emp
WHERE deptno = (SELECT deptno
                                FROM emp
                             WHERE ename = :ename);
                             
서브쿼리 (실습 sub1)]
SELECT ROUND(AVG(sal),2)
FROM emp;

SELECT COUNT(*)
FROM emp
WHERE sal >(SELECT ROUND(AVG(sal),2)
                         FROM emp);
서브쿼리 (실습 sub2)]                         
SELECT *
FROM emp
WHERE sal >(SELECT ROUND(AVG(sal),2)
                         FROM emp);
                         






