SELECT 
	MAX(ID) as id_max
	,COUNT(procv) AS QTD
	-- select *
	--into #tmp
FROM
	CONSOLIDADO.TB_CONSOLIDADO
GROUP BY 
	ID
HAVING COUNT(2) > 1
