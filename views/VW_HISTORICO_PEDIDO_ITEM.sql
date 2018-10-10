DECLARE SET VARCHAR(255) @NUMERO_PEDIDO = '';

CREATE
or replace VIEW  VW_HISTORICO_PEDIDO_ITEM AS
SELECT
    pedit61."vdpedipe_item" AS NUMERO_ITEM_PEDIDO,
    pedit61."vdpedipe_preprdt" AS PRECO_ITEM_TOTAL,
    pedit61."vdpedipe_qtdret" AS QUANTIDADE_AVULSA,
    pedit61."vdpedipe_qtdprd" AS QUANTIDADE_CAIXA,
    pedit61."vdpedipe_nit" AS NUMERO_PEDIDO_REC_ID,
    pedit61."vdpedipe_ocokd" AS CODIGO_OCORRENCIA_REC_ID,
    pedit61."vdpedipe_tbprd" AS CODIGO_TABELA_PRECO_REC_ID,
    pedit61."vdpedipe_codr" AS CODIGO_PRODUTO_REC_ID,
    cadprd61."VDPRDPRD_DESCR" AS DESCRICAO_PRODUTO,
    CADOCO61."VDNOPOCO_NOME " AS DESCRICAO_OCORRENCIA
FROM
     VW_HISTORICO_PEDIDO_CAPA
    INNER JOIN  PEDIT61 ON numero_pedido = pedit61."vdpedipe_nit"
    INNER JOIN  CADPRD61 ON cadprd61."VDPRDPRD_CODR" = pedit61."VDPEDIPE_CODR"
    INNER JOIN  CADOCO61 ON CAST(CADOCO61.VDNOPOCO_COD AS INT) = pedit61."VDPEDIPE_OCOKD"
WHERE
    (
        Cast(pedit61."vdpedipe_nit" AS VARCHAR(12)) = @numero_pedido
        OR @numero_pedido = ''
    );