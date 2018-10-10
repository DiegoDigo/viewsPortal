declare set varchar(255) @codigo_restricao = '';

CREATE
or replace VIEW  VW_RESTRICAO_FINANCEIRA_CAPA AS
SELECT
    1 AS ativo,
    concat(
        case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
        case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
    ) AS codigo_restricao_financeira,
    txpalm61."vdcnftxp_descto" AS desconto,
    txpalm61."vdcnftxp_descmax" AS desconto_maximo,
    txpalm61."vdcnftxp_taxa" AS taxa,
    txpalm61."vdcnftxp_vrpedmax" AS valor_maximo_pedido,
    txpalm61."vdcnftxp_vlrpedmin" AS valor_minimo_pedido,
    txpalm61."vdcnftxp_cpg" AS codigo_condicao_pagamento_rec_id,
    txpalm61."vdcnftxp_tpcobr" AS codigo_tipo_cobranca_rec_id
FROM
     TXPALM61
where
    (
        concat(
            case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
            case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
        ) = @codigo_restricao
        or @codigo_restricao = ''
    );