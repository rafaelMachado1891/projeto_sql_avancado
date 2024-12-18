
--Faça uma analise YTD e calcule a variação mensal. 

WITH RECEITA_TOTAL AS (
SELECT
	 EXTRACT(YEAR FROM B.ORDER_DATE) AS ANO
	,EXTRACT(MONTH FROM B.ORDER_DATE) AS MES
	,SUM((A.UNIT_PRICE * A.QUANTITY) * (1- A.DISCOUNT)) AS TOTAL    
FROM ORDER_DETAILS A 
JOIN
ORDERS B
 ON B.ORDER_ID = A.order_id
GROUP BY 
    EXTRACT(YEAR FROM B.ORDER_DATE),
    EXTRACT(MONTH FROM B.ORDER_DATE)
    ORDER BY 1,2
), 
RECEITASACUMULADAS AS (
	SELECT 
        ANO
        ,MES
        ,TOTAL
        ,SUM(TOTAL) OVER (PARTITION BY ANO ORDER BY MES) AS TOTALYTD
	FROM RECEITA_TOTAL
)
SELECT 
    ANO
    ,MES
    ,TOTAL
    ,TOTAL - LAG(TOTAL) OVER (PARTITION BY ANO ORDER BY MES) AS DIFERENCA_RECEITA
    ,TOTALYTD
    ,(TOTAL / (LAG(TOTAL) OVER (PARTITION BY ANO ORDER BY MES))-1) * 100 AS VARIACAO
FROM RECEITASACUMULADAS