create function datetostr.DATETOSTR(DATE, varchar(20)) RETURNS varchar(20);

DECLARE SET INT @CODIGOPEDIDO = 0;

CREATE OR REPLACE view  vw_acompanhamento_pedido 
AS 
  SELECT "vdpedflc_nped"         AS NUMERO_PEDIDO_GESTAO, 
         "vdpedflc_sit_nped"     AS SITUACAO_PEDIDO_GESTAO, 
         "vdpedflc_pnped"        AS NUMERO_PRE_PEDIDO_GESTAO, 
         "vdpedflc_croma"        AS NUMERO_ROMANEIO, 
         "vdpedflc_sit_crom"     AS SITUACAO_ROMANEIO, 
         "vdpedflc_serie"        AS SERIE_NFISCAL, 
         "vdpedflc_nf"           AS NUMERO_NFISCAL, 
         "vdpedflc_cod_bloq_ped" AS CODIGO_BLOQ_PEDIDO 
  FROM    vdpedflc 
  WHERE  ( "vdpedflc_nped" = @codigopedido 
            OR @codigopedido = 0 ) ;