-- -----------------------------------------
-- PROCEDURES DEL PROYECTO = 11/10
-- -----------------------------------------

-- PROCEDURE #1 K: pagos realizados en el mes. Este es para administrativos del Restaurante
DROP PROCEDURE IF EXISTS consultaPago;
DELIMITER $$
	CREATE PROCEDURE consultaPago(IN mes VARCHAR(10), IN anyo VARCHAR(10))
		BEGIN
			SELECT * FROM pago WHERE mes=monthname(PAG_fecha) AND anyo=year(PAG_fecha);
        END
	$$
DELIMITER ;
CALL consultaVentasMes('january', '2016'); -- OK comprobado el PROCEDURE #1


-- PROCEDURE #2 K: verificar si el pago de un pedido ya fue hecho. Es para empleados del Restaurante
DROP PROCEDURE IF EXISTS consultaPagoPedido;
DELIMITER $$
	CREATE PROCEDURE consultaPagoPedido(IN idIN VARCHAR(10))
		BEGIN			
			SELECT PAG_estado 
            FROM pago JOIN pedido
            WHERE pago.PEDIDO_PED_id=PED_id AND PED_id=idIN;
        END
	$$
DELIMITER ;
CALL consultaPagoPedido('5-ped'); -- OK comprobado el PROCEDURE #2


-- PROCEDURE # 3 FM: SABER EL SALDO DADO UN RESTAURANTE
DROP PROCEDURE IF EXISTS obtenerSaldoRestaurante;
DELIMITER $$
	CREATE PROCEDURE obtenerSaldoRestaurante(IN nombreRestaurante varchar(25), OUT saldo DOUBLE)
		BEGIN
			SELECT BANRES_saldo INTO saldo
			FROM restaurante JOIN `BANCA RESTAURANTE` 
			WHERE RES_nombre = nombreRestaurante AND `BANCA RESTAURANTE_BANRES_id`=BANRES_id;
		END;
	$$
DELIMITER ;
CALL obtenerSaldoRestaurante('KFC', @k); 
SELECT @k; -- OK comprobado el PROCEDURE #3


-- PROCEDURE # 4 FM: SABER EL SALDO DADO UN CLIENTE
DROP PROCEDURE IF EXISTS obtenerSaldoCliente;
DELIMITER %%
	CREATE PROCEDURE obtenerSaldoCliente(IN usuario varchar(25), OUT saldo DOUBLE)
		BEGIN
			SELECT BANCLI_saldo INTO saldo
			FROM cliente JOIN `BANCA CLIENTE` 
			WHERE CLI_usuario=usuario AND `BANCA VIRTUAL_BAN_id` = BANCLI_id;
		END;
	%%
DELIMITER ;
CALL obtenerSaldoCliente('Zache',@k);
SELECT @k; -- OK comprobado el PROCEDURE #4


-- PROCEDURE # 5 FM: DADOS DOS VALORES DE PRECIOS (A,B), SACAR EL MENU QUE ESTE ENTRE ESTOS
DROP PROCEDURE IF EXISTS filtroXprecio;
DELIMITER %%
	CREATE PROCEDURE filtroXprecio(IN pmin DOUBLE, IN pmax DOUBLE)
		BEGIN
			SELECT 
				 MEN_nombre AS Nombre,
				 RES_nombre AS Restaurante,
				 MEN_precio AS Precio,
				 MEN_tipo AS Tipo,
				 MEN_tamano AS Tamaño,
				 MEN_descripcion AS Descripción
			FROM menu JOIN restaurante 
			WHERE RESTAURANTE_RES_nit=RES_nit AND pmin<MEN_precio AND pmax>MEN_precio;
		END;
	%%
DELIMITER ;
CALL filtroXprecio(10000,20000); -- OK comprobado el PROCEDURE #5


-- PROCEDURE # 6 FM: DADO UN RESTAURANTE LISTAR TODOS LOS MENUS Y EN QUE CCO ESTA
DROP PROCEDURE IF EXISTS menus;
DELIMITER $$
	CREATE PROCEDURE menus(IN nombreRestaurante VARCHAR(50), IN cco VARCHAR(70))
		BEGIN
			DECLARE nitRes VARCHAR(70);
			DECLARE ccoId VARCHAR(10);
			SELECT DISTINCT RES_nit INTO nitRes FROM restaurante WHERE RES_nombre=nombreRestaurante;
			SELECT DISTINCT CCO_id INTO ccoId 
				FROM restaurante JOIN `centro comercial` 
				WHERE CCO_nombre LIKE cco AND `CENTRO COMERCIAL_CCO_id` = CCO_id;
			
			SELECT MEN_nombre AS Nombre, 
				 MEN_precio AS Precio,
				 MEN_tipo AS Tipo,
				 MEN_tamano AS Tamaño,
				 MEN_descripcion AS Descripción,
				 CCO_nombre AS `Centro Comercial`
			FROM menu JOIN restaurante JOIN `CENTRO COMERCIAL`
			WHERE 
				RESTAURANTE_RES_nit = nitRes				
				AND	`RESTAURANTE_CENTRO COMERCIAL_CCO_id` = `CENTRO COMERCIAL_CCO_id`
				AND `CENTRO COMERCIAL_CCO_id` = ccoId
                AND `CENTRO COMERCIAL_CCO_id` = CCO_id
                AND RESTAURANTE_RES_nit = RES_nit;
		END;
	$$		
DELIMITER ;
CALL menus('KFC','Centro Comercial Portal 80'); -- OK comprobado el PROCEDURE #6


-- PROCEDURE # 7 K: ELIMINACION EMPLEADO CON CAUSA, ACA NO SE PUEDE CON EL NOMBRE DEL EMPLEADO PORQUE PUEDEN HABER VARIOS CON EL MISMO NOMBRE
DROP PROCEDURE IF EXISTS eliminacionEmpleadoP;
DELIMITER $$
	CREATE PROCEDURE eliminacionEmpleadoP(IN id INT, IN causa VARCHAR(300))
		BEGIN
			SET @causaEliminacionEmpleado = causa;
            DELETE FROM empleado WHERE EMP_id = id;
        END
    $$
DELIMITER ;
CALL eliminacionEmpleadoP(1602052412, "me cae mal"); -- OK comprobado el PROCEDURE #7


-- PROCEDURE # 8 K: DADO UN EMPLEADO CONSULTAR SU CARGO, RESTAURANTE ASOCIADO Y HORARIO
DROP PROCEDURE IF EXISTS horarioCargo_Empleado;
DELIMITER $$
	CREATE PROCEDURE horarioCargo_Empleado(IN id INT)
		BEGIN
			SELECT 
				EMP_nombre AS `Nombre Empleado`,
                EMP_cargo AS Cargo,
                EMP_horarioEntrada AS Entrada,
                EMP_horarioSalida AS Salida,
                RES_nombre AS `Trabaja en`
            FROM empleado JOIN restaurante
            WHERE `RESTAURANTE_CENTRO COMERCIAL_CCO_id` = `CENTRO COMERCIAL_CCO_id`
				AND RESTAURANTE_RES_nit = RES_nit
                AND EMP_id=id;
        END;
    $$
DELIMITER ;
CALL horarioCargo_Empleado(1602052412); -- OK comprobado el PROCEDURE #8



-- PROCEDURE # 9 K: SIMULACION DE CLIC EN PAGAR
DROP PROCEDURE IF EXISTS simulacionPagar;
DELIMITER $$
	CREATE PROCEDURE simulacionPagar(IN pedido VARCHAR(10), IN pagar VARCHAR(10))
		BEGIN
			IF pagar = 'pagar' THEN
				INSERT INTO simulacionPagoBoton (pedido, accion) VALUES (pedido, pagar);
			ELSE 
				INSERT INTO simulacionPagoBoton (pedido, accion) VALUES (pedido, 'pendiente');
			END IF;
        END;
    $$
DELIMITER ;
CALL simulacionPagar('1-ped', 'pagar'); -- OK comprobado el PROCEDURE #9

-- PROCEDURE # 10 K: SIMULACION CLIC EN IMAGEN DE ALGUNA COMIDA
DROP PROCEDURE IF EXISTS llenadoFKmenuDetallePedido;
DELIMITER $$
	CREATE PROCEDURE llenadoFKmenuDetallePedido(IN alimento VARCHAR(50), IN cantidad DOUBLE, OUT fk VARCHAR(10))
		BEGIN
			SELECT MEN_id INTO fk FROM menu WHERE MEN_nombre LIKE alimento;
            INSERT INTO `DETALLE PEDIDO` VALUES (NOW(),'1-ped',fk,cantidad,0,'null');
        END;
    $$
DELIMITER ;
CALL llenadoFKmenuDetallePedido('Frisburrito', 3,@fkMenu); -- OK comprobado el PROCEDURE #10
select * from `DETALLE PEDIDO`;
#INSERT INTO `DETALLE PEDIDO` VALUES (NOW(),'1-ped','6701-men',3,21000,'null');

-- PROCEDURE # 11 K: ABSTRACCION DEL SUBTOTAL | MACHETAZO
DROP PROCEDURE IF EXISTS abstraccionSubtotal;
DELIMITER $$
	CREATE PROCEDURE abstraccionSubtotal()
		BEGIN
			SET @ultimaFechaDetallePedido = (SELECT DPE_fecha  FROM subtotal ORDER BY DPE_fecha DESC LIMIT 1);
            SET @ultimoRegDetallePedido = (SELECT MENU_MEN_id  FROM subtotal ORDER BY DPE_fecha DESC LIMIT 1);
            SET @precio = (SELECT MEN_precio FROM menu WHERE MEN_id = @ultimoRegDetallePedido);
            SET @ultimaCantidadDetallePedido = (SELECT DPE_cantidad  FROM subtotal ORDER BY DPE_fecha DESC LIMIT 1);
            UPDATE `detalle pedido` SET DPE_subtotal = @precio*@ultimaCantidadDetallePedido WHERE DPE_fecha = @ultimaFechaDetallePedido;            
        END;
    $$
DELIMITER ;
CALL abstraccionSubtotal(); -- OK comprobado el PROCEDURE #11