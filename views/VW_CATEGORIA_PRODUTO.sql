DECLARE SET INT @CODIGO_CATEGORIA_PRODUTO = 0;

CREATE OR REPLACE view  vw_categoria_produto 
AS 
  SELECT catprd61. "vdprdcat_nr"    AS CODIGO_CATEGORIA_PRODUTO_ERP, 
         catprd61. "vdprdcat_descr" AS DESCRICAO 
  FROM    catprd61 
  WHERE  ( catprd61. "vdprdcat_nr" = @codigo_categoria_produto 
            OR @codigo_categoria_produto = 0 ) ;