SELECT * 
FROM prod;

--특정 컬럼에 대해서만 조회 :  SELECT 컬럼1, 컬럼2....
--prod_id, prod_name컬럼만 prod테이블에서 조회

SELECT prod_id, prod_name
FROM prod;

SELECT buyer_id, buyer_name
FROM buyer;

SELECT *
FROM cart;

SELECT mem_id, mem_pass, mem_name
FROM member;

