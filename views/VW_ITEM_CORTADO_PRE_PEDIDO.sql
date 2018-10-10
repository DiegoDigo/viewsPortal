declare set bigint @cod_pre_pedido = 0;
DECLARE SET INT @codemp = 0;
CREATE
or replace VIEW  VW_ITEM_CORTADO_PRE_PEDIDO AS
select
    vdpedipp_pre_ped as PRE_PEDIDO,
    vdpedipp_item as ITEM,
    vdpedipp_codr as CODIGO_PRODUTO_ERP,
    vdpedipp_qtd as QTD_PRODUTO,
    vdpedipp_qtds as QTDS_PRODUTO,
    'SEM ESTOQUE' as MOTIVO
from
     VDPEDIPP
where
    vdpedipp_nremp = @codemp
    AND (
        vdpedipp_pre_ped = @cod_pre_pedido
        or @cod_pre_pedido = 0
    )
    AND vdpedipp_sem_estoq = 'S';