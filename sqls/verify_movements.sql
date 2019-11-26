﻿DECLARE @UNEM_ID VARCHAR(22)
DECLARE @PROD_ID VARCHAR(22)

--SET @UNEM_ID = ':id_company'
--SET @PROD_ID = ':id_product'

SET @UNEM_ID = '001410060005'
SET @PROD_ID = '001410060000002201'

SELECT
	COUNT(DISTINCT DCFS.DCFS_ID) AS 'sales'
FROM
	DOCUMENTOS_FISCAIS DCFS
LEFT JOIN 
	ITENS_FATURADOS ITFT
	ON DCFS.DCFS_ID = ITFT.DCFS_ID
WHERE
	ITFT.PROD_ID = @PROD_ID AND
	DCFS.DCFS_ID LIKE @UNEM_ID + '%' AND	
	DCFS.DCFS_STATUS = 'Válido' AND
	DCFS.DCFS_TIPO_MOVIMENTO = 'Saída' AND
	DCFS.DCFS_NATUREZA_OPERACAO = 'Venda' AND
	DCFS.DCFS_DATA_SAIDA BETWEEN dbo.fn_ONLYDATE(DATEADD(YEAR,-2,GETDATE())) AND dbo.FN_ULTIMAHORA(GETDATE())