declare set varchar(255) @codigo_restricao = '';

CREATE
or replace VIEW  VW_RESTRICAO_FINANCEIRA_ITEM AS
SELECT
    concat(
        cast(VDPAROCO_ANOTAB_CARGA as varchar(4)),
        case when length(cast(VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0' || cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela_1" as varchar(2)) else cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela_1" as varchar(2)) end
    ) AS CODIGO_TABELA_PRECO,
    concat(
        case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
        case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
    ) AS codigo_restricao_financeira
FROM
     TXPALM61,
     PAROCO61
WHERE
    txpalm61."vdcnftxp_tabela_1" <> 0
    and (
        concat(
            case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
            case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
        ) = @codigo_restricao
        or @codigo_restricao = ''
    )
UNION
SELECT
    concat(
        cast(VDPAROCO_ANOTAB_CARGA as varchar(4)),
        case when length(cast(VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0' || cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela_2" as varchar(2)) else cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela_2" as varchar(2)) end
    ) AS CODIGO_TABELA_PRECO,
    concat(
        case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
        case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
    ) AS codigo_restricao_financeira
FROM
     TXPALM61,
     PAROCO61
WHERE
    txpalm61."vdcnftxp_tabela_2" <> 0
    and (
        concat(
            case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
            case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
        ) = @codigo_restricao
        or @codigo_restricao = ''
    )
UNION
SELECT
    concat(
        cast(VDPAROCO_ANOTAB_CARGA as varchar(4)),
        case when length(cast(VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0' || cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela_3" as varchar(2)) else cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela_3" as varchar(2)) end
    ) AS CODIGO_TABELA_PRECO,
    concat(
        case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
        case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
    ) AS codigo_restricao_financeira
FROM
     TXPALM61,
     PAROCO61
WHERE
    txpalm61."vdcnftxp_tabela_3" <> 0
    and (
        concat(
            case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
            case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
        ) = @codigo_restricao
        or @codigo_restricao = ''
    )
UNION
SELECT
    concat(
        cast(VDPAROCO_ANOTAB_CARGA as varchar(4)),
        case when length(cast(VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0' || cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela_4" as varchar(2)) else cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela_4" as varchar(2)) end
    ) AS CODIGO_TABELA_PRECO,
    concat(
        case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
        case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
    ) AS codigo_restricao_financeira
FROM
     TXPALM61,
     PAROCO61
WHERE
    txpalm61."vdcnftxp_tabela_4" <> 0
    and (
        concat(
            case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
            case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
        ) = @codigo_restricao
        or @codigo_restricao = ''
    )
UNION
SELECT
    concat(
        cast(VDPAROCO_ANOTAB_CARGA as varchar(4)),
        case when length(cast(VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0' || cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela_5" as varchar(2)) else cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela_5" as varchar(2)) end
    ) AS CODIGO_TABELA_PRECO,
    concat(
        case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
        case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
    ) AS codigo_restricao_financeira
FROM
     TXPALM61,
     PAROCO61
WHERE
    txpalm61."vdcnftxp_tabela_5" <> 0
    and (
        concat(
            case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
            case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
        ) = @codigo_restricao
        or @codigo_restricao = ''
    )
UNION
SELECT
    concat(
        cast(VDPAROCO_ANOTAB_CARGA as varchar(4)),
        case when length(cast(VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0' || cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela2_1" as varchar(2)) else cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela2_1" as varchar(2)) end
    ) AS CODIGO_TABELA_PRECO,
    concat(
        case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
        case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
    ) AS codigo_restricao_financeira
FROM
     TXPALM61,
     PAROCO61
WHERE
    txpalm61."vdcnftxp_tabela2_1" <> 0
    and (
        concat(
            case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
            case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
        ) = @codigo_restricao
        or @codigo_restricao = ''
    )
UNION
SELECT
    concat(
        cast(VDPAROCO_ANOTAB_CARGA as varchar(4)),
        case when length(cast(VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0' || cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela2_2" as varchar(2)) else cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela2_2" as varchar(2)) end
    ) AS CODIGO_TABELA_PRECO,
    concat(
        case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
        case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
    ) AS codigo_restricao_financeira
FROM
     TXPALM61,
     PAROCO61
WHERE
    txpalm61."vdcnftxp_tabela2_2" <> 0
    and (
        concat(
            case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
            case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
        ) = @codigo_restricao
        or @codigo_restricao = ''
    )
UNION
SELECT
    concat(
        cast(VDPAROCO_ANOTAB_CARGA as varchar(4)),
        case when length(cast(VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0' || cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela2_3" as varchar(2)) else cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela2_3" as varchar(2)) end
    ) AS CODIGO_TABELA_PRECO,
    concat(
        case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
        case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
    ) AS codigo_restricao_financeira
FROM
     TXPALM61,
     PAROCO61
WHERE
    txpalm61."vdcnftxp_tabela2_3" <> 0
    and (
        concat(
            case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
            case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
        ) = @codigo_restricao
        or @codigo_restricao = ''
    )
UNION
SELECT
    concat(
        cast(VDPAROCO_ANOTAB_CARGA as varchar(4)),
        case when length(cast(VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0' || cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela2_4" as varchar(2)) else cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela2_4" as varchar(2)) end
    ) AS CODIGO_TABELA_PRECO,
    concat(
        case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
        case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
    ) AS codigo_restricao_financeira
FROM
     TXPALM61,
     PAROCO61
WHERE
    txpalm61."vdcnftxp_tabela2_4" <> 0
    and (
        concat(
            case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
            case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
        ) = @codigo_restricao
        or @codigo_restricao = ''
    )
UNION
SELECT
    concat(
        cast(VDPAROCO_ANOTAB_CARGA as varchar(4)),
        case when length(cast(VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0' || cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela2_5" as varchar(2)) else cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela2_5" as varchar(2)) end
    ) AS CODIGO_TABELA_PRECO,
    concat(
        case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
        case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
    ) AS codigo_restricao_financeira
FROM
     TXPALM61,
     PAROCO61
WHERE
    txpalm61."vdcnftxp_tabela2_5" <> 0
    and (
        concat(
            case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
            case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
        ) = @codigo_restricao
        or @codigo_restricao = ''
    )
UNION
SELECT
    concat(
        cast(VDPAROCO_ANOTAB_CARGA as varchar(4)),
        case when length(cast(VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0' || cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela2_6" as varchar(2)) else cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela2_6" as varchar(2)) end
    ) AS CODIGO_TABELA_PRECO,
    concat(
        case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
        case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
    ) AS codigo_restricao_financeira
FROM
     TXPALM61,
     PAROCO61
WHERE
    txpalm61."vdcnftxp_tabela2_6" <> 0
    and (
        concat(
            case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
            case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
        ) = @codigo_restricao
        or @codigo_restricao = ''
    )
UNION
SELECT
    concat(
        cast(VDPAROCO_ANOTAB_CARGA as varchar(4)),
        case when length(cast(VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0' || cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela2_7" as varchar(2)) else cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela2_7" as varchar(2)) end
    ) AS CODIGO_TABELA_PRECO,
    concat(
        case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
        case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
    ) AS codigo_restricao_financeira
FROM
     TXPALM61,
     PAROCO61
WHERE
    txpalm61."vdcnftxp_tabela2_7" <> 0
    and (
        concat(
            case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
            case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
        ) = @codigo_restricao
        or @codigo_restricao = ''
    )
UNION
SELECT
    concat(
        cast(VDPAROCO_ANOTAB_CARGA as varchar(4)),
        case when length(cast(VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0' || cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela2_8" as varchar(2)) else cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela2_8" as varchar(2)) end
    ) AS CODIGO_TABELA_PRECO,
    concat(
        case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
        case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
    ) AS codigo_restricao_financeira
FROM
     TXPALM61,
     PAROCO61
WHERE
    txpalm61."vdcnftxp_tabela2_8" <> 0
    and (
        concat(
            case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
            case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
        ) = @codigo_restricao
        or @codigo_restricao = ''
    )
UNION
SELECT
    concat(
        cast(VDPAROCO_ANOTAB_CARGA as varchar(4)),
        case when length(cast(VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0' || cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela2_9" as varchar(2)) else cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela2_9" as varchar(2)) end
    ) AS CODIGO_TABELA_PRECO,
    concat(
        case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
        case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
    ) AS codigo_restricao_financeira
FROM
     TXPALM61,
     PAROCO61
WHERE
    txpalm61."vdcnftxp_tabela2_9" <> 0
    and (
        concat(
            case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
            case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
        ) = @codigo_restricao
        or @codigo_restricao = ''
    )
UNION
SELECT
    concat(
        cast(VDPAROCO_ANOTAB_CARGA as varchar(4)),
        case when length(cast(VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0' || cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela2_10" as varchar(2)) else cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela2_10" as varchar(2)) end
    ) AS CODIGO_TABELA_PRECO,
    concat(
        case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
        case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
    ) AS codigo_restricao_financeira
FROM
     TXPALM61,
     PAROCO61
WHERE
    txpalm61."vdcnftxp_tabela2_10" <> 0
    and (
        concat(
            case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
            case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
        ) = @codigo_restricao
        or @codigo_restricao = ''
    )
UNION
SELECT
    concat(
        cast(VDPAROCO_ANOTAB_CARGA as varchar(4)),
        case when length(cast(VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0' || cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela3_1" as varchar(2)) else cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela3_1" as varchar(2)) end
    ) AS CODIGO_TABELA_PRECO,
    concat(
        case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
        case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
    ) AS codigo_restricao_financeira
FROM
     TXPALM61,
     PAROCO61
WHERE
    txpalm61."vdcnftxp_tabela3_1" <> 0
    and (
        concat(
            case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
            case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
        ) = @codigo_restricao
        or @codigo_restricao = ''
    )
UNION
SELECT
    concat(
        cast(VDPAROCO_ANOTAB_CARGA as varchar(4)),
        case when length(cast(VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0' || cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela3_2" as varchar(2)) else cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela3_2" as varchar(2)) end
    ) AS CODIGO_TABELA_PRECO,
    concat(
        case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
        case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
    ) AS codigo_restricao_financeira
FROM
     TXPALM61,
     PAROCO61
WHERE
    txpalm61."vdcnftxp_tabela3_2" <> 0
    and (
        concat(
            case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
            case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
        ) = @codigo_restricao
        or @codigo_restricao = ''
    )
UNION
SELECT
    concat(
        cast(VDPAROCO_ANOTAB_CARGA as varchar(4)),
        case when length(cast(VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0' || cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela3_3" as varchar(2)) else cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela3_3" as varchar(2)) end
    ) AS CODIGO_TABELA_PRECO,
    concat(
        case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
        case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
    ) AS codigo_restricao_financeira
FROM
     TXPALM61,
     PAROCO61
WHERE
    txpalm61."vdcnftxp_tabela3_3" <> 0
    and (
        concat(
            case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
            case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
        ) = @codigo_restricao
        or @codigo_restricao = ''
    )
UNION
SELECT
    concat(
        cast(VDPAROCO_ANOTAB_CARGA as varchar(4)),
        case when length(cast(VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0' || cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela3_4" as varchar(2)) else cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela3_4" as varchar(2)) end
    ) AS CODIGO_TABELA_PRECO,
    concat(
        case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
        case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
    ) AS codigo_restricao_financeira
FROM
     TXPALM61,
     PAROCO61
WHERE
    txpalm61."vdcnftxp_tabela3_4" <> 0
    and (
        concat(
            case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
            case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
        ) = @codigo_restricao
        or @codigo_restricao = ''
    )
UNION
SELECT
    concat(
        cast(VDPAROCO_ANOTAB_CARGA as varchar(4)),
        case when length(cast(VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0' || cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela3_5" as varchar(2)) else cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela3_5" as varchar(2)) end
    ) AS CODIGO_TABELA_PRECO,
    concat(
        case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
        case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
    ) AS codigo_restricao_financeira
FROM
     TXPALM61,
     PAROCO61
WHERE
    txpalm61."vdcnftxp_tabela3_5" <> 0
    and (
        concat(
            case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
            case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
        ) = @codigo_restricao
        or @codigo_restricao = ''
    )
UNION
SELECT
    concat(
        cast(VDPAROCO_ANOTAB_CARGA as varchar(4)),
        case when length(cast(VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0' || cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela3_6" as varchar(2)) else cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela3_6" as varchar(2)) end
    ) AS CODIGO_TABELA_PRECO,
    concat(
        case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
        case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
    ) AS codigo_restricao_financeira
FROM
     TXPALM61,
     PAROCO61
WHERE
    txpalm61."vdcnftxp_tabela3_6" <> 0
    and (
        concat(
            case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
            case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
        ) = @codigo_restricao
        or @codigo_restricao = ''
    )
UNION
SELECT
    concat(
        cast(VDPAROCO_ANOTAB_CARGA as varchar(4)),
        case when length(cast(VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0' || cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela3_7" as varchar(2)) else cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela3_7" as varchar(2)) end
    ) AS CODIGO_TABELA_PRECO,
    concat(
        case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
        case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
    ) AS codigo_restricao_financeira
FROM
     TXPALM61,
     PAROCO61
WHERE
    txpalm61."vdcnftxp_tabela3_7" <> 0
    and (
        concat(
            case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
            case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
        ) = @codigo_restricao
        or @codigo_restricao = ''
    )
UNION
SELECT
    concat(
        cast(VDPAROCO_ANOTAB_CARGA as varchar(4)),
        case when length(cast(VDPAROCO_MESTAB_CARGA as varchar(2))) = 1 then '0' || cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela3_8" as varchar(2)) else cast(VDPAROCO_MESTAB_CARGA as varchar(2)) || cast(txpalm61."vdcnftxp_tabela3_8" as varchar(2)) end
    ) AS CODIGO_TABELA_PRECO,
    concat(
        case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
        case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
    ) AS codigo_restricao_financeira
FROM
     TXPALM61,
     PAROCO61
WHERE
    txpalm61."vdcnftxp_tabela3_8" <> 0
    and (
        concat(
            case when length(Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_tpcobr" AS VARCHAR(2)) end,
            case when length(Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2))) = 1 then '0' || Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) else Cast(txpalm61."vdcnftxp_cpg" AS VARCHAR(2)) end
        ) = @codigo_restricao
        or @codigo_restricao = ''
    );