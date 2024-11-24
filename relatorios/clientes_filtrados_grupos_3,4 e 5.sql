-- Agora somente os clientes que estão nos grupos 3, 4 e 5 para que seja feita uma análise de Marketing especial 
--com eles

WITH CLIENTES_GRUPO AS(
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
)

SELECT
 company_name
,total
FROM CLIENTES_GRUPO
WHERE 
 CUSTOMER_GROUP >= 3