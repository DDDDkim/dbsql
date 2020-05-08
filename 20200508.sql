제약조건
1. PRIMARY KEY
2. UNIQUE
3. FOREIGN KEY
4. CHECK
        .NOT NULL
5. NOT NULL
        CHECK 제약 조건이지만 많이 사용하기 때문에 별도의 KEY WORD 를 제공
        
        
NOT NULL 제약조건
: 컬럼에 값이 NULL이 들어오는 것을 방지하는 제약 조건



DROP TABLE dept_test;

CREATE TABLE dept_test (
	deptno NUMBER(2, 0),
	dname VARCHAR2(14) NOT NULL,
	loc VARCHAR2(13)
);

dname 컬럼에 설정된 NOT NULL 제약조건에 의해 아래 INSERT 구문은 실패한다
INSERT INTO dept_test VALUES (99, NULL, 'daejeon');

문자열의 경우  ''를 NULL로 인식한다
아래의 INSERT 구문도 에러
INSERT INTO dept_test VALUES (99, ' ', 'daejeon');

SELECT *
FROM dept_test;


UNIQUE 제약
해당 컬럼에 동일한 값이 중복되지 않도록 제한
테이블의 모든 행중 해당 컬럼에 값은 중복되지 않고 유일해야함
EX : 직원 테이블의 사번 컬럼, 학생 테이블의 한번 컬럼


DROP TABLE dept_test;

CREATE TABLE dept_test (
	deptno NUMBER(2, 0),
	dname VARCHAR2(14) UNIQUE,
	loc VARCHAR2(13)
);

dept_test 테이블의 dname 컬럼은 UNIQUE 제약이 있기 때문에 동일한 값이 들어갈 수 없다.
INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (98, 'ddit', '대전');


복합 컬럼에 대한 UNIQUE 제약 설정
DROP TABLE dept_test;

CREATE TABLE dept_test (
	deptno NUMBER(2, 0),
	dname VARCHAR2(14),
	loc VARCHAR2(13),
    
    CONSTRAINT u_dept_test UNIQUE(dname, loc)
);

dname컬럼과 loc 컬럼이 동시에 동일한 값이어야만 중복으로 인식
밑에 두개의 쿼리는 데이터 중복이 아니므로 정상 실행
INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (98, 'ddit', '대전');

아래쿼리는 UNIQUE 제약 조건에 의해 입력되지 않는다.
INSERT INTO dept_test VALUES (97, 'ddit', '대전');

SELECT *
FROM dept_test;


FOREIGN KEY 제약조건
입력하고자 하는 데이터가 참조하는 테이블에 존재할 때만 입력 허용
ex : emp 티에블에 데이터를 입력할 때 deptno 컬럼의 값이 
      dept 테이블에 존재하는 deptno 값이어야 입력가능
      
데이터 입력시(emp) 참조하는 테이블(dept)에 데이터 존재 유무를 빠르게 알기위해서
참조하는 테이블(dept)의 컬럼(deptno)에 인덱스가 반드시 생성되어 있어야만
FOREIGN KEY 제약조건을 추가 할 수 있다.


UNIQUE 제약조건을 생성할 경우 해당 컬럼의 값 중복 체클를 빠르게 하기 위해서
오라클에서는 해당 컬럼에 인덱스가 없을 경우 자동으로 생성한다.

PRIMARY KEY 제약조건 : UNIQUE 제약 + NOT NULL
PRIMARY KEY 제약조건만 생성해도 해당 컬럼으로 인덱스를 생성 해준다


FOREIGN KEY 제약조건은 참조하는 테이블이 있기 때문에 두개의 테이블간 설정한다.

DROP TABLE dept_test;

CREATE TABLE dept_test (
	deptno NUMBER(2, 0) PRIMARY KEY,
	dname VARCHAR2(14),
	loc VARCHAR2(13)
);

INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');
COMMIT;


CREATE TABLE emp_test (
	empno NUMBER(4, 0) PRIMARY KEY,
	ename VARCHAR2(10),
	deptno NUMBER(2, 0) REFERENCES dept_test(deptno)
);

현재 부서 테이블에는 99번 부서만 존재
foreign key 제약조건에 의해 emp 테이블의 deptno 컬럼에는 99번 이외의 부서번호는 입력될 수 없다.

99번 부서는 존재하므로 정상적으로 입력 나으
INSERT INTO emp_test VALUES (9999, 'brown', 99);

98번 부서는 존재하지 않으므로 정상적으로 입력할 수 없다
INSERT INTO emp_test VALUES (9999, 'brown', 98);


FOREIGN KEY 제약조건 테이블 레벨에서 기술
DROP TABLE emp_test;

CREATE TABLE emp_test (
	empno NUMBER(4, 0) PRIMARY KEY,
	ename VARCHAR2(10),
	deptno NUMBER(2, 0),
    
    CONSTRAINT fk_emp_test_dept_test FOREIGN KEY (deptno) REFERENCE dept_test (deptno)
);








