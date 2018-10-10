DECLARE SET VARCHAR(255) @CODIGO_OCORRENCIA ='';

CREATE
or replace VIEW  VW_OCORRENCIA AS
SELECT
    CASE WHEN cadoco61."vdnopoco_cancsn" = 0 THEN 1 ELSE 0 END AS ATIVO,
    cadoco61."vdnopoco_cod" AS CODIGO_OCORRENCIA_ERP,
    cadoco61."vdnopoco_nome" AS DESCRICAO,
    cadoco61."vdnopoco_nomer" AS DESCRICAO_REDUZIDA,
    cadoco61."vdnopoco_desdobro" AS DESDOBRO,
    NULL AS EMPRESA,
    CASE WHEN cadoco61."vdnopoco_totven" = 'S' THEN 1 ELSE 0 END AS GERA_MOTIVO_FINANC,
    1 AS OCORR_DISP_PORTAL,
    cadoco61."vdnopoco_sinal" AS SINAL,
    cadoco61."vdnopoco_tipo" AS TIPO,
    cadoco61."vdnopoco_tpprd" AS TIPO_PRODUTO,
    Concat(
        '0',
        Cast(cadoco61."vdnopoco_tipooco" AS VARCHAR(2))
    ) AS CODIGO_TIPO_OCORRENCIA_ERP,
    vdnoot61."vdnopotp_natop" AS NATUREZA_OPERACAO
FROM
     CADOCO61
    INNER JOIN  VDNOOT61 ON vdnoot61."vdnopotp_oco" = Cast(cadoco61."vdnopoco_cod" AS SMALLINT)
WHERE
    cadoco61."vdnopoco_tipooco" = 1
    AND cadoco61."vdnopoco_cod" = '001'
    AND vdnoot61."vdnopotp_tipo_prod" = 'P'
    AND (
        cadoco61."vdnopoco_cod" = @CODIGO_OCORRENCIA
        OR @CODIGO_OCORRENCIA = ''
    );