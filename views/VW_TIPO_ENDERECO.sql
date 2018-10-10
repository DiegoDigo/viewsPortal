DECLARE SET VARCHAR(255) @SIGLA ='';
DECLARE SET int @ATIVO =0;

CREATE
or replace VIEW  VW_TIPO_ENDERECO AS
SELECT
    @ATIVO AS ATIVO,
    "gegentip_cod" AS DESCRICAO_LOGRADOURO,
    "gegentip_sigla" AS SIGLA_LOGRADOURO
FROM
     CEPTIP
WHERE
    (
        "gegentip_cod" = @sigla
        OR @sigla = ''
    );