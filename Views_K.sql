-- -----------------------------------------
-- VISTAS Y TABLAS NUEVAS TEMPORALES DEL PROYECTO = 0/6
-- -----------------------------------------

DROP TABLE IF EXISTS estadoPago; -- ok funcionando es una temporal para correr un TRIGGER (#2) ya que desde el mismo no se pueden correr vistas
CREATE TABLE IF NOT EXISTS estadoPago(
	pk INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id VARCHAR(10) NOT NULL,
    fecha DATETIME NOT NULL,
    total DOUBLE NOT NULL,
    fkPedido VARCHAR(10) NOT NULL
)ENGINE=InnoDB;

DROP TABLE IF EXISTS empleadosEliminados; -- OK FUNCIONANDO, TEMPORAL PARA CORRER EL TRIGGER #5
CREATE TABLE IF NOT EXISTS empleadosEliminados(
	pk INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id INT NOT NULL,
    nombre VARCHAR(50),
    cargo VARCHAR(25),
    causa VARCHAR(300)    
)ENGINE=InnoDB;
    
DROP TABLE IF EXISTS simulacionPagoBoton; -- OK FUNCIONANDO, TEMPORAL PARA CORRER EL TRIGGER #4 Y #6
CREATE TABLE IF NOT EXISTS simulacionPagoBoton(
	pk INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    pedido VARCHAR(10) NOT NULL,
    accion VARCHAR(10) NOT NULL
)ENGINE=InnoDB;


DROP TABLE IF EXISTS actualizarPago; -- OK FUNCIONANDO, TEMPORAL PARA CORRER EL TRIGGER #4 Y #6
CREATE TABLE IF NOT EXISTS actualizarPago(
	pk INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    estado VARCHAR(10) NOT NULL,
    fkPedido VARCHAR(10) NOT NULL
)ENGINE=InnoDB;

DROP VIEW IF EXISTS subtotal; -- OK FUNCIONANDO, TEMPORAL PARA CORRER EL PROCEDURE #11 TRIGGER #6
CREATE VIEW subtotal AS 
	SELECT DPE_fecha, PEDIDO_PED_id, MENU_MEN_id, DPE_cantidad, DPE_subtotal FROM `detalle pedido`;



SELECT * FROM subtotal;
SELECT * FROM PAGO;
SELECT * FROM estadopago;
SELECT * FROM simulacionPagoBoton;
DELETE FROM pago WHERE PAG_id = '1-pag';
DELETE FROM estadopago WHERE id = '1-pag';
DELETE FROM estadopago WHERE id = '-ped1';










