DECLARE
SET
    INT @codigo_cev = 0;CREATE
    or replace VIEW VW_COMODATO AS
SELECT
    CASE WHEN Length(
        Cast(cevped61."vdcevpen_codcli" AS VARCHAR (6))
    ) = 5 THEN Concat(
        '000',
        Cast(cevped61."vdcevpen_codcli" AS VARCHAR(6))
    ) ELSE CASE WHEN Length(
        Cast(cevped61."vdcevpen_codcli" AS VARCHAR(6))
    ) = 6 THEN Concat(
        '00',
        Cast(cevped61."vdcevpen_codcli" AS VARCHAR(6))
    ) ELSE CASE WHEN Length(
        Cast(cevped61."vdcevpen_codcli" AS VARCHAR(6))
    ) = 7 THEN Concat(
        '0',
        Cast(cevped61."vdcevpen_codcli" AS VARCHAR(6))
    ) END END END AS CODIGO_CLIENTE_ERP,
    NULL AS CODIGO_MODELO,
    NULL AS CODIGO_OCORRENCIA,
    NULL AS CODIGO_SITUACAO,
    cevped61."vdcevpen_dte" AS DATA_CEV,
    NULL AS DATA_UTILMA_AUDITORIA,
    cevped61."vdcevpen_dtv" AS DATA_VENCIMENTO,
    NULL AS DESCRICAO_MODELO,
    NULL AS FAZ_INVENTARIO,
    NULL AS NOME_FABRICANTE,
    NULL AS NUMERO_ATIVO,
    cevped61."vdcevpen_nrccev" AS NUMERO_CEV,
    NULL AS NUMERO_CEV_ITEM,
    NULL AS PATRIMONIO_DOIS,
    (
        SELECT
            cadprd61."vdprdprd_codr"
        FROM
            CADPRD61
        WHERE
            cadprd61."vdprdprd_cfam" = cast(
                left(
                    concat(
                        repeat(
                            '0',
                            6 - length(cast(cevped61."vdcevpen_prod" as varchar(6)))
                        ),
                        cast(cevped61."vdcevpen_prod" as varchar(6))
                    ),
                    3
                ) AS SMALLINT
            )
            AND cadprd61."vdprdprd_nro" = Cast(
                right(
                    concat(
                        repeat(
                            '0',
                            6 - length(cast(cevped61."vdcevpen_prod" as varchar(6)))
                        ),
                        cast(cevped61."vdcevpen_prod" as varchar(6))
                    ),
                    3
                ) AS SMALLINT
            )
    ) AS CODIGO_PRODUTO_ERP,
    cevped61."vdcevpen_qtdprd" AS QUANTIDADE,
    NULL AS TABELA_PRECO_REC_ID,
    NULL AS TECNOLOGIA_UTILIZADA,
    NULL AS TIPO_STATUS,
    NULL AS VALOR_ITEM
FROM
    CEVPED61
WHERE
    (
        cevped61."vdcevpen_nrccev" = @codigo_cev
        OR @codigo_cev = 0
    );