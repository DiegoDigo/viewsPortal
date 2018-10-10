declare set bigint @CODIGO_BANDA = 0;

CREATE OR REPLACE view  vw_banda_preco_capa 
AS 
  SELECT 1                                                                AS 
         ATIVO, 
         bdapre61. "vdprdbda_id"                                          AS 
            CODIGO_BANDA_PRECO_ERP, 
         bdapre61. "vdprdbda_fam"                                         AS 
            CODIGO_FAMEB, 
         bdapre61. "vdprdbda_grpcli"                                      AS 
            CODIGO_GRUPO_ANALISE_CLI, 
         bdapre61. "vdprdbda_grpcan"                                      AS 
            CODIGO_GRUPO_CANAL_CLI, 
         bdapre61. "vdprdbda_pst"                                         AS 
            CODIGO_PASTA_CLI, 
         NULL                                                             AS 
            DESCRICAO, 
         CASE 
           WHEN bdapre61. "vdprdbda_importado" = 'S' THEN 'IMPORTADO' 
           ELSE 'MANUAL' 
         end                                                              AS 
            ORIGEM_BANDA, 
         bdapre61. "vdprdbda_reg"                                         AS 
            REGIAO_CLIENTE, 
         bdapre61. "vdprdbda_caixa_unid"                                  AS 
            UNIDADE, 
         bdapre61. "vdprdbda_can"                                         AS 
            CODIGO_CANAL_ERP, 
         bdapre61. "vdprdbda_cat"                                         AS 
            CODIGO_CATEGORIA_PRODUTO_ERP, 
         bdapre61. "vdprdbda_fam"                                         AS 
            CODIGO_FAMILIA_PRODUTO_ERP, 
         bdapre61. "vdprdbda_grp"                                         AS 
            CODIGO_GRUPO_PRODUTO_ERP, 
         bdapre61. "vdprdbda_mar"                                         AS 
            CODIGO_MARCA_PRODUTO_ERP, 
         (SELECT cadprd61. "vdprdprd_codr" 
          FROM    cadprd61 
          WHERE  cadprd61. "vdprdprd_cfam" = bdapre61. "vdprdbda_fam" 
                 AND cadprd61. "vdprdprd_nro" = bdapre61. "vdprdbda_prd") AS 
         CODIGO_PRODUTO_ERP, 
         bdapre61. "vdprdbda_cpg"                                         AS 
            CODIGO_CONDICAO_PAGAMENTO_ERP 
  FROM    bdapre61 
  WHERE  bdapre61. "vdprdbda_cancsn" = 0 
         AND ( bdapre61. "vdprdbda_id" = @codigo_banda 
                OR @codigo_banda = 0 ) ;