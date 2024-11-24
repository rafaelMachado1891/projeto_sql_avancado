-- Separe os clientes em 5 grupos de acordo com o valor pago por cliente

SELECT
 A.company_name
,SUM((C.unit_price * C.quantity) * (1-C.discount)) AS total
,NTILE(5) OVER(ORDER BY(SUM((C.unit_price * C.quantity) * (1-C.discount)))DESC) AS customer_group
FROM CUSTOMERS A 
JOIN
 ORDERS B
  ON B.customer_id = A.customer_id
JOIN
 ORDER_DETAILS C
 ON C.order_id = B.order_id
GROUP BY 
 	A.company_name
 ORDER BY 
 	total DESC