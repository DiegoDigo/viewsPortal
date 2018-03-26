CREATE OR REPLACE PROCEDURE SP_COMODATOS(
				in numeroEmpresa    smallint,
                in regiaoCliente    char(006),
				in numeroCliente    char(006),
				in codigoProduto    int,
				in numeroCev        bigint,
				in numeroItemCev    int,
				in dataCev          int,
				in dataVencimento   int,
				in tipoStatus       smallint,
				in numeroAtivo      char(013),
				in patrimonioDois   char(013),
				in quantidade       int,
				in valorItem        decimal(12,2),
				in tabelaPreco      int,
				in fazInventario    smallint,
				in codigoModelo     char(010),
				in descricaoModelo  char(015),
				in nomeFabricante   char(015),
				in dataUltimaAuditoria int,
				in codigoSituacao   char(002),
				in codigoOcorrencia char(002),
				in tecnologiaUtilizada  char(001),
				in quantidadeRecolha int,
				in origem           char(001),				
				out status_msg      smallint,
				out msg             varchar(255))

LANGUAGE SQL

BEGIN
        declare nrCev  integer;
		declare codVendedor char(003);
		declare dataHoje integer;
		set dataColeta = CAST(REPLACE(CAST(CURDATE() AS CHAR(10)),'-','') AS INT);
		
		set codVendedor = select VDCLICLI_VEN  from cadcli01 where VDCLICLI_REGI = regiaoCliente and VDCLICLI_NUM = numeroCliente ;
		set nrCev = select VDCEVREC_NRCCEV from VDCEVREC WHERE VDCEVREC_NRCCEV = numeroCev and dataCev = dataColeta;
		
		IF nrCev = null THEN
			insert into VDCEVREC(
			        VDCEVREC_NREMP        ,                 
				    VDCEVREC_CODCLI       ,               
					VDCEVREC_NRCCEV       ,              
					VDCEVREC_PROD         ,             
					VDCEVREC_DATA_COLETA  ,
					VDCEVREC_VEN          ,                   					                  
					VDCEVREC_ITEM_NRCCEV  ,          
					VDCEVREC_DATA         ,                  
					VDCEVREC_DTV          ,                   
					VDCEVREC_TIPOSTATUSCEV,         
					VDCEVREC_PATRIMONIO1  ,           
					VDCEVREC_PATRIMONIO2  ,           
					VDCEVREC_QTDE         ,                  
					VDCEVREC_VLRITEM      ,               
					VDCEVREC_TBPRD        ,               
					VDCEVREC_FAZ_INVENTARIO,        
					VDCEVREC_CODMOD       ,                
					VDCEVREC_DESCR_MOD    ,             
					VDCEVREC_NOMEFABR     ,              
					VDCEVREC_DTULT_AUDITORIA,       
					VDCEVREC_SITINVE_INVENTARIO,    
					VDCEVREC_OCORINVE_INVENTARIO, 							   
					VDCEVREC_TIPOLOC_INVENTARIO ,  
                    VDCEVREC_QTDE_RECOLHA, 
                    VDCEVREC_SITUACAO,
					VDCEVREC_ORIGEM)
			       values(
				    numeroEmpresa,
					cast(concat(regiaoCliente, numeroCliente) as int),
					codigoProduto,
					numeroCev,
					dataColeta,
					codVendedor,
					numeroItemCev,
					dataCev,
					dataVencimento,
					tipoStatus,
					numeroAtivo,
					patrimonioDois,
					quantidade,
					valorItem,
					tabelaPreco,
					fazInventario,
					codigoModelo,
					descricaoModelo,
					nomeFabricante,
					dataUltimaAuditoria,
					codigoSituacao,
					codigoOcorrencia,
					tecnologiaUtilizada,
					quantidadeRecolha,
					0,
					origem
							);
			set status_msg = 0;
			set msg = 'Cadastrado com sucesso'; 
		ELSE
		    set status_msg = 1;
			set msg = 'CEV ja Existe com a data de hoje';
		END IF;
		
		
END;




