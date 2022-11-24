DECLARE
    cursor search_employee is
           select P.NOMBRES, P.APELLIDO_P, P.COD_AREA, P.COD_ENTI, P.COD_POSICION, P.CED_PROV_INIC, P.CED_TOMO, P.CED_ASIENTO, nvl(P.mon_001,0) + nvl(P.mon_011,0) + nvl(P.mon_012,0) + nvl(P.mon_013,0) + nvl(P.mon_019,0) + nvl(P.mon_080,0) as SALARIO
           from epd.epd_planilla P
           where P.COD_AREA = 0 and P.COD_ENTI = 02;

    CED_PROV_INIC VARCHAR2(4);
    CED_TOMO      NUMBER(4);
    CED_ASIENTO   NUMBER(5);
	
BEGIN
   
   delete epd.EPD_LAURAPRUEBA;
   commit;
   
   CED_PROV_INIC := '7';
   CED_TOMO      := 707;
   CED_ASIENTO   := 614;

   for x in search_employee loop
   
       exit when search_employee%notfound is null;
	   
	   if ((x.CED_PROV_INIC = CED_PROV_INIC) and (x.CED_TOMO = CED_TOMO) and (x.CED_ASIENTO = CED_ASIENTO)) then
       	  dbms_output.put_line('Nombre: '|| x.NOMBRES ||' Apellido: '|| x.APELLIDO_P ||' Area: '|| x.COD_AREA ||' Entidad: '|| x.COD_ENTI ||' Posicion: '|| x.COD_POSICION ||' Cedula: '|| x.CED_PROV_INIC ||' Tomo: '|| x.CED_TOMO ||' Asiento: '|| x.CED_ASIENTO ||' Salario: '|| x.SALARIO);
	   end if;
   end loop;
   
   commit;
END;
/