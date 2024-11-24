-- Qual foi o total de receitas do ano de 1997? 

 
SELECT 
 SUM((A.unit_price * A.quantity) * (1 - A.DISCOUNT)) 
FROM ORDER_DETAILS A 
JOIN 
(
	SELECT 
	 ORDER_ID
	FROM orders
	WHERE EXTRACT(YEAR FROM order_date)  = 1997
) b
ON B.ORDER_ID = A.ORDER_ID