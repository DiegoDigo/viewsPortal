declare set varchar(255) @CODIGO_CLIENTE = '';


CREATE
or replace VIEW  VW_VENDEDOR_CLIENTE AS
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
    cadcli61."vdclicli_ven" AS CODIGO_VENDEDOR_ERP
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
        ) = @CODIGO_CLIENTE
        OR @CODIGO_CLIENTE = ''
    )
    OR (
        SELECT
            tbblocli."vdcadblo_impclipalm"
        FROM
             TBBLOCLI
        WHERE
            tbblocli."vdcadblo_cod" = cadcli61."vdclicli_motblo"
    ) = 1
UNION
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
    cadcli61."vdclicli_ven2" AS CODIGO_VENDEDOR_ERP
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
        ) = @CODIGO_CLIENTE
        OR @CODIGO_CLIENTE = ''
    )
    AND cadcli61."vdclicli_ven2" <> '   '
    OR (
        SELECT
            tbblocli."vdcadblo_impclipalm"
        FROM
             TBBLOCLI
        WHERE
            tbblocli."vdcadblo_cod" = cadcli61."vdclicli_motblo"
    ) = 1
UNION
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
    cadcli61."vdclicli_ven3" AS CODIGO_VENDEDOR_ERP
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
        ) = @CODIGO_CLIENTE
        OR @CODIGO_CLIENTE = ''
    )
    AND cadcli61."vdclicli_ven3" <> '   '
    OR (
        SELECT
            tbblocli."vdcadblo_impclipalm"
        FROM
             TBBLOCLI
        WHERE
            tbblocli."vdcadblo_cod" = cadcli61."vdclicli_motblo"
    ) = 1
UNION
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
    cadcli61."vdclicli_ven4" AS CODIGO_VENDEDOR_ERP
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
        ) = @CODIGO_CLIENTE
        OR @CODIGO_CLIENTE = ''
    )
    and cadcli61."vdclicli_ven4" <> '   '
    OR (
        SELECT
            tbblocli."vdcadblo_impclipalm"
        FROM
             TBBLOCLI
        WHERE
            tbblocli."vdcadblo_cod" = cadcli61."vdclicli_motblo"
    ) = 1
UNION
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
    cadcli61."vdclicli_ven5" AS CODIGO_VENDEDOR_ERP
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
        ) = @CODIGO_CLIENTE
        OR @CODIGO_CLIENTE = ''
    )
    AND cadcli61."vdclicli_ven5" <> '   '
    OR (
        SELECT
            tbblocli."vdcadblo_impclipalm"
        FROM
             TBBLOCLI
        WHERE
            tbblocli."vdcadblo_cod" = cadcli61."vdclicli_motblo"
    ) = 1;