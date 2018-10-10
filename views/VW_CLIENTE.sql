DECLARE SET INT @CODIGO_CLIENTE = 0;
CREATE OR replace VIEW  vw_cliente AS SELECT 0 AS abate_icms,
       CASE 
              WHEN cadcli61. "vdclicli_classe" = 20 THEN 0 
              ELSE 1 
       END AS ativo, 
              Concat( 
       CASE 
              WHEN Length(Cast( cadcli61. "vdclicli_regi" AS CHAR(4))) = 1 THEN Concat('000', Cast( cadcli61. "vdclicli_regi" AS VARCHAR(4)) )
              WHEN Length(Cast( cadcli61. "vdclicli_regi" AS CHAR(4))) = 2 THEN Concat('00', Cast( cadcli61. "vdclicli_regi" AS VARCHAR(4)))
              WHEN Length(Cast( cadcli61. "vdclicli_regi" AS CHAR(4))) = 3 THEN Concat('0', Cast( cadcli61. "vdclicli_regi" AS VARCHAR(4)))
              WHEN Length(Cast( cadcli61. "vdclicli_regi" AS CHAR(4))) = 4 THEN Cast( cadcli61. "vdclicli_regi" AS VARCHAR(4 ))
       END, 
       CASE 
              WHEN Length(Cast( cadcli61. "vdclicli_num" AS CHAR( 4))) = 1 THEN Concat('000', Cast( cadcli61. "vdclicli_num" AS VARCHAR(4)))
              WHEN Length(Cast( cadcli61. "vdclicli_num" AS CHAR( 4))) = 2 THEN Concat('00', Cast( cadcli61. "vdclicli_num" AS VARCHAR(4)))
              WHEN Length(Cast( cadcli61. "vdclicli_num" AS CHAR( 4))) = 3 THEN Concat('0', Cast( cadcli61. "vdclicli_num" AS VARCHAR(4)))
              WHEN Length(Cast( cadcli61. "vdclicli_num" AS CHAR( 4))) = 4 THEN Cast( cadcli61. "vdclicli_num" AS VARCHAR (4))
       END)                        AS codigo_cliente_erp, 
       NULL                        AS bonus_disponivel, 
       cadcli61. "vdclicli_classe" AS classe, 
       Cast(vdparoco_anotab_carga AS VARCHAR(4)) 
              || 
       CASE 
              WHEN Length(Cast(vdparoco_mestab_carga AS VARCHAR(2))) = 1 THEN '0' 
                            ||Cast(vdparoco_mestab_carga AS VARCHAR(2)) 
              ELSE Cast(vdparoco_mestab_carga AS            VARCHAR(2)) 
       END 
              || RIGHT(Cast(cadcli61.vdclicli_tbprd AS VARCHAR(8)),2) AS codigo_tabpreco, 
       cadcli61. "vdclicli_contato"                                   AS contato, 
       cadcli61. "vdclicli_cgc"                                       AS cpf_cnpj, 
       cadcli61. "vdclicli_abona_tx_financ"                           AS despreza_taxa_financeira,
       0                                                              AS dia_semana, 
       cadcli61. "vdclicli_dias_entrega"                              AS dias_entrega , 
       cadcli61. "vdclicli_email"                                     AS email, 
       cadcli61. "vdclicli_ignora_banda_preco"                        AS ignora_banda_preco, 
       NULL                                                           AS inconformidade_cadastro,
       cadcli61. "vdclicli_credito"                                   AS limite_credito , 
       cadcli61. "vdclicli_motblo"                                    AS motivo_bloq_classe_20, 
       cadcli61. "vdclicli_motblo_jur"                                AS motivo_bloqueio_juridico,
       cadcli61. "vdclicli_num"                                       AS numero_cliente , 
       cadcli61. "vdclicli_codpasta1"                                 AS pasta, 
       cadcli61. "vdclicli_razao50"                                   AS razao_social , 
       cadcli61. "vdclicli_regi"                                      AS regiao_cliente , 
       NULL                                                           AS registro_alterado, 
       cadcli61. "vdclicli_restr_comerciais"                          AS restircao_comercial, 
       cadcli61. "vdclicli_sigla"                                     AS sigla, 
       cadcli61. "vdclicli_subcanal"                                  AS sub_canal, 
       CASE 
              WHEN Char_length(Cast( cadcli61. "vdclicli_fone" AS CHAR (12))) = 11 THEN Subblobtochar(Cast( cadcli61. "vdclicli_fone" AS CHAR(12)), 1, 2)
              ELSE '0' 
       END AS telefone_ddd, 
       CASE 
              WHEN Char_length(Cast( cadcli61. "vdclicli_fone" AS CHAR (12))) <= 9 THEN Cast( cadcli61. "vdclicli_fone" AS CHAR ( 12))
              ELSE 
                     CASE 
                            WHEN Char_length(Cast( cadcli61. "vdclicli_fone" AS   CHAR(12 ))) = 1 THEN '0'
                            ELSE Subblobtochar(Cast( cadcli61. "vdclicli_fone" AS CHAR( 12)), 3, 11 )
                     END 
       END                                  AS telefone_tronco, 
       cadcli61. "vdclicli_verba_fin_pro"   AS uso_verba_restrito_produto, 
       cadcli61. "vdclicli_cat"             AS codigo_canal_erp, 
       cadcli61. "vdclicli_cpg"             AS codigo_condicao_pagamento_erp, 
       cadcli61. "vdclicli_tpcobra"         AS codigo_tipo_cobranca_erp , 
       cadcli61. "vdclicli_disp_portal_web" AS disponivel_portal 
FROM    cadcli61 , 
        paroco61 
WHERE  ( 
              Cast(Concat( 
              CASE 
                     WHEN Length(Cast( cadcli61. "vdclicli_regi" AS CHAR (4)) ) = 1 THEN Concat('000', Cast( cadcli61. "vdclicli_regi" AS VARCHAR(4)) )
                     WHEN Length(Cast( cadcli61. "vdclicli_regi" AS CHAR (4)) ) = 2 THEN Concat('00', Cast( cadcli61. "vdclicli_regi" AS VARCHAR(4)))
                     WHEN Length(Cast( cadcli61. "vdclicli_regi" AS CHAR (4)) ) = 3 THEN Concat('0', Cast( cadcli61. "vdclicli_regi" AS VARCHAR(4)))
                     WHEN Length(Cast( cadcli61. "vdclicli_regi" AS CHAR (4)) ) = 4 THEN Cast( cadcli61. "vdclicli_regi" AS VARCHAR (4) )
              END, 
              CASE 
                     WHEN Length(Cast( cadcli61. "vdclicli_num" AS CHAR( 4))) = 1 THEN Concat('000', Cast( cadcli61. "vdclicli_num" AS VARCHAR(4)))
                     WHEN Length(Cast( cadcli61. "vdclicli_num" AS CHAR( 4))) = 2 THEN Concat('00', Cast( cadcli61. "vdclicli_num" AS VARCHAR(4)))
                     WHEN Length(Cast( cadcli61. "vdclicli_num" AS CHAR( 4))) = 3 THEN Concat('0', Cast( cadcli61. "vdclicli_num" AS VARCHAR(4)))
                     WHEN Length(Cast( cadcli61. "vdclicli_num" AS CHAR( 4))) = 4 THEN Cast( cadcli61. "vdclicli_num" AS VARCHAR ( 4))
              END) AS INTEGER) = @CODIGO_CLIENTE 
       OR     @CODIGO_CLIENTE = 0 );