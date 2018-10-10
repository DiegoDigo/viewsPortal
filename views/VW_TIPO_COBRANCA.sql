DECLARE SET INT @CODIGO_TIPO_COBRANCA = 0;

CREATE
or replace VIEW  VW_TIPO_COBRANCA AS
SELECT
    tpcobr61."vdcadtco_ativo" AS ATIVO,
    tpcobr61."vdcadtco_cod" AS CODIGO_TIPO_COBRANCA_ERP,
    tpcobr61."vdcadtco_descricao" AS DESCRICAO,
    tpcobr61."vdcadtco_prazo" AS PRAZO,
    tpcobr61."vdcadtco_redcnt" AS RED,
    tpcobr61."vdcadtco_redcnt" AS RED_F,
    tpcobr61."vdcadtco_perm01" AS PERM01,
    tpcobr61."vdcadtco_perm02" AS PERM02,
    tpcobr61."vdcadtco_perm03" AS PERM03,
    tpcobr61."vdcadtco_perm04" AS PERM04,
    tpcobr61."vdcadtco_perm05" AS PERM05,
    tpcobr61."vdcadtco_perm06" AS PERM06,
    tpcobr61."vdcadtco_perm07" AS PERM07,
    tpcobr61."vdcadtco_perm08" AS PERM08,
    tpcobr61."vdcadtco_perm09" AS PERM09
FROM
     TPCOBR61
WHERE
    (
        tpcobr61."vdcadtco_cod" = @CODIGO_TIPO_COBRANCA
        OR @CODIGO_TIPO_COBRANCA = 0
    );