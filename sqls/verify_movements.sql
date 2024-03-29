DECLARE @UNEM_ID VARCHAR(22)
      , @PROD_ID VARCHAR(22)
      , @DT_INICIO DATETIME
      , @DT_FINAL  DATETIME

SET @UNEM_ID = ':id_company'
SET @PROD_ID = ':id_product'

--SET @UNEM_ID = '001410060001'
--SET @PROD_ID = '001410040000000019'

SET @DT_INICIO = dbo.fn_ONLYDATE(DATEADD(YEAR,-2,GETDATE()))
SET @DT_FINAL = dbo.FN_ULTIMAHORA(GETDATE())

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
   DCFS.DCFS_STATUS = 'V�lido' AND
   DCFS.DCFS_TIPO_MOVIMENTO = 'Sa�da' AND
   DCFS.DCFS_NATUREZA_OPERACAO = 'Venda' AND
   DCFS.DCFS_DATA_SAIDA BETWEEN @DT_INICIO AND @DT_FINAL
