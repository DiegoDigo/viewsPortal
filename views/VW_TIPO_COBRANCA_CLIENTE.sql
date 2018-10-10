DECLARE SET VARCHAR(255) @codigoclienteerp = '';


CREATE
or replace VIEW  VW_TIPO_COBRANCA_CLIENTE AS
SELECT
    1 AS ATIVO,
    Concat(
        CASE WHEN Length(Cast(cadcli61."vdclicli_regi" AS CHAR(4))) = 1 THEN Concat(
            '000',
            Cast(cadcli61."vdclicli_regi" AS VARCHAR(4))
        ) WHEN Length(Cast(cadcli61."vdclicli_regi" AS CHAR(4))) = 2 THEN Concat(
            '00',
            Cast(cadcli61."vdclicli_regi" AS VARCHAR(4))
        ) WHEN Length(Cast(cadcli61."vdclicli_regi" AS CHAR(4))) = 3 THEN Concat(
            '0',
            Cast(cadcli61."vdclicli_regi" AS VARCHAR(4))
        ) WHEN Length(Cast(cadcli61."vdclicli_regi" AS CHAR(4))) = 4 THEN Cast(cadcli61."vdclicli_regi" AS VARCHAR(4)) END,
        CASE WHEN Length(Cast(cadcli61."vdclicli_num" AS CHAR(4))) = 1 THEN Concat(
            '000',
            Cast(cadcli61."vdclicli_num" AS VARCHAR(4))
        ) WHEN Length(Cast(cadcli61."vdclicli_num" AS CHAR(4))) = 2 THEN Concat(
            '00',
            Cast(cadcli61."vdclicli_num" AS VARCHAR(4))
        ) WHEN Length(Cast(cadcli61."vdclicli_num" AS CHAR(4))) = 3 THEN Concat(
            '0',
            Cast(cadcli61."vdclicli_num" AS VARCHAR(4))
        ) WHEN Length(Cast(cadcli61."vdclicli_num" AS CHAR(4))) = 4 THEN Cast(cadcli61."vdclicli_num" AS VARCHAR (4)) END
    ) AS CODIGO_CLIENTE_ERP,
    cadcli61."vdclicli_tpcobra" AS CODIGO_TIPO_COBRANCA_ERP
FROM
     CADCLI61
WHERE
    (
        Concat(
            CASE WHEN Length(Cast(cadcli61."vdclicli_regi" AS CHAR(4))) = 1 THEN Concat(
                '000',
                Cast(cadcli61."vdclicli_regi" AS VARCHAR(4))
            ) WHEN Length(Cast(cadcli61."vdclicli_regi" AS CHAR(4))) = 2 THEN Concat(
                '00',
                Cast(cadcli61."vdclicli_regi" AS VARCHAR(4))
            ) WHEN Length(Cast(cadcli61."vdclicli_regi" AS CHAR(4))) = 3 THEN Concat(
                '0',
                Cast(cadcli61."vdclicli_regi" AS VARCHAR(4))
            ) WHEN Length(Cast(cadcli61."vdclicli_regi" AS CHAR(4))) = 4 THEN Cast(cadcli61."vdclicli_regi" AS VARCHAR (4)) END,
            CASE WHEN Length(Cast(cadcli61."vdclicli_num" AS CHAR(4))) = 1 THEN Concat(
                '000',
                Cast(cadcli61."vdclicli_num" AS VARCHAR(4))
            ) WHEN Length(Cast(cadcli61."vdclicli_num" AS CHAR(4))) = 2 THEN Concat(
                '00',
                Cast(cadcli61."vdclicli_num" AS VARCHAR(4))
            ) WHEN Length(Cast(cadcli61."vdclicli_num" AS CHAR(4))) = 3 THEN Concat(
                '0',
                Cast(cadcli61."vdclicli_num" AS VARCHAR(4))
            ) WHEN Length(Cast(cadcli61."vdclicli_num" AS CHAR(4))) = 4 THEN Cast(cadcli61."vdclicli_num" AS VARCHAR (4)) END
        ) = @codigoclienteerp
        OR @codigoclienteerp = '';
    );