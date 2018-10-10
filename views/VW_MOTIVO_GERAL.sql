


CREATE
or replace VIEW  VW_MOTIVO_GERAL AS
SELECT
    1 AS ativo,
    Cast(bnftip61."vdpedbnf_cod" AS CHAR(3)) AS codigo_motivo_geral,
    bnftip61."vdpedbnf_descricao" AS descricao,
    NULL AS descricao_reduzida,
    0 AS infui_venda,
    bnftip61."vdpedbnf_influi_verba" AS permite_venda,
    '01' AS tipo_motivo_geral_rec_id
FROM
     BNFTIP61
WHERE
    bnftip61."vdpedbnf_cancsn" = 0
    AND bnftip61."vdpedbnf_carrega_palm" = 1
UNION ALL
SELECT
    1 AS ativo,
    tbtroca."vdcadtro_cod" AS codigo_motivo_geral,
    tbtroca."vdcadtro_descr" AS descricao,
    tbtroca."vdcadtro_descrred" AS descricao_reduzida,
    0 AS infui_venda,
    0 AS permite_venda,
    CASE WHEN tbtroca."vdcadtro_tipo" = 1 THEN '02' ELSE '03' END AS tipo_motivo_geral_rec_id
FROM
     TBTROCA
WHERE
    tbtroca."vdcadtro_cancsn" = 0
UNION ALL
SELECT
    1 AS ativo,
    tipcev61."vdcevtip_cod" AS codigo_motivo_geral,
    tipcev61."vdcevtip_nome" AS descricao,
    NULL AS descricao_reduzida,
    0 AS infui_venda,
    0 AS permite_venda,
    CASE WHEN tipcev61."vdcevtip_operacao" = 1 THEN '04' ELSE CASE WHEN tipcev61."vdcevtip_operacao" = 3 THEN '03' ELSE '05' END END AS tipo_motivo_geral_rec_id
FROM
     TIPCEV61
UNION ALL
SELECT
    1 AS ativo,
    tbblocli."vdcadblo_cod" AS codigo_motivo_geral,
    tbblocli."vdcadblo_descr" AS descricao,
    tbblocli."vdcadblo_descrred" AS descricao_reduzida,
    tbblocli."vdcadblo_venda" AS infui_venda,
    0 AS permite_venda,
    '06' AS tipo_motivo_geral_rec_id
FROM
     TBBLOCLI
UNION ALL
SELECT
    1 AS ativo,
    Cast(motcanpd."vdcadmdc_cod" AS CHAR(3)) AS codigo_motivo_geral,
    motcanpd."vdcadmdc_descr" AS descricao,
    motcanpd."vdcadmdc_descrred" AS descricao_reduzida,
    0 AS infui_venda,
    0 AS permite_venda,
    '08' AS tipo_motivo_geral_rec_id
FROM
     MOTCANPD
UNION ALL
SELECT
    1 AS ativo,
    tbdevol."vdcaddev_cod" AS codigo_motivo_geral,
    tbdevol."vdcaddev_descr" AS descricao,
    tbdevol."vdcaddev_descrred" AS descricao_reduzida,
    0 AS infui_venda,
    0 AS permite_venda,
    '09' AS tipo_motivo_geral_rec_id
FROM
     TBDEVOL
WHERE
    tbdevol."vdcaddev_cancsn" = 0
UNION ALL
SELECT
    1 AS ativo,
    tbncol."vdcadnco_cod" AS codigo_motivo_geral,
    tbncol."vdcadnco_descr" AS descricao,
    tbncol."vdcadnco_descrred" AS descricao_reduzida,
    0 AS infui_venda,
    0 AS permite_venda,
    '10' AS tipo_motivo_geral_rec_id
FROM
     TBNCOL
UNION ALL
SELECT
    1 AS ativo,
    tbncol."vdcadnco_cod" AS codigo_motivo_geral,
    tbncol."vdcadnco_descr" AS descricao,
    tbncol."vdcadnco_descrred" AS descricao_reduzida,
    0 AS infui_venda,
    0 AS permite_venda,
    '18' AS tipo_motivo_geral_rec_id
FROM
     TBNCOL
WHERE
    tbncol."vdcadnco_cod" = 'I'
    OR tbncol."vdcadnco_cod" = 'F'
    OR tbncol."vdcadnco_cod" = 'N'
UNION ALL
SELECT
    1 AS ativo,
    Cast(tabblq61."vdcadbpd_cod" AS CHAR(3)) AS codigo_motivo_geral,
    tabblq61."vdcadbpd_descr" AS descricao,
    tabblq61."vdcadbpd_descr" AS descricao_reduzida,
    0 AS infui_venda,
    0 AS permite_venda,
    '99' AS tipo_motivo_geral_rec_id
FROM
     TABBLQ61
WHERE
    tabblq61."vdcadbpd_cancsn" = 0;