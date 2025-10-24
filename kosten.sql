-- SQL Script Optimizado y Limpio
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema kosten
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `kosten` DEFAULT CHARACTER SET utf8 ;
USE `kosten` ;
-- =====================================================
-- Tablas de Catálogo (Roles, Sectores, Estados, Cargos)
-- =====================================================

-- -----------------------------------------------------
-- Table `kosten`.`rol`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kosten`.`rol` ;
CREATE TABLE IF NOT EXISTS `kosten`.`rol` (
  `idRol` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) UNIQUE NULL,
  `descripcion` VARCHAR(140) NULL,
  PRIMARY KEY (`idRol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kosten`.`sector`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kosten`.`sector` ;
CREATE TABLE IF NOT EXISTS `kosten`.`sector` (
  `idSector` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) UNIQUE NULL,
  `descripcion` VARCHAR(140) NULL,
  PRIMARY KEY (`idSector`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kosten`.`estado del usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kosten`.`estadoU` ;
CREATE TABLE IF NOT EXISTS `kosten`.`estadoU` (
  `idEstadoU` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) UNIQUE NULL,
  `descripcion` VARCHAR(140) NULL,
  PRIMARY KEY (`idEstadoU`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kosten`.`cargo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kosten`.`cargo` ;
CREATE TABLE IF NOT EXISTS `kosten`.`cargo` (
  `idCargo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) UNIQUE NULL,
  `descripcion` VARCHAR(140) NULL,
  PRIMARY KEY (`idCargo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kosten`.`tipoDocumento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kosten`.`tipoDocumento` ;
CREATE TABLE IF NOT EXISTS `kosten`.`tipoDocumento` (
  `idTipoDocumento` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) UNIQUE NULL,
  `descripcion` VARCHAR(140) NULL,
  PRIMARY KEY (`idTipoDocumento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kosten`.`estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kosten`.`estado` ;
CREATE TABLE IF NOT EXISTS `kosten`.`estado` (
  `idEstado` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) UNIQUE NULL,
  `descripcion` VARCHAR(140) NULL,
  PRIMARY KEY (`idEstado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kosten`.`palabraClave`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kosten`.`palabraClave` ;
CREATE TABLE IF NOT EXISTS `kosten`.`palabraClave` (
  `idPalabraClave` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) UNIQUE NULL,
  `descripcion` VARCHAR(140) NULL,
  PRIMARY KEY (`idPalabraClave`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kosten`.`permiso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kosten`.`permiso` ;
CREATE TABLE IF NOT EXISTS `kosten`.`permiso` (
  `idpermiso` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) UNIQUE NULL,
  `descripcion` VARCHAR(140) NULL,
  PRIMARY KEY (`idpermiso`))
ENGINE = InnoDB;


-- =====================================================
-- Tablas Principales y de Relación
-- =====================================================

-- -----------------------------------------------------
-- Table `kosten`.`usuario` 
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kosten`.`usuario` ;
CREATE TABLE IF NOT EXISTS `kosten`.`usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `dni` INT UNIQUE NOT NULL UNIQUE, 
  `email` VARCHAR(50) UNIQUE NOT NULL,
  `password` VARCHAR(60) NOT NULL,
  `nombre` VARCHAR(45) NULL, 
  `apellido` VARCHAR(45) NULL,
  `legajo` VARCHAR(45) UNIQUE NOT NULL, 
  `rol_idRol` INT NOT NULL,
  `sector_idSector` INT NOT NULL,
  `estadoU_idEstadoU` INT NOT NULL,
  `cargo_idCargo` INT NOT NULL,
  PRIMARY KEY (`idUsuario`),
  INDEX `fk_usuario_rol_idx` (`rol_idRol` ASC),
  INDEX `fk_usuario_sector_idx` (`sector_idSector` ASC),
  INDEX `fk_usuario_estadoU_idx` (`estadoU_idEstadoU` ASC),
  INDEX `fk_usuario_cargo_idx` (`cargo_idCargo` ASC),
  CONSTRAINT `fk_usuario_rol`
    FOREIGN KEY (`rol_idRol`)
    REFERENCES `kosten`.`rol` (`idRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_sector`
    FOREIGN KEY (`sector_idSector`)
    REFERENCES `kosten`.`sector` (`idSector`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_estadoU`
    FOREIGN KEY (`estadoU_idEstadoU`)
    REFERENCES `kosten`.`estadoU` (`idEstadoU`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_cargo`
    FOREIGN KEY (`cargo_idCargo`)
    REFERENCES `kosten`.`cargo` (`idCargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kosten`.`documento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kosten`.`documento` ;
CREATE TABLE IF NOT EXISTS `kosten`.`documento` (
  `idDocumento` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(60) NULL,
  `resumen` VARCHAR(145) NULL,
  `fechaCreacion` DATE NULL,
  `numDocumento` VARCHAR(45) UNIQUE NULL,
  `tipoDocumento_idTipoDocumento` INT NOT NULL,
  `estado_idestado` INT NOT NULL,
  `sector_idSector` INT NOT NULL,
  PRIMARY KEY (`idDocumento`),
  INDEX `fk_documento_tipoDocumento_idx` (`tipoDocumento_idTipoDocumento` ASC),
  INDEX `fk_documento_estado_idx` (`estado_idestado` ASC),
  INDEX `fk_documento_sector_idx` (`sector_idSector` ASC),
  CONSTRAINT `fk_documento_tipoDocumento`
    FOREIGN KEY (`tipoDocumento_idTipoDocumento`)
    REFERENCES `kosten`.`tipoDocumento` (`idTipoDocumento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_documento_estado`
    FOREIGN KEY (`estado_idestado`)
    REFERENCES `kosten`.`estado` (`idEstado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_documento_sector`
    FOREIGN KEY (`sector_idSector`)
    REFERENCES `kosten`.`sector` (`idSector`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kosten`.`registro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kosten`.`registro` ;
CREATE TABLE IF NOT EXISTS `kosten`.`registro` (
  `idRegistro` INT NOT NULL AUTO_INCREMENT,
  `fechaCarga` DATE NULL,
  `documento_idDocumento` INT NOT NULL,
  `usuario_idUsuario` INT NOT NULL, -- Columna clave
  PRIMARY KEY (`idRegistro`),
  INDEX `fk_registro_documento_idx` (`documento_idDocumento` ASC),
  INDEX `fk_registro_usuario_idx` (`usuario_idUsuario` ASC),
  CONSTRAINT `fk_registro_documento`
    FOREIGN KEY (`documento_idDocumento`)
    REFERENCES `kosten`.`documento` (`idDocumento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_registro_usuario`
    FOREIGN KEY (`usuario_idUsuario`)
    REFERENCES `kosten`.`usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kosten`.`archivo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kosten`.`archivo` ;
CREATE TABLE IF NOT EXISTS `kosten`.`archivo` (
  `idArchivo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) UNIQUE NULL,
  `url` VARCHAR(255) NULL,
  `documento_idDocumento` INT NOT NULL,
  PRIMARY KEY (`idArchivo`),
  INDEX `fk_archivo_documento_idx` (`documento_idDocumento` ASC),
  CONSTRAINT `fk_archivo_documento`
    FOREIGN KEY (`documento_idDocumento`)
    REFERENCES `kosten`.`documento` (`idDocumento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kosten`.`etiqueta` (MEJORA: Añadida Clave Primaria Compuesta)
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kosten`.`etiqueta` ;
CREATE TABLE IF NOT EXISTS `kosten`.`etiqueta` (
  `documento_idDocumento` INT NOT NULL,
  `palabraClave_idPalabraClave` INT NOT NULL,
  PRIMARY KEY (`documento_idDocumento`, `palabraClave_idPalabraClave`),
  INDEX `fk_etiqueta_palabraClave_idx` (`palabraClave_idPalabraClave` ASC),
  CONSTRAINT `fk_etiqueta_documento`
    FOREIGN KEY (`documento_idDocumento`)
    REFERENCES `kosten`.`documento` (`idDocumento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_etiqueta_palabraClave`
    FOREIGN KEY (`palabraClave_idPalabraClave`)
    REFERENCES `kosten`.`palabraClave` (`idPalabraClave`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kosten`.`asigna` (MEJORA: Añadida Clave Primaria Compuesta)
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kosten`.`asigna` ;
CREATE TABLE IF NOT EXISTS `kosten`.`asigna` (
  `rol_idRol` INT NOT NULL,
  `permiso_idpermiso` INT NOT NULL,
  PRIMARY KEY (`rol_idRol`, `permiso_idpermiso`),
  INDEX `fk_asigna_permiso_idx` (`permiso_idpermiso` ASC),
  CONSTRAINT `fk_asigna_rol`
    FOREIGN KEY (`rol_idRol`)
    REFERENCES `kosten`.`rol` (`idRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asigna_permiso`
    FOREIGN KEY (`permiso_idpermiso`)
    REFERENCES `kosten`.`permiso` (`idpermiso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kosten`.`referencia` (MEJORA: Añadida Clave Primaria Compuesta)
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kosten`.`referencia` ;
CREATE TABLE IF NOT EXISTS `kosten`.`referencia` (
  `documento_idDocumentoOrigen` INT NOT NULL,
  `documento_idDocumentoReferencial` INT NOT NULL,
  PRIMARY KEY (`documento_idDocumentoOrigen`, `documento_idDocumentoReferencial`),
  INDEX `fk_referencia_documento2_idx` (`documento_idDocumentoReferencial` ASC),
  CONSTRAINT `fk_referencia_documento1`
    FOREIGN KEY (`documento_idDocumentoOrigen`)
    REFERENCES `kosten`.`documento` (`idDocumento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_referencia_documento2`
    FOREIGN KEY (`documento_idDocumentoReferencial`)
    REFERENCES `kosten`.`documento` (`idDocumento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;