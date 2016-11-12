-- -----------------------------------------
-- VISTAS Y TABLAS NUEVAS TEMPORALES DEL PROYECTO = 0/6
-- -----------------------------------------

/*
DROP TABLE IF EXISTS tempIdPedido; -- no esta funcionando
CREATE TABLE IF NOT EXISTS tempIdPedido(
	pk INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    id VARCHAR(10) NOT NULL,
    valor DOUBLE NOT NULL
)ENGINE=InnoDB;

DROP TABLE IF EXISTS m; -- no esta en uso
CREATE TABLE IF NOT EXISTS m(
	pk INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    m1 VARCHAR(10) NOT NULL
)ENGINE=InnoDB;


DROP TABLE IF EXISTS errorSaldo; -- no está en uso
CREATE TABLE IF NOT EXISTS errorSaldo(
	pk INT NOT NULL PRIMARY KEY,
	mensaje VARCHAR(50) NOT NULL	
)ENGINE=InnoDB;

INSERT INTO errorSaldo VALUES (0,'Saldo insuficiente');
INSERT INTO errorSaldo VALUES (1,'La transacción ha sido exitosa');


DROP TABLE IF EXISTS temp; -- no esta en uso
CREATE TABLE IF NOT EXISTS temp(
	pk INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	pk2 INT NOT NULL
    #idCliente VARCHAR(10) NOT NULL,
	#totalPago DOUBLE NOT NULL
)ENGINE=InnoDB; 

*/
-- -----------------------------------------------------------
DROP TABLE IF EXISTS estadoPago; -- ok funcionando es una temporal para correr un TRIGGER (#2) ya que desde el mismo no se pueden correr vistas
CREATE TABLE IF NOT EXISTS estadoPago(
	pk INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id VARCHAR(10) NOT NULL,
    fecha DATETIME NOT NULL,
    total DOUBLE NOT NULL,
    fkPedido VARCHAR(10) NOT NULL
)ENGINE=InnoDB;

DROP TABLE IF EXISTS empleadosEliminados;
CREATE TABLE IF NOT EXISTS empleadosEliminados(
	pk INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id INT NOT NULL,
    nombre VARCHAR(50),
    cargo VARCHAR(25),
    causa VARCHAR(300)    
)ENGINE=InnoDB;
    










