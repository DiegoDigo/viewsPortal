
DECLARE SET VARCHAR(255) @CODIGO_PEDIDO = '';


CREATE
or replace VIEW  VW_PEDIDO_PENDENTE_LIBERACAO AS
SELECT
    CASE WHEN pedcp61."vdpedcpe_fl" = 9 THEN 0 ELSE 1 END AS ATIVO,
    pedcp61."vdpedcpe_dtemiped" AS DATA_HORA_EMISSAO_PEDIDO,
    pedcp61."vdpedcpe_dt1vc" AS DATA_VENCIMENTO,
    pedcp61."vdpedcpe_descfi" AS DESCONTO_FINANCEIRO,
    pedcp61."vdpedcpe_nped" AS NUMERO_PEDIDO,
    pedcp61."vdpedcpe_desc" AS PERCENTUAL_DESCONTO,
    pedcp61."vdpedcpe_fl" AS STATUS_PEDIDO,
    (
        SELECT
            CASE WHEN tabblq61."vdcadbpd_descr" = NULL THEN 'LIBERADO' ELSE tabblq61."vdcadbpd_descr" END
        FROM
             TABBLQ61
        WHERE
            tabblq61."vdcadbpd_cod" = pedcp61."vdpedcpe_fl"
    ) AS DESCRICAO_BLOQUEIO,
    pedcp61."vdpedcpe_txfin" AS TAXA_FINANCEIRO,
    pedcp61."vdpedcpe_vlr_fcem_r" + pedcp61."vdpedcpe_vlr_fsem_r" + pedcp61."vdpedcpe_vlr_fctr_r" + pedcp61."vdpedcpe_vlr_fstr_r" AS VALOR_DEVOLUCAO,
    pedcp61."vdpedcpe_vlr_fcem" + pedcp61."vdpedcpe_vlr_fsem" + pedcp61."vdpedcpe_vlr_fctr" + pedcp61."vdpedcpe_vlr_fstr" AS VALOR_PEDIDO,
    CASE WHEN Length(Cast(pedcp61."vdpedcpe_codcli" AS CHAR(8))) = 5 THEN Concat(
        '000',
        Cast(pedcp61."vdpedcpe_codcli" AS VARCHAR(8))
    ) WHEN Length(Cast(pedcp61."vdpedcpe_codcli" AS CHAR(8))) = 6 THEN Concat(
        '00',
        Cast(pedcp61."vdpedcpe_codcli" AS VARCHAR(8))
    ) WHEN Length(Cast(pedcp61."vdpedcpe_codcli" AS CHAR(8))) = 7 THEN Concat(
        '0',
        Cast(pedcp61."vdpedcpe_codcli" AS VARCHAR(4))
    ) WHEN Length(Cast(pedcp61."vdpedcpe_codcli" AS CHAR(8))) = 8 THEN Cast(pedcp61."vdpedcpe_codcli" AS VARCHAR(8)) END AS CODIGO_CLIENTE_REC_ID,
    pedcp61."vdpedcpe_cpg" AS CODIGO_CONDICAO_PAGAMENTO_REC_ID,
    pedcp61."vdpedcpe_tpcobr" AS CODIGO_TIPO_COBRANCA_REC_ID,
    (
        SELECT
            cadven61."vdvenven_sigla"
        FROM
             CADVEN61
        WHERE
            cadven61."vdvenven_sigla" = pedcp61."vdpedcpe_ven"
    ) AS CODIGO_VENDEDOR,
    (
        SELECT
            cadven61."vdvenven_nome"
        FROM
             CADVEN61
        WHERE
            cadven61."vdvenven_sigla" = pedcp61."vdpedcpe_ven"
    ) AS NOME_VENDEDOR
FROM
     PEDCP61
WHERE
    Cast(pedcp61."vdpedcpe_nped" AS VARCHAR(12)) = @CODIGO_PEDIDO
    OR @CODIGO_PEDIDO = ''
    AND (
        pedcp61."vdpedcpe_fl" = 5
        OR pedcp61."vdpedcpe_fl" = 7
    );