-- -----------------------------------------
-- TRIGGERS DEL PROYECTO = 5/5
-- -----------------------------------------

-- #1 OK: se quiere hacer el descuento desde la cuenta del cliente con el monto del total del pedido
DROP TRIGGER IF EXISTS descuentoSaldoCliente; -- ok trigger funcionando
DELIMITER $$
	CREATE TRIGGER descuentoSaldoCliente AFTER INSERT ON estadoPago
		FOR EACH ROW
			BEGIN                
                SET @cliente = (SELECT CLIENTE_CLI_id FROM pedido JOIN estadoPago WHERE PED_id = fkPedido AND PED_id = NEW.fkPedido);
				SET @banca = (SELECT `BANCA VIRTUAL_BAN_id` FROM cliente WHERE CLI_id=@cliente);
				SET @saldo = (SELECT BANCLI_saldo FROM cliente JOIN `banca cliente` WHERE BANCLI_id=`BANCA VIRTUAL_BAN_id` AND BANCLI_id=@banca);
                SET @total = (SELECT total FROM pedido JOIN estadoPago WHERE PED_id = fkPedido AND PED_id = NEW.fkPedido);                
                
                IF @saldo>=@total THEN 
					UPDATE `banca cliente` SET BANCLI_saldo = (@saldo-@total) WHERE BANCLI_id = @banca;				
                END IF;                
            END;
    $$
DELIMITER ;

-- #2 OK: HACE PARTE DEL TRIGGER #1
DROP TRIGGER IF EXISTS activeTableEstadoPago; -- ok funcionando 
DELIMITER $$
	CREATE TRIGGER activeTableEstadoPago AFTER INSERT ON pago 
		FOR EACH ROW
			BEGIN
				IF NEW.PAG_estado='espera' THEN
					INSERT INTO estadoPago (id, fecha, total, fkPedido) VALUES (NEW.PAG_id, NEW.PAG_fecha, NEW.PAG_total, NEW.PEDIDO_PED_id);                    
				END IF;
            END;
    $$
DELIMITER ;

-- #3 OK: Permitir solo saldos positivos en la cuenta del cliente | MACHETAZO
DROP TRIGGER IF EXISTS verificacionSaldoCuentaCliente;
DELIMITER $$
	CREATE TRIGGER verificacionSaldoCuentaCliente AFTER INSERT ON cliente -- `banca cliente`
		FOR EACH ROW
			BEGIN
				SET @idBanca = (SELECT BANCLI_id FROM cliente JOIN `banca cliente` WHERE BANCLI_id=`BANCA VIRTUAL_BAN_id` AND CLI_id=NEW.CLI_id);
				SET @valor = (SELECT BANCLI_saldo FROM cliente JOIN `banca cliente` WHERE BANCLI_id=`BANCA VIRTUAL_BAN_id` AND CLI_id=NEW.CLI_id);
                IF @valor < 0 THEN
					UPDATE `banca cliente` SET BANCLI_estadoCuenta = 'INACTIVA', BANCLI_saldo = 0 WHERE BANCLI_id=@idBanca;
				END IF;
            END;
	$$
DELIMITER ;

-- #4 OK FM: que despues de actualizar un registro en  `detalle pedido` actualiza el valor del atributo PAG_total de la tabla PAGO
DROP TRIGGER IF EXISTS totalPago;
DELIMITER &&  
	CREATE TRIGGER totalPago AFTER INSERT ON `detalle pedido`
		FOR EACH ROW 
			BEGIN
				SET @pre_total=(
					SELECT SUM(DPE_subtotal) FROM `detalle pedido` WHERE PEDIDO_PED_id=NEW.PEDIDO_PED_id);
				UPDATE PAGO SET PAG_total=@pre_total WHERE PEDIDO_PED_id=NEW.PEDIDO_PED_id ;
			END; 
	&&
DELIMITER ;

-- #5 OK: al eliminar un empleado reportarselo al CCO DBA
DROP TRIGGER IF EXISTS eliminacionEmpleadoT;
DELIMITER $$
	CREATE TRIGGER eliminacionEmpleadoT AFTER DELETE ON empleado
		FOR EACH ROW
			BEGIN
				INSERT INTO empleadosEliminados (id, nombre, cargo, causa) VALUES (OLD.EMP_id, OLD.EMP_nombre, OLD.EMP_cargo, @causaEliminacionEmpleado);
            END;
    $$
DELIMITER ;








/* TRIGGER PARA ACTUALIZA EL SUBTOTAL, NO FUNCIONA
# trigger que asigna a DPE_subtotal el valor de cantidad * precio

DROP TRIGGER IF EXISTS TR_1;
DELIMITER &&
  
CREATE TRIGGER TR_1 AFTER INSERT ON `detalle pedido`
FOR EACH ROW BEGIN
SET @cant=NEW.DPE_cantidad;
SET @price=(SELECT MEN_precio FROM MENU WHERE MEN_id=NEW.MENU_MEN_id);
UPDATE `detalle pedido` SET DPE_subtotal=@cant*@price WHERE DPE_fecha=NEW.DPE_fecha;
END; &&
  
DELIMITER ;

*/

-- -----------------------------------------
-- DATOS PARA PROBAR TRIGGERS
-- -----------------------------------------


INSERT INTO PEDIDO VALUES ('6-ped','HECHO','13-cli');
INSERT INTO PAGO VALUES ('6-pag','APROBADO','2016/11/07  12:45:05',0,'6-ped');
INSERT INTO `DETALLE PEDIDO` VALUES ('2016/11/07  13:00:05','6-ped','7567-men',2,100,'null');
INSERT INTO `DETALLE PEDIDO` VALUES ('2016/11/07  13:04:05','6-ped','7755-men',4,200,'null');
INSERT INTO `DETALLE PEDIDO` VALUES (NOW(),'6-ped','7755-men',4,100,'null');

SELECT * FROM `detalle pedido`;
SELECT * FROM pago;
SELECT * FROM pedido;

DELETE FROM PEDIDO;
DELETE FROM `DETALLE PEDIDO`;





SELECT * FROM estadoPago;
SELECT * FROM pago;
#SELECT * FROM temp;

SELECT * FROM `banca cliente`; 
SELECT * FROM pedido;
SELECT * FROM cliente;
select @text;

-- ------------------------------
-- INICIO ELIMINANDO DATOS 
-- ------------------------------
#DELETE FROM temp;
DELETE FROM pago;
DELETE FROM estadoPago;
DELETE FROM `banca cliente`;
-- ------------------------------
-- FIN ELIMINANDO DATOS 
-- ------------------------------





INSERT INTO `BANCA CLIENTE` VALUES ('3683 .920678 .0917','ACTIVA',-1);
INSERT INTO `BANCA CLIENTE` VALUES ('3600 .006879 .6984','ACTIVA',-3);
INSERT INTO `BANCA CLIENTE` VALUES ('3644 .418778 .7807','ACTIVA',-5);
INSERT INTO `BANCA CLIENTE` VALUES ('3679 .087233 .9498','ACTIVA',-9);
INSERT INTO `BANCA CLIENTE` VALUES ('3604 .252878 .4739','ACTIVA',-30);


INSERT INTO cliente VALUES ('15-cli','Keeli','CLV34TXN2BH','Keelie C. Wilder','keelie.wilder@gmail.com','1971/03/10','3683 .920678 .0917');
INSERT INTO cliente VALUES ('32-cli','Raven','KYU26BUX0DK','Raven N. Alvarez','raven.alvarez@gmail.com','1984/01/19','3600 .006879 .6984');
INSERT INTO cliente VALUES ('20-cli','Ingri','COO15PAK2TW','Ingrid K. Velez','ingrid.velez@gmail.com','1967/09/12','3644 .418778 .7807');
INSERT INTO cliente VALUES ('28-cli','Gisel','FUU93OQA4DD','Giselle Q. Hebert','giselle.hebert@gmail.com','1960/06/12','3679 .087233 .9498');
INSERT INTO cliente VALUES ('41-cli','Quinn','BRQ73AYX9YY','Quinn Walls','quinn.walls@gmail.com','1966/10/23','3604 .252878 .4739');


INSERT INTO PEDIDO VALUES ('1-ped','SELECCIONANDO','15-cli');
INSERT INTO PEDIDO VALUES ('2-ped','SELECCIONANDO','20-cli');
INSERT INTO PEDIDO VALUES ('3-ped','SELECCIONANDO','28-cli');
INSERT INTO PEDIDO VALUES ('5-ped','HECHO','32-cli');
INSERT INTO PEDIDO VALUES ('4-ped','SELECCIONANDO','41-cli');


INSERT INTO PAGO VALUES ('1-pag','ESPERA','2016/04/22  17:15:04',21000,'1-ped');
INSERT INTO PAGO VALUES ('2-pag','ESPERA','2016/04/17  23:59:16',15300,'2-ped');
INSERT INTO PAGO VALUES ('3-pag','ESPERA','2016/01/07  10:06:53',139500,'3-ped');
INSERT INTO PAGO VALUES ('4-pag','ESPERA','2016/01/30  4:03:03',41600,'4-ped');
INSERT INTO PAGO VALUES ('5-pag','APROBADO','2016/06/16  12:40:05',154000,'5-ped');

