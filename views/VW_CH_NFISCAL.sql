DECLARE SET INT @NNF = 0;
DECLARE SET CHAR @SNF = ' ';

CREATE OR REPLACE view  vw_ch_nfiscal 
AS 
  SELECT vdfatnfr_nnf, 
         vdfatnfr_serie, 
         vdfatnfr_ident_nf 
  FROM    vdfatn61 
  WHERE  ( ( vdfatnfr_nnf = @nnf 
              OR @nnf = 0 ) 
           AND ( vdfatnfr_serie = @snf 
                  OR @snf = ' ' ) ) 
         AND ( vdfatnfr_demi > ( Datetostr(Curdate() - 45, 'yyyy/mm/dd') ) ) ;