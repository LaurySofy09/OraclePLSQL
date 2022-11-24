create or replace procedure imprimir_pedido (p_idpedido in number, p_resumen_pedido out clob)
is

v_res_pedido clob;
br varchar2(1) := chr(10);
sep varchar2(35) := br||'--------------------------------'||br;
v_datos_cliente varchar2(140);
v_direccion_cliente varchar2(140);
v_precio_final number;

cursor pedidos_articulo(id_pedido number) is
select p.cantidad,a.nombre,a.precio
from pedidos_articulos p
inner join articulos a on p.idarticulo = a.idarticulo
where p.idpedido = id_pedido;

begin

    v_res_pedido := sep;
    v_res_pedido:= v_res_pedido||'PEDIDO Nº: '||p_idpedido;
    v_res_pedido := v_res_pedido||sep;
    
    select c.apellido||', '||c.nombre||'. DOC: '||c.documento, d.calle||' '||d.numero||' - Piso: '||d.piso||' '||d.departamento
    into v_datos_cliente,v_direccion_cliente
    from pedidos p
    inner join clientes c on p.idcliente = c.idcliente
    inner join direcciones d on d.idcliente = p.iddireccion
    where p.idpedido = p_idpedido;
    
    v_res_pedido := v_res_pedido||'CLIENTE: '||v_datos_cliente||br||'DIRECCION: '||v_direccion_cliente||sep;
    v_res_pedido := v_res_pedido||sep||'A R T I C U L O S'||sep;
    
    for art in pedidos_articulo(p_idpedido) loop
    
        v_res_pedido := v_res_pedido||art.nombre||'(x'||art.cantidad||')........$'||art.precio||br;
    
    end loop;
    
    v_precio_final := calcular_valor_pedido(p_idpedido);
    v_res_pedido:=v_res_pedido||sep||'TOTAL: $'||v_precio_final||sep;
    

    p_resumen_pedido := v_res_pedido;

end;