declare

v_id_pedido number;
v_resumen clob;

begin

    v_id_pedido := 3;

    imprimir_pedido(v_id_pedido,v_resumen);
    dbms_output.put_line(v_resumen);

end;