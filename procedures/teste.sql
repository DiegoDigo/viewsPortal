CREATE OR REPLACE PROCEDURE SP_BOLETIM(in hora_final int,
									   in hora_inicial   int, 
									   out teste varchar(255))

LANGUAGE SQL

BEGIN

declare HORAS_EM_SEGUNDO float;
declare DIF_HORA float;
declare DIF_MIN  float;
declare DIF_SEC  float;

set HORAS_EM_SEGUNDO =   

( (cast(substring(Cast(hora_inicial as char(006)), 1,2) as int) * 3600) + 
 (cast(substring(Cast(hora_inicial as char(006)), 3,2) as int) * 60) +
 cast(substring(Cast(hora_inicial as char(006)), 5,2) as int) )
 -
 ( (cast(substring(Cast(hora_final as char(006)), 1,2) as int) * 3600) 
 + (cast(substring(Cast(hora_final as char(006)), 3,2) as int) * 60) +
 cast(substring(Cast(hora_final as char(006)), 5,2) as int) ) ;


SET DIF_HORA =  HORAS_EM_SEGUNDO / 3600 ;	

SET DIF_MIN =  abs((HORAS_EM_SEGUNDO - (CAST(LEFT(CAST(DIF_HORA AS VARCHAR(255)), locate('.', CAST(DIF_HORA AS VARCHAR(255)), 1)) AS INT) * 3600)) / 60) ;


SET DIF_SEC =  DIF_MIN - (CAST(LEFT(CAST(DIF_HORA AS VARCHAR(255)), locate('.', CAST(DIF_HORA AS VARCHAR(255)), 1)) AS INT )* 60);




SET TESTE =  DIF_SEC ;
END;



