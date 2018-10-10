DECLARE SET varchar(27) @CODIGO_COMBO = '';
CREATE
or replace VIEW  VW_COMBO_PRODUTO AS
SELECT
    vdprdcbo."vdprdcbo_qtdcx" AS QUANTIDADE_CAIXA,
    vdprdcbo."vdprdcbo_qtdav" AS QUANTIDADE_AVULSO,
    vdprdcbo."vdprdcbo_codrprd" AS CODIGO_PRODUTO_ERP,
    vdprdcbo."vdprdcbo_ocor" AS CODIGO_OCOR_ERP,
    concat(
        concat(
            concat(
                repeat(
                    '0',
                    3 - length(cast(VDPRDCBO_CODEMP as varchar(03)))
                ),
                cast(VDPRDCBO_CODEMP as varchar(03))
            ),
            concat(
                repeat(
                    '0',
                    10 - length(cast(VDPRDCBO_CODCBO as varchar(10)))
                ),
                cast(VDPRDCBO_CODCBO as varchar(10))
            )
        ),
        concat(
            concat(
                repeat(
                    '0',
                    10 - length(cast(VDPRDCBO_CODRPRD as varchar(10)))
                ),
                cast(VDPRDCBO_CODRPRD as varchar(10))
            ),
            concat(
                repeat(
                    '0',
                    3 - length(cast(VDPRDCBO_OCOR as varchar(03)))
                ),
                cast(VDPRDCBO_OCOR as varchar(03))
            )
        )
    ) AS CODIGO_PRODUTO_COMBO_ERP
FROM
     VDPRDCBO
WHERE
    vdprdcbo."vdprdcbo_codrprd" <> 0
    AND (
        concat(
            concat(
                concat(
                    repeat(
                        '0',
                        3 - length(cast(VDPRDCBO_CODEMP as varchar(03)))
                    ),
                    cast(VDPRDCBO_CODEMP as varchar(03))
                ),
                concat(
                    repeat(
                        '0',
                        10 - length(cast(VDPRDCBO_CODCBO as varchar(10)))
                    ),
                    cast(VDPRDCBO_CODCBO as varchar(10))
                )
            ),
            concat(
                concat(
                    repeat(
                        '0',
                        10 - length(cast(VDPRDCBO_CODRPRD as varchar(10)))
                    ),
                    cast(VDPRDCBO_CODRPRD as varchar(10))
                ),
                concat(
                    repeat(
                        '0',
                        3 - length(cast(VDPRDCBO_OCOR as varchar(03)))
                    ),
                    cast(VDPRDCBO_OCOR as varchar(03))
                )
            )
        ) = @CODIGO_COMBO
        or @CODIGO_COMBO = ''
    );