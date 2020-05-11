부모-자식 테이블 관계

1.테이블 생성시 순서
    1.부모(dept)
    2.자식(emp)
    
2.데이터 생성시(insert) 순서
    1.부모(dept)
    2.자식(emp)
    
3.데이터 삭제(delete) 순서
    1.자식(emp)
    2.부모(dept)
    
    
    
테이블 변경시(테이블이 이미 생성되어 있는경우) 제약조건 추가 삭제

DROP TABLE emp_test;

CREATE TABLE emp_test(
	empno NUMBER(4),
	ename VARCHAR2(10),
	deptno NUMBER(2)
);

테이블 생성시 제약조건을 특별히 생성하지 않음

테이블 변경을 통한 PRIMARY KEY 추가

문법 : ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 제약조건타입 (적용할 컬럼[,]);
제약조건 타입 : PRIMARY KEY, UNIQUE, FOREIGN KEY, CHECK

ALTER TABLE emp_test ADD CONSTRAINT pk_emp_test PRIMARY KEY (empno);


테이블 변경시 제약조건 삭제
문법 : ALTER TABLE  테이블명 DROP CONSTRAINT 제약조건명;

위에서 추가한 제약조건 pk_emp_test 삭제
ALTER TABLE emp_test DROP CONSTRAINT pk_emp_test;

테이블 생성이후 외래키 제약조건 추가 실습
emp_test.deptno ==> dept_test.deptno

dept_test 테이블의 deptno 에 인덱스 생성 되어있는지 확인

ALTER TABLE emp_test ADD CONSTRAINT 제약조건명 제약조건타입 (컬럼) REFERENCES 참조테이블명 (참조테이블컬럼명);

ALTER TABLE emp_test ADD CONSTRAINT fk_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test (deptno);

삭제는 동일;

제약조건 활성화 비활성화.
테이블에 설정된 제약조건을 삭제하는 것이 아니라 잠시 기능을 끄고, 키는 설정

문법 : ALTER TABLE 테이블명 ENABLE | DISABLE CONSTRAINT 제약조건명;

위에서 설정한 fk_emp_test_dept_test FOREIGN KEY  제약조건을 비활성화;
ALTER TABLE emp_test DISABLE CONSTRAINT fk_emp_test_dept_test;

dept(부모)테이블에는 99번 부서만 존재하는 상황
SELECT *
FROM dept_test;

fk_emp_test_dept_test 제약조건이 비활성화되어 있기 때문에 emp_Test 테이블에는 99번 부서 이외의 값이 입력 가능한 상황

dept_test 테이블에 88번 부서가 없지만 아래 쿼리는 정상적으로 실행
INSERT INTO emp_test VALUES (9999, 'brown', 88);


현재 상황 : emp_test 테이블에 dept_test 테이블에 존재하지 않는 88번 부서를 사용하고 있는 상황
                fk_emp_test_dept_test 제약조건은 비활성화된 상태
                
데이터의 무결성이 깨진 상태에서 fk_emp_test_dept_test 를 활성화 시켜면??
==> 데이터 무결성을 지킬 수 없으므로 활성화 될 수 없다.

ALTER TABLE emp_test ENABLE CONSTRAINT fk_emp_test_dept_test;


emp, dept 테이블에는 현재 PRIMARY KEY, FOREIGN KEY 제약이 걸려 있지 않은 상황
emp테이블은 empno를 key로
dept 테이블은 deptno를 key로 하는  PRIMARY KEY  제약을 추가하고

emp.deptno ==> dept.deptno를 참조하도록 FOREIGN KEY 를 추가

제약조건 명은 수업시간에 안내한 방법으로 명명

ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);

ALTER TABLE dept ADD CONSTRAINT pk_dept PRIMARY KEY (deptno);

ALTER TABLE emp ADD CONSTRAINT fk_emp_dept FOREIGN KEY (deptno) REFERENCES dept (deptno);


제약조건 확인
툴에서 제공해주는 메뉴(테이블 선택 ==> 제약조건 tab);
USER_CONSTRAINTS : 제약조건 정보(MASTER);

USER_CONS_COLUMNS : 제약조건 컬럼 정보(상세);

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'EMP';


컬럼확인
툴
SELECT *
DESC;
USER_TAB_COLUMNS (data dictionary, 오라클에서 내부적으로 관리하는 view);

SELECT *
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'EMP';


SELECT 'SELECT * FROM ' || TABLE_NAME || ';'
FROM USER_TABLES;


테이블, 컬럼 주석 : USER_TAB_COMMENTS, USER_COL_COMMENTS;

SELECT *
FROM user_tab_comments;

실제 서비스에서 사용되는 테이블의 수는 수십개로 끝나지 않는 경우가 많다.

테이블의 주석 생성하기
문법 : COMMENT ON TABLE 테이블명 IS '주석';

emp 테이블에 주석 생성하기
COMMENT ON TABLE emp IS '맨날쓰는거ㅡㅡ';

SELECT *
FROM user_tab_comments
WHERE TABLE_NAME = 'EMP';

컬럼 주석 생성
COMMENT ON COLUMN 테이블명.컬럼명 IS '주석';

empno : 사번, ename : 이름, hiredate : 입사일자 생성후 user_col_commnets 를 통해 확인;

COMMENT ON COLUMN emp.empno IS '사번';
COMMENT ON COLUMN emp.ename IS '이름';
COMMENT ON COLUMN emp.hiredate IS '입사일자';

SELECT *
FROM user_col_comments
WHERE TABLE_NAME = 'EMP';

TABLE-comments 실습 
comment1];
SELECT utc.*, column_name, ucc.comments col_comment
    FROM user_tab_comments utc, user_col_comments ucc
 WHERE utc.table_name = ucc.table_name 
       AND (utc.TABLE_NAME IN ('CUSTOMER', 'PRODUCT', 'CYCLE', 'DAILY'));



View는 쿼리다
논리적인 데이터 집합 = SQL
물리적인 데이터 집합이 아니다

view 사용 용도
    . 데이터 보안(불필요한 컬럼 공개를 제한)
    . 자주사용하는 복잡한 쿼리 재사용
        . IN-LINE VIEW를 사용해도 동일한 결과를 만들어 낼 수 있으나
         MAIN 쿼리가 길어지는 단점이 있따.

view를 생성하기 위해서는 CREATE VIEW 권한을 갖고 있어야 한다. (DBA 설정)

SYSTEM 계정을 통해
GRANT CREATE VIEW TO 뷰생성권한을 부여할 계정;

문법 : CREATE [OR REPLACE] VIEW 뷰이름 [컬럼 별칭1, 컬럼별칭2...] AS
    SELECT 쿼리;
    
    
emp 테이블에서 sal, comm 컬럼을 제외한 6가지 컬럼만 조회가 가능한 v_emp view 를 생성
    
    
CREATE OR REPLACE VIEW v_emp AS
SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp;


view (v_emp)를 통한 데이터 조회;
SELECT *
FROM v_emp;

v_emp view는 DDDD꼐정 소유
HR계정에게 인사 시스템 개발을 위해서 EMP 테이블이 아닌 SAL, COMM조회가 제한된
v_emp view를 조회할수 있도록 권한을 부여

[hr계정에서 실행]권한부여전 hr 계정에서 v_emp 조회
SELECT *
FROM DDDD.v_emp;

[DDDD계정에서 실행]DDDD계정에서 hr계정으로 v_emp_view 를 조회할 수 있는 권한 부여
GRANT SELECT ON v_emp TO hr;

[hr계정에서 실행]v_emp view 권한을 hr 계정에 부여한 이우 조회 테스트.;
SELECT *
FROM DDDD.v_emp;



실습
v-emp_dept 뷰를 생성
emp, dept 테이블을 deptno 컬럼으로 조인하고
emp.empno, ename, dept.deptno, dname 4개의 컬럼으로 구성

CREATE OR REPLACE VIEW v_emp_dept AS
    SELECT emp.empno, emp.ename, dept.deptno, dept.dname
    FROM emp, dept
    WHERE emp.deptno = dept.deptno;

SELECT *
FROM v_emp_dept;\

VIEW 삭제
문법 : DROP VIEW 삭제할 뷰이름;
DROP VIEW v_emp;



