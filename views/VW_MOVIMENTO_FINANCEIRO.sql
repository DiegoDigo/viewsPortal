DECLARE SET INT @DATA_OPERACAO = 0;

CREATE
or replace VIEW  VW_MOVIMENTO_FINANCEIRO AS
SELECT
    CASE WHEN Length(
        Cast(chdepo61."crchqdep_codcli" AS VARCHAR (10))
    ) = 5 THEN Concat(
        '000',
        Cast(chdepo61."crchqdep_codcli" AS VARCHAR(10))
    ) ELSE CASE WHEN Length(
        Cast(chdepo61."crchqdep_codcli" AS VARCHAR(10))
    ) = 6 THEN Concat(
        '00',
        Cast(chdepo61."crchqdep_codcli" AS VARCHAR(10))
    ) ELSE CASE WHEN Length(
        Cast(chdepo61."crchqdep_codcli" AS VARCHAR(10))
    ) = 7 THEN Concat(
        '0',
        Cast(chdepo61."crchqdep_codcli" AS VARCHAR(10))
    ) ELSE CASE WHEN Length(
        Cast(chdepo61."crchqdep_codcli" AS VARCHAR(10))
    ) = 8 THEN Cast(chdepo61."crchqdep_codcli" AS VARCHAR(10)) END END END END AS CODIGO_CLIENTE_ERP,
    NULL AS CODIGO_PRODUTO_ERP,
    CASE WHEN chdepo61."crchqdep_dtv" >= Cast(
        Replace(Cast(Curdate() AS VARCHAR(10)), '-', '') AS INT
    ) THEN chdepo61."crchqdep_dte" ELSE chdepo61."crchqdep_dtv" END AS DATA_OPERACAO,
    chdepo61."crchqdep_dtv" AS DATA_VENCIMENTO,
    CASE WHEN chdepo61."crchqdep_dte" = chdepo61."crchqdep_dtv" THEN 1 ELSE 2 END AS MOD,
    Cast(chdepo61."crchqdep_ndoc" AS VARCHAR(255)) AS NUMERO_DOCUMENTO,
    CASE WHEN chdepo61."crchqdep_dtv" >= Cast(
        Replace(Cast(Curdate() AS VARCHAR(10)), '-', '') AS INT
    ) THEN '1' ELSE '2' END AS TIPO_REGISTRO,
    chdepo61."crchqdep_nped" AS NUMERO_PEDIDO,
    chdepo61."crchqdep_vldoc" AS VALOR
FROM
     CHDEPO61
WHERE
    chdepo61."crchqdep_dtv" >= Cast(
        Replace(Cast(Curdate() AS VARCHAR(10)), '-', '') AS INT
    )
    AND (
        chdepo61."crchqdep_dte" = @DATA_OPERACAO
        OR @DATA_OPERACAO = 0
    )
UNION ALL
SELECT
    CASE WHEN Length(Cast(chdev61."crchqdev_ccli" AS VARCHAR(10))) = 5 THEN Concat(
        '000',
        Cast(chdev61."crchqdev_ccli" AS VARCHAR(10))
    ) ELSE CASE WHEN Length(Cast(chdev61."crchqdev_ccli" AS VARCHAR(10))) = 6 THEN Concat(
        '00',
        Cast(chdev61."crchqdev_ccli" AS VARCHAR(10))
    ) ELSE CASE WHEN Length(Cast(chdev61."crchqdev_ccli" AS VARCHAR(10))) = 7 THEN Concat(
        '0',
        Cast(chdev61."crchqdev_ccli" AS VARCHAR(10))
    ) ELSE CASE WHEN Length(Cast(chdev61."crchqdev_ccli" AS VARCHAR(10))) = 8 THEN Cast(chdev61."crchqdev_ccli" AS VARCHAR (10)) END END END END AS CODIGO_CLIENTE_ERP,
    NULL AS CODIGO_PRODUTO,
    CASE WHEN chdev61."crchqdev_dtqui" > 0 THEN chdev61."crchqdev_dtqui" ELSE 0 END AS DATA_OPERACAO,
    chdev61."crchqdev_dtvto" AS DATA_VENCIMENTO,
    0 AS MOD,
    chdev61."crchqdev_nchq" AS NUMERO_DOCUMENTO,
    '3' AS TIPO_REGISTRO,
    chdev61."crchqdev_nped" AS NUMERO_PEDIDO,
    chdev61."crchqdev_vlori" AS VALOR
FROM
     CHDEV61
WHERE
    chdev61."crchqdev_dtqui" = 0
    AND chdev61."crchqdev_dtemi" >= Cast(
        Replace(Cast(Curdate() - 45 AS VARCHAR(10)), '-', '') AS INT
    )
    AND (
        chdev61."crchqdev_dtqui" = @DATA_OPERACAO
        OR @DATA_OPERACAO = 0
    )
UNION ALL
SELECT
    CASE WHEN Length(
        Cast(cadbai61."crmovbai_ccli" AS VARCHAR (10))
    ) = 5 THEN Concat(
        '000',
        Cast(cadbai61."crmovbai_ccli" AS VARCHAR(10))
    ) ELSE CASE WHEN Length(Cast(cadbai61."crmovbai_ccli" AS VARCHAR(10))) = 6 THEN Concat(
        '00',
        Cast(cadbai61."crmovbai_ccli" AS VARCHAR(10))
    ) ELSE CASE WHEN Length(
        Cast(cadbai61."crmovbai_ccli" AS VARCHAR(10))
    ) = 7 THEN Concat(
        '0',
        Cast(cadbai61."crmovbai_ccli" AS VARCHAR(10))
    ) ELSE CASE WHEN Length(
        Cast(cadbai61."crmovbai_ccli" AS VARCHAR(10))
    ) = 8 THEN Cast(cadbai61."crmovbai_ccli" AS VARCHAR(10)) END END END END AS CODIGO_CLIENTE_ERP,
    NULL AS CODIGO_PRODUTO,
    cadbai61."crmovbai_dtp" AS DATA_OPERACAO,
    cadbai61."crmovbai_dtv" AS DATA_VENCIMENTO,
    cadbai61."crmovbai_mod" AS MOD,
    cadbai61."crmovbai_ndupl" AS NUMERO_DOCUMENTO,
    '2' AS TIPO_REGISTRO,
    cadbai61."crmovbai_nped" AS NUMERO_PEDIDO,
    cadbai61."crmovbai_valor" AS VALOR
FROM
     CADBAI61
WHERE
    cadbai61."crmovbai_dtp" >= Cast(
        Replace(Cast(Curdate() - 45 AS VARCHAR(10)), '-', '') AS INT
    )
    AND (
        cadbai61."crmovbai_dtv" = @DATA_OPERACAO
        OR @DATA_OPERACAO = 0
    )
UNION ALL
SELECT
    CASE WHEN Length(
        Cast(cadmov61."crmovmov_ccli" AS VARCHAR (10))
    ) = 5 THEN Concat(
        '000',
        Cast(cadmov61."crmovmov_ccli" AS VARCHAR(10))
    ) ELSE CASE WHEN Length(Cast(cadmov61."crmovmov_ccli" AS VARCHAR(10))) = 6 THEN Concat(
        '00',
        Cast(cadmov61."crmovmov_ccli" AS VARCHAR(10))
    ) ELSE CASE WHEN Length(
        Cast(cadmov61."crmovmov_ccli" AS VARCHAR(10))
    ) = 7 THEN Concat(
        '0',
        Cast(cadmov61."crmovmov_ccli" AS VARCHAR(10))
    ) ELSE CASE WHEN Length(
        Cast(cadmov61."crmovmov_ccli" AS VARCHAR(10))
    ) = 8 THEN Cast(cadmov61."crmovmov_ccli" AS VARCHAR(10)) END END END END AS CODIGO_CLIENTE_ERP,
    NULL AS CODIGO_PRODUTO,
    cadmov61."crmovmov_dte" AS DATA_OPERACAO,
    cadmov61."crmovmov_dtv" AS DATA_VENCIMENTO,
    cadmov61."crmovmov_mod" AS MOD,
    cadmov61."crmovmov_ndupl" AS NUMERO_DOCUMENTO,
    '1' AS TIPO_REGISTRO,
    cadmov61."crmovmov_nped" AS NUMERO_PEDIDO,
    cadmov61."crmovmov_valor" AS VALOR
FROM
     CADMOV61
WHERE
    (
        cadmov61."crmovmov_dte" = @DATA_OPERACAO
        OR @DATA_OPERACAO = 0
    )
ORDER BY
    3;