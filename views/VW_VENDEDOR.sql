
DECLARE SET VARCHAR(255) @CODIGO_VENDEDOR = '';

CREATE
or replace VIEW  VW_VENDEDOR AS
SELECT
    1 AS ATIVO,
    cadven61."vdvenven_sigla" AS CODIGO_VENDEDOR_ERP,
    cadven61."vdvenven_nome" AS NOME,
    cadven61."vdvenven_ddd" AS TELEFONE_DD,
    cadven61."vdvenven_tel" AS TELEFONE_TRONCO,
    '01' AS TIPO
FROM
     CADVEN61
WHERE
    (
        cadven61."vdvenven_sigla" = @CODIGO_VENDEDOR
        OR @CODIGO_VENDEDOR = ''
    )
    AND (
        cadven61."vdvenven_nivel" = 4
        OR cadven61."vdvenven_nivel" = 5
    )
    AND (
        cadven61."vdvenven_tpven" = 'V'
        OR cadven61."vdvenven_tpven" = 'R'
    );