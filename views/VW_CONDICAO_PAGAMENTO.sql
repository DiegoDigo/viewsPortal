DECLARE SET INT @CODIGO_CONDICAO_PAGAMENTO = 0;
CREATE
or replace VIEW  VW_CONDICAO_PAGAMENTO AS
SELECT
    condpg61."vdcadpag_ativo" AS ATIVO,
    condpg61."vdcadpag_cod" AS CODIGO_CONDICAO_PAGAMENTO_ERP,
    condpg61."vdcadpag_descr" AS DESCRICAO,
    CASE WHEN condpg61."vdcadpag_cod" = 1 THEN 1 ELSE 0 END AS INFORMA_PRIMEIRA_PARCELA,
    condpg61."vdcadpag_nrdias" AS NUMERO_DIAS,
    condpg61."vdcadpag_prazo" AS PRAZO
FROM
     CONDPG61
WHERE
    (
        condpg61."vdcadpag_cod" = @CODIGO_CONDICAO_PAGAMENTO
        OR @CODIGO_CONDICAO_PAGAMENTO = 0
    );