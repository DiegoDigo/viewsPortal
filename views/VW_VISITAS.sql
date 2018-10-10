declare set  int @pasta = 0;

CREATE
or replace VIEW  VW_VISITAS AS
select
    numero_pasta as numeroPasta,
    data_visita as diaVisita
from
     PASTA_VISITA
where
    (
        numero_pasta = @pasta
        or @pasta = 0
    )
order by
    1;