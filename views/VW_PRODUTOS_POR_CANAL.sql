declare set integer @id =0;

CREATE
or replace VIEW  VW_PRODUTOS_POR_CANAL AS
SELECT
    case when length(cast(VDPRDCAN_CODCLI as char(8))) = 5 then concat('000', cast(VDPRDCAN_CODCLI as char(8))) when length(cast(VDPRDCAN_CODCLI as char(8))) = 6 then concat('00', cast(VDPRDCAN_CODCLI as char(8))) when length(cast(VDPRDCAN_CODCLI as char(8))) = 7 then concat('0', cast(VDPRDCAN_CODCLI as char(8))) ELSE cast(VDPRDCAN_CODCLI as char(8)) END AS COD_CLIENTE,
    VDPRDCAN_CANAL AS ERP_CANAL,
    VDPRDCAN_SUB_CANAL AS SUB_CANAL,
    (
        SELECT
            CADPRD61."VDPRDPRD_CODR"
        FROM
             CADPRD61
        WHERE
            CADPRD61."VDPRDPRD_CFAM" = VDPRDCAN_FAMPRD
            AND CADPRD61."VDPRDPRD_NRO" = VDPRDCAN_NROPRD
    ) AS COD_PRODUTO,
    VDPRDCAN_GRPPRD AS ERP_COD_GRUPO,
    VDPRDCAN_CATPRD AS ERP_COD_CATEGORIA,
    VDPRDCAN_MARPRD AS ERP_MARCA
FROM
     VDPRDCAN
where(
        VDPRDCAN_ID = @id
        or @id = 0
    );