DECLARE SET INT @CODIGO_FAMILIA = 0;

CREATE
or replace VIEW  VW_FAMILIA_PRODUTO AS
SELECT
    cadfam61."vdprdfam_fameb" AS CODIGO_FAMEB,
    cadfam61."vdprdfam_cod" AS CODIGO_FAMILIA_PRODUTO_ERP,
    cadfam61."vdprdfam_nome" AS DESCRICAO
FROM
     CADFAM61
WHERE
    (
        cadfam61."vdprdfam_cod" = @CODIGO_FAMILIA
        OR @CODIGO_FAMILIA = 0
    );