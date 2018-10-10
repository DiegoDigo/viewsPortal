DECLARE SET SMALLINT @CODIGO_EMPRESA = 0;

CREATE
or replace VIEW  VW_PAROCO AS
SELECT
    VDPAROCO_CODEMP AS CODIGO_EMPRESA,
    VDPAROCO_OCOKD_BIMOB_CL AS OCORRENCIA_BIMOB_CL,
    VDPAROCO_OCOKD_BIMOB_SL AS OCORRENCIA_BIMOB_SL,
    VDPAROCO_OCVDVAS AS OCORRENCIA_VENDA_VASILHAME,
    VDPAROCO_OCOKD_VIMOB_SL AS OCORRENCIA_VIMOB_SL,
    VDPAROCO_OCCEVSAI AS OCORRENCIA_CEV_SAIDA,
    VDPAROCO_OCCEVSAI_FE AS OCORRENCIA_CEV_SAIDA_FE,
    VDPAROCO_OCCEVREC AS OCORRENCIA_CEV_RECOLHIMENTO,
    VDPAROCO_OCCEVREC_FE AS OCORRENCIA_CEV_RECOLHIMENTO_FE,
    VDPAROCO_OCCEVSAI_SL AS OCORRENCIA_CEV_RECOLHIMENTO_SL,
    VDPAROCO_OCCEVSAI_FE_SL AS OCORRENCIA_CEV_RECOLHIMENTO_FE_SL,
    VDPAROCO_DEV_KAR_DIAANT_FIN AS OCORRENCIA_DEV_DIA_ANTERIOR_FIN,
    VDPAROCO_DEV_KAR_DIAANT_NFIN AS OCORRENCIA_DEV_DIA_ANTERIOR_NAO_FIN,
    VDPAROCO_OCOKD_COMPRA AS OCORRENCIA_COMPRA,
    VDPAROCO_OCOKD_COMPRA_BONIF AS OCORRENCIA_COMPRA_BONIFICADA,
    VDPAROCO_OCO_AUTOCONS AS OCORRENCIA_AUTOCONS,
    VDPAROCO_QUEBRA AS QUEBRA,
    VDPAROCO_QUEBRA2 AS QUEBRA2,
    VDPAROCO_QUEBRA3 AS QUEBRA3,
    VDPAROCO_OCO_VDA_DIRETA AS OCORRENCIA_VENDA_DIRETA,
    VDPAROCO_OCO_DIGPED AS OCORRENCIA_DIGIPED,
    VDPAROCO_OCCONSIG AS OCORRENCIA_CONSIG,
    VDPAROCO_OCOKDREM AS OCORRENCIA_REM,
    VDPAROCO_OCOKDREM_BONIF AS OCORRENCIA_REM_BONIFICADO,
    VDPAROCO_OCOKDREM_ESPECIAL AS OCORRENCIA_REM_ESPECIAL,
    VDPAROCO_OCBON1 AS OCORRENCIA_BONIFICADA_1,
    VDPAROCO_OCBON2 AS OCORRENCIA_BONIFICADA_2,
    VDPAROCO_OCBON3 AS OCORRENCIA_BONIFICADA_3,
    VDPAROCO_OCBON4 AS OCORRENCIA_BONIFICADA_4,
    VDPAROCO_OCB0N5 AS OCORRENCIA_BONIFICADA_5,
    VDPAROCO_OCTCA1 AS OCORRENCIA_TROCA1,
    VDPAROCO_OCTCA2 AS OCORRENCIA_TROCA2,
    VDPAROCO_OCTCA3 AS OCORRENCIA_TROCA3,
    VDPAROCO_OCTCA4 AS OCORRENCIA_TROCA4,
    VDPAROCO_OCTCA5 AS OCORRENCIA_TROCA5,
    VDPAROCO_SPREM_E AS SPREM_E,
    VDPAROCO_SPREM_I AS SPREM_I,
    VDPAROCO_OCOKDRETV AS COCORRENCIA_RETV,
    VDPAROCO_OCOKDSAIV AS COCORRENCIA_SAIV,
    VDPAROCO_OCO_INV_SABOR_E AS COCORRENCIA_INV_SABOR_E,
    VDPAROCO_OCO_INV_SABOR_S AS COCORRENCIA_INV_SABOR_S,
    VDPAROCO_OCO_INV_SABOR_E_ANT AS COCORRENCIA_INV_SABOR_E_ANT,
    VDPAROCO_OCO_INV_SABOR_S_ANT AS COCORRENCIA_INV_SABOR_S_ANT,
    VDPAROCO_TAB_CUSTO_PROD AS CODIGO_TABELA_CUSTO_ERP,
    VDPAROCO_TAB_PREMED_VDA AS COCORRENCIA_TAB_PREMED_VDA,
    CASE WHEN LENGTH(CAST(VDPAROCO_CLIENTE AS VARCHAR(008))) = 5 THEN CONCAT('000', CAST(VDPAROCO_CLIENTE AS VARCHAR(008))) WHEN LENGTH(CAST(VDPAROCO_CLIENTE AS VARCHAR(008))) = 6 THEN CONCAT('00', CAST(VDPAROCO_CLIENTE AS VARCHAR(008))) WHEN LENGTH(CAST(VDPAROCO_CLIENTE AS VARCHAR(008))) = 7 THEN CONCAT('0', CAST(VDPAROCO_CLIENTE AS VARCHAR(008))) ELSE CAST(VDPAROCO_CLIENTE AS VARCHAR(008)) END AS CODIGO_CLIENTE_ERP,
    VDPAROCO_TIPCLI AS TIPCLI,
    VDPAROCO_TIPPRD AS TIPPRD,
    VDPAROCO_TIPPLA AS TIPLA,
    VDPAROCO_VISFAT AS VISFAT,
    VDPAROCO_VERBA AS VERBA,
    VDPAROCO_INDENIZA AS INDENIZA,
    VDPAROCO_INTEGRA_FORMA_CONTBL AS INTREGRA_CONTABEL,
    VDPAROCO_IGUALLC AS IGUALIC,
    VDPAROCO_ANTECIPADO AS ANTECIPADO,
    VDPAROCO_SOLAVANCO AS SOLAVANCO,
    VDPAROCO_TIPFOR AS TIPFOR,
    VDPAROCO_TABCUSTO_FREPUXA AS TABCUSTO_PREPUXA,
    VDPAROCO_TABCUSTO_FREENTR AS TABELA_CUSTO_FRETE_ENTRGA,
    VDPAROCO_OCOKD_COMPRA_FE AS OCORRENCIA_COMPRA_FE,
    VDPAROCO_OCOTK_ENTFUTURA AS OCORRENCIA_ENTFUTURA,
    VDPAROCO_OCOTK_VENFAT AS OCORRENCIA_VENFAT,
    VDPAROCO_ANOTAB_CARGA AS ANO_TABELA_CARGA,
    VDPAROCO_MESTAB_CARGA AS MES_TABELA_CARGA,
    VDPAROCO_USA_BANDPREC AS USA_BANDEIRA,
    VDPAROCO_SENHA_LIB AS SENHA_LIB,
    VDPAROCO_CTRL_RESTRICOES AS RESTRICAO_FINANCEIRA,
    VDPAROCO_RESTR_COMERCIAL AS RESTRICAO_COMERCIAL,
    VDPAROCO_FAM_FAMC_BAND AS BANDA_FAM_FAMC,
    VDPAROCO_REG_PASTA_BANDPREC AS BANDA_REG_PASTA,
    VDPAROCO_BDA_VEN_SUP_GER AS BANDA_VEN_SUP_GER,
    VDPAROCO_CAN_GRPCAN_BANDPREC AS BANDA_CAN_GRPCAN
FROM
     PAROCO61
WHERE
    (
        VDPAROCO_CODEMP = @CODIGO_EMPRESA
        OR @CODIGO_EMPRESA = 0
    );