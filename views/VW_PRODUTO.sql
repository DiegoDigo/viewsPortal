declare set int @DISP_PORTAL_WEB = 1;
DECLARE SET INT @CODIGO_PROD = 0;
DECLARE SET INT @CODIGO_FAMILIA = 0;
DECLARE SET INT @CODIGO_SEQUENCIA = 0;


CREATE
or replace VIEW  VW_PRODUTO AS
SELECT
    CASE WHEN cadprd61."vdprdprd_flag" = 'A' THEN 1 ELSE 0 END AS ATIVO,
    cadprd61."vdprdprd_bonifica_unid" AS BONIFICA_UNIDADE,
    cadprd61."vdprdprd_clasf" AS CLASS_FISCAL,
    NULL AS CODIGO_EAN_FAB,
    cadprd61."vdprdprd_codr" AS CODIGO_PRODUTO_ERP,
    cadprd61."vdprdprd_descr" AS DESCRICAO,
    cadprd61."vdprdprd_descri" AS DESCRICAO_RED,
    cadprd61."vdprdprd_ipipauta" AS IPI_PAUTA,
    cadprd61."vdprdprd_linha" AS LINHA,
    cadprd61."vdprdprd_medida" AS LITRAGEM,
    NULL AS PERCENTUAL_BONUS_GERA,
    NULL AS PERCENTUAL_BONUS_USA,
    cadprd61."vdprdprd_permite_bonif" AS PERMITE_BONIFICACAO,
    cadprd61."vdprdprd_peso" AS PESO,
    cadprd61."vdprdprd_pesoemb" AS PESO_EMB,
    cadprd61."vdprdprd_qtdminvd" AS QTD_MIN_VENDA_AV,
    NULL AS QTD_MIN_VENDA_CX,
    cadprd61."vdprdprd_qtdun" AS QUANTIDADE_CX,
    cadprd61."vdprdprd_tipobanda" AS TIPO_BANDA,
    cadprd61."vdprdprd_tipo" AS TIPO_PRODUTO,
    NULL AS UTILIZA_BANDA_PRECO_TIPO,
    NULL AS VALOR_MINIMO_BONUS,
    cadprd61."vdprdprd_tipoqtdvdcx" AS VENDA_MULTI_MIN_CX,
    cadprd61."vdprdprd_tipoqtdvd" AS VENDA_MULTI_MIN_AV,
    CASE WHEN cadprd61."vdprdprd_enc" = 'S' THEN 1 ELSE 0 END AS VENDA_AVULSO,
    CASE WHEN cadprd61."vdprdprd_tipo" = 'P' THEN 1 ELSE 0 END AS VISIBILIDADE_PORTAL,
    cadprd61."vdprdprd_catprd" AS CODIGO_CATEGORIA_PRODUTO_ERP,
    cadprd61."vdprdprd_cfam" AS CODIGO_FAMILIA_PRODUTO_ERP,
    cadprd61."vdprdprd_grpprd" AS CODIGO_GRUPO_PRODUTO_ERP,
    cadprd61."vdprdprd_marprd" AS CODIGO_MARCA_PRODUTO_ERP,
    cadprd61."vdprdprd_disp_portal_web" AS DISP_PORTAL_WEB
FROM
     CADPRD61
WHERE
    cadprd61."vdprdprd_cfam" > @CODIGO_FAMILIA
    AND cadprd61."vdprdprd_nro" > @CODIGO_SEQUENCIA
    AND cadprd61."vdprdprd_flag" = 'A'
    AND (
        cadprd61."vdprdprd_disp_portal_web" = @DISP_PORTAL_WEB
        or @DISP_PORTAL_WEB = 2
    )
    AND (
        cadprd61."vdprdprd_codr" = @CODIGO_PROD
        OR @CODIGO_PROD = 0
    );