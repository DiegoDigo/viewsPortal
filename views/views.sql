create function datetostr.DATETOSTR(DATE, varchar(20)) RETURNS varchar(20);

DECLARE SET INT @CODIGOPEDIDO = 0;
CREATE or replace VIEW "VW_ACOMPANHAMENTO_PEDIDO" 
AS 
  SELECT   "vdpedflc_nped"         AS 
         NUMERO_PEDIDO_GESTAO, 
           "vdpedflc_sit_nped"     AS 
            SITUACAO_PEDIDO_GESTAO, 
           "vdpedflc_pnped"        AS 
            NUMERO_PRE_PEDIDO_GESTAO, 
           "vdpedflc_croma"        AS NUMERO_ROMANEIO, 
           "vdpedflc_sit_crom"     AS SITUACAO_ROMANEIO, 
           "vdpedflc_serie"        AS SERIE_NFISCAL, 
           "vdpedflc_nf"           AS NUMERO_NFISCAL, 
           "vdpedflc_cod_bloq_ped" AS CODIGO_BLOQ_PEDIDO 
  FROM   vdpedflc 
  WHERE  ( "vdpedflc_nped" = @CODIGOPEDIDO 
                OR @CODIGOPEDIDO = 0 ) ;

declare set bigint @CODIGO_BANDA = 0;

CREATE or replace VIEW   "VW_BANDA_PRECO_CAPA" 
AS 
  SELECT 1                                                      AS ATIVO, 
			  
		  bdapre61. "vdprdbda_id"	            as CODIGO_BANDA_PRECO_ERP,
          bdapre61. "vdprdbda_fam"              AS CODIGO_FAMEB, 
          bdapre61. "vdprdbda_grpcli"           AS 
            CODIGO_GRUPO_ANALISE_CLI, 
          bdapre61. "vdprdbda_grpcan"           AS 
            CODIGO_GRUPO_CANAL_CLI, 
          bdapre61. "vdprdbda_pst"              AS 
         CODIGO_PASTA_CLI 
            , 
         NULL                                                   AS 
            DESCRICAO, 
         CASE 
           WHEN  bdapre61. "vdprdbda_importado" = 'S' THEN 
           'IMPORTADO' 
           ELSE 'MANUAL' 
         END                                                    AS ORIGEM_BANDA, 
          bdapre61. "vdprdbda_reg"              AS REGIAO_CLIENTE 
         , 
          bdapre61. "vdprdbda_caixa_unid"       AS 
         UNIDADE, 
          bdapre61. "vdprdbda_can"              AS 
         CODIGO_CANAL_ERP 
            , 
          bdapre61. "vdprdbda_cat"              AS 
            CODIGO_CATEGORIA_PRODUTO_ERP, 
          bdapre61. "vdprdbda_fam"              AS 
            CODIGO_FAMILIA_PRODUTO_ERP, 
          bdapre61. "vdprdbda_grp"              AS 
            CODIGO_GRUPO_PRODUTO_ERP, 
          bdapre61. "vdprdbda_mar"              AS 
            CODIGO_MARCA_PRODUTO_ERP, 
         (SELECT  cadprd61. "vdprdprd_codr" 
          FROM    cadprd61 
          WHERE   cadprd61. "vdprdprd_cfam" = 
                          bdapre61. "vdprdbda_fam" 
                 AND  cadprd61. "vdprdprd_nro" = 
                      bdapre61. "vdprdbda_prd") AS 
            CODIGO_PRODUTO_ERP, 
          bdapre61. "vdprdbda_cpg"              AS 
            CODIGO_CONDICAO_PAGAMENTO_ERP 		 
  FROM    bdapre61 
  WHERE   bdapre61. "vdprdbda_cancsn" = 0 
         AND (bdapre61. "vdprdbda_id" = @CODIGO_BANDA 
                OR @CODIGO_BANDA = 0 ) ;

DECLARE SET INTEGER @CODIGO_BANDA = 0;


CREATE OR REPLACE VIEW   "VW_BANDA_PRECO_ITEM"

AS 
select 
     distinct(bdapre61. "vdprdbda_id") AS CODIGO_BANDA_PRECO_ERP,
	 bdapre61.VDPRDBDA_BANDPREC_1 AS QUANTIDADE ,
	 bdapre61.VDPRDBDA_TAB_X_1 AS CODIGO_TABPRECO_ERP,
	 bdapre61.VDPRDBDA_DESCTO_1 AS DESCONTO_MAXIMO
from 
	 bdapre61
INNER JOIN  tabprc61 ON
	 bdapre61."vdprdbda_fam" =  tabprc61."VDTABPRD_CFAM" AND
	 bdapre61."vdprdbda_prd" =  tabprc61."VDTABPRD_NRO"
INNER JOIN  cadprd61 ON
	 bdapre61."vdprdbda_fam" =  cadprd61."VDPRDPRD_CFAM" AND
	 bdapre61."vdprdbda_prd" =  cadprd61."VDPRDPRD_NRO"
WHERE 
	 cadprd61."vdprdprd_flag" = 'A' and 
	 cadprd61."vdprdprd_disp_portal_web" <> 0 and
	 bdapre61."vdprdbda_bandprec_1" <> 0  and
	 bdapre61."vdprdbda_cancsn" = 0  and
 ( 			bdapre61. "vdprdbda_id" = @CODIGO_BANDA 
                OR @CODIGO_BANDA = 0 ) AND
	LEFT(CAST( tabprc61.VDTABPRD_DTVGF AS VARCHAR(8)),4 )>= LEFT(CAST(Curdate() - 365 AS Char(4)),4)
UNION ALL
select 
     distinct(bdapre61. "vdprdbda_id") as CODIGO_BANDA_PRECO_ERP,
	 bdapre61.VDPRDBDA_BANDPREC_2 AS QUANTIDADE ,
	 bdapre61.VDPRDBDA_TAB_X_2 AS CODIGO_TABPRECO_ERP,
	 bdapre61.VDPRDBDA_DESCTO_2 AS DESCONTO_MAXIMO
from 
	 bdapre61
INNER JOIN  tabprc61 ON
	 bdapre61."vdprdbda_fam" =  tabprc61."VDTABPRD_CFAM" AND
	 bdapre61."vdprdbda_prd" =  tabprc61."VDTABPRD_NRO"
INNER JOIN  cadprd61 ON
	 bdapre61."vdprdbda_fam" =  cadprd61."VDPRDPRD_CFAM" AND
	 bdapre61."vdprdbda_prd" =  cadprd61."VDPRDPRD_NRO"
WHERE 
	 cadprd61."vdprdprd_flag" = 'A' and 
	 cadprd61."vdprdprd_disp_portal_web" <> 0 and
	 bdapre61. "vdprdbda_bandprec_2" <> 0  and
	 bdapre61. "vdprdbda_cancsn" = 0  and
 ( 		bdapre61. "vdprdbda_id"  = @CODIGO_BANDA 
                OR @CODIGO_BANDA = 0 ) AND
	LEFT(CAST( tabprc61.VDTABPRD_DTVGF AS VARCHAR(8)),4 )>= LEFT(CAST(Curdate() - 365 AS Char(4)),4)
UNION ALL
select 
	 distinct(bdapre61. "vdprdbda_id") as CODIGO_BANDA_PRECO_ERP,
	 bdapre61.VDPRDBDA_BANDPREC_3 AS QUANTIDADE ,
	 bdapre61.VDPRDBDA_TAB_X_3 AS CODIGO_TABPRECO_ERP,
	 bdapre61.VDPRDBDA_DESCTO_3 AS DESCONTO_MAXIMO
from 
	 bdapre61
INNER JOIN  tabprc61 ON
	 bdapre61."vdprdbda_fam" =  tabprc61."VDTABPRD_CFAM" AND
	 bdapre61."vdprdbda_prd" =  tabprc61."VDTABPRD_NRO"
INNER JOIN  cadprd61 ON
	 bdapre61."vdprdbda_fam" =  cadprd61."VDPRDPRD_CFAM" AND
	 bdapre61."vdprdbda_prd" =  cadprd61."VDPRDPRD_NRO"
WHERE 
	 cadprd61."vdprdprd_flag" = 'A' and 
	 cadprd61."vdprdprd_disp_portal_web" <> 0 and
	 bdapre61. "vdprdbda_bandprec_3" <> 0  and
	 bdapre61. "vdprdbda_cancsn" = 0  and
 ( 	bdapre61. "vdprdbda_id" = @CODIGO_BANDA 
                OR @CODIGO_BANDA = 0 ) AND
	LEFT(CAST( tabprc61.VDTABPRD_DTVGF AS VARCHAR(8)),4 )>= LEFT(CAST(Curdate() - 365 AS Char(4)),4)
UNION ALL
select 
	distinct(bdapre61. "vdprdbda_id") as CODIGO_BANDA_PRECO_ERP,
	 bdapre61.VDPRDBDA_BANDPREC_4 AS QUANTIDADE ,
	 bdapre61.VDPRDBDA_TAB_X_4 AS CODIGO_TABPRECO_ERP,
	 bdapre61.VDPRDBDA_DESCTO_4 AS DESCONTO_MAXIMO
from 
	 bdapre61
INNER JOIN  tabprc61 ON
	 bdapre61."vdprdbda_fam" =  tabprc61."VDTABPRD_CFAM" AND
	 bdapre61."vdprdbda_prd" =  tabprc61."VDTABPRD_NRO"
INNER JOIN  cadprd61 ON
	 bdapre61."vdprdbda_fam" =  cadprd61."VDPRDPRD_CFAM" AND
	 bdapre61."vdprdbda_prd" =  cadprd61."VDPRDPRD_NRO"
WHERE 
	 cadprd61."vdprdprd_flag" = 'A' and 
	 cadprd61."vdprdprd_disp_portal_web" <> 0 and
	 bdapre61. "vdprdbda_bandprec_4" <> 0  and
	 bdapre61. "vdprdbda_cancsn" = 0  and
 ( 		bdapre61. "vdprdbda_id" = @CODIGO_BANDA 
                OR @CODIGO_BANDA = 0 ) AND
	LEFT(CAST( tabprc61.VDTABPRD_DTVGF AS VARCHAR(8)),4 )>= LEFT(CAST(Curdate() - 365 AS Char(4)),4)
UNION ALL
select 
bdapre61. "vdprdbda_id" as CODIGO_BANDA_PRECO_ERP,
	 bdapre61.VDPRDBDA_BANDPREC_5 AS QUANTIDADE ,
	 bdapre61.VDPRDBDA_TAB_X_5 AS CODIGO_TABPRECO_ERP,
	 bdapre61.VDPRDBDA_DESCTO_5 AS DESCONTO_MAXIMO
from 
	 bdapre61
INNER JOIN  tabprc61 ON
	 bdapre61."vdprdbda_fam" =  tabprc61."VDTABPRD_CFAM" AND
	 bdapre61."vdprdbda_prd" =  tabprc61."VDTABPRD_NRO"
INNER JOIN  cadprd61 ON
	 bdapre61."vdprdbda_fam" =  cadprd61."VDPRDPRD_CFAM" AND
	 bdapre61."vdprdbda_prd" =  cadprd61."VDPRDPRD_NRO"
WHERE 
     cadprd61."vdprdprd_flag" = 'A' and 
	 cadprd61."vdprdprd_disp_portal_web" <> 0 and
	 bdapre61. "vdprdbda_bandprec_5" <> 0  and
	 bdapre61. "vdprdbda_cancsn" = 0  and
 ( bdapre61. "vdprdbda_id" = @CODIGO_BANDA 
                OR @CODIGO_BANDA = 0 ) AND
	LEFT(CAST( tabprc61.VDTABPRD_DTVGF AS VARCHAR(8)),4 )>= LEFT(CAST(Curdate() - 365 AS Char(4)),4)
UNION ALL
select 
 distinct(bdapre61. "vdprdbda_id") as CODIGO_BANDA_PRECO_ERP,
	 bdapre61.VDPRDBDA_BANDPREC_6 AS QUANTIDADE ,
	 bdapre61.VDPRDBDA_TAB_X_6 AS CODIGO_TABPRECO_ERP,
	 bdapre61.VDPRDBDA_DESCTO_6 AS DESCONTO_MAXIMO
from 
	 bdapre61
INNER JOIN  tabprc61 ON
	 bdapre61."vdprdbda_fam" =  tabprc61."VDTABPRD_CFAM" AND
	 bdapre61."vdprdbda_prd" =  tabprc61."VDTABPRD_NRO"
INNER JOIN  cadprd61 ON
	 bdapre61."vdprdbda_fam" =  cadprd61."VDPRDPRD_CFAM" AND
	 bdapre61."vdprdbda_prd" =  cadprd61."VDPRDPRD_NRO"
WHERE 
     cadprd61."vdprdprd_flag" = 'A' and 
	 cadprd61."vdprdprd_disp_portal_web" <> 0 and
	 bdapre61. "vdprdbda_bandprec_6" <> 0  and
	 bdapre61. "vdprdbda_cancsn" = 0  and
 ( 	bdapre61. "vdprdbda_id" = @CODIGO_BANDA 
                OR @CODIGO_BANDA = 0 ) AND
	LEFT(CAST( tabprc61.VDTABPRD_DTVGF AS VARCHAR(8)),4 )>= LEFT(CAST(Curdate() - 365 AS Char(4)),4)
	
	
	
	
UNION ALL
select 
 distinct(bdapre61. "vdprdbda_id") as CODIGO_BANDA_PRECO_ERP,
	 bdapre61.VDPRDBDA_BANDPREC_7 AS QUANTIDADE ,
	 bdapre61.VDPRDBDA_TAB_X_7 AS CODIGO_TABPRECO_ERP,
	 bdapre61.VDPRDBDA_DESCTO_7 AS DESCONTO_MAXIMO
from 
	 bdapre61
INNER JOIN  tabprc61 ON
	 bdapre61."vdprdbda_fam" =  tabprc61."VDTABPRD_CFAM" AND
	 bdapre61."vdprdbda_prd" =  tabprc61."VDTABPRD_NRO"
INNER JOIN  cadprd61 ON
	 bdapre61."vdprdbda_fam" =  cadprd61."VDPRDPRD_CFAM" AND
	 bdapre61."vdprdbda_prd" =  cadprd61."VDPRDPRD_NRO"
WHERE 
	 cadprd61."vdprdprd_flag" = 'A' and 
	 cadprd61."vdprdprd_disp_portal_web" <> 0 and
	 bdapre61. "vdprdbda_bandprec_7" <> 0  and
	 bdapre61. "vdprdbda_cancsn" = 0  and
 ( 	bdapre61. "vdprdbda_id" = @CODIGO_BANDA 
                OR @CODIGO_BANDA = 0 ) AND
	LEFT(CAST( tabprc61.VDTABPRD_DTVGF AS VARCHAR(8)),4 )>= LEFT(CAST(Curdate() - 365 AS Char(4)),4)
UNION ALL
select 
     distinct(bdapre61. "vdprdbda_id") as CODIGO_BANDA_PRECO_ERP,
	 bdapre61.VDPRDBDA_BANDPREC_8 AS QUANTIDADE ,
	 bdapre61.VDPRDBDA_TAB_X_8 AS CODIGO_TABPRECO_ERP,
	 bdapre61.VDPRDBDA_DESCTO_8 AS DESCONTO_MAXIMO
from 
	 bdapre61
INNER JOIN  tabprc61 ON
	 bdapre61."vdprdbda_fam" =  tabprc61."VDTABPRD_CFAM" AND
	 bdapre61."vdprdbda_prd" =  tabprc61."VDTABPRD_NRO"
INNER JOIN  cadprd61 ON
	 bdapre61."vdprdbda_fam" =  cadprd61."VDPRDPRD_CFAM" AND
	 bdapre61."vdprdbda_prd" =  cadprd61."VDPRDPRD_NRO"
WHERE 
	 cadprd61."vdprdprd_flag" = 'A' and 
	 cadprd61."vdprdprd_disp_portal_web" <> 0 and
	 bdapre61. "vdprdbda_bandprec_8" <> 0  and
	 bdapre61. "vdprdbda_cancsn" = 0  and
 ( bdapre61. "vdprdbda_id" = @CODIGO_BANDA 
                OR @CODIGO_BANDA = 0 ) AND
	LEFT(CAST( tabprc61.VDTABPRD_DTVGF AS VARCHAR(8)),4 )>= LEFT(CAST(Curdate() - 365 AS Char(4)),4)
UNION ALL
select 
     distinct(bdapre61. "vdprdbda_id") as CODIGO_BANDA_PRECO_ERP,
	 bdapre61.VDPRDBDA_BANDPREC_9 AS QUANTIDADE ,
	 bdapre61.VDPRDBDA_TAB_X_9 AS CODIGO_TABPRECO_ERP,
	 bdapre61.VDPRDBDA_DESCTO_9 AS DESCONTO_MAXIMO
from 
	 bdapre61
INNER JOIN  tabprc61 ON
	 bdapre61."vdprdbda_fam" =  tabprc61."VDTABPRD_CFAM" AND
	 bdapre61."vdprdbda_prd" =  tabprc61."VDTABPRD_NRO"
INNER JOIN  cadprd61 ON
	 bdapre61."vdprdbda_fam" =  cadprd61."VDPRDPRD_CFAM" AND
	 bdapre61."vdprdbda_prd" =  cadprd61."VDPRDPRD_NRO"
WHERE 
	 cadprd61."vdprdprd_flag" = 'A' and 
	 cadprd61."vdprdprd_disp_portal_web" <> 0 and
	 bdapre61. "vdprdbda_bandprec_9" <> 0  and
	 bdapre61. "vdprdbda_cancsn" = 0 and
 ( 	bdapre61. "vdprdbda_id" = @CODIGO_BANDA 
                OR @CODIGO_BANDA = 0 ) AND
	LEFT(CAST( tabprc61.VDTABPRD_DTVGF AS VARCHAR(8)),4 )>= LEFT(CAST(Curdate() - 365 AS Char(4)),4)  ;

CREATE or replace VIEW   "VW_BANDA_PRECO_REST" 
AS 
  SELECT 1                                         AS ATIVO, 
         Cast(Cast( bdapre61. "vdprdbda_fam" AS VARCHAR(3)) 
              || Cast( bdapre61. "vdprdbda_prd" AS VARCHAR(3)) 
              || Cast( bdapre61. "vdprdbda_grp" AS VARCHAR(2)) 
              || Cast( bdapre61. "vdprdbda_cat" AS VARCHAR(2)) 
              || Cast( bdapre61. "vdprdbda_mar" AS VARCHAR(2)) 
              || Cast( bdapre61. "vdprdbda_reg" AS VARCHAR(4)) 
              || Cast( bdapre61. "vdprdbda_pst" AS VARCHAR(4)) 
              || Cast( bdapre61. "vdprdbda_grpcli" AS VARCHAR(4)) 
              || Cast( bdapre61. "vdprdbda_ven" AS VARCHAR(3)) 
              || Cast( bdapre61. "vdprdbda_can" AS VARCHAR(2)) 
              || Cast( bdapre61. "vdprdbda_grpcan" AS VARCHAR(2)) 
              || Cast( bdapre61. "vdprdbda_cpg" AS VARCHAR(2)) 
              || Cast( bdapre61. "vdprdbda_grpesc" AS VARCHAR(3)) 
              AS 
              VARCHAR(50))                         AS CODIGO_BANDA_PRECO_ERP, 
          bdapre61. "vdprdbda_ven" AS CODIGO_VENDEDOR_ERP 
  FROM    bdapre61 
  WHERE   bdapre61. "vdprdbda_cancsn" = 0 
         AND  bdapre61. "vdprdbda_ven" <> '   ' ;

declare set varchar(255) @CODIGO_CANAL = '';

CREATE or replace VIEW   "VW_CANAL_VENDA" 
AS 
  SELECT CASE 
           WHEN  ccat61. "vdclicat_cancsn" = 0 THEN 1 
           ELSE 0 
         END                             AS ATIVO, 
          ccat61. "vdclicat_autoserv"    AS AUTO_SERVICO, 
          ccat61. "vdclicat_cod"         AS CODIGO_CANAL, 
          ccat61. "vdclicat_grpcan"      AS CODIGO_GRUPO_CANAL, 
          ccat61. "vdclicat_nome"        AS DESCRICAO, 
          ccat61. "vdclicat_descr_compl" AS DESCRICAO_COMPLEMENTAR, 
          ccat61. "vdclicat_descr_compl" AS DIVISAO_CANAL 
  FROM    ccat61 
  WHERE  (  ccat61. "vdclicat_cod" = @CODIGO_CANAL 
            OR @CODIGO_CANAL = '' );  

			
			
DECLARE SET INT @CODIGO_CATEGORIA_PRODUTO = 0;
CREATE or replace VIEW   "VW_CATEGORIA_PRODUTO" 
AS 
  SELECT  catprd61. "vdprdcat_nr"    AS CODIGO_CATEGORIA_PRODUTO_ERP, 
          catprd61. "vdprdcat_descr" AS DESCRICAO 
  FROM    catprd61 
  WHERE  (  catprd61. "vdprdcat_nr" = @CODIGO_CATEGORIA_PRODUTO 
            OR @CODIGO_CATEGORIA_PRODUTO = 0 ) ;

DECLARE SET INT @NNF = 0;
DECLARE SET CHAR @SNF = ' ';
CREATE OR REPLACE VIEW "VW_CH_NFISCAL"  
AS 
SELECT VDFATNFR_NNF, 
       VDFATNFR_SERIE, 
       VDFATNFR_IDENT_NF 
FROM VDFATN61 
WHERE ((VDFATNFR_NNF = @NNF OR @NNF = 0 )     AND 
       (VDFATNFR_SERIE = @SNF OR @SNF = ' ')) AND 
       (VDFATNFR_DEMI > (DATETOSTR(Curdate() - 45 , 'yyyy/mm/dd')));
       
       
       
DECLARE SET INT @CODIGO_CLIENTE = 0;
CREATE or replace VIEW  "VW_CLIENTE" 
AS 
SELECT 0                                                        AS abate_icms, 
         CASE 
           WHEN  cadcli61. "vdclicli_classe" = 20 THEN 0 
           ELSE 1 
         END                                                      AS ativo, 
         Concat(CASE 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 1 
                THEN Concat('000', Cast( cadcli61. 
                                        "vdclicli_regi" 
                                        AS 
                                        VARCHAR(4)) 
                     ) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 2 
                THEN Concat('00', Cast( cadcli61. "vdclicli_regi" 
                                       AS 
                                       VARCHAR(4))) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 3 
                THEN Concat('0', Cast( cadcli61. "vdclicli_regi" 
                                      AS 
                                      VARCHAR(4))) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 4 
                THEN Cast( cadcli61. "vdclicli_regi" AS VARCHAR(4 
                          )) 
                END, CASE 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 1 
                     THEN Concat('000', Cast( cadcli61. 
                                             "vdclicli_num" AS 
                                             VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 2 
                     THEN Concat('00', Cast( cadcli61. 
                                            "vdclicli_num" AS 
                                            VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 3 
                     THEN Concat('0', Cast( cadcli61. 
                                           "vdclicli_num" AS 
                                           VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 4 
                     THEN Cast( cadcli61. "vdclicli_num" AS 
                               VARCHAR 
                               (4)) 
                     END)                                         AS 
            codigo_cliente_erp, 
         NULL                                                     AS 
            bonus_disponivel, 
          cadcli61. "vdclicli_classe"             AS classe, 
        cast(VDPAROCO_ANOTAB_CARGA as varchar(4)) || case when length(cast(VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then   '0'||cast(VDPAROCO_MESTAB_CARGA as varchar(2)) else cast(VDPAROCO_MESTAB_CARGA as varchar(2)) end || right(cast(cadcli61.vdclicli_tbprd as varchar(8)),2)  AS 
            codigo_tabpreco, 
          cadcli61. "vdclicli_contato"            AS contato, 
          cadcli61. "vdclicli_cgc"                AS cpf_cnpj, 
          cadcli61. "vdclicli_abona_tx_financ"    AS 
            despreza_taxa_financeira, 
         0                                                        AS dia_semana, 
          cadcli61. "vdclicli_dias_entrega"       AS dias_entrega 
         , 
          cadcli61. "vdclicli_email"              AS 
         email, 
          cadcli61. "vdclicli_ignora_banda_preco" AS 
            ignora_banda_preco, 
         NULL                                                     AS 
            inconformidade_cadastro, 
          cadcli61. "vdclicli_credito"            AS 
         limite_credito 
            , 
          cadcli61. "vdclicli_motblo"             AS 
            motivo_bloq_classe_20, 
          cadcli61. "vdclicli_motblo_jur"         AS 
            motivo_bloqueio_juridico, 
          cadcli61. "vdclicli_num"                AS 
         numero_cliente 
            , 
          cadcli61. "vdclicli_codpasta1"          AS 
            pasta, 
          cadcli61. "vdclicli_razao50"            AS razao_social 
         , 
          cadcli61. "vdclicli_regi"               AS 
         regiao_cliente 
            , 
         NULL                                                     AS 
            registro_alterado, 
          cadcli61. "vdclicli_restr_comerciais"   AS 
            restircao_comercial, 
          cadcli61. "vdclicli_sigla"              AS sigla, 
          cadcli61. "vdclicli_subcanal"           AS sub_canal, 
         CASE 
           WHEN Char_length(Cast( cadcli61. "vdclicli_fone" AS 
                                 CHAR 
                                 (12))) 
                = 11 THEN Subblobtochar(Cast( cadcli61. 
                                             "vdclicli_fone" AS 
                                             CHAR(12)), 1, 2) 
           ELSE '0' 
         END                                                      AS 
         telefone_ddd, 
         CASE 
           WHEN Char_length(Cast( cadcli61. "vdclicli_fone" AS 
                                 CHAR 
                                 (12))) 
                <= 9 THEN Cast( cadcli61. "vdclicli_fone" AS CHAR 
                               ( 
                               12)) 
           ELSE 
             CASE 
               WHEN Char_length(Cast( cadcli61. "vdclicli_fone" 
                                     AS 
                                     CHAR(12 
                                     ))) 
                    = 1 THEN '0' 
               ELSE Subblobtochar(Cast( cadcli61. "vdclicli_fone" 
                                       AS CHAR( 
                                       12)), 3, 11 
                    ) 
             END 
         END                                                      AS 
            telefone_tronco, 
          cadcli61. "vdclicli_verba_fin_pro"      AS 
            uso_verba_restrito_produto, 
          cadcli61. "vdclicli_cat"                AS 
            codigo_canal_erp, 
          cadcli61. "vdclicli_cpg"                AS 
            codigo_condicao_pagamento_erp, 
          cadcli61. "vdclicli_tpcobra"            AS 
            codigo_tipo_cobranca_erp ,
		 cadcli61."VDCLICLI_DISP_PORTAL_WEB"  AS disponivel_portal
  FROM    cadcli61 , paroco61
  WHERE cadcli61. "vdclicli_dtult" > cast((DATETOSTR(Curdate() - 90 , 'yyyy/mm/dd')) as int)
        and ( Cast(Concat(CASE 
                             WHEN Length(Cast( cadcli61. 
                                              "vdclicli_regi" 
                                              AS 
                                              CHAR 
                                              (4)) 
                                  ) = 1 
                           THEN Concat('000', Cast( cadcli61. 
                                                   "vdclicli_regi" 
                                                   AS 
                                                   VARCHAR(4)) 
                                ) 
                             WHEN Length(Cast( cadcli61. 
                                              "vdclicli_regi" 
                                              AS 
                                              CHAR 
                                              (4)) 
                                  ) = 2 
                           THEN Concat('00', Cast( cadcli61. 
                                                  "vdclicli_regi" 
                                                  AS 
                                                  VARCHAR(4))) 
                             WHEN Length(Cast( cadcli61. 
                                              "vdclicli_regi" 
                                              AS 
                                              CHAR 
                                              (4)) 
                                  ) = 3 
                           THEN Concat('0', Cast( cadcli61. 
                                                 "vdclicli_regi" AS 
                                                 VARCHAR(4))) 
                             WHEN Length(Cast( cadcli61. 
                                              "vdclicli_regi" 
                                              AS 
                                              CHAR 
                                              (4)) 
                                  ) = 4 
                           THEN Cast( cadcli61. "vdclicli_regi" 
                                     AS 
                                     VARCHAR 
                                     (4) 
                                ) 
                           END, CASE 
                                  WHEN Length(Cast( cadcli61. 
                                                   "vdclicli_num" 
                                                   AS 
                                                   CHAR( 
                                                   4))) = 1 
                                THEN Concat('000', Cast( 
                                      cadcli61. 
                                     "vdclicli_num" AS 
                                     VARCHAR(4))) 
                                  WHEN Length(Cast( cadcli61. 
                                                   "vdclicli_num" 
                                                   AS 
                                                   CHAR( 
                                                   4))) = 2 
                                THEN Concat('00', Cast( cadcli61. 
                                                       "vdclicli_num" 
                                                       AS 
                                                       VARCHAR(4))) 
                                  WHEN Length(Cast( cadcli61. 
                                                   "vdclicli_num" 
                                                   AS 
                                                   CHAR( 
                                                   4))) = 3 
                                THEN Concat('0', Cast( cadcli61. 
                                                      "vdclicli_num" 
                                                      AS 
                                                      VARCHAR(4))) 
                                  WHEN Length(Cast( cadcli61. 
                                                   "vdclicli_num" 
                                                   AS 
                                                   CHAR( 
                                                   4))) = 4 
                                THEN Cast( cadcli61. 
                                          "vdclicli_num" 
                                          AS 
                                          VARCHAR 
                                          ( 
                                          4)) 
                                END) AS INTEGER) = @CODIGO_CLIENTE 
                OR @CODIGO_CLIENTE = 0 ) ;
				
				
		
DECLARE SET varchar(27) @CODIGO_COMBO = '';
CREATE or replace VIEW   "VW_COMBO_PRODUTO" 
AS 
  SELECT  vdprdcbo. "vdprdcbo_qtdcx"   AS QUANTIDADE_CAIXA, 
          vdprdcbo. "vdprdcbo_qtdav"   AS QUANTIDADE_AVULSO, 
          vdprdcbo. "vdprdcbo_codrprd" AS CODIGO_PRODUTO_ERP, 
          vdprdcbo. "vdprdcbo_ocor"    AS CODIGO_OCOR_ERP, 
concat(
concat(concat(repeat('0',3 - length(cast(VDPRDCBO_CODEMP  as varchar(03)))),   cast(VDPRDCBO_CODEMP as varchar(03)))
,
concat(repeat('0',10 - length(cast(VDPRDCBO_CODCBO  as varchar(10)))),         cast(VDPRDCBO_CODCBO as varchar(10)))),
concat(
concat(repeat('0',10 - length(cast(VDPRDCBO_CODRPRD as varchar(10))) ), cast(VDPRDCBO_CODRPRD as varchar(10))),
concat(repeat('0',3 - length(cast(VDPRDCBO_OCOR    as varchar(03))) ),         cast(VDPRDCBO_OCOR as varchar(03)))
)
)		  AS CODIGO_PRODUTO_COMBO_ERP 
  FROM    vdprdcbo 
  WHERE   vdprdcbo. "vdprdcbo_codrprd" <> 0 
         AND 
		 (concat(
concat(concat(repeat('0',3 - length(cast(VDPRDCBO_CODEMP  as varchar(03)))),   cast(VDPRDCBO_CODEMP as varchar(03)))
,
concat(repeat('0',10 - length(cast(VDPRDCBO_CODCBO  as varchar(10)))),         cast(VDPRDCBO_CODCBO as varchar(10)))),
concat(
concat(repeat('0',10 - length(cast(VDPRDCBO_CODRPRD as varchar(10))) ), cast(VDPRDCBO_CODRPRD as varchar(10))),
concat(repeat('0',3 - length(cast(VDPRDCBO_OCOR    as varchar(03))) ),         cast(VDPRDCBO_OCOR as varchar(03)))
)
)	= @CODIGO_COMBO	or  @CODIGO_COMBO = '' );

DECLARE SET INT @codigo_cev  =0;
CREATE or replace VIEW   "VW_COMODATO" 
AS 
  SELECT CASE 
           WHEN Length(Cast( cevped61. "vdcevpen_codcli" AS 
                            VARCHAR 
                            (6))) 
                = 5 THEN Concat('000', Cast( cevped61. 
                                            "vdcevpen_codcli" 
                                            AS VARCHAR(6))) 
           ELSE 
             CASE 
               WHEN Length(Cast( cevped61. "vdcevpen_codcli" AS 
                                VARCHAR(6) 
                           )) = 
                    6 THEN Concat('00', Cast( cevped61. 
                                             "vdcevpen_codcli" 
                                             AS 
                                             VARCHAR(6))) 
               ELSE 
                 CASE 
                   WHEN Length(Cast( cevped61. "vdcevpen_codcli" 
                                    AS 
                                    VARCHAR(6) 
                               )) = 
                        7 THEN Concat('0', Cast( cevped61. 
                                                "vdcevpen_codcli" 
                                                AS 
                                                VARCHAR(6))) 
                 END 
             END 
         END 
            AS CODIGO_CLIENTE_ERP, 
         NULL 
            AS CODIGO_MODELO, 
         NULL 
            AS CODIGO_OCORRENCIA, 
         NULL 
            AS CODIGO_SITUACAO, 
          cevped61. "vdcevpen_dte" 
            AS DATA_CEV, 
         NULL 
            AS DATA_UTILMA_AUDITORIA, 
          cevped61. "vdcevpen_dtv" 
            AS DATA_VENCIMENTO, 
         NULL 
            AS DESCRICAO_MODELO, 
         NULL 
            AS FAZ_INVENTARIO, 
         NULL 
            AS NOME_FABRICANTE, 
         NULL 
            AS NUMERO_ATIVO, 
          cevped61. "vdcevpen_nrccev" 
            AS NUMERO_CEV, 
         NULL 
            AS NUMERO_CEV_ITEM, 
         NULL 
            AS PATRIMONIO_DOIS, 
         (SELECT  cadprd61. "vdprdprd_codr" 
          FROM    cadprd61 
          WHERE   cadprd61. "vdprdprd_cfam" = cast(left(concat(repeat('0', 6 - length(cast(cevped61. "vdcevpen_prod" as varchar(6)))), cast(cevped61. "vdcevpen_prod" as varchar(6))), 3) AS SMALLINT) 
                 AND  cadprd61. "vdprdprd_nro" = 
                     Cast( right(concat(repeat('0', 6 - length(cast(cevped61. "vdcevpen_prod" as varchar(6)))), cast(cevped61. "vdcevpen_prod" as varchar(6))), 3) AS SMALLINT 
                     ) 
         ) 
            AS 
         CODIGO_PRODUTO_ERP, 
          cevped61. "vdcevpen_qtdprd" 
            AS QUANTIDADE, 
         NULL 
            AS TABELA_PRECO_REC_ID, 
         NULL 
            AS TECNOLOGIA_UTILIZADA, 
         NULL 
            AS TIPO_STATUS, 
         NULL 
            AS VALOR_ITEM 
  FROM    cevped61 
  WHERE  (  cevped61. "vdcevpen_nrccev" = @codigo_cev 
            OR @codigo_cev = 0 ) ;
			

DECLARE SET INT @CODIGO_CONDICAO_PAGAMENTO = 0;
CREATE or replace VIEW   "VW_CONDICAO_PAGAMENTO" 
AS 
  SELECT  condpg61. "vdcadpag_ativo"  AS ATIVO, 
          condpg61. "vdcadpag_cod"    AS 
            CODIGO_CONDICAO_PAGAMENTO_ERP, 
          condpg61. "vdcadpag_descr"  AS DESCRICAO, 
         CASE 
           WHEN  condpg61. "vdcadpag_cod" = 1 THEN 1 
           ELSE 0 
         END                                          AS 
         INFORMA_PRIMEIRA_PARCELA, 
          condpg61. "vdcadpag_nrdias" AS NUMERO_DIAS, 
          condpg61. "vdcadpag_prazo"  AS PRAZO 
  FROM    condpg61 
  WHERE  (  condpg61. "vdcadpag_cod" = @CODIGO_CONDICAO_PAGAMENTO 
            OR @CODIGO_CONDICAO_PAGAMENTO = 0 ) ;

declare set int @pasta = 0;

CREATE or replace VIEW  "VW_DIAS_VISITA_VENDEDOR"
AS 
  select 
        numero_pasta as numeroPasta,
 		data_visita  as diaVisita
  from pasta_visita where (numero_pasta = @pasta or @pasta = 0)order by 1;

DECLARE SET INT @CODIGO_CLIENTE = 0;
CREATE or replace VIEW   "VW_ENDERECO" 
AS 
  SELECT 1                                                AS ATIVO, 
          cadcli61. "vdclicli_baifat"     AS BAIRRO, 
          cadcli61. "vdclicli_cepfat"     AS CEP_ENDERECO, 
          cadcli61. "vdclicli_endfat"     AS ENDERECO, 
          cadcli61. "vdclicli_munfat"     AS MUNICIPIO, 
          cadcli61. "vdclicli_endfat_nr"  AS NUMERO, 
         NULL                                             AS PONTO_REFERENCIA, 
          cadcli61. "vdclicli_estfat"     AS UTF_ENDERECO, 
         1                                                AS 
         ORIGEM_LOGRADOURO_ERP 
            , 
         Concat(CASE 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 1 
                THEN Concat('000', Cast( cadcli61. 
                                        "vdclicli_regi" 
                                        AS 
                                        VARCHAR(4)) 
                     ) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 2 
                THEN Concat('00', Cast( cadcli61. "vdclicli_regi" 
                                       AS 
                                       VARCHAR(4))) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 3 
                THEN Concat('0', Cast( cadcli61. "vdclicli_regi" 
                                      AS 
                                      VARCHAR(4))) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 4 
                THEN Cast( cadcli61. "vdclicli_regi" AS VARCHAR(4 
                          )) 
                END, CASE 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 1 
                     THEN Concat('000', Cast( cadcli61. 
                                             "vdclicli_num" AS 
                                             VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 2 
                     THEN Concat('00', Cast( cadcli61. 
                                            "vdclicli_num" AS 
                                            VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 3 
                     THEN Concat('0', Cast( cadcli61. 
                                           "vdclicli_num" AS 
                                           VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 4 
                     THEN Cast( cadcli61. "vdclicli_num" AS 
                               VARCHAR 
                               (4)) 
                     END)                                 AS codigo_cliente_erp, 
          cadcli61. "vdclicli_endfat_tip" AS SIGLA_LOGRADOURO_ERP 
  FROM    cadcli61 
  WHERE    ( Cast(Concat(CASE 
                             WHEN Length(Cast( cadcli61. 
                                              "vdclicli_regi" 
                                              AS 
                                              CHAR 
                                              (4)) 
                                  ) = 1 
                           THEN Concat('000', Cast( cadcli61. 
                                                   "vdclicli_regi" 
                                                   AS 
                                                   VARCHAR(4)) 
                                ) 
                             WHEN Length(Cast( cadcli61. 
                                              "vdclicli_regi" 
                                              AS 
                                              CHAR 
                                              (4)) 
                                  ) = 2 
                           THEN Concat('00', Cast( cadcli61. 
                                                  "vdclicli_regi" 
                                                  AS 
                                                  VARCHAR(4))) 
                             WHEN Length(Cast( cadcli61. 
                                              "vdclicli_regi" 
                                              AS 
                                              CHAR 
                                              (4)) 
                                  ) = 3 
                           THEN Concat('0', Cast( cadcli61. 
                                                 "vdclicli_regi" AS 
                                                 VARCHAR(4))) 
                             WHEN Length(Cast( cadcli61. 
                                              "vdclicli_regi" 
                                              AS 
                                              CHAR 
                                              (4)) 
                                  ) = 4 
                           THEN Cast( cadcli61. "vdclicli_regi" 
                                     AS 
                                     VARCHAR 
                                     (4)) 
                           END, CASE 
                                  WHEN Length(Cast( cadcli61. 
                                                   "vdclicli_num" 
                                                   AS 
                                                   CHAR( 
                                                   4))) = 1 
                                THEN Concat('000', Cast( 
                                      cadcli61. 
                                     "vdclicli_num" AS 
                                     VARCHAR(4))) 
                                  WHEN Length(Cast( cadcli61. 
                                                   "vdclicli_num" 
                                                   AS 
                                                   CHAR( 
                                                   4))) = 2 
                                THEN Concat('00', Cast( cadcli61. 
                                                       "vdclicli_num" 
                                                       AS 
                                                       VARCHAR(4))) 
                                  WHEN Length(Cast( cadcli61. 
                                                   "vdclicli_num" 
                                                   AS 
                                                   CHAR( 
                                                   4))) = 3 
                                THEN Concat('0', Cast( cadcli61. 
                                                      "vdclicli_num" 
                                                      AS 
                                                      VARCHAR(4))) 
                                  WHEN Length(Cast( cadcli61. 
                                                   "vdclicli_num" 
                                                   AS 
                                                   CHAR( 
                                                   4))) = 4 
                                THEN Cast( cadcli61. 
                                          "vdclicli_num" 
                                          AS 
                                          VARCHAR 
                                          ( 
                                          4)) 
                                END) AS INTEGER) = @CODIGO_CLIENTE 
                OR @CODIGO_CLIENTE = 0 ) 
  UNION ALL 
  SELECT 1                                                AS ATIVO, 
          cadcli61. "vdclicli_baicob"     AS BAIRRO, 
          cadcli61. "vdclicli_cepcob"     AS CEP_ENDERECO, 
          cadcli61. "vdclicli_endcob"     AS ENDERECO, 
          cadcli61. "vdclicli_muncob"     AS MUNICIPIO, 
          cadcli61. "vdclicli_endcob_nr"  AS NUMERO, 
         NULL                                             AS 
         PONTO_REFERENCIAENDFAT, 
          cadcli61. "vdclicli_estcob"     AS UTF_ENDERECO, 
         2                                                AS 
         ORIGEM_LOGRADOURO_REC_ID, 
         Concat(CASE 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 1 
                THEN Concat('000', Cast( cadcli61. 
                                        "vdclicli_regi" 
                                        AS 
                                        VARCHAR(4)) 
                     ) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 2 
                THEN Concat('00', Cast( cadcli61. "vdclicli_regi" 
                                       AS 
                                       VARCHAR(4))) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 3 
                THEN Concat('0', Cast( cadcli61. "vdclicli_regi" 
                                      AS 
                                      VARCHAR(4))) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 4 
                THEN Cast( cadcli61. "vdclicli_regi" AS VARCHAR(4 
                          )) 
                END, CASE 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 1 
                     THEN Concat('000', Cast( cadcli61. 
                                             "vdclicli_num" AS 
                                             VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 2 
                     THEN Concat('00', Cast( cadcli61. 
                                            "vdclicli_num" AS 
                                            VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 3 
                     THEN Concat('0', Cast( cadcli61. 
                                           "vdclicli_num" AS 
                                           VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 4 
                     THEN Cast( cadcli61. "vdclicli_num" AS 
                               VARCHAR 
                               (4)) 
                     END)                                 AS codigo_cliente_erp, 
          cadcli61. "vdclicli_endcob_tip" AS 
         SIGLA_LOGRADOURO_REC_ID 
  FROM    cadcli61 
  WHERE    
          ( Cast(Concat(CASE 
                             WHEN Length(Cast( cadcli61. 
                                              "vdclicli_regi" 
                                              AS 
                                              CHAR 
                                              (4)) 
                                  ) = 1 
                           THEN Concat('000', Cast( cadcli61. 
                                                   "vdclicli_regi" 
                                                   AS 
                                                   VARCHAR(4)) 
                                ) 
                             WHEN Length(Cast( cadcli61. 
                                              "vdclicli_regi" 
                                              AS 
                                              CHAR 
                                              (4)) 
                                  ) = 2 
                           THEN Concat('00', Cast( cadcli61. 
                                                  "vdclicli_regi" 
                                                  AS 
                                                  VARCHAR(4))) 
                             WHEN Length(Cast( cadcli61. 
                                              "vdclicli_regi" 
                                              AS 
                                              CHAR 
                                              (4)) 
                                  ) = 3 
                           THEN Concat('0', Cast( cadcli61. 
                                                 "vdclicli_regi" AS 
                                                 VARCHAR(4))) 
                             WHEN Length(Cast( cadcli61. 
                                              "vdclicli_regi" 
                                              AS 
                                              CHAR 
                                              (4)) 
                                  ) = 4 
                           THEN Cast( cadcli61. "vdclicli_regi" 
                                     AS 
                                     VARCHAR 
                                     (4)) 
                           END, CASE 
                                  WHEN Length(Cast( cadcli61. 
                                                   "vdclicli_num" 
                                                   AS 
                                                   CHAR( 
                                                   4))) = 1 
                                THEN Concat('000', Cast( 
                                      cadcli61. 
                                     "vdclicli_num" AS 
                                     VARCHAR(4))) 
                                  WHEN Length(Cast( cadcli61. 
                                                   "vdclicli_num" 
                                                   AS 
                                                   CHAR( 
                                                   4))) = 2 
                                THEN Concat('00', Cast( cadcli61. 
                                                       "vdclicli_num" 
                                                       AS 
                                                       VARCHAR(4))) 
                                  WHEN Length(Cast( cadcli61. 
                                                   "vdclicli_num" 
                                                   AS 
                                                   CHAR( 
                                                   4))) = 3 
                                THEN Concat('0', Cast( cadcli61. 
                                                      "vdclicli_num" 
                                                      AS 
                                                      VARCHAR(4))) 
                                  WHEN Length(Cast( cadcli61. 
                                                   "vdclicli_num" 
                                                   AS 
                                                   CHAR( 
                                                   4))) = 4 
                                THEN Cast( cadcli61. 
                                          "vdclicli_num" 
                                          AS 
                                          VARCHAR 
                                          ( 
                                          4)) 
                                END) AS INTEGER) = @CODIGO_CLIENTE 
                OR @CODIGO_CLIENTE = 0 ) 
  UNION ALL 
  SELECT 1                                                AS ATIVO, 
          cadcli61. "vdclicli_baient"     AS BAIRRO, 
          cadcli61. "vdclicli_cepent"     AS CEP_ENDERECO, 
          cadcli61. "vdclicli_endent"     AS ENDERECO, 
          cadcli61. "vdclicli_munent"     AS MUNICIPIO, 
          cadcli61. "vdclicli_endent_nr"  AS NUMERO, 
         NULL                                             AS 
         PONTO_REFERENCIAENDFAT, 
          cadcli61. "vdclicli_estent"     AS UTF_ENDERECO, 
         3                                                AS 
         ORIGEM_LOGRADOURO_REC_ID, 
         Concat(CASE 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 1 
                THEN Concat('000', Cast( cadcli61. 
                                        "vdclicli_regi" 
                                        AS 
                                        VARCHAR(4)) 
                     ) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 2 
                THEN Concat('00', Cast( cadcli61. "vdclicli_regi" 
                                       AS 
                                       VARCHAR(4))) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 3 
                THEN Concat('0', Cast( cadcli61. "vdclicli_regi" 
                                      AS 
                                      VARCHAR(4))) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 4 
                THEN Cast( cadcli61. "vdclicli_regi" AS VARCHAR(4 
                          )) 
                END, CASE 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 1 
                     THEN Concat('000', Cast( cadcli61. 
                                             "vdclicli_num" AS 
                                             VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 2 
                     THEN Concat('00', Cast( cadcli61. 
                                            "vdclicli_num" AS 
                                            VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 3 
                     THEN Concat('0', Cast( cadcli61. 
                                           "vdclicli_num" AS 
                                           VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 4 
                     THEN Cast( cadcli61. "vdclicli_num" AS 
                               VARCHAR 
                               (4)) 
                     END)                                 AS codigo_cliente_erp, 
          cadcli61. "vdclicli_endent_tip" AS 
         SIGLA_LOGRADOURO_REC_ID 
  FROM    cadcli61 
WHERE     ( Cast(Concat(CASE 
                             WHEN Length(Cast( cadcli61. 
                                              "vdclicli_regi" 
                                              AS 
                                              CHAR 
                                              (4)) 
                                  ) = 1 
                           THEN Concat('000', Cast( cadcli61. 
                                                   "vdclicli_regi" 
                                                   AS 
                                                   VARCHAR(4)) 
                                ) 
                             WHEN Length(Cast( cadcli61. 
                                              "vdclicli_regi" 
                                              AS 
                                              CHAR 
                                              (4)) 
                                  ) = 2 
                           THEN Concat('00', Cast( cadcli61. 
                                                  "vdclicli_regi" 
                                                  AS 
                                                  VARCHAR(4))) 
                             WHEN Length(Cast( cadcli61. 
                                              "vdclicli_regi" 
                                              AS 
                                              CHAR 
                                              (4)) 
                                  ) = 3 
                           THEN Concat('0', Cast( cadcli61. 
                                                 "vdclicli_regi" AS 
                                                 VARCHAR(4))) 
                             WHEN Length(Cast( cadcli61. 
                                              "vdclicli_regi" 
                                              AS 
                                              CHAR 
                                              (4)) 
                                  ) = 4 
                           THEN Cast( cadcli61. "vdclicli_regi" 
                                     AS 
                                     VARCHAR 
                                     (4)) 
                           END, CASE 
                                  WHEN Length(Cast( cadcli61. 
                                                   "vdclicli_num" 
                                                   AS 
                                                   CHAR( 
                                                   4))) = 1 
                                THEN Concat('000', Cast( 
                                      cadcli61. 
                                     "vdclicli_num" AS 
                                     VARCHAR(4))) 
                                  WHEN Length(Cast( cadcli61. 
                                                   "vdclicli_num" 
                                                   AS 
                                                   CHAR( 
                                                   4))) = 2 
                                THEN Concat('00', Cast( cadcli61. 
                                                       "vdclicli_num" 
                                                       AS 
                                                       VARCHAR(4))) 
                                  WHEN Length(Cast( cadcli61. 
                                                   "vdclicli_num" 
                                                   AS 
                                                   CHAR( 
                                                   4))) = 3 
                                THEN Concat('0', Cast( cadcli61. 
                                                      "vdclicli_num" 
                                                      AS 
                                                      VARCHAR(4))) 
                                  WHEN Length(Cast( cadcli61. 
                                                   "vdclicli_num" 
                                                   AS 
                                                   CHAR( 
                                                   4))) = 4 
                                THEN Cast( cadcli61. 
                                          "vdclicli_num" 
                                          AS 
                                          VARCHAR 
                                          ( 
                                          4)) 
                                END) AS INTEGER) = @CODIGO_CLIENTE 
                OR @CODIGO_CLIENTE = 0 ) ;

DECLARE SET INT @CODIGO_FAMILIA = 0;
CREATE or replace VIEW   "VW_FAMILIA_PRODUTO" 
AS 
  SELECT  cadfam61. "vdprdfam_fameb" AS CODIGO_FAMEB, 
          cadfam61. "vdprdfam_cod"   AS 
         CODIGO_FAMILIA_PRODUTO_ERP, 
          cadfam61. "vdprdfam_nome"  AS DESCRICAO 
  FROM    cadfam61 
  WHERE  (  cadfam61. "vdprdfam_cod" = @CODIGO_FAMILIA 
            OR @CODIGO_FAMILIA = 0 ) ;

DECLARE SET INT @CODIGO_GRUPO_PRODUTO = 0;
CREATE or replace VIEW   "VW_GRUPO_PRODUTO" 
AS 
  SELECT  grpprd61. "vdprdgrp_grupo" AS CODIGO_GRUPO_PRODUTO_ERP, 
          grpprd61. "vdprdgrp_descr" AS DESCRICAO 
  FROM    grpprd61 
  WHERE  (  grpprd61. "vdprdgrp_grupo" = @CODIGO_GRUPO_PRODUTO 
            OR @CODIGO_GRUPO_PRODUTO = 0 ) ;

DECLARE SET VARCHAR(255) @numero_pedido ='';
CREATE or replace VIEW  "VW_HISTORICO_PEDIDO_CAPA" 
AS 
  SELECT CASE 
           WHEN  pedcp61. "vdpedcpe_fl" = 9 THEN 0 
           ELSE 1 
         END                                               AS ATIVO, 
          pedcp61. "vdpedcpe_motdev"       AS 
            CODIGO_MOTIVO_DEVOLUCAO, 
          pedcp61. "vdpedcpe_dtemiped"     AS 
            DATA_HORA_EMISSAO_PEDIDO, 
          pedcp61. "vdpedcpe_dt1vc"        AS DATA_VENCIMENTO, 
          pedcp61. "vdpedcpe_descfi"       AS DESCONTO_FINANCEIRO 
         , 
          pedcp61. "vdpedcpe_nped"         AS 
         NUMERO_PEDIDO, 
          pedcp61. "vdpedcpe_desc"         AS PERCENTUAL_DESCONTO 
         , 
         CASE 
           WHEN  pedcp61. "vdpedcpe_fl" = 9 THEN 'CA' 
           ELSE 
             CASE 
               WHEN  pedcp61. "vdpedcpe_vlr_fcem_r" 
                    +  pedcp61. "vdpedcpe_vlr_fsem_r" 
                    +  pedcp61. "vdpedcpe_vlr_fctr_r" 
                    +  pedcp61. "vdpedcpe_vlr_fstr_r" = 0 THEN 
               'DV' 
               ELSE '0' 
             END 
         END                                               AS STATUS_PEDIDO, 
          pedcp61. "vdpedcpe_txfin"        AS TAXA_FINANCEIRO, 
          pedcp61. "vdpedcpe_vlr_fcem_r" 
         +  pedcp61. "vdpedcpe_vlr_fsem_r" 
         +  pedcp61. "vdpedcpe_vlr_fctr_r" 
         +  pedcp61. "vdpedcpe_vlr_fstr_r" AS VALOR_DEVOLUCAO, 
          pedcp61. "vdpedcpe_vlr_fcem" 
         +  pedcp61. "vdpedcpe_vlr_fsem" 
         +  pedcp61. "vdpedcpe_vlr_fctr" 
         +  pedcp61. "vdpedcpe_vlr_fstr"   AS VALOR_PEDIDO, 
         CASE 
           WHEN Length(Cast( pedcp61. "vdpedcpe_codcli" AS CHAR(8 
                            )) 
                ) = 5 
         THEN Concat('000', Cast( pedcp61. "vdpedcpe_codcli" AS 
                                 VARCHAR(8) 
                            )) 
           WHEN Length(Cast( pedcp61. "vdpedcpe_codcli" AS CHAR(8 
                            )) 
                ) = 6 
         THEN Concat('00', Cast( pedcp61. "vdpedcpe_codcli" AS 
                                VARCHAR(8)) 
              ) 
           WHEN Length(Cast( pedcp61. "vdpedcpe_codcli" AS CHAR(8 
                            )) 
                ) = 7 
         THEN Concat('0', Cast( pedcp61. "vdpedcpe_codcli" AS 
                               VARCHAR(4))) 
           WHEN Length(Cast( pedcp61. "vdpedcpe_codcli" AS CHAR(8 
                            )) 
                ) = 8 
         THEN Cast( pedcp61. "vdpedcpe_codcli" AS VARCHAR(8)) 
         END                                               AS 
            CODIGO_CLIENTE_REC_ID, 
          pedcp61. "vdpedcpe_cpg"          AS 
            CODIGO_CONDICAO_PAGAMENTO_REC_ID, 
          pedcp61. "vdpedcpe_tpcobr"       AS 
            CODIGO_TIPO_COBRANCA_REC_ID , 
			CADCLI61.VDCLICLI_CGC as CNPJ_CPF,
			CADCLI61.VDCLICLI_RAZAO50 AS RAZAO_CLIENTE,
			condpg01.VDCADPAG_DESCR AS DESCRICAO_CONDICAO_PAGAMENTO,
			tpcobr01. "vdcadtco_descricao"	AS DESCRICAO_TIPO_COBRANCA,
      VDPEDCPE_SERIE    AS SFISCAL,
      VDPEDCPE_NFIS     AS NFISCAL_INI,
      VDPEDCPE_NFISULT  AS NFISCAL_ULT 
     		
  FROM    pedcp61 
  
  inner join CADCLI61
on 
CADCLI61.VDCLICLI_REGI = cast(substring(concat(repeat('0', 8 - length(cast(vdpedcpe_codcli as varchar(08)))), cast(vdpedcpe_codcli as varchar(08))),1,4) as int ) and 
CADCLI61.VDCLICLI_NUM = cast(substring(concat(repeat('0', 8 - length(cast(vdpedcpe_codcli as varchar(08)))), cast(vdpedcpe_codcli as varchar(08))),5,4) as int )
inner join condpg01 on
	condpg01. "vdcadpag_cod" = vdpedcpe_cpg
inner join tpcobr01 
     on VDPEDCPE_TPCOBR = tpcobr01.VDCADTCO_COD
  
  
  WHERE  ( Cast( pedcp61. "vdpedcpe_nped" AS VARCHAR(12)) = 
           @numero_pedido 
            OR @numero_pedido = '' ) 
         AND  pedcp61. "vdpedcpe_nped" >= cast(trim (DATETOSTR(Curdate() - 45 , 'yyyymmdd')) || '0000'  as bigint);
DECLARE SET VARCHAR(255) @NUMERO_PEDIDO = '';
CREATE or replace VIEW   "VW_HISTORICO_PEDIDO_ITEM" 
AS 
 SELECT   pedit61. "vdpedipe_item"    AS NUMERO_ITEM_PEDIDO, 
          pedit61. "vdpedipe_preprdt" AS PRECO_ITEM_TOTAL, 
          pedit61. "vdpedipe_qtdret"  AS QUANTIDADE_AVULSA, 
          pedit61. "vdpedipe_qtdprd"  AS QUANTIDADE_CAIXA, 
          pedit61. "vdpedipe_nit"     AS NUMERO_PEDIDO_REC_ID, 
          pedit61. "vdpedipe_ocokd"   AS CODIGO_OCORRENCIA_REC_ID , 
          pedit61. "vdpedipe_tbprd"   AS CODIGO_TABELA_PRECO_REC_ID     , 
          pedit61. "vdpedipe_codr"    AS CODIGO_PRODUTO_REC_ID ,
		  cadprd61."VDPRDPRD_DESCR"   AS DESCRICAO_PRODUTO ,
		  CADOCO61."VDNOPOCO_NOME "   AS DESCRICAO_OCORRENCIA
  FROM    VW_HISTORICO_PEDIDO_CAPA
          INNER JOIN pedit61 ON numero_pedido = pedit61. "vdpedipe_nit" 
          INNER JOIN cadprd61 ON cadprd61."VDPRDPRD_CODR"  = pedit61."VDPEDIPE_CODR" 
	        INNER JOIN CADOCO61 ON CAST(CADOCO61.VDNOPOCO_COD AS INT) = pedit61. "VDPEDIPE_OCOKD"               		  
  WHERE  ( Cast( pedit61. "vdpedipe_nit" AS VARCHAR(12)) = 
               @numero_pedido 
                OR @numero_pedido = '' ) ;

declare set bigint @cod_pre_pedido = 0;
DECLARE SET INT @codemp = 0;

CREATE or replace VIEW  "VW_ITEM_CORTADO_PRE_PEDIDO" 
AS 
  select 
	vdpedipp_pre_ped as PRE_PEDIDO,
	vdpedipp_item as ITEM,
	vdpedipp_codr as CODIGO_PRODUTO_ERP,
	vdpedipp_qtd  as QTD_PRODUTO,
	vdpedipp_qtds as QTDS_PRODUTO,
	'SEM ESTOQUE' as MOTIVO
  from vdpedipp where vdpedipp_nremp = @codemp AND (vdpedipp_pre_ped = @cod_pre_pedido or @cod_pre_pedido = 0) AND 
                      vdpedipp_sem_estoq = 'S';

DECLARE SET INT @CODIGO_MARCA_PRODUTO = 0;
CREATE or replace VIEW   "VW_MARCA_PRODUTO" 
AS 
  SELECT  marprd61. "vdprdmar_marca" AS CODIGO_MARCA_PRODUTO_ERP, 
          marprd61. "vdprdmar_descr" AS DESCRICAO 
  FROM    marprd61 
  WHERE  (  marprd61. "vdprdmar_marca" = @CODIGO_MARCA_PRODUTO 
            OR @CODIGO_MARCA_PRODUTO = 0 ) ;

CREATE or replace VIEW   "VW_MOTIVO_GERAL" 
AS 
  SELECT 1                                                          AS ativo, 
         Cast( bnftip61. "vdpedbnf_cod" AS CHAR(3)) AS 
            codigo_motivo_geral, 
          bnftip61. "vdpedbnf_descricao"            AS descricao, 
         NULL                                                       AS 
            descricao_reduzida, 
         0                                                          AS 
         infui_venda 
            , 
          bnftip61. "vdpedbnf_influi_verba"         AS 
            permite_venda, 
         '01'                                                       AS 
            tipo_motivo_geral_rec_id 
  FROM    bnftip61 
  WHERE   bnftip61. "vdpedbnf_cancsn" = 0 
         AND  bnftip61. "vdpedbnf_carrega_palm" = 1 
  UNION ALL 
  SELECT 1                                             AS ativo, 
          tbtroca. "vdcadtro_cod"      AS codigo_motivo_geral, 
          tbtroca. "vdcadtro_descr"    AS descricao, 
          tbtroca. "vdcadtro_descrred" AS descricao_reduzida, 
         0                                             AS infui_venda, 
         0                                             AS permite_venda, 
         CASE 
           WHEN  tbtroca. "vdcadtro_tipo" = 1 THEN '02' 
           ELSE '03' 
         END                                           AS 
         tipo_motivo_geral_rec_id 
  FROM    tbtroca 
  WHERE   tbtroca. "vdcadtro_cancsn" = 0 
  UNION ALL 
  SELECT 1                                          AS ativo, 
          tipcev61. "vdcevtip_cod"  AS codigo_motivo_geral, 
          tipcev61. "vdcevtip_nome" AS descricao, 
         NULL                                       AS descricao_reduzida, 
         0                                          AS infui_venda, 
         0                                          AS permite_venda, 
         CASE 
           WHEN  tipcev61. "vdcevtip_operacao" = 1 THEN '04' 
           ELSE 
             CASE 
               WHEN  tipcev61. "vdcevtip_operacao" = 3 THEN '03' 
               ELSE '05' 
             END 
         END                                        AS tipo_motivo_geral_rec_id 
  FROM    tipcev61 
  UNION ALL 
  SELECT 1                                              AS ativo, 
          tbblocli. "vdcadblo_cod"      AS codigo_motivo_geral, 
          tbblocli. "vdcadblo_descr"    AS descricao, 
          tbblocli. "vdcadblo_descrred" AS descricao_reduzida, 
          tbblocli. "vdcadblo_venda"    AS infui_venda, 
         0                                              AS permite_venda, 
         '06'                                           AS 
         tipo_motivo_geral_rec_id 
  FROM    tbblocli 
  UNION ALL 
  SELECT 1                                                          AS ativo, 
         Cast( motcanpd. "vdcadmdc_cod" AS CHAR(3)) AS 
         codigo_motivo_geral, 
          motcanpd. "vdcadmdc_descr"                AS descricao, 
          motcanpd. "vdcadmdc_descrred"             AS 
         descricao_reduzida, 
         0                                                          AS 
         infui_venda 
         , 
         0                                                          AS 
         permite_venda, 
         '08'                                                       AS 
         tipo_motivo_geral_rec_id 
  FROM    motcanpd 
  UNION ALL 
  SELECT 1                                             AS ativo, 
          tbdevol. "vdcaddev_cod"      AS codigo_motivo_geral, 
          tbdevol. "vdcaddev_descr"    AS descricao, 
          tbdevol. "vdcaddev_descrred" AS descricao_reduzida, 
         0                                             AS infui_venda, 
         0                                             AS permite_venda, 
         '09'                                          AS 
         tipo_motivo_geral_rec_id 
  FROM    tbdevol 
  WHERE   tbdevol. "vdcaddev_cancsn" = 0 
  UNION ALL 
  SELECT 1                                            AS ativo, 
          tbncol. "vdcadnco_cod"      AS codigo_motivo_geral, 
          tbncol. "vdcadnco_descr"    AS descricao, 
          tbncol. "vdcadnco_descrred" AS descricao_reduzida, 
         0                                            AS infui_venda, 
         0                                            AS permite_venda, 
         '10'                                         AS 
         tipo_motivo_geral_rec_id 
  FROM    tbncol 
  UNION ALL 
  SELECT 1                                            AS ativo, 
          tbncol. "vdcadnco_cod"      AS codigo_motivo_geral, 
          tbncol. "vdcadnco_descr"    AS descricao, 
          tbncol. "vdcadnco_descrred" AS descricao_reduzida, 
         0                                            AS infui_venda, 
         0                                            AS permite_venda, 
         '18'                                         AS 
         tipo_motivo_geral_rec_id 
  FROM    tbncol 
  WHERE   tbncol. "vdcadnco_cod" = 'I' 
          OR  tbncol. "vdcadnco_cod" = 'F' 
          OR  tbncol. "vdcadnco_cod" = 'N' 
  UNION ALL 
  SELECT 1                                                          AS ativo, 
         Cast( tabblq61. "vdcadbpd_cod" AS CHAR(3)) AS 
         codigo_motivo_geral, 
          tabblq61. "vdcadbpd_descr"                AS descricao, 
          tabblq61. "vdcadbpd_descr"                AS 
         descricao_reduzida, 
         0                                                          AS 
         infui_venda 
         , 
         0                                                          AS 
         permite_venda, 
         '99'                                                       AS 
         tipo_motivo_geral_rec_id 
  FROM    tabblq61 
  WHERE   tabblq61. "vdcadbpd_cancsn" = 0 ;

DECLARE SET INT @DATA_OPERACAO = 0;
CREATE or replace VIEW   "VW_MOVIMENTO_FINANCEIRO" 
AS 
  SELECT CASE 
           WHEN Length(Cast( chdepo61. "crchqdep_codcli" AS 
                            VARCHAR 
                            (10))) 
                = 5 THEN Concat('000', Cast( chdepo61. 
                                            "crchqdep_codcli" 
                                            AS VARCHAR(10))) 
           ELSE 
             CASE 
               WHEN Length(Cast( chdepo61. "crchqdep_codcli" AS 
                                VARCHAR(10))) 
                    = 6 THEN Concat('00', Cast( chdepo61. 
                                               "crchqdep_codcli" AS 
                                               VARCHAR(10))) 
               ELSE 
                 CASE 
                   WHEN Length(Cast( chdepo61. "crchqdep_codcli" 
                                    AS 
                                    VARCHAR(10))) 
                        = 7 THEN Concat('0', Cast( chdepo61. 
                                                  "crchqdep_codcli" 
                                                  AS 
                                                  VARCHAR(10))) 
                   ELSE 
                     CASE 
                       WHEN Length(Cast( chdepo61. 
                                        "crchqdep_codcli" AS 
                                        VARCHAR(10))) 
                            = 8 THEN Cast( chdepo61. 
                                          "crchqdep_codcli" AS 
                                          VARCHAR( 
                                          10)) 
                     END 
                 END 
             END 
         END                                                              AS 
            CODIGO_CLIENTE_ERP, 
         NULL                                                             AS 
            CODIGO_PRODUTO_ERP, 
         CASE 
           WHEN  chdepo61. "crchqdep_dtv" >= Cast( 
                Replace(Cast(Curdate() AS 
                VARCHAR(10)), '-', '') AS INT) THEN 
            chdepo61. "crchqdep_dte" 
           ELSE  chdepo61. "crchqdep_dtv" 
         END                                                              AS 
            DATA_OPERACAO, 
          chdepo61. "crchqdep_dtv"                        AS 
            DATA_VENCIMENTO, 
         CASE 
           WHEN  chdepo61. "crchqdep_dte" = 
                 chdepo61. "crchqdep_dtv" THEN 1 
           ELSE 2 
         END                                                              AS MOD 
         , 
         Cast( chdepo61. "crchqdep_ndoc" AS 
              VARCHAR(255)) AS 
         NUMERO_DOCUMENTO, 
         CASE 
           WHEN  chdepo61. "crchqdep_dtv" >= Cast( 
                Replace(Cast(Curdate() AS 
                VARCHAR(10)), '-', '') AS INT) THEN '1' 
           ELSE '2' 
         END                                                              AS 
            TIPO_REGISTRO, 
          chdepo61. "crchqdep_nped"                       AS 
            NUMERO_PEDIDO, 
          chdepo61. "crchqdep_vldoc"                      AS 
         VALOR 
  FROM    chdepo61 
  WHERE   chdepo61. "crchqdep_dtv" >= Cast( 
                Replace(Cast(Curdate() AS 
                VARCHAR(10)), '-', '') AS INT) 
         AND (  chdepo61. "crchqdep_dte" = @DATA_OPERACAO 
                OR @DATA_OPERACAO = 0 ) 
  UNION ALL 
  SELECT CASE 
           WHEN Length(Cast( chdev61. "crchqdev_ccli" AS 
                            VARCHAR(10))) = 5 
         THEN Concat('000', Cast( chdev61. "crchqdev_ccli" AS 
                                 VARCHAR(10)) 
              ) 
           ELSE 
             CASE 
               WHEN Length(Cast( chdev61. "crchqdev_ccli" AS 
                                VARCHAR(10))) 
                    = 6 
             THEN Concat('00', Cast( chdev61. "crchqdev_ccli" AS 
                                    VARCHAR( 
                                    10))) 
               ELSE 
                 CASE 
                   WHEN Length(Cast( chdev61. "crchqdev_ccli" AS 
                                    VARCHAR( 
                                    10))) 
                        = 7 
                 THEN Concat('0', Cast( chdev61. "crchqdev_ccli" 
                                       AS 
                                       VARCHAR(10))) 
                   ELSE 
                     CASE 
                       WHEN Length(Cast( chdev61. "crchqdev_ccli" 
                                        AS 
                                        VARCHAR( 
                                        10))) 
                            = 8 
                     THEN Cast( chdev61. "crchqdev_ccli" AS 
                               VARCHAR 
                               (10)) 
                     END 
                 END 
             END 
         END                                        AS CODIGO_CLIENTE_ERP, 
         NULL                                       AS CODIGO_PRODUTO, 
         CASE 
           WHEN  chdev61. "crchqdev_dtqui" > 0 THEN 
            chdev61. "crchqdev_dtqui" 
           ELSE 0 
         END                                        AS DATA_OPERACAO, 
          chdev61. "crchqdev_dtvto" AS DATA_VENCIMENTO, 
         0                                          AS MOD, 
          chdev61. "crchqdev_nchq"  AS NUMERO_DOCUMENTO, 
         '3'                                        AS TIPO_REGISTRO, 
          chdev61. "crchqdev_nped"  AS NUMERO_PEDIDO, 
          chdev61. "crchqdev_vlori" AS VALOR 
  FROM    chdev61 
  WHERE   chdev61. "crchqdev_dtqui" = 0 
         AND  chdev61. "crchqdev_dtemi" >= Cast( 
             Replace(Cast(Curdate() - 45 AS 
                          VARCHAR(10)), '-', '') AS INT) 
         AND (  chdev61. "crchqdev_dtqui" = @DATA_OPERACAO 
                OR @DATA_OPERACAO = 0 ) 
  UNION ALL 
  SELECT CASE 
           WHEN Length(Cast( cadbai61. "crmovbai_ccli" AS VARCHAR 
                            ( 
                            10))) = 
                5 THEN Concat('000', Cast( cadbai61. 
                                          "crmovbai_ccli" AS 
                                          VARCHAR(10))) 
           ELSE 
             CASE 
               WHEN Length(Cast( cadbai61. "crmovbai_ccli" AS 
                                VARCHAR(10)) 
                    ) = 
                    6 THEN Concat('00', Cast( cadbai61. 
                                             "crmovbai_ccli" AS 
                                             VARCHAR(10))) 
               ELSE 
                 CASE 
                   WHEN Length(Cast( cadbai61. "crmovbai_ccli" AS 
                                    VARCHAR( 
                                    10)) 
                        ) = 
                        7 THEN Concat('0', Cast( cadbai61. 
                                                "crmovbai_ccli" 
                                                AS 
                                                VARCHAR(10))) 
                   ELSE 
                     CASE 
                       WHEN Length(Cast( cadbai61. 
                                        "crmovbai_ccli" 
                                        AS 
                                        VARCHAR( 
                                        10)) 
                            ) = 
                            8 THEN Cast( cadbai61. 
                                        "crmovbai_ccli" 
                                        AS 
                                        VARCHAR( 
                                        10)) 
                     END 
                 END 
             END 
         END                                         AS CODIGO_CLIENTE_ERP, 
         NULL                                        AS CODIGO_PRODUTO, 
          cadbai61. "crmovbai_dtp"   AS DATA_OPERACAO, 
          cadbai61. "crmovbai_dtv"   AS DATA_VENCIMENTO, 
          cadbai61. "crmovbai_mod"   AS MOD, 
          cadbai61. "crmovbai_ndupl" AS NUMERO_DOCUMENTO, 
         '2'                                         AS TIPO_REGISTRO, 
          cadbai61. "crmovbai_nped"  AS NUMERO_PEDIDO, 
          cadbai61. "crmovbai_valor" AS VALOR 
  FROM    cadbai61 
  WHERE   cadbai61. "crmovbai_dtp" >= Cast( 
                Replace(Cast(Curdate() - 45 AS 
                VARCHAR(10)), '-', '') AS INT) 
         AND (  cadbai61. "crmovbai_dtv" = @DATA_OPERACAO 
                OR @DATA_OPERACAO = 0 ) 
  UNION ALL 
  SELECT CASE 
           WHEN Length(Cast( cadmov61. "crmovmov_ccli" AS VARCHAR 
                            ( 
                            10))) = 
                5 THEN Concat('000', Cast( cadmov61. 
                                          "crmovmov_ccli" AS 
                                          VARCHAR(10))) 
           ELSE 
             CASE 
               WHEN Length(Cast( cadmov61. "crmovmov_ccli" AS 
                                VARCHAR(10)) 
                    ) = 
                    6 THEN Concat('00', Cast( cadmov61. 
                                             "crmovmov_ccli" AS 
                                             VARCHAR(10))) 
               ELSE 
                 CASE 
                   WHEN Length(Cast( cadmov61. "crmovmov_ccli" AS 
                                    VARCHAR( 
                                    10)) 
                        ) = 
                        7 THEN Concat('0', Cast( cadmov61. 
                                                "crmovmov_ccli" 
                                                AS 
                                                VARCHAR(10))) 
                   ELSE 
                     CASE 
                       WHEN Length(Cast( cadmov61. 
                                        "crmovmov_ccli" 
                                        AS 
                                        VARCHAR( 
                                        10)) 
                            ) = 
                            8 THEN Cast( cadmov61. 
                                        "crmovmov_ccli" 
                                        AS 
                                        VARCHAR( 
                                        10)) 
                     END 
                 END 
             END 
         END                                         AS CODIGO_CLIENTE_ERP, 
         NULL                                        AS CODIGO_PRODUTO, 
          cadmov61. "crmovmov_dte"   AS DATA_OPERACAO, 
          cadmov61. "crmovmov_dtv"   AS DATA_VENCIMENTO, 
          cadmov61. "crmovmov_mod"   AS MOD, 
          cadmov61. "crmovmov_ndupl" AS NUMERO_DOCUMENTO, 
          '1'                        AS TIPO_REGISTRO, 
          cadmov61. "crmovmov_nped"  AS NUMERO_PEDIDO, 
          cadmov61. "crmovmov_valor" AS VALOR 
  FROM    cadmov61 
  WHERE  (  cadmov61. "crmovmov_dte" = @DATA_OPERACAO 
            OR @DATA_OPERACAO = 0 ) 
  ORDER  BY 3 ;

DECLARE SET VARCHAR(255) @CODIGO_OCORRENCIA ='';
CREATE or replace VIEW   "VW_OCORRENCIA" 
AS 
  SELECT CASE 
           WHEN  cadoco61. "vdnopoco_cancsn" = 0 THEN 1 
           ELSE 0 
         END 
            AS ATIVO, 
          cadoco61. "vdnopoco_cod" 
            AS CODIGO_OCORRENCIA_ERP, 
          cadoco61. "vdnopoco_nome" 
            AS DESCRICAO, 
          cadoco61. "vdnopoco_nomer" 
            AS DESCRICAO_REDUZIDA, 
          cadoco61. "vdnopoco_desdobro" 
            AS DESDOBRO, 
         NULL 
            AS EMPRESA, 
         CASE 
           WHEN  cadoco61. "vdnopoco_totven" = 'S' THEN 1 
           ELSE 0 
         END 
            AS GERA_MOTIVO_FINANC, 
         1 
            AS OCORR_DISP_PORTAL, 
          cadoco61. "vdnopoco_sinal" 
            AS SINAL, 
          cadoco61. "vdnopoco_tipo" 
            AS TIPO, 
          cadoco61. "vdnopoco_tpprd" 
            AS TIPO_PRODUTO, 
         Concat('0', Cast( cadoco61. "vdnopoco_tipooco" AS 
                          VARCHAR( 
                          2))) AS 
         CODIGO_TIPO_OCORRENCIA_ERP, 
          vdnoot61. "vdnopotp_natop" 
            AS NATUREZA_OPERACAO 
  FROM    cadoco61 
         INNER JOIN  vdnoot61 
                 ON  vdnoot61. "vdnopotp_oco" = Cast( 
                     cadoco61. "vdnopoco_cod" AS SMALLINT) 
  WHERE   cadoco61. "vdnopoco_tipooco" = 1 
         AND  cadoco61. "vdnopoco_cod" = '001' 
         AND  vdnoot61. "vdnopotp_tipo_prod" = 'P' 
         AND (  cadoco61. "vdnopoco_cod" = @CODIGO_OCORRENCIA 
                OR @CODIGO_OCORRENCIA = '' ) ;

DECLARE SET SMALLINT @CODIGO_EMPRESA = 0;
CREATE or replace VIEW  "VW_PAROCO" 
AS 
    SELECT 
         VDPAROCO_CODEMP               AS CODIGO_EMPRESA,
         VDPAROCO_OCOKD_BIMOB_CL       AS OCORRENCIA_BIMOB_CL,
         VDPAROCO_OCOKD_BIMOB_SL       AS OCORRENCIA_BIMOB_SL,
         VDPAROCO_OCVDVAS              AS OCORRENCIA_VENDA_VASILHAME,
         VDPAROCO_OCOKD_VIMOB_SL       AS OCORRENCIA_VIMOB_SL,
         VDPAROCO_OCCEVSAI             AS OCORRENCIA_CEV_SAIDA,
         VDPAROCO_OCCEVSAI_FE          AS OCORRENCIA_CEV_SAIDA_FE,
         VDPAROCO_OCCEVREC             AS OCORRENCIA_CEV_RECOLHIMENTO,
         VDPAROCO_OCCEVREC_FE          AS OCORRENCIA_CEV_RECOLHIMENTO_FE,
         VDPAROCO_OCCEVSAI_SL          AS OCORRENCIA_CEV_RECOLHIMENTO_SL,
         VDPAROCO_OCCEVSAI_FE_SL       AS OCORRENCIA_CEV_RECOLHIMENTO_FE_SL,
         VDPAROCO_DEV_KAR_DIAANT_FIN   AS OCORRENCIA_DEV_DIA_ANTERIOR_FIN,
         VDPAROCO_DEV_KAR_DIAANT_NFIN  AS OCORRENCIA_DEV_DIA_ANTERIOR_NAO_FIN,
         VDPAROCO_OCOKD_COMPRA         AS OCORRENCIA_COMPRA,
         VDPAROCO_OCOKD_COMPRA_BONIF   AS OCORRENCIA_COMPRA_BONIFICADA,
         VDPAROCO_OCO_AUTOCONS         AS OCORRENCIA_AUTOCONS,
         VDPAROCO_QUEBRA               AS QUEBRA,
         VDPAROCO_QUEBRA2              AS QUEBRA2,
         VDPAROCO_QUEBRA3              AS QUEBRA3,
         VDPAROCO_OCO_VDA_DIRETA       AS OCORRENCIA_VENDA_DIRETA,
         VDPAROCO_OCO_DIGPED           AS OCORRENCIA_DIGIPED,
         VDPAROCO_OCCONSIG             AS OCORRENCIA_CONSIG,
         VDPAROCO_OCOKDREM             AS OCORRENCIA_REM,
         VDPAROCO_OCOKDREM_BONIF       AS OCORRENCIA_REM_BONIFICADO,
         VDPAROCO_OCOKDREM_ESPECIAL    AS OCORRENCIA_REM_ESPECIAL,
         VDPAROCO_OCBON1               AS OCORRENCIA_BONIFICADA_1,
         VDPAROCO_OCBON2               AS OCORRENCIA_BONIFICADA_2,
         VDPAROCO_OCBON3               AS OCORRENCIA_BONIFICADA_3,
         VDPAROCO_OCBON4               AS OCORRENCIA_BONIFICADA_4,
         VDPAROCO_OCB0N5               AS OCORRENCIA_BONIFICADA_5,
         VDPAROCO_OCTCA1               AS OCORRENCIA_TROCA1,
         VDPAROCO_OCTCA2               AS OCORRENCIA_TROCA2,
         VDPAROCO_OCTCA3               AS OCORRENCIA_TROCA3,
         VDPAROCO_OCTCA4               AS OCORRENCIA_TROCA4,
         VDPAROCO_OCTCA5               AS OCORRENCIA_TROCA5,
         VDPAROCO_SPREM_E              AS SPREM_E,
         VDPAROCO_SPREM_I              AS SPREM_I,
         VDPAROCO_OCOKDRETV            AS COCORRENCIA_RETV,
         VDPAROCO_OCOKDSAIV            AS COCORRENCIA_SAIV,
         VDPAROCO_OCO_INV_SABOR_E      AS COCORRENCIA_INV_SABOR_E,
         VDPAROCO_OCO_INV_SABOR_S      AS COCORRENCIA_INV_SABOR_S,
         VDPAROCO_OCO_INV_SABOR_E_ANT  AS COCORRENCIA_INV_SABOR_E_ANT,
         VDPAROCO_OCO_INV_SABOR_S_ANT  AS COCORRENCIA_INV_SABOR_S_ANT,
         VDPAROCO_TAB_CUSTO_PROD       AS CODIGO_TABELA_CUSTO_ERP,
         VDPAROCO_TAB_PREMED_VDA       AS COCORRENCIA_TAB_PREMED_VDA,
         CASE WHEN LENGTH(CAST(VDPAROCO_CLIENTE AS VARCHAR(008))) = 5 THEN CONCAT('000',CAST(VDPAROCO_CLIENTE AS VARCHAR(008)))
		 WHEN LENGTH(CAST(VDPAROCO_CLIENTE AS VARCHAR(008))) = 6 THEN CONCAT('00',CAST(VDPAROCO_CLIENTE AS VARCHAR(008)))
		 WHEN LENGTH(CAST(VDPAROCO_CLIENTE AS VARCHAR(008))) = 7 THEN CONCAT('0',CAST(VDPAROCO_CLIENTE AS VARCHAR(008)))
		 ELSE CAST(VDPAROCO_CLIENTE AS VARCHAR(008))  END AS CODIGO_CLIENTE_ERP,		 
         VDPAROCO_TIPCLI               AS TIPCLI,
         VDPAROCO_TIPPRD               AS TIPPRD, 
         VDPAROCO_TIPPLA               AS TIPLA,
         VDPAROCO_VISFAT               AS VISFAT,
         VDPAROCO_VERBA                AS VERBA,
         VDPAROCO_INDENIZA             AS INDENIZA ,
         VDPAROCO_INTEGRA_FORMA_CONTBL AS INTREGRA_CONTABEL,
         VDPAROCO_IGUALLC              AS IGUALIC,
         VDPAROCO_ANTECIPADO           AS ANTECIPADO,
         VDPAROCO_SOLAVANCO            AS SOLAVANCO,
         VDPAROCO_TIPFOR               AS TIPFOR,
         VDPAROCO_TABCUSTO_FREPUXA     AS TABCUSTO_PREPUXA,
         VDPAROCO_TABCUSTO_FREENTR     AS TABELA_CUSTO_FRETE_ENTRGA,
         VDPAROCO_OCOKD_COMPRA_FE      AS OCORRENCIA_COMPRA_FE,
         VDPAROCO_OCOTK_ENTFUTURA      AS OCORRENCIA_ENTFUTURA,
         VDPAROCO_OCOTK_VENFAT         AS OCORRENCIA_VENFAT,
         VDPAROCO_ANOTAB_CARGA         AS ANO_TABELA_CARGA,
         VDPAROCO_MESTAB_CARGA         AS MES_TABELA_CARGA,
         VDPAROCO_USA_BANDPREC         AS USA_BANDEIRA,                       
         VDPAROCO_SENHA_LIB            AS SENHA_LIB, 
         VDPAROCO_CTRL_RESTRICOES      AS RESTRICAO_FINANCEIRA,
         VDPAROCO_RESTR_COMERCIAL      AS RESTRICAO_COMERCIAL,
         VDPAROCO_FAM_FAMC_BAND        AS BANDA_FAM_FAMC, 
         VDPAROCO_REG_PASTA_BANDPREC   AS BANDA_REG_PASTA,
         VDPAROCO_BDA_VEN_SUP_GER      AS BANDA_VEN_SUP_GER,
         VDPAROCO_CAN_GRPCAN_BANDPREC  AS BANDA_CAN_GRPCAN
    FROM PAROCO61 WHERE (VDPAROCO_CODEMP = @CODIGO_EMPRESA OR @CODIGO_EMPRESA = 0 )
  ;
DECLARE SET VARCHAR(255) @CODIGO_PEDIDO = '';
CREATE or replace  VIEW   "VW_PEDIDO_PENDENTE_LIBERACAO"
AS 
 SELECT CASE
         WHEN pedcp61. "vdpedcpe_fl" = 9 THEN 0
         ELSE 1
       END                                                           AS ATIVO,
       pedcp61. "vdpedcpe_dtemiped"                                  AS
       DATA_HORA_EMISSAO_PEDIDO,
       pedcp61. "vdpedcpe_dt1vc"                                     AS
       DATA_VENCIMENTO,
       pedcp61. "vdpedcpe_descfi"                                    AS
       DESCONTO_FINANCEIRO,
       pedcp61. "vdpedcpe_nped"                                      AS
       NUMERO_PEDIDO,
       pedcp61. "vdpedcpe_desc"                                      AS
       PERCENTUAL_DESCONTO,
       pedcp61. "vdpedcpe_fl"                                        AS
       STATUS_PEDIDO,
       (SELECT CASE WHEN tabblq61. "vdcadbpd_descr" = NULL THEN 
	           'LIBERADO' ELSE tabblq61. "vdcadbpd_descr" END
        FROM    tabblq61
        WHERE  tabblq61. "vdcadbpd_cod" = pedcp61. "vdpedcpe_fl")    AS
       DESCRICAO_BLOQUEIO,
       pedcp61. "vdpedcpe_txfin"                                     AS
       TAXA_FINANCEIRO,
       pedcp61. "vdpedcpe_vlr_fcem_r"
       + pedcp61. "vdpedcpe_vlr_fsem_r"
       + pedcp61. "vdpedcpe_vlr_fctr_r"
       + pedcp61. "vdpedcpe_vlr_fstr_r"                              AS
       VALOR_DEVOLUCAO,
       pedcp61. "vdpedcpe_vlr_fcem"
       + pedcp61. "vdpedcpe_vlr_fsem"
       + pedcp61. "vdpedcpe_vlr_fctr"
       + pedcp61. "vdpedcpe_vlr_fstr"                                AS
       VALOR_PEDIDO,
       CASE
         WHEN Length(Cast(pedcp61. "vdpedcpe_codcli" AS CHAR(8))) = 5 THEN
         Concat('000', Cast(pedcp61. "vdpedcpe_codcli" AS VARCHAR(8)))
         WHEN Length(Cast(pedcp61. "vdpedcpe_codcli" AS CHAR(8))) = 6 THEN
         Concat('00', Cast(pedcp61. "vdpedcpe_codcli" AS VARCHAR(8)))
         WHEN Length(Cast(pedcp61. "vdpedcpe_codcli" AS CHAR(8))) = 7 THEN
         Concat('0', Cast(pedcp61. "vdpedcpe_codcli" AS VARCHAR(4)))
         WHEN Length(Cast(pedcp61. "vdpedcpe_codcli" AS CHAR(8))) = 8 THEN
         Cast(pedcp61. "vdpedcpe_codcli" AS VARCHAR(8))
       END                                                           AS
       CODIGO_CLIENTE_REC_ID,
       pedcp61. "vdpedcpe_cpg"                                       AS
       CODIGO_CONDICAO_PAGAMENTO_REC_ID,
       pedcp61. "vdpedcpe_tpcobr"                                    AS
       CODIGO_TIPO_COBRANCA_REC_ID,
       (SELECT cadven61. "vdvenven_sigla"
        FROM    cadven61
        WHERE  cadven61. "vdvenven_sigla" = pedcp61. "vdpedcpe_ven") AS
       CODIGO_VENDEDOR,
       (SELECT cadven61. "vdvenven_nome"
        FROM    cadven61
        WHERE  cadven61. "vdvenven_sigla" = pedcp61. "vdpedcpe_ven") AS
       NOME_VENDEDOR
FROM    pedcp61
WHERE  Cast(pedcp61. "vdpedcpe_nped" AS VARCHAR(12)) = @CODIGO_PEDIDO
        OR @CODIGO_PEDIDO = ''
           AND ( pedcp61. "vdpedcpe_fl" = 5
                  OR pedcp61. "vdpedcpe_fl" = 7 )  ;

CREATE or replace VIEW   "VW_PEDIDO_SUGESTAO" 
AS 
  SELECT 
          '0'                              AS COD_CLIENTE,   
          VDCLPV61. "VDCLIPVC_CODCAT"    AS COD_CANAL, 
(SELECT CADPRD61."VDPRDPRD_CODR" FROM CADPRD61 WHERE  CADPRD61."VDPRDPRD_CFAM" = CAST(LEFT(CONCAT(REPEAT('0',6-LENGTH(CAST(VDCLIPVC_CODPRD AS VARCHAR(6)))) , CAST(VDCLIPVC_CODPRD AS VARCHAR(6))),3) AS INT) AND CADPRD61."VDPRDPRD_NRO" = CAST(RIGHT(CONCAT(REPEAT('0',6-LENGTH(CAST(VDCLIPVC_CODPRD AS VARCHAR(6)))) , CAST(VDCLIPVC_CODPRD AS VARCHAR(6))),3) AS INT)) AS COD_PRODUTO_REDUZIDO, 
          VDCLPV61. "VDCLIPVC_SUG_QTDECX"  AS QTD_CX, 
          VDCLPV61. "VDCLIPVC_SUG_QTDEUN"  AS QTD_AV
  FROM    VDCLPV61 

  UNION ALL
  SELECT 
          CASE 
             WHEN LENGTH(CAST(CLCVTE61. "VDCLCVTE_CODCLI" AS VARCHAR(8))) = 5 THEN
			     CONCAT('000',CAST(CLCVTE61. "VDCLCVTE_CODCLI" AS VARCHAR(8))) 
			WHEN LENGTH(CAST(CLCVTE61. "VDCLCVTE_CODCLI" AS VARCHAR(8))) = 6 THEN
				CONCAT('00',CAST(CLCVTE61. "VDCLCVTE_CODCLI" AS VARCHAR(8))) 
			WHEN LENGTH(CAST(CLCVTE61. "VDCLCVTE_CODCLI" AS VARCHAR(8))) = 7 THEN
				CONCAT('0',CAST(CLCVTE61. "VDCLCVTE_CODCLI" AS VARCHAR(8))) ELSE
			CAST(CLCVTE61. "VDCLCVTE_CODCLI" AS VARCHAR(8)) END    AS COD_CLIENTE, 
		  '00'                            AS COD_CANAL,          
(SELECT CADPRD61."VDPRDPRD_CODR" FROM CADPRD61 WHERE  CADPRD61."VDPRDPRD_CFAM" = CAST(LEFT(CONCAT(REPEAT('0',6-LENGTH(CAST(VDCLCVTE_CODPRD AS VARCHAR(6)))) , CAST(VDCLCVTE_CODPRD AS VARCHAR(6))),3) AS INT) AND CADPRD61."VDPRDPRD_NRO" = CAST(RIGHT(CONCAT(REPEAT('0',6-LENGTH(CAST(VDCLCVTE_CODPRD AS VARCHAR(6)))) , CAST(VDCLCVTE_CODPRD AS VARCHAR(6))),3) AS INT))  AS COD_PRODUTO_REDUZIDO,
          CLCVTE61. "VDCLCVTE_SUG_QTDCX"  AS QTD_CX, 
          CLCVTE61. "VDCLCVTE_SUG_QTDUN"  AS QTD_AV  
  FROM    CLCVTE61;

  
  
  

	DECLARE SET BIGINT @COD_PRODUTO = 0;
	DECLARE SET BIGINT @COD_TABELA = 0;

	CREATE or replace VIEW   "VW_PRECO_PRODUTO" 
AS 
  SELECT  tabprc61. "vdtabprd_aliqpvv"          AS aliq_pvv, 
         cadprd61. "vdprdprd_disp_portal_web"     AS ativo, 
         Cast(Cast(Cast( tabprc61. "vdtabprd_ano" AS CHAR(04)) 
                   || CASE 
                        WHEN  tabprc61. "vdtabprd_mes" <= 9 THEN 
                        Concat('0', Cast( tabprc61. 
                                         "vdtabprd_mes" 
                                         AS CHAR 
                                         (1)) 
                        ) 
                        ELSE Cast( tabprc61. "vdtabprd_mes" AS 
                                  CHAR 
                                  (2)) 
                      END 
                   || CASE 
                        WHEN  tabprc61. "vdtabprd_nmes" <= 9 THEN 
                        Concat('0', Cast( tabprc61. 
                                         "vdtabprd_nmes" 
                                         AS 
                                         CHAR(1)) 
                        ) 
                        ELSE Cast( tabprc61. "vdtabprd_nmes" AS 
                                  CHAR(2)) 
                      END AS CHAR(08)) AS BIGINT) AS codigo_tabpreco_erp, 
          tabprc61. "vdtabprd_daicmo"           AS da_icm_o, 
          tabprc61. "vdtabprd_desc"             AS desconto, 
          tabprc61. "vdtabprd_descmax"          AS desconto_maximo, 
          tabprc61. "vdtabprd_descvb"           AS desconto_verba, 
          tabprc61. "vdtabprd_despac"           AS despac, 
          tabprc61. "vdtabprd_tipotab"          AS origem_tabela, 
          tabprc61. "vdtabprd_participabda"     AS participa_banda_preco, 
          NULL                                  AS preco_custo_caixa, 
          NULL                                  AS preco_custo_un, 
          tabprc61. "vdtabprd_precopvv"         AS preco_pvv, 
          NULL                                  AS promocao, 
          tabprc61. "vdtabprd_restr_comerciais" AS restricao, 
          tabprc61. "vdtabprd_selo"             AS selo, 
          tabprc61. "vdtabprd_tpcont"           AS tp_cont, 
          NULL                                  AS uf_table_preco, 
          tabprc61. "vdtabprd_valicm"           AS val_icms, 
          tabprc61. "vdtabprd_valipi"           AS val_ipi, 
          tabprc61. "vdtabprd_preco"            AS valor, 
          cadprd61. "vdprdprd_codr"             AS codigo_produto_erp, 
          tabprc61. "vdtabprd_dtvgf"            AS fim 
  FROM    cadprd61 
         INNER JOIN  tabprc61 
                 ON  cadprd61. "vdprdprd_cfam" = 
                                tabprc61. "vdtabprd_cfam" 
                    AND  cadprd61. "vdprdprd_nro" = 
                         tabprc61. "vdtabprd_nro" 
                    AND  cadprd61. "vdprdprd_disp_portal_web" <> 
                        0                     
                    AND LEFT(Cast( tabprc61.vdtabprd_dtvgf AS 
                                  VARCHAR(8)) 
                        , 4) >= 
                        LEFT( 
                        Cast(Curdate() - 365 AS CHAR(4)), 4)                     
         INNER JOIN PAROCO61
                ON 	tabprc61. "vdtabprd_ano"= PAROCO61."VDPAROCO_ANOTAB_CARGA" AND 	 tabprc61. "vdtabprd_mes" = PAROCO61."VDPAROCO_MESTAB_CARGA"
    WHERE (cadprd61."VDPRDPRD_CODR" = @COD_PRODUTO OR @COD_PRODUTO = 0) AND
          ( Cast(Cast(Cast( tabprc61. "vdtabprd_ano" AS CHAR(04)) 
                   || CASE 
                        WHEN  tabprc61. "vdtabprd_mes" <= 9 THEN 
                        Concat('0', Cast( tabprc61. 
                                         "vdtabprd_mes" 
                                         AS CHAR 
                                         (1)) 
                        ) 
                        ELSE Cast( tabprc61. "vdtabprd_mes" AS 
                                  CHAR 
                                  (2)) 
                      END 
                   || CASE 
                        WHEN  tabprc61. "vdtabprd_nmes" <= 9 THEN 
                        Concat('0', Cast( tabprc61. 
                                         "vdtabprd_nmes" 
                                         AS 
                                         CHAR(1)) 
                        ) 
                        ELSE Cast( tabprc61. "vdtabprd_nmes" AS 
                                  CHAR(2)) 
                      END AS CHAR(08)) AS BIGINT) = @COD_TABELA OR @COD_TABELA = 0)	;

					  
					  
declare set int @DISP_PORTAL_WEB = 1;
DECLARE SET INT @CODIGO_PROD = 0;
DECLARE SET INT @CODIGO_FAMILIA = 0;
DECLARE SET INT @CODIGO_SEQUENCIA = 0;
CREATE or replace VIEW   "VW_PRODUTO" 
AS 
  SELECT CASE 
           WHEN  cadprd61. "vdprdprd_flag" = 'A' THEN 1 
           ELSE 0 
         END                                                 AS ATIVO, 
          cadprd61. "vdprdprd_bonifica_unid" AS BONIFICA_UNIDADE, 
          cadprd61. "vdprdprd_clasf"         AS CLASS_FISCAL, 
         NULL                                                AS CODIGO_EAN_FAB, 
          cadprd61. "vdprdprd_codr"          AS 
         CODIGO_PRODUTO_ERP, 
          cadprd61. "vdprdprd_descr"         AS DESCRICAO, 
          cadprd61. "vdprdprd_descri"        AS DESCRICAO_RED, 
          cadprd61. "vdprdprd_ipipauta"      AS IPI_PAUTA, 
          cadprd61. "vdprdprd_linha"         AS LINHA, 
          cadprd61. "vdprdprd_medida"        AS LITRAGEM, 
         NULL                                                AS 
            PERCENTUAL_BONUS_GERA, 
         NULL                                                AS 
            PERCENTUAL_BONUS_USA, 
          cadprd61. "vdprdprd_permite_bonif" AS 
         PERMITE_BONIFICACAO 
            , 
          cadprd61. "vdprdprd_peso"          AS PESO, 
          cadprd61. "vdprdprd_pesoemb"       AS PESO_EMB, 
          cadprd61. "vdprdprd_qtdminvd"      AS QTD_MIN_VENDA_AV, 
         NULL                                                AS QTD_MIN_VENDA_CX 
         , 
          cadprd61. "vdprdprd_qtdun"         AS 
         QUANTIDADE_CX, 
          cadprd61. "vdprdprd_tipobanda"     AS TIPO_BANDA, 
          cadprd61. "vdprdprd_tipo"          AS TIPO_PRODUTO, 
         NULL                                                AS 
            UTILIZA_BANDA_PRECO_TIPO, 
         NULL                                                AS 
         VALOR_MINIMO_BONUS 
            , 
          cadprd61. "vdprdprd_tipoqtdvdcx"   AS 
            VENDA_MULTI_MIN_CX, 
          cadprd61. "vdprdprd_tipoqtdvd"     AS 
         VENDA_MULTI_MIN_AV, 
         CASE 
           WHEN  cadprd61. "vdprdprd_enc" = 'S' THEN 1 
           ELSE 0 
         END                                                 AS VENDA_AVULSO, 
         CASE 
           WHEN  cadprd61. "vdprdprd_tipo" = 'P' THEN 1 
           ELSE 0 
         END                                                 AS 
            VISIBILIDADE_PORTAL, 
          cadprd61. "vdprdprd_catprd"        AS 
            CODIGO_CATEGORIA_PRODUTO_ERP, 
          cadprd61. "vdprdprd_cfam"          AS 
            CODIGO_FAMILIA_PRODUTO_ERP, 
          cadprd61. "vdprdprd_grpprd"        AS 
            CODIGO_GRUPO_PRODUTO_ERP, 
          cadprd61. "vdprdprd_marprd"        AS 
            CODIGO_MARCA_PRODUTO_ERP ,
          cadprd61. "vdprdprd_disp_portal_web"        AS 
            DISP_PORTAL_WEB 			
  FROM    cadprd61 	
  WHERE   cadprd61. "vdprdprd_cfam" > @CODIGO_FAMILIA 
         AND  cadprd61. "vdprdprd_nro" > @CODIGO_SEQUENCIA 
         AND  cadprd61. "vdprdprd_flag" = 'A' 
         AND (cadprd61. "vdprdprd_disp_portal_web" = @DISP_PORTAL_WEB  or @DISP_PORTAL_WEB = 2)
         AND (  cadprd61. "vdprdprd_codr" = @CODIGO_PROD 
                OR @CODIGO_PROD = 0 ) ;

declare set integer @id =0;

CREATE or replace VIEW "VW_PRODUTOS_POR_CANAL"
AS 
SELECT 
  
 case when length(cast(VDPRDCAN_CODCLI as char(8))) = 5 then 
      concat('000', cast(VDPRDCAN_CODCLI as char(8))) 
	when length(cast(VDPRDCAN_CODCLI as char(8))) = 6  then 
      concat('00', cast(VDPRDCAN_CODCLI as char(8))) 
	when length(cast(VDPRDCAN_CODCLI as char(8))) = 7  then 
      concat('0', cast(VDPRDCAN_CODCLI as char(8))) ELSE
	cast(VDPRDCAN_CODCLI as char(8)) END AS  COD_CLIENTE,

 VDPRDCAN_CANAL	    AS  ERP_CANAL,
 VDPRDCAN_SUB_CANAL AS  SUB_CANAL,	
 (SELECT CADPRD61."VDPRDPRD_CODR" FROM CADPRD61 WHERE  CADPRD61."VDPRDPRD_CFAM" = VDPRDCAN_FAMPRD AND CADPRD61."VDPRDPRD_NRO" = VDPRDCAN_NROPRD) AS COD_PRODUTO,
 VDPRDCAN_GRPPRD AS ERP_COD_GRUPO,			
 VDPRDCAN_CATPRD AS ERP_COD_CATEGORIA,
 VDPRDCAN_MARPRD AS ERP_MARCA	
 FROM VDPRDCAN where(VDPRDCAN_ID = @id or @id = 0);

CREATE or replace VIEW   "VW_RESTRICAO_COMERCIAL_CAPA" 
AS 
  SELECT CASE 
           WHEN  grptab61. "vdtabgrc_cancsn" = 0 THEN 1 
           ELSE 0 
         END                                             AS ATIVO, 
          grptab61. "vdtabgrc_grpcan"    AS 
         CODIGO_GRUPO_CANAL_ERP, 
          grptab61. "vdtabgrc_seq"       AS 
            CODIGO_RESTRICAO_COMERCIAL_ERP, 
          grptab61. "vdtabgrc_divcan"    AS DIVISAO_CANAL, 
          grptab61. "vdtabgrc_valminped" AS VALOR_MINIMO_PEDIDO, 
          grptab61. "vdtabgrc_canal"     AS CODIGO_CANAL_ERP, 
         CASE 
           WHEN Length(Cast( grptab61. "vdtabgrc_cliente" AS 
                            VARCHAR(8))) 
                = 5 THEN Concat('000', Cast( grptab61. 
                                            "vdtabgrc_cliente" 
                                            AS VARCHAR(8))) 
           ELSE 
             CASE 
               WHEN Length(Cast( grptab61. "vdtabgrc_cliente" AS 
                                VARCHAR(8 
                                ))) 
                    = 6 THEN Concat('00', Cast( grptab61. 
                                               "vdtabgrc_cliente" 
                                               AS VARCHAR(8))) 
               ELSE 
                 CASE 
                   WHEN Length(Cast( grptab61. "vdtabgrc_cliente" 
                                    AS 
                                    VARCHAR(8 
                                    ))) 
                        = 7 THEN Concat('0', Cast( grptab61. 
                                                  "vdtabgrc_cliente" AS 
                                                  VARCHAR(8))) 
                   ELSE 
                     CASE 
                       WHEN Length(Cast( grptab61. 
                                        "vdtabgrc_cliente" AS 
                                        VARCHAR(8 
                                        ))) 
                            = 8 THEN Cast( grptab61. 
                                          "vdtabgrc_cliente" AS 
                                          VARCHAR 
                                          (8)) 
                     END 
                 END 
             END 
         END                                             AS CODIGO_CLIENTE_ERP, 
          grptab61. "vdtabgrc_condpag"   AS 
            CODIGO_CONDICAO_PAGAMENTO_ERP, 
          grptab61. "vdtabgrc_tipcobr"   AS 
            CODIGO_TIPO_COBRANCA_ERP 
  FROM    grptab61 
  WHERE  Cast( grptab61. "vdtabgrc_cliente" AS VARCHAR(8)) <> '0' ;

CREATE or replace VIEW   "VW_RESTRICAO_COMERCIAL_ITEM" 
AS 
  SELECT  grptab61. "vdtabgrc_tab01" AS CODIGO_TABELA_PRECO, 
          grptab61. "vdtabgrc_seq"   AS 
            CODIGO_RESTRICAO_COMERCIAL_ERP 
  FROM    grptab61 
  WHERE   grptab61. "vdtabgrc_tab01" <> 0 
  UNION 
  SELECT  grptab61. "vdtabgrc_tab02" AS CODIGO_TABELA_PRECO, 
          grptab61. "vdtabgrc_seq"   AS 
         CODIGO_RESTRICAO_COMERCIAL_ERP 
  FROM    grptab61 
  WHERE   grptab61. "vdtabgrc_tab02" <> 0 
  UNION 
  SELECT  grptab61. "vdtabgrc_tab03" AS CODIGO_TABELA_PRECO, 
          grptab61. "vdtabgrc_seq"   AS 
         CODIGO_RESTRICAO_COMERCIAL_ERP 
  FROM    grptab61 
  WHERE   grptab61. "vdtabgrc_tab03" <> 0 
  UNION 
  SELECT  grptab61. "vdtabgrc_tab04" AS CODIGO_TABELA_PRECO, 
          grptab61. "vdtabgrc_seq"   AS 
         CODIGO_RESTRICAO_COMERCIAL_ERP 
  FROM    grptab61 
  WHERE   grptab61. "vdtabgrc_tab04" <> 0 
  UNION 
  SELECT  grptab61. "vdtabgrc_tab05" AS CODIGO_TABELA_PRECO, 
          grptab61. "vdtabgrc_seq"   AS 
         CODIGO_RESTRICAO_COMERCIAL_ERP 
  FROM    grptab61 
  WHERE   grptab61. "vdtabgrc_tab05" <> 0 
  UNION 
  SELECT  grptab61. "vdtabgrc_tab06" AS CODIGO_TABELA_PRECO, 
          grptab61. "vdtabgrc_seq"   AS 
         CODIGO_RESTRICAO_COMERCIAL_ERP 
  FROM    grptab61 
  WHERE   grptab61. "vdtabgrc_tab06" <> 0 
  UNION 
  SELECT  grptab61. "vdtabgrc_tab07" AS CODIGO_TABELA_PRECO, 
          grptab61. "vdtabgrc_seq"   AS 
         CODIGO_RESTRICAO_COMERCIAL_ERP 
  FROM    grptab61 
  WHERE   grptab61. "vdtabgrc_tab07" <> 0 
  UNION 
  SELECT  grptab61. "vdtabgrc_tab08" AS CODIGO_TABELA_PRECO, 
          grptab61. "vdtabgrc_seq"   AS 
         CODIGO_RESTRICAO_COMERCIAL_ERP 
  FROM    grptab61 
  WHERE   grptab61. "vdtabgrc_tab08" <> 0 
  UNION 
  SELECT  grptab61. "vdtabgrc_tab09" AS CODIGO_TABELA_PRECO, 
          grptab61. "vdtabgrc_seq"   AS 
         CODIGO_RESTRICAO_COMERCIAL_ERP 
  FROM    grptab61 
  WHERE   grptab61. "vdtabgrc_tab09" <> 0 
  UNION 
  SELECT  grptab61. "vdtabgrc_tab10" AS CODIGO_TABELA_PRECO, 
          grptab61. "vdtabgrc_seq"   AS 
         CODIGO_RESTRICAO_COMERCIAL_ERP 
  FROM    grptab61 
  WHERE   grptab61. "vdtabgrc_tab10" <> 0 ;

declare set varchar(255) @codigo_restricao = '';

CREATE or replace VIEW   "VW_RESTRICAO_FINANCEIRA_CAPA" 
AS 
  SELECT 1                                                         AS ativo, 
         concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) AS codigo_restricao_financeira, 
          txpalm61. "vdcnftxp_descto"              AS desconto, 
          txpalm61. "vdcnftxp_descmax"             AS desconto_maximo, 
          txpalm61. "vdcnftxp_taxa"                AS taxa, 
          txpalm61. "vdcnftxp_vrpedmax"            AS valor_maximo_pedido, 
          txpalm61. "vdcnftxp_vlrpedmin"           AS valor_minimo_pedido, 
          txpalm61. "vdcnftxp_cpg"                 AS codigo_condicao_pagamento_rec_id, 
          txpalm61. "vdcnftxp_tpcobr"              AS codigo_tipo_cobranca_rec_id 
  FROM    txpalm61 where (concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) = @codigo_restricao or @codigo_restricao = '');

		   
		   
		   
		   
			
declare set varchar(255) @codigo_restricao = '';
CREATE or replace VIEW   "VW_RESTRICAO_FINANCEIRA_ITEM" 
AS 
  SELECT concat(cast( VDPAROCO_ANOTAB_CARGA as varchar(4)),
case when length(cast( VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0'||cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela_1" as varchar(2)) else cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela_1" as varchar(2)) end) AS 
            CODIGO_TABELA_PRECO, 
			concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) AS codigo_restricao_financeira 
  FROM    txpalm61 , paroco61  
  WHERE   txpalm61. "vdcnftxp_tabela_1" <> 0 and 
  (concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) = @codigo_restricao or @codigo_restricao = '')
  UNION 
  SELECT concat(cast( VDPAROCO_ANOTAB_CARGA as varchar(4)),
case when length(cast( VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0'||cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela_2" as varchar(2)) else cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela_2" as varchar(2)) end) AS 
            CODIGO_TABELA_PRECO, 
			concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) AS codigo_restricao_financeira 
  FROM    txpalm61 , paroco61  
  WHERE   txpalm61. "vdcnftxp_tabela_2" <> 0 and 
  (concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) = @codigo_restricao or @codigo_restricao = '')
  UNION 
  SELECT concat(cast( VDPAROCO_ANOTAB_CARGA as varchar(4)),
case when length(cast( VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0'||cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela_3" as varchar(2)) else cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela_3" as varchar(2)) end) AS 
            CODIGO_TABELA_PRECO, 
         concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) AS codigo_restricao_financeira  
  FROM    txpalm61 , paroco61  
  WHERE   txpalm61. "vdcnftxp_tabela_3" <> 0 and 
  (concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) = @codigo_restricao or @codigo_restricao = '')
  UNION 
  SELECT concat(cast( VDPAROCO_ANOTAB_CARGA as varchar(4)),
case when length(cast( VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0'||cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela_4" as varchar(2)) else cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela_4" as varchar(2)) end) AS 
            CODIGO_TABELA_PRECO, 
concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) AS codigo_restricao_financeira  
  FROM    txpalm61 , paroco61  
  WHERE   txpalm61. "vdcnftxp_tabela_4" <> 0 and 
  (concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) = @codigo_restricao or @codigo_restricao = '')
  UNION 
    SELECT concat(cast( VDPAROCO_ANOTAB_CARGA as varchar(4)),
case when length(cast( VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0'||cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela_5" as varchar(2)) else cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela_5" as varchar(2)) end) AS 
            CODIGO_TABELA_PRECO,          
         concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) AS codigo_restricao_financeira 
  FROM    txpalm61 , paroco61  
  WHERE   txpalm61. "vdcnftxp_tabela_5" <> 0 and 
  (concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) = @codigo_restricao or @codigo_restricao = '')
  UNION 
    SELECT concat(cast( VDPAROCO_ANOTAB_CARGA as varchar(4)),
case when length(cast( VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0'||cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela2_1" as varchar(2)) else cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela2_1" as varchar(2)) end) AS 
            CODIGO_TABELA_PRECO, 
concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) AS codigo_restricao_financeira 
  FROM    txpalm61 , paroco61  
  WHERE   txpalm61. "vdcnftxp_tabela2_1" <> 0 and 
  (concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) = @codigo_restricao or @codigo_restricao = '')
  UNION 
      SELECT concat(cast( VDPAROCO_ANOTAB_CARGA as varchar(4)),
case when length(cast( VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0'||cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela2_2" as varchar(2)) else cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela2_2" as varchar(2)) end) AS 
            CODIGO_TABELA_PRECO, 
concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) AS codigo_restricao_financeira  
  FROM    txpalm61 , paroco61  
  WHERE   txpalm61. "vdcnftxp_tabela2_2" <> 0 and 
  (concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) = @codigo_restricao or @codigo_restricao = '')
  UNION 
      SELECT concat(cast( VDPAROCO_ANOTAB_CARGA as varchar(4)),
case when length(cast( VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0'||cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela2_3" as varchar(2)) else cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela2_3" as varchar(2)) end) AS 
            CODIGO_TABELA_PRECO, 
concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) AS codigo_restricao_financeira 
  FROM    txpalm61 , paroco61  
  WHERE   txpalm61. "vdcnftxp_tabela2_3" <> 0 and 
  (concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) = @codigo_restricao or @codigo_restricao = '')
  UNION 
     SELECT concat(cast( VDPAROCO_ANOTAB_CARGA as varchar(4)),
case when length(cast( VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0'||cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela2_4" as varchar(2)) else cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela2_4" as varchar(2)) end) AS 
            CODIGO_TABELA_PRECO,
			concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) AS codigo_restricao_financeira  
  FROM    txpalm61 , paroco61  
  WHERE   txpalm61. "vdcnftxp_tabela2_4" <> 0 and 
  (concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) = @codigo_restricao or @codigo_restricao = '')
				 
  UNION 
    SELECT concat(cast( VDPAROCO_ANOTAB_CARGA as varchar(4)),
case when length(cast( VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0'||cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela2_5" as varchar(2)) else cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela2_5" as varchar(2)) end) AS 
            CODIGO_TABELA_PRECO,
			concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) AS codigo_restricao_financeira 
  FROM    txpalm61 , paroco61  
  WHERE   txpalm61. "vdcnftxp_tabela2_5" <> 0 and 
  (concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) = @codigo_restricao or @codigo_restricao = '')
  UNION 
    SELECT concat(cast( VDPAROCO_ANOTAB_CARGA as varchar(4)),
case when length(cast( VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0'||cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela2_6" as varchar(2)) else cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela2_6" as varchar(2)) end) AS 
            CODIGO_TABELA_PRECO,
			concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) AS codigo_restricao_financeira 
  FROM    txpalm61 , paroco61  
  WHERE   txpalm61. "vdcnftxp_tabela2_6" <> 0 and 
  (concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) = @codigo_restricao or @codigo_restricao = '')
  UNION 
    SELECT concat(cast( VDPAROCO_ANOTAB_CARGA as varchar(4)),
case when length(cast( VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0'||cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela2_7" as varchar(2)) else cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela2_7" as varchar(2)) end) AS 
            CODIGO_TABELA_PRECO,
			concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) AS codigo_restricao_financeira 
  FROM    txpalm61 , paroco61  
  WHERE   txpalm61. "vdcnftxp_tabela2_7" <> 0 and 
  (concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) = @codigo_restricao or @codigo_restricao = '')
  UNION 
    SELECT concat(cast( VDPAROCO_ANOTAB_CARGA as varchar(4)),
case when length(cast( VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0'||cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela2_8" as varchar(2)) else cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela2_8" as varchar(2)) end) AS 
            CODIGO_TABELA_PRECO,
			concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) AS codigo_restricao_financeira 

  FROM    txpalm61 , paroco61  
  WHERE   txpalm61. "vdcnftxp_tabela2_8" <> 0 and 
  (concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) = @codigo_restricao or @codigo_restricao = '')
  UNION 
    SELECT concat(cast( VDPAROCO_ANOTAB_CARGA as varchar(4)),
case when length(cast( VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0'||cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela2_9" as varchar(2)) else cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela2_9" as varchar(2)) end) AS 
            CODIGO_TABELA_PRECO,
			concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) AS codigo_restricao_financeira 
  FROM    txpalm61 , paroco61  
  WHERE   txpalm61. "vdcnftxp_tabela2_9" <> 0 and 
  (concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) = @codigo_restricao or @codigo_restricao = '')
  UNION 
     SELECT concat(cast( VDPAROCO_ANOTAB_CARGA as varchar(4)),
case when length(cast( VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0'||cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela2_10" as varchar(2)) else cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela2_10" as varchar(2)) end) AS 
            CODIGO_TABELA_PRECO,
			concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) AS codigo_restricao_financeira 
  FROM    txpalm61 , paroco61  
  WHERE   txpalm61. "vdcnftxp_tabela2_10" <> 0 and 
  (concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) = @codigo_restricao or @codigo_restricao = '')
  UNION 
    SELECT concat(cast( VDPAROCO_ANOTAB_CARGA as varchar(4)),
case when length(cast( VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0'||cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela3_1" as varchar(2)) else cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela3_1" as varchar(2)) end) AS 
            CODIGO_TABELA_PRECO,
			concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) AS codigo_restricao_financeira 
  FROM    txpalm61 , paroco61  
  WHERE   txpalm61. "vdcnftxp_tabela3_1" <> 0 and 
  (concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) = @codigo_restricao or @codigo_restricao = '')
  UNION  
  SELECT concat(cast( VDPAROCO_ANOTAB_CARGA as varchar(4)),
case when length(cast( VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0'||cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela3_2" as varchar(2)) else cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela3_2" as varchar(2)) end) AS 
            CODIGO_TABELA_PRECO,
			concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) AS codigo_restricao_financeira 
  FROM    txpalm61 , paroco61  
  WHERE   txpalm61. "vdcnftxp_tabela3_2" <> 0 and 
  (concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) = @codigo_restricao or @codigo_restricao = '')
  UNION 
SELECT concat(cast( VDPAROCO_ANOTAB_CARGA as varchar(4)),
case when length(cast( VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0'||cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela3_3" as varchar(2)) else cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela3_3" as varchar(2)) end) AS 
            CODIGO_TABELA_PRECO,
			concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) AS codigo_restricao_financeira 
  FROM    txpalm61 , paroco61  
  WHERE   txpalm61. "vdcnftxp_tabela3_3" <> 0 and 
  (concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) = @codigo_restricao or @codigo_restricao = '')
UNION
      SELECT concat(cast( VDPAROCO_ANOTAB_CARGA as varchar(4)),
case when length(cast( VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0'||cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela3_4" as varchar(2)) else cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela3_4" as varchar(2)) end) AS 
            CODIGO_TABELA_PRECO,
			concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) AS codigo_restricao_financeira 
  FROM    txpalm61 , paroco61  
  WHERE   txpalm61. "vdcnftxp_tabela3_4" <> 0 and 
  (concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) = @codigo_restricao or @codigo_restricao = '')
  UNION
      SELECT concat(cast( VDPAROCO_ANOTAB_CARGA as varchar(4)),
case when length(cast( VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0'||cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela3_5" as varchar(2)) else cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela3_5" as varchar(2)) end) AS 
            CODIGO_TABELA_PRECO,
			concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) AS codigo_restricao_financeira 
  FROM    txpalm61 , paroco61  
  WHERE   txpalm61. "vdcnftxp_tabela3_5" <> 0 and 
  (concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) = @codigo_restricao or @codigo_restricao = '')
  UNION
      SELECT concat(cast( VDPAROCO_ANOTAB_CARGA as varchar(4)),
case when length(cast( VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0'||cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela3_6" as varchar(2)) else cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela3_6" as varchar(2)) end) AS 
            CODIGO_TABELA_PRECO,
			concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) AS codigo_restricao_financeira 
  FROM    txpalm61 , paroco61  
  WHERE   txpalm61. "vdcnftxp_tabela3_6" <> 0 and 
  (concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) = @codigo_restricao or @codigo_restricao = '')
  UNION
      SELECT concat(cast( VDPAROCO_ANOTAB_CARGA as varchar(4)),
case when length(cast( VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0'||cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela3_7" as varchar(2)) else cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela3_7" as varchar(2)) end) AS 
            CODIGO_TABELA_PRECO,
			concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) AS codigo_restricao_financeira 
  FROM    txpalm61 , paroco61  
  WHERE   txpalm61. "vdcnftxp_tabela3_7" <> 0 and 
  (concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) = @codigo_restricao or @codigo_restricao = '')
  UNION
      SELECT concat(cast( VDPAROCO_ANOTAB_CARGA as varchar(4)),
case when length(cast( VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0'||cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela3_8" as varchar(2)) else cast( VDPAROCO_MESTAB_CARGA as varchar(2))||cast(txpalm61. "vdcnftxp_tabela3_8" as varchar(2)) end) AS 
            CODIGO_TABELA_PRECO,
			concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) AS codigo_restricao_financeira 
  FROM    txpalm61 , paroco61  
  WHERE   txpalm61. "vdcnftxp_tabela3_8" <> 0 and 
  (concat(case when length(Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then 
		            '0'||Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2))  else
				    Cast( txpalm61. "vdcnftxp_tpcobr" AS VARCHAR(2)) end ,
				  case when length(Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))) = 1 then 
				    '0'|| Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2)) else
				    Cast( txpalm61. "vdcnftxp_cpg" AS VARCHAR(2))  end
				 ) = @codigo_restricao or @codigo_restricao = '');

DECLARE SET INT @CODIGO_TIPO_COBRANCA = 0;
CREATE or replace VIEW   "VW_TIPO_COBRANCA" 
AS 
  SELECT  tpcobr61. "vdcadtco_ativo"     AS ATIVO, 
          tpcobr61. "vdcadtco_cod"       AS CODIGO_TIPO_COBRANCA_ERP, 
          tpcobr61. "vdcadtco_descricao" AS DESCRICAO, 
          tpcobr61. "vdcadtco_prazo"     AS PRAZO, 
          tpcobr61. "vdcadtco_redcnt"    AS RED, 
          tpcobr61. "vdcadtco_redcnt"    AS RED_F,
          tpcobr61. "vdcadtco_perm01"    AS PERM01,
          tpcobr61. "vdcadtco_perm02"    AS PERM02,
          tpcobr61. "vdcadtco_perm03"    AS PERM03,
          tpcobr61. "vdcadtco_perm04"    AS PERM04,
          tpcobr61. "vdcadtco_perm05"    AS PERM05,
          tpcobr61. "vdcadtco_perm06"    AS PERM06,
          tpcobr61. "vdcadtco_perm07"    AS PERM07,
          tpcobr61. "vdcadtco_perm08"    AS PERM08,
          tpcobr61. "vdcadtco_perm09"    AS PERM09
  FROM    tpcobr61
  WHERE  (  tpcobr61. "vdcadtco_cod" = @CODIGO_TIPO_COBRANCA 
            OR @CODIGO_TIPO_COBRANCA = 0 ) ;
DECLARE SET VARCHAR(255) @codigoclienteerp = '';

CREATE or replace VIEW   "VW_TIPO_COBRANCA_CLIENTE" 
AS 
  SELECT 1                                             AS ATIVO, 
         Concat(CASE 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 1 
                THEN Concat('000', Cast( cadcli61. 
                                        "vdclicli_regi" 
                                        AS 
                                        VARCHAR(4)) 
                     ) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 2 
                THEN Concat('00', Cast( cadcli61. "vdclicli_regi" 
                                       AS 
                                       VARCHAR(4))) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 3 
                THEN Concat('0', Cast( cadcli61. "vdclicli_regi" 
                                      AS 
                                      VARCHAR(4))) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 4 
                THEN Cast( cadcli61. "vdclicli_regi" AS VARCHAR(4 
                          )) 
                END, CASE 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 1 
                     THEN Concat('000', Cast( cadcli61. 
                                             "vdclicli_num" AS 
                                             VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 2 
                     THEN Concat('00', Cast( cadcli61. 
                                            "vdclicli_num" AS 
                                            VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 3 
                     THEN Concat('0', Cast( cadcli61. 
                                           "vdclicli_num" AS 
                                           VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 4 
                     THEN Cast( cadcli61. "vdclicli_num" AS 
                               VARCHAR 
                               (4)) 
                     END)                              AS CODIGO_CLIENTE_ERP, 
          cadcli61. "vdclicli_tpcobra" AS 
         CODIGO_TIPO_COBRANCA_ERP 
  FROM    cadcli61 
  WHERE  ( Concat(CASE 
                    WHEN Length(Cast( cadcli61. "vdclicli_regi" 
                                     AS 
                                     CHAR(4) 
                                )) 
                         = 1 
                  THEN Concat('000', Cast( cadcli61. 
                                          "vdclicli_regi" AS 
                                          VARCHAR(4)) 
                       ) 
                    WHEN Length(Cast( cadcli61. "vdclicli_regi" 
                                     AS 
                                     CHAR(4) 
                                )) 
                         = 2 
                  THEN Concat('00', Cast( cadcli61. 
                                         "vdclicli_regi" 
                                         AS 
                                         VARCHAR(4))) 
                    WHEN Length(Cast( cadcli61. "vdclicli_regi" 
                                     AS 
                                     CHAR(4) 
                                )) 
                         = 3 
                  THEN Concat('0', Cast( cadcli61. 
                                        "vdclicli_regi" 
                                        AS 
                                        VARCHAR(4))) 
                    WHEN Length(Cast( cadcli61. "vdclicli_regi" 
                                     AS 
                                     CHAR(4) 
                                )) 
                         = 4 
                  THEN Cast( cadcli61. "vdclicli_regi" AS VARCHAR 
                            (4 
                            )) 
                  END, CASE 
                         WHEN Length(Cast( cadcli61. 
                                          "vdclicli_num" 
                                          AS 
                                          CHAR( 
                                          4))) = 1 
                       THEN Concat('000', Cast( cadcli61. 
                                               "vdclicli_num" 
                                               AS 
                                               VARCHAR(4))) 
                         WHEN Length(Cast( cadcli61. 
                                          "vdclicli_num" 
                                          AS 
                                          CHAR( 
                                          4))) = 2 
                       THEN Concat('00', Cast( cadcli61. 
                                              "vdclicli_num" AS 
                                              VARCHAR(4))) 
                         WHEN Length(Cast( cadcli61. 
                                          "vdclicli_num" 
                                          AS 
                                          CHAR( 
                                          4))) = 3 
                       THEN Concat('0', Cast( cadcli61. 
                                             "vdclicli_num" AS 
                                             VARCHAR(4))) 
                         WHEN Length(Cast( cadcli61. 
                                          "vdclicli_num" 
                                          AS 
                                          CHAR( 
                                          4))) = 4 
                       THEN Cast( cadcli61. "vdclicli_num" AS 
                                 VARCHAR (4)) 
                       END) = @codigoclienteerp 
            OR @codigoclienteerp = '' )  ;

DECLARE SET VARCHAR(255) @SIGLA ='';
DECLARE SET int @ATIVO =0;
CREATE or replace VIEW  "VW_TIPO_ENDERECO" 
AS 
  SELECT @ATIVO                                    AS ATIVO, 
           "gegentip_cod"   AS DESCRICAO_LOGRADOURO, 
           "gegentip_sigla" AS SIGLA_LOGRADOURO 
  FROM   ceptip 
  WHERE  (   "gegentip_cod" = @sigla 
            OR @sigla = '' ) ;

DECLARE SET INT @ATIVO = 1;

CREATE or replace VIEW   "VW_TIPO_OCORRENCIA" 
AS 
  SELECT @ATIVO                                        AS ATIVO, 
         CASE  cadoco61. "vdnopoco_tipooco" 
           WHEN 01 THEN 'Vendas' 
           ELSE 
             CASE  cadoco61. "vdnopoco_tipooco" 
               WHEN 02 THEN 'Bonificacao' 
               ELSE 
                 CASE  cadoco61. "vdnopoco_tipooco" 
                   WHEN 03 THEN 'Troca' 
                   ELSE 
                     CASE  cadoco61. "vdnopoco_tipooco" 
                       WHEN 04 THEN 'Indenizacao' 
                       ELSE 
                         CASE  cadoco61. "vdnopoco_tipooco" 
                           WHEN 05 THEN 'Cev Recolhimento' 
                           ELSE 
                             CASE  cadoco61. "vdnopoco_tipooco" 
                               WHEN 06 THEN 'Cev Recolhimento FE' 
                               ELSE 
                                 CASE  cadoco61. 
                                      "vdnopoco_tipooco" 
                                   WHEN 07 THEN 'Cev Saida' 
                                   ELSE 
                                     CASE  cadoco61. 
                                          "vdnopoco_tipooco" 
                                       WHEN 08 THEN 'Cev Saida FE' 
                                       ELSE 
                                         CASE  cadoco61. 
                                              "vdnopoco_tipooco" 
                                           WHEN 09 THEN 'Cev Saida SL' 
                                           ELSE 
                                             CASE  cadoco61. 
                                                  "vdnopoco_tipooco" 
                                               WHEN 10 THEN 'Cev Saida FESL' 
                                               ELSE 
                                                 CASE  cadoco61. 
                                                      "vdnopoco_tipooco" 
                                                   WHEN 11 THEN 
                                                   'Bonificacao Solavanco' 
                                                   ELSE 
                                                     CASE 
                                              cadoco61. 
                                             "vdnopoco_tipooco" 
                                                       WHEN 12 THEN 
                                                       'Recolhimento CEV' 
                                                       ELSE 
                                 CASE  cadoco61. 
                                      "vdnopoco_tipooco" 
                                   WHEN 13 THEN 
                                   'Recolhimento CEV FE' 
                                   ELSE 
                                     CASE  cadoco61. 
                                          "vdnopoco_tipooco" 
                                       WHEN 14 THEN 
                                       'Recolhimento Vasilhame' 
                                       ELSE 
                                         CASE 
                                  cadoco61. 
                                 "vdnopoco_tipooco" 
                                           WHEN 15 THEN 
                                           'Recolhimento Vasilhame FE' 
                                           ELSE 
                                             CASE 
                                      cadoco61. 
                                     "vdnopoco_tipooco" 
                                               WHEN 16 THEN 'VIMOB' 
                                               ELSE 
                                                 CASE 
                                          cadoco61. 
                                         "vdnopoco_tipooco" 
                                                   WHEN 17 THEN 
                                                   'Inventario' 
                                                   ELSE 
                                                     CASE 
                                              cadoco61. 
                                             "vdnopoco_tipooco" 
                                                       WHEN 18 THEN 
                                                       'Descarga' 
                                                       ELSE 
                                             CASE 
                                      cadoco61. 
                                     "vdnopoco_tipooco" 
                                               WHEN 19 THEN 
                                               'Descarga Tipo01' 
                                               ELSE 
                                                 CASE 
                      cadoco61. 
                     "vdnopoco_tipooco" 
                     WHEN 20 THEN 'Venda Verba' 
                     ELSE 
                     CASE 
                      cadoco61. 
                     "vdnopoco_tipooco" 
                     WHEN 21 THEN 
                     'Bonificacao Automatica' 
                     ELSE 
                     CASE 
                      cadoco61. 
                     "vdnopoco_tipooco" 
                     WHEN 22 THEN 
                     'Transferencia' 
                     ELSE 
                     CASE 
                      cadoco61. 
                     "vdnopoco_tipooco" 
                     WHEN 99 THEN 
                     'Outros' 
                     END 
                     END 
                     END 
                     END 
                     END 
                     END 
                     END 
                     END 
                     END 
                     END 
                     END 
                     END 
                     END 
                     END 
                     END 
                     END 
                     END 
                     END 
                     END 
                     END 
                 END 
             END 
         END                                           AS DESCRICAO, 
          cadoco61. "vdnopoco_tipooco" AS 
            CODIGO_TIPO_OCORRENCIA_ERP 
  FROM    cadoco61 
  WHERE   cadoco61. "vdnopoco_tipooco" > 0 
  GROUP  BY descricao, 
            codigo_tipo_ocorrencia_erp 
  HAVING Count(DISTINCT  cadoco61. "vdnopoco_tipooco", 
                 cadoco61. "vdnopoco_tipooco" > 0) > 0 ;

DECLARE SET INT @CODIGO_CLIENTE = 0;
DECLARE SET INT @DATA_EMISSAO = 0;
DECLARE SET DECIMAL @VALORFINAL = 0;

CREATE or replace VIEW   "VW_VALIDA_DUP_PEDIDO" 
AS 
  SELECT  VDPEDCPP_PRE_PED
  FROM VDPEDCPP    
  WHERE  VDPEDCPP_CODCLI = @CODIGO_CLIENTE AND 
         VDPEDCPP_DTEMI  = @DATA_EMISSAO  AND
         VDPEDCPP_VLRFIN = @VALORFINAL ;
DECLARE SET VARCHAR(255) @CODIGO_VENDEDOR = '';
CREATE or replace VIEW   "VW_VENDEDOR" 
AS 
  SELECT 1                                           AS ATIVO, 
          cadven61. "vdvenven_sigla" AS CODIGO_VENDEDOR_ERP, 
          cadven61. "vdvenven_nome"  AS NOME, 
          cadven61. "vdvenven_ddd"   AS TELEFONE_DD, 
          cadven61. "vdvenven_tel"   AS TELEFONE_TRONCO, 
         '01'                        AS TIPO 
  FROM    cadven61 
  WHERE  (  cadven61. "vdvenven_sigla" = @CODIGO_VENDEDOR 
            OR @CODIGO_VENDEDOR = '' ) 
         AND (  cadven61. "vdvenven_nivel" = 4 
                OR  cadven61. "vdvenven_nivel" = 5 ) 
         AND (  cadven61. "vdvenven_tpven" = 'V' 
                OR  cadven61. "vdvenven_tpven" = 'R' ) ;

declare set varchar(255) @CODIGO_CLIENTE = '';
CREATE or replace VIEW   "VW_VENDEDOR_CLIENTE" 
AS 
  SELECT 1                                         AS ATIVO, 
         Concat(CASE 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 1 
                THEN Concat('000', Cast( cadcli61. 
                                        "vdclicli_regi" 
                                        AS 
                                        VARCHAR(4)) 
                     ) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 2 
                THEN Concat('00', Cast( cadcli61. "vdclicli_regi" 
                                       AS 
                                       VARCHAR(4))) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 3 
                THEN Concat('0', Cast( cadcli61. "vdclicli_regi" 
                                      AS 
                                      VARCHAR(4))) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 4 
                THEN Cast( cadcli61. "vdclicli_regi" AS VARCHAR(4 
                          )) 
                END, CASE 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 1 
                     THEN Concat('000', Cast( cadcli61. 
                                             "vdclicli_num" AS 
                                             VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 2 
                     THEN Concat('00', Cast( cadcli61. 
                                            "vdclicli_num" AS 
                                            VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 3 
                     THEN Concat('0', Cast( cadcli61. 
                                           "vdclicli_num" AS 
                                           VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 4 
                     THEN Cast( cadcli61. "vdclicli_num" AS 
                               VARCHAR 
                               (4)) 
                     END)                          AS CODIGO_CLIENTE_ERP, 
          cadcli61. "vdclicli_ven" AS CODIGO_VENDEDOR_ERP 
  FROM    cadcli61 
  WHERE  (  Concat(CASE 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 1 
                THEN Concat('000', Cast( cadcli61. 
                                        "vdclicli_regi" 
                                        AS 
                                        VARCHAR(4)) 
                     ) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 2 
                THEN Concat('00', Cast( cadcli61. "vdclicli_regi" 
                                       AS 
                                       VARCHAR(4))) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 3 
                THEN Concat('0', Cast( cadcli61. "vdclicli_regi" 
                                      AS 
                                      VARCHAR(4))) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 4 
                THEN Cast( cadcli61. "vdclicli_regi" AS VARCHAR(4 
                          )) 
                END, CASE 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 1 
                     THEN Concat('000', Cast( cadcli61. 
                                             "vdclicli_num" AS 
                                             VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 2 
                     THEN Concat('00', Cast( cadcli61. 
                                            "vdclicli_num" AS 
                                            VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 3 
                     THEN Concat('0', Cast( cadcli61. 
                                           "vdclicli_num" AS 
                                           VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 4 
                     THEN Cast( cadcli61. "vdclicli_num" AS 
                               VARCHAR 
                               (4)) 
                     END)  = @CODIGO_CLIENTE
            OR @CODIGO_CLIENTE = '' ) 
          
          OR (SELECT  tbblocli. "vdcadblo_impclipalm" 
              FROM    tbblocli 
              WHERE   tbblocli. "vdcadblo_cod" = 
                      cadcli61. "vdclicli_motblo") = 1 
  UNION 
  SELECT 1                                          AS ATIVO, 
         Concat(CASE 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 1 
                THEN Concat('000', Cast( cadcli61. 
                                        "vdclicli_regi" 
                                        AS 
                                        VARCHAR(4)) 
                     ) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 2 
                THEN Concat('00', Cast( cadcli61. "vdclicli_regi" 
                                       AS 
                                       VARCHAR(4))) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 3 
                THEN Concat('0', Cast( cadcli61. "vdclicli_regi" 
                                      AS 
                                      VARCHAR(4))) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 4 
                THEN Cast( cadcli61. "vdclicli_regi" AS VARCHAR(4 
                          )) 
                END, CASE 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 1 
                     THEN Concat('000', Cast( cadcli61. 
                                             "vdclicli_num" AS 
                                             VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 2 
                     THEN Concat('00', Cast( cadcli61. 
                                            "vdclicli_num" AS 
                                            VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 3 
                     THEN Concat('0', Cast( cadcli61. 
                                           "vdclicli_num" AS 
                                           VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 4 
                     THEN Cast( cadcli61. "vdclicli_num" AS 
                               VARCHAR 
                               (4)) 
                     END)                           AS CODIGO_CLIENTE_ERP, 
          cadcli61. "vdclicli_ven2" AS CODIGO_VENDEDOR_ERP 
  FROM    cadcli61 
  WHERE  (  Concat(CASE 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 1 
                THEN Concat('000', Cast( cadcli61. 
                                        "vdclicli_regi" 
                                        AS 
                                        VARCHAR(4)) 
                     ) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 2 
                THEN Concat('00', Cast( cadcli61. "vdclicli_regi" 
                                       AS 
                                       VARCHAR(4))) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 3 
                THEN Concat('0', Cast( cadcli61. "vdclicli_regi" 
                                      AS 
                                      VARCHAR(4))) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 4 
                THEN Cast( cadcli61. "vdclicli_regi" AS VARCHAR(4 
                          )) 
                END, CASE 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 1 
                     THEN Concat('000', Cast( cadcli61. 
                                             "vdclicli_num" AS 
                                             VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 2 
                     THEN Concat('00', Cast( cadcli61. 
                                            "vdclicli_num" AS 
                                            VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 3 
                     THEN Concat('0', Cast( cadcli61. 
                                           "vdclicli_num" AS 
                                           VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 4 
                     THEN Cast( cadcli61. "vdclicli_num" AS 
                               VARCHAR 
                               (4)) 
                     END)  = @CODIGO_CLIENTE
            OR @CODIGO_CLIENTE = '' )
         AND  cadcli61. "vdclicli_ven2" <> '   ' 
          
          OR (SELECT  tbblocli. "vdcadblo_impclipalm" 
              FROM    tbblocli 
              WHERE   tbblocli. "vdcadblo_cod" = 
                      cadcli61. "vdclicli_motblo") = 1 
  UNION 
  SELECT 1                                          AS ATIVO, 
         Concat(CASE 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 1 
                THEN Concat('000', Cast( cadcli61. 
                                        "vdclicli_regi" 
                                        AS 
                                        VARCHAR(4)) 
                     ) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 2 
                THEN Concat('00', Cast( cadcli61. "vdclicli_regi" 
                                       AS 
                                       VARCHAR(4))) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 3 
                THEN Concat('0', Cast( cadcli61. "vdclicli_regi" 
                                      AS 
                                      VARCHAR(4))) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 4 
                THEN Cast( cadcli61. "vdclicli_regi" AS VARCHAR(4 
                          )) 
                END, CASE 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 1 
                     THEN Concat('000', Cast( cadcli61. 
                                             "vdclicli_num" AS 
                                             VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 2 
                     THEN Concat('00', Cast( cadcli61. 
                                            "vdclicli_num" AS 
                                            VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 3 
                     THEN Concat('0', Cast( cadcli61. 
                                           "vdclicli_num" AS 
                                           VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 4 
                     THEN Cast( cadcli61. "vdclicli_num" AS 
                               VARCHAR 
                               (4)) 
                     END)                           AS CODIGO_CLIENTE_ERP, 
          cadcli61. "vdclicli_ven3" AS CODIGO_VENDEDOR_ERP 
  FROM    cadcli61 
  WHERE  (  Concat(CASE 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 1 
                THEN Concat('000', Cast( cadcli61. 
                                        "vdclicli_regi" 
                                        AS 
                                        VARCHAR(4)) 
                     ) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 2 
                THEN Concat('00', Cast( cadcli61. "vdclicli_regi" 
                                       AS 
                                       VARCHAR(4))) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 3 
                THEN Concat('0', Cast( cadcli61. "vdclicli_regi" 
                                      AS 
                                      VARCHAR(4))) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 4 
                THEN Cast( cadcli61. "vdclicli_regi" AS VARCHAR(4 
                          )) 
                END, CASE 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 1 
                     THEN Concat('000', Cast( cadcli61. 
                                             "vdclicli_num" AS 
                                             VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 2 
                     THEN Concat('00', Cast( cadcli61. 
                                            "vdclicli_num" AS 
                                            VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 3 
                     THEN Concat('0', Cast( cadcli61. 
                                           "vdclicli_num" AS 
                                           VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 4 
                     THEN Cast( cadcli61. "vdclicli_num" AS 
                               VARCHAR 
                               (4)) 
                     END)  = @CODIGO_CLIENTE
            OR @CODIGO_CLIENTE = '' ) 
         AND  cadcli61. "vdclicli_ven3" <> '   ' 
          
          OR (SELECT  tbblocli. "vdcadblo_impclipalm" 
              FROM    tbblocli 
              WHERE   tbblocli. "vdcadblo_cod" = 
                      cadcli61. "vdclicli_motblo") = 1 
  UNION 
  SELECT 1                                          AS ATIVO, 
         Concat(CASE 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 1 
                THEN Concat('000', Cast( cadcli61. 
                                        "vdclicli_regi" 
                                        AS 
                                        VARCHAR(4)) 
                     ) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 2 
                THEN Concat('00', Cast( cadcli61. "vdclicli_regi" 
                                       AS 
                                       VARCHAR(4))) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 3 
                THEN Concat('0', Cast( cadcli61. "vdclicli_regi" 
                                      AS 
                                      VARCHAR(4))) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 4 
                THEN Cast( cadcli61. "vdclicli_regi" AS VARCHAR(4 
                          )) 
                END, CASE 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 1 
                     THEN Concat('000', Cast( cadcli61. 
                                             "vdclicli_num" AS 
                                             VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 2 
                     THEN Concat('00', Cast( cadcli61. 
                                            "vdclicli_num" AS 
                                            VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 3 
                     THEN Concat('0', Cast( cadcli61. 
                                           "vdclicli_num" AS 
                                           VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 4 
                     THEN Cast( cadcli61. "vdclicli_num" AS 
                               VARCHAR 
                               (4)) 
                     END)                           AS CODIGO_CLIENTE_ERP, 
          cadcli61. "vdclicli_ven4" AS CODIGO_VENDEDOR_ERP 
  FROM    cadcli61 
  WHERE (  Concat(CASE 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 1 
                THEN Concat('000', Cast( cadcli61. 
                                        "vdclicli_regi" 
                                        AS 
                                        VARCHAR(4)) 
                     ) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 2 
                THEN Concat('00', Cast( cadcli61. "vdclicli_regi" 
                                       AS 
                                       VARCHAR(4))) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 3 
                THEN Concat('0', Cast( cadcli61. "vdclicli_regi" 
                                      AS 
                                      VARCHAR(4))) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 4 
                THEN Cast( cadcli61. "vdclicli_regi" AS VARCHAR(4 
                          )) 
                END, CASE 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 1 
                     THEN Concat('000', Cast( cadcli61. 
                                             "vdclicli_num" AS 
                                             VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 2 
                     THEN Concat('00', Cast( cadcli61. 
                                            "vdclicli_num" AS 
                                            VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 3 
                     THEN Concat('0', Cast( cadcli61. 
                                           "vdclicli_num" AS 
                                           VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 4 
                     THEN Cast( cadcli61. "vdclicli_num" AS 
                               VARCHAR 
                               (4)) 
                     END)  = @CODIGO_CLIENTE
            OR @CODIGO_CLIENTE = '' ) and  cadcli61. "vdclicli_ven4" <> '   ' 
          
          OR (SELECT  tbblocli. "vdcadblo_impclipalm" 
              FROM    tbblocli 
              WHERE   tbblocli. "vdcadblo_cod" = 
                      cadcli61. "vdclicli_motblo") = 1 
  UNION 
  SELECT 1                                          AS ATIVO, 
         Concat(CASE 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 1 
                THEN Concat('000', Cast( cadcli61. 
                                        "vdclicli_regi" 
                                        AS 
                                        VARCHAR(4)) 
                     ) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 2 
                THEN Concat('00', Cast( cadcli61. "vdclicli_regi" 
                                       AS 
                                       VARCHAR(4))) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 3 
                THEN Concat('0', Cast( cadcli61. "vdclicli_regi" 
                                      AS 
                                      VARCHAR(4))) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 4 
                THEN Cast( cadcli61. "vdclicli_regi" AS VARCHAR(4 
                          )) 
                END, CASE 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 1 
                     THEN Concat('000', Cast( cadcli61. 
                                             "vdclicli_num" AS 
                                             VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 2 
                     THEN Concat('00', Cast( cadcli61. 
                                            "vdclicli_num" AS 
                                            VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 3 
                     THEN Concat('0', Cast( cadcli61. 
                                           "vdclicli_num" AS 
                                           VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 4 
                     THEN Cast( cadcli61. "vdclicli_num" AS 
                               VARCHAR 
                               (4)) 
                     END)                           AS CODIGO_CLIENTE_ERP, 
          cadcli61. "vdclicli_ven5" AS CODIGO_VENDEDOR_ERP 
  FROM    cadcli61 
  WHERE (  Concat(CASE 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 1 
                THEN Concat('000', Cast( cadcli61. 
                                        "vdclicli_regi" 
                                        AS 
                                        VARCHAR(4)) 
                     ) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 2 
                THEN Concat('00', Cast( cadcli61. "vdclicli_regi" 
                                       AS 
                                       VARCHAR(4))) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 3 
                THEN Concat('0', Cast( cadcli61. "vdclicli_regi" 
                                      AS 
                                      VARCHAR(4))) 
                  WHEN Length(Cast( cadcli61. "vdclicli_regi" AS 
                                   CHAR(4))) 
                       = 4 
                THEN Cast( cadcli61. "vdclicli_regi" AS VARCHAR(4 
                          )) 
                END, CASE 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 1 
                     THEN Concat('000', Cast( cadcli61. 
                                             "vdclicli_num" AS 
                                             VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 2 
                     THEN Concat('00', Cast( cadcli61. 
                                            "vdclicli_num" AS 
                                            VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 3 
                     THEN Concat('0', Cast( cadcli61. 
                                           "vdclicli_num" AS 
                                           VARCHAR(4))) 
                       WHEN Length(Cast( cadcli61. "vdclicli_num" 
                                        AS CHAR( 
                                        4))) = 4 
                     THEN Cast( cadcli61. "vdclicli_num" AS 
                               VARCHAR 
                               (4)) 
                     END)  = @CODIGO_CLIENTE
            OR @CODIGO_CLIENTE = '' )
        AND  cadcli61. "vdclicli_ven5" <> '   ' 
         
         OR (SELECT  tbblocli. "vdcadblo_impclipalm" 
             FROM    tbblocli 
             WHERE   tbblocli. "vdcadblo_cod" = 
                     cadcli61. "vdclicli_motblo") = 1 ;


       
       