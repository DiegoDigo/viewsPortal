DECLARE SET INT @CODIGO_CLIENTE = 0;


CREATE
or replace VIEW  VW_ENDERECO AS
SELECT
    1 AS ATIVO,
    cadcli61."vdclicli_baifat" AS BAIRRO,
    cadcli61."vdclicli_cepfat" AS CEP_ENDERECO,
    cadcli61."vdclicli_endfat" AS ENDERECO,
    cadcli61."vdclicli_munfat" AS MUNICIPIO,
    cadcli61."vdclicli_endfat_nr" AS NUMERO,
    NULL AS PONTO_REFERENCIA,
    cadcli61."vdclicli_estfat" AS UTF_ENDERECO,
    1 AS ORIGEM_LOGRADOURO_ERP,
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
    ) AS codigo_cliente_erp,
    cadcli61."vdclicli_endfat_tip" AS SIGLA_LOGRADOURO_ERP
FROM
     CADCLI61
WHERE
    (
        Cast(
            Concat(
                CASE WHEN Length(Cast(cadcli61."vdclicli_regi" AS CHAR (4))) = 1 THEN Concat(
                    '000',
                    Cast(cadcli61."vdclicli_regi" AS VARCHAR(4))
                ) WHEN Length(Cast(cadcli61."vdclicli_regi" AS CHAR (4))) = 2 THEN Concat(
                    '00',
                    Cast(cadcli61."vdclicli_regi" AS VARCHAR(4))
                ) WHEN Length(Cast(cadcli61."vdclicli_regi" AS CHAR (4))) = 3 THEN Concat(
                    '0',
                    Cast(cadcli61."vdclicli_regi" AS VARCHAR(4))
                ) WHEN Length(Cast(cadcli61."vdclicli_regi" AS CHAR (4))) = 4 THEN Cast(cadcli61."vdclicli_regi" AS VARCHAR (4)) END,
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
            ) AS INTEGER
        ) = @CODIGO_CLIENTE
        OR @CODIGO_CLIENTE = 0
    )
UNION ALL
SELECT
    1 AS ATIVO,
    cadcli61."vdclicli_baicob" AS BAIRRO,
    cadcli61."vdclicli_cepcob" AS CEP_ENDERECO,
    cadcli61."vdclicli_endcob" AS ENDERECO,
    cadcli61."vdclicli_muncob" AS MUNICIPIO,
    cadcli61."vdclicli_endcob_nr" AS NUMERO,
    NULL AS PONTO_REFERENCIAENDFAT,
    cadcli61."vdclicli_estcob" AS UTF_ENDERECO,
    2 AS ORIGEM_LOGRADOURO_REC_ID,
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
    ) AS codigo_cliente_erp,
    cadcli61."vdclicli_endcob_tip" AS SIGLA_LOGRADOURO_REC_ID
FROM
     CADCLI61
WHERE
    (
        Cast(
            Concat(
                CASE WHEN Length(Cast(cadcli61."vdclicli_regi" AS CHAR (4))) = 1 THEN Concat(
                    '000',
                    Cast(cadcli61."vdclicli_regi" AS VARCHAR(4))
                ) WHEN Length(Cast(cadcli61."vdclicli_regi" AS CHAR (4))) = 2 THEN Concat(
                    '00',
                    Cast(cadcli61."vdclicli_regi" AS VARCHAR(4))
                ) WHEN Length(Cast(cadcli61."vdclicli_regi" AS CHAR (4))) = 3 THEN Concat(
                    '0',
                    Cast(cadcli61."vdclicli_regi" AS VARCHAR(4))
                ) WHEN Length(Cast(cadcli61."vdclicli_regi" AS CHAR (4))) = 4 THEN Cast(cadcli61."vdclicli_regi" AS VARCHAR (4)) END,
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
            ) AS INTEGER
        ) = @CODIGO_CLIENTE
        OR @CODIGO_CLIENTE = 0
    )
UNION ALL
SELECT
    1 AS ATIVO,
    cadcli61."vdclicli_baient" AS BAIRRO,
    cadcli61."vdclicli_cepent" AS CEP_ENDERECO,
    cadcli61."vdclicli_endent" AS ENDERECO,
    cadcli61."vdclicli_munent" AS MUNICIPIO,
    cadcli61."vdclicli_endent_nr" AS NUMERO,
    NULL AS PONTO_REFERENCIAENDFAT,
    cadcli61."vdclicli_estent" AS UTF_ENDERECO,
    3 AS ORIGEM_LOGRADOURO_REC_ID,
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
    ) AS codigo_cliente_erp,
    cadcli61."vdclicli_endent_tip" AS SIGLA_LOGRADOURO_REC_ID
FROM
     CADCLI61
WHERE
    (
        Cast(
            Concat(
                CASE WHEN Length(Cast(cadcli61."vdclicli_regi" AS CHAR (4))) = 1 THEN Concat(
                    '000',
                    Cast(cadcli61."vdclicli_regi" AS VARCHAR(4))
                ) WHEN Length(Cast(cadcli61."vdclicli_regi" AS CHAR (4))) = 2 THEN Concat(
                    '00',
                    Cast(cadcli61."vdclicli_regi" AS VARCHAR(4))
                ) WHEN Length(Cast(cadcli61."vdclicli_regi" AS CHAR (4))) = 3 THEN Concat(
                    '0',
                    Cast(cadcli61."vdclicli_regi" AS VARCHAR(4))
                ) WHEN Length(Cast(cadcli61."vdclicli_regi" AS CHAR (4))) = 4 THEN Cast(cadcli61."vdclicli_regi" AS VARCHAR (4)) END,
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
            ) AS INTEGER
        ) = @CODIGO_CLIENTE
        OR @CODIGO_CLIENTE = 0
    );