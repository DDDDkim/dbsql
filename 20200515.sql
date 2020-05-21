ROLLUP : 서브그룹 생성 - 기술된 컬럼을 오른쪽에서부터 지워나가며 GROUP BY를 실행

아래 쿼리의 서브그룹
1. GROUP BY job, deptno
2. GROUP BY job
3. GROUP BY ==> 전체;

ROLLUP 사용시 생성되는 서브그룹의 수는 : ROLLUP에 기술한 컬럼수 + 1;

GROUP_AD2]
SELECT NVL(job, '총계'), deptno, GROUPING(job), GROUPING(deptno), SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

SELECT CASE 
            WHEN GROUPING(job) = 1 THEN '총계'
            ELSE job
        END job
        , deptno, GROUPING(job), GROUPING(deptno), SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

GROUP_AD2]
SELECT CASE 
            WHEN GROUPING(job) = 1 THEN '총'
            ELSE job
        END job
        , CASE 
            WHEN GROUPING(job) = 1 THEN '계'
            WHEN GROUPING(deptno) = 1 THEN '소계'
            ELSE TO_CHAR(deptno)
        END deptno
        , SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

GROUP_AD3];
SELECT deptno, job, SUM(sal)
FROM emp
GROUP BY ROLLUP (deptno, job);

GROUP_AD4];
SELECT d.dname, e.job, SUM(sal) sal
FROM emp e RIGHT OUTER JOIN dept d ON(e.deptno=d.deptno)
GROUP BY ROLLUP (d.dname, e.job);


SELECT NVL(dept.dname,'총합')dname, a.job, a.sum_sal
FROM
(SELECT deptno, job, SUM(sal) sum_sal
FROM emp
GROUP BY ROLLUP (deptno, job) )a, dept
WHERE a.deptno = dept.deptno(+);



GROUP_AD5];
SELECT dept.dname, a.job, a.sum_sal
FROM
(SELECT deptno, job, SUM(sal) sum_sal
FROM emp
GROUP BY ROLLUP (deptno, job) )a, dept
WHERE a.deptno = dept.deptno(+);


2.GROUPING SETS
ROLLUP 의 단점 : 관심없는 서브그룹도 생성해야한다.
                ROLLUP절에 기술한 컬럼을 오른쪽에서 지워나가기 때문에
                만약 중간과정에 있는 서브그룹이 불필요할 경우 낭비.
GROUPING SETS : 개발자가 직접 생성할 서브그룹을 명시
사용법 : GROUP BY GROUPING SETS (col1, col2)


SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY GROUPING SETS(job, deptno);

그룹기준을
1.job, deptno
2.mgr

GROUP BY GROUPING SETS ( (job, deptno), mgr)

SELECT job, deptno, SUM(sal)
FROm emp
GROUP BY GROUPING SETS ( (job, deptno), mgr);


REPORT GROUP FUCTION ==> 확장된 GROUP BY
REPORT GROUP FUNCTION을 사용을 안하면
여러개의 SQL작성, UNION ALL을 통해서 하나의 결과로 합치는 과정
==> 좀더 편하게 하는게 REPORT GROUP FUNCTION

3.CUBE
사용법 : GROUP BY CUBE (col1, col2....)
기술된 컬럼의 가능한 모든 조합 (순서는 지킨다)

GROUP BY CUBE(job, deptno);
    1       2
  job,   deptno
  job,      x
   X,    deptno
   X,       X
   
SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY CUBE (job, deptno);


여러개의 REPORT GROUP 사용하기
SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);

**발생 가능한 조합을 계산
  1     2       3
job  deptno     mgr ==> GROUP BY job, deptno, mgr
job  X          mgr ==> GROUP BY job, mgr
job  deptno     X ==> GROUP BY job, deptno
job  X          X ==> GROUP BY job

SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY job, ROLLUP(job, deptno), CUBE(mgr);


상호연관 서브쿼리 업데이트
1. emp테이블을 이용하여 emp_test 테이블 생성
DROP TABLE emp_test;

CREATE TABLE emp_test AS
SELECT *
FROM emp;
2. emp_test 테이블에 dname 컬럼 추가(dept 테이블 참고)
DESC dept;

ALTER TABLE emp_test ADD (dname VARCHAR2(14));
3.subquery를 이용하여 emp_test테이블에 추가된 dname컬럼을 업데이트해주는 쿼리를 작성
emp_test테이블의 deptno값을 확인해서 dept테이블의 deptno값이랑 일치하는 dname 컬럼값을 가져와 update

UPDATE emp_test SET dname = (SELECT dname
                             FROM dept
                             WHERE emp_test.deptno = dept.deptno);

SELECT *
FROM emp_test;


DROP TABLE dept_test;

CREATE TABLE dept_test AS
SELECT *
FROM dept;

ALTER TABLE dept_test ADD (empcnt NUMBER);

UPDATE dept_test SET empcnt = (SELECT COUNT(*)
                                FROM emp
                                WHERE dept_test.deptno = emp.deptno);

SELECT *
FROM dept_test

SELECT 결과 전체를 대상으로 그룹 함수를 적용한 경우
대상되는 행이 없더라도 0값이 리턴

SELECT COUNT(*)
FROM emp
WHERE 1=2;

GROUP BY 절을 기술할 경우 대상이 되는 행이 없을 경우 조회는 행이 없다.
SELECT COUNT(*)
FROM emp
WHERE 1=2
GROUP BY deptno;
