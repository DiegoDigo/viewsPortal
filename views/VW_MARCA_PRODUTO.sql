DECLARE SET INT @CODIGO_MARCA_PRODUTO = 0;
CREATE
or replace VIEW  VW_MARCA_PRODUTO AS
SELECT
    marprd61."vdprdmar_marca" AS CODIGO_MARCA_PRODUTO_ERP,
    marprd61."vdprdmar_descr" AS DESCRICAO
FROM
     MARPRD61
WHERE
    (
        marprd61."vdprdmar_marca" = @CODIGO_MARCA_PRODUTO
        OR @CODIGO_MARCA_PRODUTO = 0
    );