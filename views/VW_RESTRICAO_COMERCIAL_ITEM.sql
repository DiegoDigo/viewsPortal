CREATE
or replace VIEW  VW_RESTRICAO_COMERCIAL_ITEM AS
SELECT
    grptab61."vdtabgrc_tab01" AS CODIGO_TABELA_PRECO,
    grptab61."vdtabgrc_seq" AS CODIGO_RESTRICAO_COMERCIAL_ERP
FROM
     GRPTAB61
WHERE
    grptab61."vdtabgrc_tab01" <> 0
UNION
SELECT
    grptab61."vdtabgrc_tab02" AS CODIGO_TABELA_PRECO,
    grptab61."vdtabgrc_seq" AS CODIGO_RESTRICAO_COMERCIAL_ERP
FROM
     GRPTAB61
WHERE
    grptab61."vdtabgrc_tab02" <> 0
UNION
SELECT
    grptab61."vdtabgrc_tab03" AS CODIGO_TABELA_PRECO,
    grptab61."vdtabgrc_seq" AS CODIGO_RESTRICAO_COMERCIAL_ERP
FROM
     GRPTAB61
WHERE
    grptab61."vdtabgrc_tab03" <> 0
UNION
SELECT
    grptab61."vdtabgrc_tab04" AS CODIGO_TABELA_PRECO,
    grptab61."vdtabgrc_seq" AS CODIGO_RESTRICAO_COMERCIAL_ERP
FROM
     GRPTAB61
WHERE
    grptab61."vdtabgrc_tab04" <> 0
UNION
SELECT
    grptab61."vdtabgrc_tab05" AS CODIGO_TABELA_PRECO,
    grptab61."vdtabgrc_seq" AS CODIGO_RESTRICAO_COMERCIAL_ERP
FROM
     GRPTAB61
WHERE
    grptab61."vdtabgrc_tab05" <> 0
UNION
SELECT
    grptab61."vdtabgrc_tab06" AS CODIGO_TABELA_PRECO,
    grptab61."vdtabgrc_seq" AS CODIGO_RESTRICAO_COMERCIAL_ERP
FROM
     GRPTAB61
WHERE
    grptab61."vdtabgrc_tab06" <> 0
UNION
SELECT
    grptab61."vdtabgrc_tab07" AS CODIGO_TABELA_PRECO,
    grptab61."vdtabgrc_seq" AS CODIGO_RESTRICAO_COMERCIAL_ERP
FROM
     GRPTAB61
WHERE
    grptab61."vdtabgrc_tab07" <> 0
UNION
SELECT
    grptab61."vdtabgrc_tab08" AS CODIGO_TABELA_PRECO,
    grptab61."vdtabgrc_seq" AS CODIGO_RESTRICAO_COMERCIAL_ERP
FROM
     GRPTAB61
WHERE
    grptab61."vdtabgrc_tab08" <> 0
UNION
SELECT
    grptab61."vdtabgrc_tab09" AS CODIGO_TABELA_PRECO,
    grptab61."vdtabgrc_seq" AS CODIGO_RESTRICAO_COMERCIAL_ERP
FROM
     GRPTAB61
WHERE
    grptab61."vdtabgrc_tab09" <> 0
UNION
SELECT
    grptab61."vdtabgrc_tab10" AS CODIGO_TABELA_PRECO,
    grptab61."vdtabgrc_seq" AS CODIGO_RESTRICAO_COMERCIAL_ERP
FROM
     GRPTAB61
WHERE
    grptab61."vdtabgrc_tab10" <> 0;