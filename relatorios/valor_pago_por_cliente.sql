-- Qual o valor que cada cliente já pagou até agora ? 

SELECT
    B.COMPANY_NAME
   ,SUM(A.UNIT_PRICE * A.QUANTITY * (1 - A.DISCOUNT)) AS TOTAL_SALES
FROM ORDER_DETAILS A 

JOIN
 (
	SELECT 
	 A.order_id
	,A.customer_id
	,B.company_name
	FROM ORDERS A
	JOIN
	CUSTOMERS B
	ON B.CUSTOMER_ID = A.customer_id
	
 ) B
 ON B.ORDER_ID = A.ORDER_ID

 GROUP BY
  B.COMPANY_NAME

 ORDER BY 
 TOTAL_SALES desc