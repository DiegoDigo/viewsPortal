DECLARE SET INTEGER @CODIGO_BANDA = 0;

CREATE OR replace VIEW  vw_banda_preco_item AS
SELECT DISTINCT(bdapre61. "vdprdbda_id" )                   AS CODIGO_BANDA_PRECO_ERP,
                bdapre61.vdprdbda_bandprec_1                AS QUANTIDADE , 
                bdapre61.vdprdbda_tab_x_1                   AS CODIGO_TABPRECO_ERP, 
                bdapre61.vdprdbda_descto_1                  AS DESCONTO_MAXIMO 
FROM             bdapre61 
INNER JOIN       tabprc61 
ON              bdapre61. "vdprdbda_fam" = tabprc61. "vdtabprd_cfam" 
AND             bdapre61. "vdprdbda_prd" = tabprc61. "vdtabprd_nro" 
INNER JOIN       cadprd61 
ON              bdapre61. "vdprdbda_fam" = cadprd61. "vdprdprd_cfam" 
AND             bdapre61. "vdprdbda_prd" = cadprd61. "vdprdprd_nro" 
WHERE           cadprd61. "vdprdprd_flag" = 'A' 
AND             cadprd61. "vdprdprd_disp_portal_web" <> 0 
AND             bdapre61. "vdprdbda_bandprec_1" <> 0 
AND             bdapre61. "vdprdbda_cancsn" = 0 
AND             ( 
                                bdapre61. "vdprdbda_id" = @CODIGO_BANDA 
                OR              @CODIGO_BANDA = 0 ) 
AND             LEFT(Cast( tabprc61.vdtabprd_dtvgf AS VARCHAR(8)),4 )>= LEFT(Cast(Curdate() - 365 AS CHAR(4)),4)
UNION ALL 
SELECT DISTINCT(bdapre61. "vdprdbda_id" )    AS CODIGO_BANDA_PRECO_ERP, 
                bdapre61.vdprdbda_bandprec_2 AS QUANTIDADE , 
                bdapre61.vdprdbda_tab_x_2    AS CODIGO_TABPRECO_ERP, 
                bdapre61.vdprdbda_descto_2   AS DESCONTO_MAXIMO 
FROM             bdapre61 
INNER JOIN       tabprc61 
ON              bdapre61. "vdprdbda_fam" = tabprc61. "vdtabprd_cfam" 
AND             bdapre61. "vdprdbda_prd" = tabprc61. "vdtabprd_nro" 
INNER JOIN       cadprd61 
ON              bdapre61. "vdprdbda_fam" = cadprd61. "vdprdprd_cfam" 
AND             bdapre61. "vdprdbda_prd" = cadprd61. "vdprdprd_nro" 
WHERE           cadprd61. "vdprdprd_flag" = 'A' 
AND             cadprd61. "vdprdprd_disp_portal_web" <> 0 
AND             bdapre61. "vdprdbda_bandprec_2" <> 0 
AND             bdapre61. "vdprdbda_cancsn" = 0 
AND             ( 
                                bdapre61. "vdprdbda_id" = @CODIGO_BANDA 
                OR              @CODIGO_BANDA = 0 ) 
AND             LEFT(Cast( tabprc61.vdtabprd_dtvgf AS VARCHAR(8)),4 )>= LEFT(Cast(Curdate() - 365 AS CHAR(4)),4)
UNION ALL 
SELECT DISTINCT(bdapre61. "vdprdbda_id" )    AS CODIGO_BANDA_PRECO_ERP, 
                bdapre61.vdprdbda_bandprec_3 AS QUANTIDADE , 
                bdapre61.vdprdbda_tab_x_3    AS CODIGO_TABPRECO_ERP, 
                bdapre61.vdprdbda_descto_3   AS DESCONTO_MAXIMO 
FROM             bdapre61 
INNER JOIN       tabprc61 
ON              bdapre61. "vdprdbda_fam" = tabprc61. "vdtabprd_cfam" 
AND             bdapre61. "vdprdbda_prd" = tabprc61. "vdtabprd_nro" 
INNER JOIN       cadprd61 
ON              bdapre61. "vdprdbda_fam" = cadprd61. "vdprdprd_cfam" 
AND             bdapre61. "vdprdbda_prd" = cadprd61. "vdprdprd_nro" 
WHERE           cadprd61. "vdprdprd_flag" = 'A' 
AND             cadprd61. "vdprdprd_disp_portal_web" <> 0 
AND             bdapre61. "vdprdbda_bandprec_3" <> 0 
AND             bdapre61. "vdprdbda_cancsn" = 0 
AND             ( 
                                bdapre61. "vdprdbda_id" = @CODIGO_BANDA 
                OR              @CODIGO_BANDA = 0 ) 
AND             LEFT(Cast( tabprc61.vdtabprd_dtvgf AS VARCHAR(8)),4 )>= LEFT(Cast(Curdate() - 365 AS CHAR(4)),4)
UNION ALL 
SELECT DISTINCT(bdapre61. "vdprdbda_id" )    AS CODIGO_BANDA_PRECO_ERP, 
                bdapre61.vdprdbda_bandprec_4 AS QUANTIDADE , 
                bdapre61.vdprdbda_tab_x_4    AS CODIGO_TABPRECO_ERP, 
                bdapre61.vdprdbda_descto_4   AS DESCONTO_MAXIMO 
FROM             bdapre61 
INNER JOIN       tabprc61 
ON              bdapre61. "vdprdbda_fam" = tabprc61. "vdtabprd_cfam" 
AND             bdapre61. "vdprdbda_prd" = tabprc61. "vdtabprd_nro" 
INNER JOIN       cadprd61 
ON              bdapre61. "vdprdbda_fam" = cadprd61. "vdprdprd_cfam" 
AND             bdapre61. "vdprdbda_prd" = cadprd61. "vdprdprd_nro" 
WHERE           cadprd61. "vdprdprd_flag" = 'A' 
AND             cadprd61. "vdprdprd_disp_portal_web" <> 0 
AND             bdapre61. "vdprdbda_bandprec_4" <> 0 
AND             bdapre61. "vdprdbda_cancsn" = 0 
AND             ( 
                                bdapre61. "vdprdbda_id" = @CODIGO_BANDA 
                OR              @CODIGO_BANDA = 0 ) 
AND             LEFT(Cast( tabprc61.vdtabprd_dtvgf AS VARCHAR(8)),4 )>= LEFT(Cast(Curdate() - 365 AS CHAR(4)),4)
UNION ALL 
SELECT     bdapre61. "vdprdbda_id"      AS CODIGO_BANDA_PRECO_ERP, 
           bdapre61.vdprdbda_bandprec_5 AS QUANTIDADE , 
           bdapre61.vdprdbda_tab_x_5    AS CODIGO_TABPRECO_ERP, 
           bdapre61.vdprdbda_descto_5   AS DESCONTO_MAXIMO 
FROM        bdapre61 
INNER JOIN  tabprc61 
ON         bdapre61. "vdprdbda_fam" = tabprc61. "vdtabprd_cfam" 
AND        bdapre61. "vdprdbda_prd" = tabprc61. "vdtabprd_nro" 
INNER JOIN  cadprd61 
ON         bdapre61. "vdprdbda_fam" = cadprd61. "vdprdprd_cfam" 
AND        bdapre61. "vdprdbda_prd" = cadprd61. "vdprdprd_nro" 
WHERE      cadprd61. "vdprdprd_flag" = 'A' 
AND        cadprd61. "vdprdprd_disp_portal_web" <> 0 
AND        bdapre61. "vdprdbda_bandprec_5" <> 0 
AND        bdapre61. "vdprdbda_cancsn" = 0 
AND        ( 
                      bdapre61. "vdprdbda_id" = @CODIGO_BANDA 
           OR         @CODIGO_BANDA = 0 ) 
AND        LEFT(Cast( tabprc61.vdtabprd_dtvgf AS VARCHAR(8)),4 )>= LEFT(Cast(Curdate() - 365 AS CHAR(4)),4)
UNION ALL 
SELECT DISTINCT(bdapre61. "vdprdbda_id" )    AS CODIGO_BANDA_PRECO_ERP, 
                bdapre61.vdprdbda_bandprec_6 AS QUANTIDADE , 
                bdapre61.vdprdbda_tab_x_6    AS CODIGO_TABPRECO_ERP, 
                bdapre61.vdprdbda_descto_6   AS DESCONTO_MAXIMO 
FROM             bdapre61 
INNER JOIN       tabprc61 
ON              bdapre61. "vdprdbda_fam" = tabprc61. "vdtabprd_cfam" 
AND             bdapre61. "vdprdbda_prd" = tabprc61. "vdtabprd_nro" 
INNER JOIN       cadprd61 
ON              bdapre61. "vdprdbda_fam" = cadprd61. "vdprdprd_cfam" 
AND             bdapre61. "vdprdbda_prd" = cadprd61. "vdprdprd_nro" 
WHERE           cadprd61. "vdprdprd_flag" = 'A' 
AND             cadprd61. "vdprdprd_disp_portal_web" <> 0 
AND             bdapre61. "vdprdbda_bandprec_6" <> 0 
AND             bdapre61. "vdprdbda_cancsn" = 0 
AND             ( 
                                bdapre61. "vdprdbda_id" = @CODIGO_BANDA 
                OR              @CODIGO_BANDA = 0 ) 
AND             LEFT(Cast( tabprc61.vdtabprd_dtvgf AS VARCHAR(8)),4 )>= LEFT(Cast(Curdate() - 365 AS CHAR(4)),4)
UNION ALL 
SELECT DISTINCT(bdapre61. "vdprdbda_id" )    AS CODIGO_BANDA_PRECO_ERP, 
                bdapre61.vdprdbda_bandprec_7 AS QUANTIDADE , 
                bdapre61.vdprdbda_tab_x_7    AS CODIGO_TABPRECO_ERP, 
                bdapre61.vdprdbda_descto_7   AS DESCONTO_MAXIMO 
FROM             bdapre61 
INNER JOIN       tabprc61 
ON              bdapre61. "vdprdbda_fam" = tabprc61. "vdtabprd_cfam" 
AND             bdapre61. "vdprdbda_prd" = tabprc61. "vdtabprd_nro" 
INNER JOIN       cadprd61 
ON              bdapre61. "vdprdbda_fam" = cadprd61. "vdprdprd_cfam" 
AND             bdapre61. "vdprdbda_prd" = cadprd61. "vdprdprd_nro" 
WHERE           cadprd61. "vdprdprd_flag" = 'A' 
AND             cadprd61. "vdprdprd_disp_portal_web" <> 0 
AND             bdapre61. "vdprdbda_bandprec_7" <> 0 
AND             bdapre61. "vdprdbda_cancsn" = 0 
AND             ( 
                                bdapre61. "vdprdbda_id" = @CODIGO_BANDA 
                OR              @CODIGO_BANDA = 0 ) 
AND             LEFT(Cast( tabprc61.vdtabprd_dtvgf AS VARCHAR(8)),4 )>= LEFT(Cast(Curdate() - 365 AS CHAR(4)),4)
UNION ALL 
SELECT DISTINCT(bdapre61. "vdprdbda_id" )    AS CODIGO_BANDA_PRECO_ERP, 
                bdapre61.vdprdbda_bandprec_8 AS QUANTIDADE , 
                bdapre61.vdprdbda_tab_x_8    AS CODIGO_TABPRECO_ERP, 
                bdapre61.vdprdbda_descto_8   AS DESCONTO_MAXIMO 
FROM             bdapre61 
INNER JOIN       tabprc61 
ON              bdapre61. "vdprdbda_fam" = tabprc61. "vdtabprd_cfam" 
AND             bdapre61. "vdprdbda_prd" = tabprc61. "vdtabprd_nro" 
INNER JOIN       cadprd61 
ON              bdapre61. "vdprdbda_fam" = cadprd61. "vdprdprd_cfam" 
AND             bdapre61. "vdprdbda_prd" = cadprd61. "vdprdprd_nro" 
WHERE           cadprd61. "vdprdprd_flag" = 'A' 
AND             cadprd61. "vdprdprd_disp_portal_web" <> 0 
AND             bdapre61. "vdprdbda_bandprec_8" <> 0 
AND             bdapre61. "vdprdbda_cancsn" = 0 
AND             ( 
                                bdapre61. "vdprdbda_id" = @CODIGO_BANDA 
                OR              @CODIGO_BANDA = 0 ) 
AND             LEFT(Cast( tabprc61.vdtabprd_dtvgf AS VARCHAR(8)),4 )>= LEFT(Cast(Curdate() - 365 AS CHAR(4)),4)
UNION ALL 
SELECT DISTINCT(bdapre61. "vdprdbda_id" )    AS CODIGO_BANDA_PRECO_ERP, 
                bdapre61.vdprdbda_bandprec_9 AS QUANTIDADE , 
                bdapre61.vdprdbda_tab_x_9    AS CODIGO_TABPRECO_ERP, 
                bdapre61.vdprdbda_descto_9   AS DESCONTO_MAXIMO 
FROM             bdapre61 
INNER JOIN       tabprc61 
ON              bdapre61. "vdprdbda_fam" = tabprc61. "vdtabprd_cfam" 
AND             bdapre61. "vdprdbda_prd" = tabprc61. "vdtabprd_nro" 
INNER JOIN       cadprd61 
ON              bdapre61. "vdprdbda_fam" = cadprd61. "vdprdprd_cfam" 
AND             bdapre61. "vdprdbda_prd" = cadprd61. "vdprdprd_nro" 
WHERE           cadprd61. "vdprdprd_flag" = 'A' 
AND             cadprd61. "vdprdprd_disp_portal_web" <> 0 
AND             bdapre61. "vdprdbda_bandprec_9" <> 0 
AND             bdapre61. "vdprdbda_cancsn" = 0 
AND             ( 
                                bdapre61. "vdprdbda_id" = @CODIGO_BANDA 
                OR              @CODIGO_BANDA = 0 ) 
AND             LEFT(Cast( tabprc61.vdtabprd_dtvgf AS VARCHAR(8)),4 )>= LEFT(Cast(Curdate() - 365 AS CHAR(4)),4) ;