-- MySQL Script generated by MySQL Workbench
-- 11/05/16 20:19:47
-- Model: ZONA DE COMIDAS CC    Version: 2.0

-- Proyecto para la asignatura Base de Datos de la Universidad Nacional de Colombia sede Bogotá. 2016-3

-- MySQL Workbench Forward Engineering

SET @SQL_SAFE_UPDATES=0;

-- -----------------------------------------------------
-- Schema zonaComidasCC
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `zonaComidasCC` ;

-- -----------------------------------------------------
-- Schema zonaComidasCC
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `zonaComidasCC` DEFAULT CHARACTER SET utf8 ;
USE `zonaComidasCC` ;

-- -----------------------------------------------------
-- Table `CENTRO COMERCIAL`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CENTRO COMERCIAL` ;

CREATE TABLE IF NOT EXISTS `CENTRO COMERCIAL` (
  `CCO_id` VARCHAR(10) NOT NULL DEFAULT '1-cco',
  `CCO_nombre` VARCHAR(70) NOT NULL,
  `CCO_direccion` VARCHAR(70) NOT NULL,
  `CCO_ciudad` VARCHAR(45) NOT NULL,
  `CCO_telefono` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`CCO_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BANCA RESTAURANTE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BANCA RESTAURANTE` ;

CREATE TABLE IF NOT EXISTS `BANCA RESTAURANTE` (
  `BANRES_id` VARCHAR(25) NOT NULL,
  `BANRES_estadoCuenta` ENUM('ACTIVA','INACTIVA','ANULADA','MORA') NOT NULL DEFAULT 'INACTIVA',
  `BANRES_saldo` DOUBLE NOT NULL,
  PRIMARY KEY (`BANRES_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RESTAURANTE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `RESTAURANTE` ;

CREATE TABLE IF NOT EXISTS `RESTAURANTE` (
  `RES_nit` VARCHAR(18) NOT NULL DEFAULT '111.111.111-1-res',
  `CENTRO COMERCIAL_CCO_id` VARCHAR(10) NOT NULL,
  `RES_nombre` VARCHAR(70) NOT NULL,
  `RES_local` VARCHAR(5) NOT NULL,
  `RES_telefono` VARCHAR(20) NOT NULL,
  `BANCA RESTAURANTE_BANRES_id` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`RES_nit`, `CENTRO COMERCIAL_CCO_id`),
  CONSTRAINT `fk_RESTAURANTE_CENTRO COMERCIAL1`
    FOREIGN KEY (`CENTRO COMERCIAL_CCO_id`)
    REFERENCES `CENTRO COMERCIAL` (`CCO_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_RESTAURANTE_BANCA RESTAURANTE1`
    FOREIGN KEY (`BANCA RESTAURANTE_BANRES_id`)
    REFERENCES `BANCA RESTAURANTE` (`BANRES_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MENU`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MENU` ;

CREATE TABLE IF NOT EXISTS `MENU` (
  `MEN_id` VARCHAR(10) NOT NULL DEFAULT '1-men',
  `MEN_nombre` VARCHAR(60) NOT NULL,
  `MEN_tipo` ENUM('COMIDA','BEBIDA','POSTRE','COMBO','OTRO') NOT NULL,
  `MEN_tamano` ENUM('PERSONAL', 'FAMILIAR', 'INFANTIL', 'NORMAL', 'ESPECIAL', 'GRANDE', 'MEDIANO', 'PEQUEÑO') NOT NULL,
  `MEN_precio` DOUBLE NOT NULL,
  `MEN_descripcion` VARCHAR(500) NOT NULL,
  `RES_imagen` VARCHAR(100) NOT NULL,
  `RESTAURANTE_RES_nit` VARCHAR(18) NOT NULL,
  `RESTAURANTE_CENTRO COMERCIAL_CCO_id` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`MEN_id`),
  CONSTRAINT `fk_MENU_RESTAURANTE1`
    FOREIGN KEY (`RESTAURANTE_RES_nit` , `RESTAURANTE_CENTRO COMERCIAL_CCO_id`)
    REFERENCES `RESTAURANTE` (`RES_nit` , `CENTRO COMERCIAL_CCO_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BANCA CLIENTE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BANCA CLIENTE` ;

CREATE TABLE IF NOT EXISTS `BANCA CLIENTE` (
  `BANCLI_id` VARCHAR(25) NOT NULL,
  `BANCLI_estadoCuenta` ENUM('ACTIVA','INACTIVA','ANULADA','MORA') NOT NULL DEFAULT 'INACTIVA',
  `BANCLI_saldo` DOUBLE NOT NULL,
  PRIMARY KEY (`BANCLI_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CLIENTE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CLIENTE` ;

CREATE TABLE IF NOT EXISTS `CLIENTE` (
  `CLI_id` VARCHAR(10) NOT NULL DEFAULT '1-cli',
  `CLI_usuario` VARCHAR(50) NOT NULL DEFAULT 'user1',
  `CLI_contrasena` VARCHAR(50) NOT NULL,
  `CLI_nombre` VARCHAR(60) NOT NULL,
  `CLI_email` VARCHAR(70) NOT NULL,
  `CLI_fechaCumpleanos` DATE NULL,
  `BANCA VIRTUAL_BAN_id` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`CLI_id`),
  CONSTRAINT `fk_CLIENTE_BANCA VIRTUAL1`
    FOREIGN KEY (`BANCA VIRTUAL_BAN_id`)
    REFERENCES `BANCA CLIENTE` (`BANCLI_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PEDIDO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PEDIDO` ;

CREATE TABLE IF NOT EXISTS `PEDIDO` (
  `PED_id` VARCHAR(10) NOT NULL DEFAULT '1-ped',
  `PED_estado` ENUM('SELECCIONANDO','GENERANDO','HECHO') NOT NULL DEFAULT 'SELECCIONANDO',
  `CLIENTE_CLI_id` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`PED_id`),
  CONSTRAINT `fk_ PEDIDO_CLIENTE1`
    FOREIGN KEY (`CLIENTE_CLI_id`)
    REFERENCES `CLIENTE` (`CLI_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DETALLE PEDIDO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DETALLE PEDIDO` ;

CREATE TABLE IF NOT EXISTS `DETALLE PEDIDO` (
  `DPE_fecha` DATETIME NOT NULL,
  `PEDIDO_PED_id` VARCHAR(10) NOT NULL,
  `MENU_MEN_id` VARCHAR(10) NOT NULL,
  `DPE_cantidad` TINYINT NOT NULL,
  `DPE_subtotal` DOUBLE NOT NULL,
  `DPE_notas` VARCHAR(250) NULL,
  PRIMARY KEY (`DPE_fecha`, `PEDIDO_PED_id`),
  CONSTRAINT `fk_ PEDIDO_has_MENU_MENU1`
    FOREIGN KEY (`MENU_MEN_id`)
    REFERENCES `MENU` (`MEN_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ DETALLE PEDIDO_ PEDIDO1`
    FOREIGN KEY (`PEDIDO_PED_id`)
    REFERENCES `PEDIDO` (`PED_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TURNO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TURNO` ;

CREATE TABLE IF NOT EXISTS `TURNO` (
  `TUR_id` VARCHAR(10) NOT NULL DEFAULT '1-tur',
  `TUR_estado` ENUM('RECOGER','PREPARANDO','OTRO') NOT NULL DEFAULT 'OTRO',
  `TUR_numMesa` TINYINT NOT NULL DEFAULT 1,
  
  `DETALLE PEDIDO_PEDIDO_PED_id` VARCHAR(10) NOT NULL,
  `DETALLE PEDIDO_DPE_fecha` DATETIME NOT NULL,
  PRIMARY KEY (`TUR_id`),
  CONSTRAINT `fk_TURNO_ DETALLE PEDIDO1`
    FOREIGN KEY (`DETALLE PEDIDO_DPE_fecha` , `DETALLE PEDIDO_PEDIDO_PED_id`)
    REFERENCES `DETALLE PEDIDO` (`DPE_fecha` , `PEDIDO_PED_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PAGO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PAGO` ;

CREATE TABLE IF NOT EXISTS `PAGO` (
  `PAG_id` VARCHAR(10) NOT NULL DEFAULT '1-pag',
  `PAG_estado` ENUM('NO PAGADO','ESPERA','APROBADO','NO APROBADO', 'CANCELADO') NOT NULL DEFAULT 'ESPERA',
  `PAG_fecha` DATETIME NOT NULL,
  `PAG_total` DOUBLE NOT NULL,
  `PEDIDO_PED_id` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`PAG_id`),
  CONSTRAINT `fk_PAGO_ PEDIDO1`
    FOREIGN KEY (`PEDIDO_PED_id`)
    REFERENCES `PEDIDO` (`PED_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EMPLEADO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EMPLEADO` ;

CREATE TABLE IF NOT EXISTS `EMPLEADO` (
  `EMP_id` INT NOT NULL,
  `EMP_nombre` VARCHAR(50) NOT NULL,
  `EMP_cargo` ENUM('CAJERO','COCINERO','MESERO','OTRO','ADMINISTRADOR') NOT NULL,
  `EMP_horarioEntrada` VARCHAR(250) NULL,
  `EMP_horarioSalida` VARCHAR(250) NULL,
  `RESTAURANTE_RES_nit` VARCHAR(18) NOT NULL,
  `RESTAURANTE_CENTRO COMERCIAL_CCO_id` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`EMP_id`),
  CONSTRAINT `fk_EMPLEADO_RESTAURANTE1`
    FOREIGN KEY (`RESTAURANTE_RES_nit` , `RESTAURANTE_CENTRO COMERCIAL_CCO_id`)
    REFERENCES `RESTAURANTE` (`RES_nit` , `CENTRO COMERCIAL_CCO_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PROVEEDOR`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PROVEEDOR` ;

CREATE TABLE IF NOT EXISTS `PROVEEDOR` (
  `PRO_nit` VARCHAR(18) NOT NULL DEFAULT '111.111.111-1-pro',
  `PRO_nombreEmpresa` VARCHAR(50) NOT NULL,
  `PRO_telefonoEmpresa` VARCHAR(25) NOT NULL,
  `PRO_direccion` VARCHAR(45) NOT NULL,
  `PRO_ciudad` VARCHAR(20) NOT NULL,
  `PRO_telefono2Empresa` VARCHAR(25) NULL,
  `PRO_nombreContacto` VARCHAR(50) NULL,
  `PRO_telefonoContacto` VARCHAR(15) NULL,
  PRIMARY KEY (`PRO_nit`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PROVEEDOR_has_RESTAURANTE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PROVEEDOR_has_RESTAURANTE` ;

CREATE TABLE IF NOT EXISTS `PROVEEDOR_has_RESTAURANTE` (
  `PROVEEDOR_PRO_nit` VARCHAR(18) NOT NULL,
  `RESTAURANTE_RES_nit` VARCHAR(18) NOT NULL,
  `RESTAURANTE_CENTRO COMERCIAL_CCO_id` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`PROVEEDOR_PRO_nit`, `RESTAURANTE_RES_nit`, `RESTAURANTE_CENTRO COMERCIAL_CCO_id`),
  CONSTRAINT `fk_PROVEEDOR_has_RESTAURANTE_PROVEEDOR1`
    FOREIGN KEY (`PROVEEDOR_PRO_nit`)
    REFERENCES `PROVEEDOR` (`PRO_nit`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PROVEEDOR_has_RESTAURANTE_RESTAURANTE1`
    FOREIGN KEY (`RESTAURANTE_RES_nit` , `RESTAURANTE_CENTRO COMERCIAL_CCO_id`)
    REFERENCES `RESTAURANTE` (`RES_nit` , `CENTRO COMERCIAL_CCO_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


