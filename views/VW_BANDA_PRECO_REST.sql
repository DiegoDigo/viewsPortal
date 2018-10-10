CREATE OR replace VIEW  vw_banda_preco_rest 
AS 
  SELECT 1 
         AS ATIVO 
            , 
         Cast(Cast(bdapre61. "vdprdbda_fam" AS VARCHAR(3)) 
              || Cast(bdapre61. "vdprdbda_prd" AS VARCHAR(3)) 
              || Cast(bdapre61. "vdprdbda_grp" AS VARCHAR(2)) 
              || Cast(bdapre61. "vdprdbda_cat" AS VARCHAR(2)) 
              || Cast(bdapre61. "vdprdbda_mar" AS VARCHAR(2)) 
              || Cast(bdapre61. "vdprdbda_reg" AS VARCHAR(4)) 
              || Cast(bdapre61. "vdprdbda_pst" AS VARCHAR(4)) 
              || Cast(bdapre61. "vdprdbda_grpcli" AS VARCHAR(4)) 
              || Cast(bdapre61. "vdprdbda_ven" AS VARCHAR(3)) 
              || Cast(bdapre61. "vdprdbda_can" AS VARCHAR(2)) 
              || Cast(bdapre61. "vdprdbda_grpcan" AS VARCHAR(2)) 
              || Cast(bdapre61. "vdprdbda_cpg" AS VARCHAR(2)) 
              || Cast(bdapre61. "vdprdbda_grpesc" AS VARCHAR(3)) AS VARCHAR(50)) 
         AS 
         CODIGO_BANDA_PRECO_ERP, 
         bdapre61. "vdprdbda_ven" 
         AS 
            CODIGO_VENDEDOR_ERP 
  FROM    bdapre61 
  WHERE  bdapre61. "vdprdbda_cancsn" = 0 
         AND bdapre61. "vdprdbda_ven" <> '   ' ;