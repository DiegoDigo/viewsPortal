DECLARE SET INT @CODIGO_GRUPO_PRODUTO = 0;

CREATE
or replace VIEW  VW_GRUPO_PRODUTO AS
SELECT
    grpprd61."vdprdgrp_grupo" AS CODIGO_GRUPO_PRODUTO_ERP,
    grpprd61."vdprdgrp_descr" AS DESCRICAO
FROM
     GRPPRD61
WHERE
    (
        grpprd61."vdprdgrp_grupo" = @CODIGO_GRUPO_PRODUTO
        OR @CODIGO_GRUPO_PRODUTO = 0
    );