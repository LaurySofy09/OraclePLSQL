DECLARE
    cursor search_employee(P_CED_PROV_INIC VARCHAR2, P_CED_TOMO NUMBER, P_CED_ASIENTO NUMBER) is
           select P.NOMBRES, P.APELLIDO_P, P.COD_AREA, P.COD_ENTI, P.COD_POSICION, P.CED_PROV_INIC, P.CED_TOMO, P.CED_ASIENTO, nvl(P.mon_001,0) + nvl(P.mon_011,0) + nvl(P.mon_012,0) + nvl(P.mon_013,0) + nvl(P.mon_019,0) + nvl(P.mon_080,0) as SALARIO
           from epd.epd_planilla P
           where P.COD_AREA = 0 and P.COD_ENTI = 02 and P.CED_PROV_INIC = P_CED_PROV_INIC and P.CED_TOMO = P_CED_TOMO and P.CED_ASIENTO = P_CED_ASIENTO;

    CED_PROV_INIC VARCHAR2(4);
    CED_TOMO      NUMBER(4);
    CED_ASIENTO   NUMBER(5);
	
BEGIN
   
   delete epd.EPD_LAURAPRUEBA;
   commit;
   
   CED_PROV_INIC := '&CED_PROV_INIC';
   CED_TOMO      := &CED_TOMO;
   CED_ASIENTO   := &CED_ASIENTO;

   for x in search_employee(&CED_PROV_INIC, &CED_TOMO, &CED_ASIENTO) loop
   
       exit when search_employee%notfound is null;
       dbms_output.put_line('Nombre: '|| x.NOMBRES ||' Apellido: '|| x.APELLIDO_P ||' Area: '|| x.COD_AREA ||' Entidad: '|| x.COD_ENTI ||' Posicion: '|| x.COD_POSICION ||' Cedula: '|| x.CED_PROV_INIC ||' Tomo: '|| x.CED_TOMO ||' Asiento: '|| x.CED_ASIENTO ||' Salario: '|| x.SALARIO);
   		
	   insert into epd.EPD_LAURAPRUEBA(COD_AREA, COD_ENTI, COD_POSICION, CED_PROV_INIC, CED_TOMO, CED_ASIENTO, NOMBRES, APELLIDO_P, SALARIO) values(x.COD_AREA, x.COD_ENTI, x.COD_POSICION, x.CED_PROV_INIC, x.CED_TOMO, x.CED_ASIENTO, x.NOMBRES, x.APELLIDO_P, x.SALARIO);
	   
   end loop;
   
   commit;
END;

 select * from epd.EPD_LAURAPRUEBA;


-- create table epd_tabla_prueba_lsd as 
-- select * from epd.epd_planilla 
-- where cod_area = 0 and cod_enti = 02
-- 
-- 
-- DROP table epd_tabla_prueba_lsd 
-- 
-- create table epd_tabla_prueba_lsd as 
-- select * from epd.epd_planilla 
-- where cod_area = 0 and cod_enti = 0
-- 
-- 
-- DROP table epd_tabla_prueba_lsd 
-- 
-- 
-- create table epd_tabla_prueba_lsd as 
-- select COD_AREA, 
-- COD_ENTI, 
-- COD_POSICION, 
-- CED_PROV_INIC, 
-- CED_TOMO, 
-- CED_ASIENTO, 
-- NOMBRES, 
-- APELLIDO_P, 
-- APELLIDO_M, 
-- APELLIDO_C from epd.epd_planilla 
-- where cod_area = 0 and cod_enti = 0
-- 
-- 
-- insert into epd_tabla_prueba_lsd 
-- select COD_AREA, 
--        COD_ENTI, 
--        COD_POSICION, 
--        CED_PROV_INIC, 
--        CED_TOMO, 
--        CED_ASIENTO, 
--        NOMBRES, 
--        APELLIDO_P, 
--        APELLIDO_M, 
--        APELLIDO_C from epd.epd_planilla 
-- where cod_area = 0 and cod_enti = 02 and cod_unidad = 8 and nombres like '%LAURA%'
-- 
-- 
-- commit;