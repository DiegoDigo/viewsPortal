CREATE
or replace VIEW  VW_RESTRICAO_COMERCIAL_CAPA AS
SELECT
    CASE WHEN grptab61."vdtabgrc_cancsn" = 0 THEN 1 ELSE 0 END AS ATIVO,
    grptab61."vdtabgrc_grpcan" AS CODIGO_GRUPO_CANAL_ERP,
    grptab61."vdtabgrc_seq" AS CODIGO_RESTRICAO_COMERCIAL_ERP,
    grptab61."vdtabgrc_divcan" AS DIVISAO_CANAL,
    grptab61."vdtabgrc_valminped" AS VALOR_MINIMO_PEDIDO,
    grptab61."vdtabgrc_canal" AS CODIGO_CANAL_ERP,
    CASE WHEN Length(
        Cast(grptab61."vdtabgrc_cliente" AS VARCHAR(8))
    ) = 5 THEN Concat(
        '000',
        Cast(grptab61."vdtabgrc_cliente" AS VARCHAR(8))
    ) ELSE CASE WHEN Length(
        Cast(grptab61."vdtabgrc_cliente" AS VARCHAR(8))
    ) = 6 THEN Concat(
        '00',
        Cast(grptab61."vdtabgrc_cliente" AS VARCHAR(8))
    ) ELSE CASE WHEN Length(
        Cast(grptab61."vdtabgrc_cliente" AS VARCHAR(8))
    ) = 7 THEN Concat(
        '0',
        Cast(grptab61."vdtabgrc_cliente" AS VARCHAR(8))
    ) ELSE CASE WHEN Length(
        Cast(grptab61."vdtabgrc_cliente" AS VARCHAR(8))
    ) = 8 THEN Cast(grptab61."vdtabgrc_cliente" AS VARCHAR (8)) END END END END AS CODIGO_CLIENTE_ERP,
    grptab61."vdtabgrc_condpag" AS CODIGO_CONDICAO_PAGAMENTO_ERP,
    grptab61."vdtabgrc_tipcobr" AS CODIGO_TIPO_COBRANCA_ERP
FROM
     GRPTAB61
WHERE
    Cast(grptab61."vdtabgrc_cliente" AS VARCHAR(8)) <> '0';