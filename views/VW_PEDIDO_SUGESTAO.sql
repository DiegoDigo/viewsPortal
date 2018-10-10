



CREATE
or replace VIEW  VW_PEDIDO_SUGESTAO AS
SELECT
    '0' AS COD_CLIENTE,
    VDCLPV61."VDCLIPVC_CODCAT" AS COD_CANAL,
    (
        SELECT
            CADPRD61."VDPRDPRD_CODR"
        FROM
             CADPRD61
        WHERE
            CADPRD61."VDPRDPRD_CFAM" = CAST(
                LEFT(
                    CONCAT(
                        REPEAT(
                            '0',
                            6 - LENGTH(CAST(VDCLIPVC_CODPRD AS VARCHAR(6)))
                        ),
                        CAST(VDCLIPVC_CODPRD AS VARCHAR(6))
                    ),
                    3
                ) AS INT
            )
            AND CADPRD61."VDPRDPRD_NRO" = CAST(
                RIGHT(
                    CONCAT(
                        REPEAT(
                            '0',
                            6 - LENGTH(CAST(VDCLIPVC_CODPRD AS VARCHAR(6)))
                        ),
                        CAST(VDCLIPVC_CODPRD AS VARCHAR(6))
                    ),
                    3
                ) AS INT
            )
    ) AS COD_PRODUTO_REDUZIDO,
    VDCLPV61."VDCLIPVC_SUG_QTDECX" AS QTD_CX,
    VDCLPV61."VDCLIPVC_SUG_QTDEUN" AS QTD_AV
FROM
     VDCLPV61
UNION ALL
SELECT
    CASE WHEN LENGTH(CAST(CLCVTE61."VDCLCVTE_CODCLI" AS VARCHAR(8))) = 5 THEN CONCAT(
        '000',
        CAST(CLCVTE61."VDCLCVTE_CODCLI" AS VARCHAR(8))
    ) WHEN LENGTH(CAST(CLCVTE61."VDCLCVTE_CODCLI" AS VARCHAR(8))) = 6 THEN CONCAT(
        '00',
        CAST(CLCVTE61."VDCLCVTE_CODCLI" AS VARCHAR(8))
    ) WHEN LENGTH(CAST(CLCVTE61."VDCLCVTE_CODCLI" AS VARCHAR(8))) = 7 THEN CONCAT(
        '0',
        CAST(CLCVTE61."VDCLCVTE_CODCLI" AS VARCHAR(8))
    ) ELSE CAST(CLCVTE61."VDCLCVTE_CODCLI" AS VARCHAR(8)) END AS COD_CLIENTE,
    '00' AS COD_CANAL,
    (
        SELECT
            CADPRD61."VDPRDPRD_CODR"
        FROM
             CADPRD61
        WHERE
            CADPRD61."VDPRDPRD_CFAM" = CAST(
                LEFT(
                    CONCAT(
                        REPEAT(
                            '0',
                            6 - LENGTH(CAST(VDCLCVTE_CODPRD AS VARCHAR(6)))
                        ),
                        CAST(VDCLCVTE_CODPRD AS VARCHAR(6))
                    ),
                    3
                ) AS INT
            )
            AND CADPRD61."VDPRDPRD_NRO" = CAST(
                RIGHT(
                    CONCAT(
                        REPEAT(
                            '0',
                            6 - LENGTH(CAST(VDCLCVTE_CODPRD AS VARCHAR(6)))
                        ),
                        CAST(VDCLCVTE_CODPRD AS VARCHAR(6))
                    ),
                    3
                ) AS INT
            )
    ) AS COD_PRODUTO_REDUZIDO,
    CLCVTE61."VDCLCVTE_SUG_QTDCX" AS QTD_CX,
    CLCVTE61."VDCLCVTE_SUG_QTDUN" AS QTD_AV
FROM
     CLCVTE61 ;