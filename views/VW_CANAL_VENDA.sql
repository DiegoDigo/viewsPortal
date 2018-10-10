declare set varchar(255) @CODIGO_CANAL = '';

CREATE OR REPLACE view  vw_canal_venda 
AS 
  SELECT CASE 
           WHEN ccat61. "vdclicat_cancsn" = 0 THEN 1 
           ELSE 0 
         end                            AS ATIVO, 
         ccat61. "vdclicat_autoserv"    AS AUTO_SERVICO, 
         ccat61. "vdclicat_cod"         AS CODIGO_CANAL, 
         ccat61. "vdclicat_grpcan"      AS CODIGO_GRUPO_CANAL, 
         ccat61. "vdclicat_nome"        AS DESCRICAO, 
         ccat61. "vdclicat_descr_compl" AS DESCRICAO_COMPLEMENTAR, 
         ccat61. "vdclicat_descr_compl" AS DIVISAO_CANAL 
  FROM    ccat61 
  WHERE  ( ccat61. "vdclicat_cod" = @codigo_canal 
            OR @codigo_canal = '' ) ;