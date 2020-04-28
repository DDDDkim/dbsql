JOIN2]
SELECT buyer_id, buyer_name, prod_id, prod_name 
FROM buyer, prod
WHERE buyer.buyer_id = prod.prod_buyer;

SELECT COUNT(*)
FROM buyer, prod
WHERE buyer.buyer_id = prod.prod_buyer;

SELECT buyer_name, COUNT(*)
FROM buyer, prod
WHERE buyer.buyer_id = prod.prod_buyer
GROUP BY buyer.buyer_name;

JOIN3]
SELECT mem_id, mem_name, prod_id, cart_qty
FROM member m, cart c, prod p
WHERE c.cart_prod = p.prod_id AND c.cart_member = m.mem_id;

테이블 JOIN 테이블 ON/USING

SELECT mem_id, mem_name, prod_id, cart_qty
FROM member JOIN cart ON(cart.cart_member = member.mem_id)  
                            JOIN prod ON(cart.cart_prod = prod.prod_id);
                            
참고사항
SELECT deptno, COUNT(*)
FROM emp
GROUP BY deptno;

cid : customer id
cnm : customer name

SELECT *
FROM customer;

pid : product id
pnm : product name;
SELECT *
FROM product;

cycle : 애음 주기
cid : 고객 id
pid : product id
day : 애음 요일
cnt : 수량
SELECT *
FROM cycle;

4]
SELECT customer.cid, cnm, pid, day, cnt
FROM customer, cycle
WHERE customer.cid = cycle.cid
      AND customer.cnm in('brown', 'sally');

5]
SELECT customer.cid, cnm, cycle.pid, pnm, day, cnt
fROM customer, cycle, product
WHERE customer.cid = cycle.cid
     AND cycle.pid = product.pid
     AND customer.cnm in('brown', 'sally');
     
6]
SELECT customer.cid, cnm, cycle.pid, pnm, SUM(cnt) cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
     AND cycle.pid = product.pid
GROUP BY customer.cid, cnm, cycle.pid, pnm;

7]
SELECT cycle.pid, pnm, SUM(cnt) cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
     AND cycle.pid = product.pid
GROUP BY cycle.pid, pnm;
    


