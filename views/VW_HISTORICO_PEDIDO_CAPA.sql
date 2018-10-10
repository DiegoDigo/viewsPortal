DECLARE SET VARCHAR(255) @numero_pedido ='';

CREATE
or replace VIEW  VW_HISTORICO_PEDIDO_CAPA AS
SELECT
    CASE WHEN pedcp61."vdpedcpe_fl" = 9 THEN 0 ELSE 1 END AS ATIVO,
    pedcp61."vdpedcpe_motdev" AS CODIGO_MOTIVO_DEVOLUCAO,
    pedcp61."vdpedcpe_dtemiped" AS DATA_HORA_EMISSAO_PEDIDO,
    pedcp61."vdpedcpe_dt1vc" AS DATA_VENCIMENTO,
    pedcp61."vdpedcpe_descfi" AS DESCONTO_FINANCEIRO,
    pedcp61."vdpedcpe_nped" AS NUMERO_PEDIDO,
    pedcp61."vdpedcpe_desc" AS PERCENTUAL_DESCONTO,
    CASE WHEN pedcp61."vdpedcpe_fl" = 9 THEN 'CA' ELSE CASE WHEN pedcp61."vdpedcpe_vlr_fcem_r" + pedcp61."vdpedcpe_vlr_fsem_r" + pedcp61."vdpedcpe_vlr_fctr_r" + pedcp61."vdpedcpe_vlr_fstr_r" = 0 THEN 'DV' ELSE '0' END END AS STATUS_PEDIDO,
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
    CADCLI61.VDCLICLI_CGC as CNPJ_CPF,
    CADCLI61.VDCLICLI_RAZAO50 AS RAZAO_CLIENTE,
    condpg01.VDCADPAG_DESCR AS DESCRICAO_CONDICAO_PAGAMENTO,
    tpcobr01."vdcadtco_descricao" AS DESCRICAO_TIPO_COBRANCA,
    VDPEDCPE_SERIE AS SFISCAL,
    VDPEDCPE_NFIS AS NFISCAL_INI,
    VDPEDCPE_NFISULT AS NFISCAL_ULT
FROM
     PEDCP61
    inner join  CADCLI61 on CADCLI61.VDCLICLI_REGI = cast(
        substring(
            concat(
                repeat(
                    '0',
                    8 - length(cast(vdpedcpe_codcli as varchar(08)))
                ),
                cast(vdpedcpe_codcli as varchar(08))
            ),
            1,
            4
        ) as int
    )
    and CADCLI61.VDCLICLI_NUM = cast(
        substring(
            concat(
                repeat(
                    '0',
                    8 - length(cast(vdpedcpe_codcli as varchar(08)))
                ),
                cast(vdpedcpe_codcli as varchar(08))
            ),
            5,
            4
        ) as int
    )
    inner join  CONDPG01 on condpg01."vdcadpag_cod" = vdpedcpe_cpg
    inner join  TPCOBR01 on VDPEDCPE_TPCOBR = tpcobr01.VDCADTCO_COD
WHERE
    (
        Cast(pedcp61."vdpedcpe_nped" AS VARCHAR(12)) = @numero_pedido
        OR @numero_pedido = ''
    )
    AND pedcp61."vdpedcpe_nped" >= cast(
        trim (DATETOSTR(Curdate() - 45, 'yyyymmdd')) || '0000' as bigint
    );