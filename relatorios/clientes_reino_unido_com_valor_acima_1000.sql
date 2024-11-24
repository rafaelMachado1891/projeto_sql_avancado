-- Identificar os clientes do reino unido que pagaram mais de mil dolares

WITH Clientes_Reino_Unido AS (
	SELECT 
	 customer_id
	,company_name
	,country
	FROM CUSTOMERS
	WHERE COUNTRY = 'UK'
)

SELECT
 A.company_name
,SUM(c.unit_price * c.quantity * (1-c.discount)) AS Total
FROM clientes_reino_unido A 
JOIN
 ORDERS B 
ON B.customer_id = A.customer_id
JOIN
order_details c
on c.order_id = B.order_id

GROUP BY 
 A.company_name
HAVING
 SUM(c.unit_price * c.quantity * (1-c.discount)) >= 1000
ORDER BY 
 Total desc