-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema tcs
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema tcs
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tcs` DEFAULT CHARACTER SET utf8 ;
USE `tcs` ;

-- -----------------------------------------------------
-- Table `tcs`.`telefono`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tcs`.`telefono` (
  `id` INT NOT NULL,
  `lada` VARCHAR(3) NOT NULL,
  `numero` VARCHAR(10) NOT NULL,
  `tipo_telefono` ENUM('Celular', 'Local', 'Trabajo') NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcs`.`direccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tcs`.`direccion` (
  `id` INT NOT NULL,
  `calle` VARCHAR(20) NOT NULL,
  `numero` VARCHAR(5) NOT NULL,
  `colonia` VARCHAR(20) NOT NULL,
  `ciudad` VARCHAR(20) NOT NULL,
  `municipio` VARCHAR(20) NOT NULL,
  `estado` VARCHAR(20) NOT NULL,
  `tipo_direccion` ENUM('Billing', 'Personal', 'Trabajo') NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcs`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tcs`.`persona` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(20) NOT NULL,
  `apellido_paterno` VARCHAR(20) NOT NULL,
  `apellido_materno` VARCHAR(20) NOT NULL,
  `DOB` DATE NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcs`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tcs`.`usuario` (
  `id` INT NOT NULL,
  `usuario` VARCHAR(20) NOT NULL,
  `password` VARCHAR(20) NOT NULL,
  `persona_id` INT NOT NULL,
  PRIMARY KEY (`id`, `persona_id`),
  UNIQUE INDEX `usuario_UNIQUE` (`usuario` ASC) VISIBLE,
  INDEX `fk_usuario_persona_idx` (`persona_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_persona`
    FOREIGN KEY (`persona_id`)
    REFERENCES `tcs`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcs`.`telefono_persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tcs`.`telefono_persona` (
  `persona_id` INT NOT NULL,
  `telefono_id` INT NOT NULL,
  PRIMARY KEY (`persona_id`, `telefono_id`),
  INDEX `fk_telefono_persona_telefono1_idx` (`telefono_id` ASC) VISIBLE,
  CONSTRAINT `fk_telefono_persona_persona1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `tcs`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_telefono_persona_telefono1`
    FOREIGN KEY (`telefono_id`)
    REFERENCES `tcs`.`telefono` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcs`.`direccion_persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tcs`.`direccion_persona` (
  `persona_id` INT NOT NULL,
  `direccion_id` INT NOT NULL,
  PRIMARY KEY (`persona_id`, `direccion_id`),
  INDEX `fk_direccion_persona_direccion1_idx` (`direccion_id` ASC) VISIBLE,
  CONSTRAINT `fk_direccion_persona_persona1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `tcs`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_direccion_persona_direccion1`
    FOREIGN KEY (`direccion_id`)
    REFERENCES `tcs`.`direccion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
