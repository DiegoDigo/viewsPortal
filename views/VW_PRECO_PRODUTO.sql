DECLARE SET BIGINT @COD_PRODUTO = 0;
DECLARE SET BIGINT @COD_TABELA = 0;


CREATE
or replace VIEW  VW_PRECO_PRODUTO AS
SELECT
    tabprc61."vdtabprd_aliqpvv" AS aliq_pvv,
    cadprd61."vdprdprd_disp_portal_web" AS ativo,
    Cast(
        Cast(
            Cast(tabprc61."vdtabprd_ano" AS CHAR(04)) || CASE WHEN tabprc61."vdtabprd_mes" <= 9 THEN Concat(
                '0',
                Cast(tabprc61."vdtabprd_mes" AS CHAR (1))
            ) ELSE Cast(tabprc61."vdtabprd_mes" AS CHAR (2)) END || CASE WHEN tabprc61."vdtabprd_nmes" <= 9 THEN Concat(
                '0',
                Cast(tabprc61."vdtabprd_nmes" AS CHAR(1))
            ) ELSE Cast(tabprc61."vdtabprd_nmes" AS CHAR(2)) END AS CHAR(08)
        ) AS BIGINT
    ) AS codigo_tabpreco_erp,
    tabprc61."vdtabprd_daicmo" AS da_icm_o,
    tabprc61."vdtabprd_desc" AS desconto,
    tabprc61."vdtabprd_descmax" AS desconto_maximo,
    tabprc61."vdtabprd_descvb" AS desconto_verba,
    tabprc61."vdtabprd_despac" AS despac,
    tabprc61."vdtabprd_tipotab" AS origem_tabela,
    tabprc61."vdtabprd_participabda" AS participa_banda_preco,
    NULL AS preco_custo_caixa,
    NULL AS preco_custo_un,
    tabprc61."vdtabprd_precopvv" AS preco_pvv,
    NULL AS promocao,
    tabprc61."vdtabprd_restr_comerciais" AS restricao,
    tabprc61."vdtabprd_selo" AS selo,
    tabprc61."vdtabprd_tpcont" AS tp_cont,
    NULL AS uf_table_preco,
    tabprc61."vdtabprd_valicm" AS val_icms,
    tabprc61."vdtabprd_valipi" AS val_ipi,
    tabprc61."vdtabprd_preco" AS valor,
    cadprd61."vdprdprd_codr" AS codigo_produto_erp,
    tabprc61."vdtabprd_dtvgf" AS fim
FROM
     CADPRD61
    INNER JOIN  TABPRC61 ON cadprd61."vdprdprd_cfam" = tabprc61."vdtabprd_cfam"
    AND cadprd61."vdprdprd_nro" = tabprc61."vdtabprd_nro"
    AND cadprd61."vdprdprd_disp_portal_web" <> 0
    AND LEFT(Cast(tabprc61.vdtabprd_dtvgf AS VARCHAR(8)), 4) >= LEFT(Cast(Curdate() - 365 AS CHAR(4)), 4)
    INNER JOIN  PAROCO61 ON tabprc61."vdtabprd_ano" = PAROCO61."VDPAROCO_ANOTAB_CARGA"
    AND tabprc61."vdtabprd_mes" = PAROCO61."VDPAROCO_MESTAB_CARGA"
WHERE
    (
        cadprd61."VDPRDPRD_CODR" = @COD_PRODUTO
        OR @COD_PRODUTO = 0
    )
    AND (
        Cast(
            Cast(
                Cast(tabprc61."vdtabprd_ano" AS CHAR(04)) || CASE WHEN tabprc61."vdtabprd_mes" <= 9 THEN Concat(
                    '0',
                    Cast(tabprc61."vdtabprd_mes" AS CHAR (1))
                ) ELSE Cast(tabprc61."vdtabprd_mes" AS CHAR (2)) END || CASE WHEN tabprc61."vdtabprd_nmes" <= 9 THEN Concat(
                    '0',
                    Cast(tabprc61."vdtabprd_nmes" AS CHAR(1))
                ) ELSE Cast(tabprc61."vdtabprd_nmes" AS CHAR(2)) END AS CHAR(08)
            ) AS BIGINT
        ) = @COD_TABELA
        OR @COD_TABELA = 0
    );