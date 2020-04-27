SELECT empno, ename, sal, NVL(comm, 0)
FROM emp;

SELECT empno, ename, job, sal, deptno,
        DECODE(job, 'SALESMAN', sal*1.05,
                    'MANAGER', DECODE(deptno, 10, sal*1.30, sal*1.10),
                    'PRESIDENT', sal*1.20,
                    sal*1) BONUS
FROM emp;


집합 A = (10, 15, 18, 23, 24, 25, 29, 30, 35, 37)
Prime Number 소수 : ( 23,29,37) : COUNT-3, MAX-37, MIN-23, AVG-29.66, SUM-89
    --> 입력이 여러개 결과는 한건 --> multi row function
비소수 : ( 10, 15, 18, 24, 25, 30, 35)

SELECT *
FROM emp;


GROUP FUNCTION
여러행의 데이터를 이용하여 같은 그룹끼리 묶어 연산하는 함수
여러행을 입력받아 하나의 행으로 결과가 묶인다.
EX : 부서별 급여 평균
    emp 테이블에는 14명의 직원이 있고,  14명의 직원 3개의 부서(10, 20, 30)에 속해 있다.
    부서별 급여 평균은 3개의 행으로 결과가 반환된다.

GROUP BY 적용시 주의사항 : SELECT 기술할 수 있는 컬럼이 제한됨

SELECT 그룹핑 기준 컬럼, 그룹함수
FROM 테이블
GROUP BY 그룹핑 기준 컬럼
[ORDER BY];

부서별로 가장 높은 급여값
SELECT deptno, MIN(ename), MAX(sal)
FROM emp
GROUP BY deptno;

SELECT deptno, --> 컬럼명을 적지않아도 무방하다(이미 GROUP BY절에 적었기 때문에, 다른 컬럼명이 오면 문제가된다.)
        MAX(sal),--부서별로 가장 높은 급여 값
        MIN(sal),--부서별로 가장 낮은 급여 값
        ROUND(AVG(sal),2),--부서별 급여 평균
        SUM(sal),--부서별 급여 합
        COUNT(sal),--부서별 급여 건수(sal 커럼의 값이 null이 아닌 row의 수)
        COUNT(*),
        COUNT(mgr)
FROM emp
GROUP BY deptno;


*그룹 함수를 통해 부서번호 별 가장 높은 급여를 구할 수는 있지만
 가장 높은 급여를 받는 사람의 이름을 알 수는 없다
 ==> 추후 WINDOW FUNCTION을 통해 해결가능


*emp 테이블의 그룹 기준을 부서번호가 아닌 전체 직원으로 설정하는 방법
SELECT  MAX(sal),--전체직원중 가장 높은 급여 값
        MIN(sal),--전체직원중 가장 낮은 급여 값
        ROUND(AVG(sal),2),--전체직원중 급여 평균
        SUM(sal),--전체직원중 급여 합
        COUNT(sal),--전체직원중 급여 건수(sal 커럼의 값이 null이 아닌 row의 수)
        COUNT(*),--전체행의수
        COUNT(mgr)--ㅡmgr 컬럼이 null이 아닌 건수
FROM emp;

GROUP BY 절에 기술된 컬림 
    SELECT 절에 나오지 않으면 ???
    
GROUP BY 절에 기술되지 않은 컬럼이
    SELECT 절에 나오면 ???;


SELECT deptno, 'TEST', 1,
        MAX(sal),--부서별로 가장 높은 급여 값
        MIN(sal),--부서별로 가장 낮은 급여 값
        ROUND(AVG(sal),2),--부서별 급여 평균
        SUM(sal),--부서별 급여 합
        COUNT(sal),--부서별 급여 건수(sal 커럼의 값이 null이 아닌 row의 수)
        COUNT(*),
        COUNT(mgr)
FROM emp
GROUP BY deptno;

GROUP 함수 연산시 NULL 값은 제외가된다.
30번 부서에는  NULL값을 갖는 행이 있지만 SUM(COMM)의 값이 정상적으로 계산된 걸 확인 할 수 있다
SELECT deptno, SUM(comm) 
FROM emp
GROUP BY deptno;

10,20번 부서의 SUM(COMM)컬럼이 NULL이 아니라 0이나오도록 처리
*특별한 사유가 아니면 그룹함수 계산결과에 NULL처리를 하는 것이 성능상 유리

NVL(SUM)COMM), 0) : COMM컬럼에 SUM그룹함수를 적용하고 최종 결과에 NVL을 적용(1회호출)
SUM(NVL(COMM, 0)) : 모든 COMM컬럽에 NVL 함수를 적용후(해당 그룹의 ROW수만큼 호출) SUM 그룹함수 적용

SELECT deptno, NVL(SUM(comm),0)
FROM emp
GROUP BY deptno;


single row 함수는 where 절에 기술할 수 있지만
multi row 함수(group 함수) 는 where절에 기술할 수 없고
GROUP BY 절 이후 HAVING 절에 별도로 기술

sing row 함수는 where절에 사용가능
SELECT *
FROM emp
WHERE LOWER(ename) = 'smith';

부서별 급여 합이 5000이 넘는 부서만 조회
SELECT deptno, SUM(sal)
FROM emp
WHERE SUM(sal) > 9000 ===>>안됨
GROUP BY deptno;

SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno
HAVING SUM(sal) > 9000;

SELECT MAX(sal) max_sal, 
        MIN(sal) min_sal, 
        ROUND(AVG(sal),2) avg_sal, 
        SUM(sal) sum_sal, 
        COUNT(sal) count_sal,
        COUNT(mgr) count_mgr, 
        COUNT(*) count_all
FROM emp;

SELECT deptno,
        MAX(sal) max_sal, 
        MIN(sal) min_sal,
        ROUND(AVG(sal),2) avg_sal,
        SUM(sal) sum_sal,
        COUNT(sal) count_sal,
        COUNT(mgr) count_mr,
        COUNT(*) count_all
FROM emp
GROUP BY deptno;

SELECT DECODE(deptno, 10,  'ACCOUNTING',
                        20, 'RESEARCH',
                        30, 'SALES',
                        40, 'OPERATIONS', 'DDIT') dname,
        MAX(sal) max_sal, 
        MIN(sal) min_sal,
        ROUND(AVG(sal),2) avg_sal,
        SUM(sal) sum_sal,
        COUNT(sal) count_sal,
        COUNT(mgr) count_mr,           
        COUNT(*) count_all
FROM emp
GROUP BY deptno;
                        
SELECT hiredate
FROM emp;
                        
SELECT TO_CHAR(hiredate,'YYYYMM') hire_yyyymm,
        COUNT(hiredate) cnt
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYYMM')
ORDER BY TO_CHAR(hiredate,'YYYYMM');

SELECT TO_CHAR(hiredate,'YYYY') hire_yyyy,
        COUNT(hiredate) cnt
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYY')
ORDER BY TO_CHAR(hiredate,'YYYY');

SELECT COUNT(*) cnt
FROM dept;

SELECT COUNT(COUNT(deptno)) cnt
FROM emp
GROUP BY deptno;








