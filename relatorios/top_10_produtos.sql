-Top 10 Produtos Mais Vendidos
--Identificar os 10 produtos mais vendidos.

SELECT
 B.product_name
,SUM(a.unit_price * a.quantity * (1-a.discount)) AS total_sales
FROM order_details a 
JOIN
 products b 
 on B.product_id = A.product_id

GROUP BY 
 B.product_name
ORDER BY
 total_sales desc
 LIMIT 10