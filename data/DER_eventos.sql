-- MySQL Script generated by MySQL Workbench
-- Mon Nov  4 22:58:30 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema eventos
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `eventos` ;

CREATE SCHEMA IF NOT EXISTS `eventos` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;

USE `eventos` ;

-- -----------------------------------------------------
-- Table `eventos`.`materiales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `eventos`.`materiales` ;

CREATE TABLE IF NOT EXISTS `eventos`.`materiales` (

  `materiales_id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(255) NOT NULL,
  `nombre_material` VARCHAR(255) NOT NULL,
  `validacion` VARCHAR(255) NOT NULL DEFAULT 'Pendiente',
  PRIMARY KEY (`materiales_id`)
  
  )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `eventos`.`interviniente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `eventos`.`interviniente` ;

CREATE TABLE IF NOT EXISTS `eventos`.`interviniente` (

  `interviniente_id` INT NOT NULL AUTO_INCREMENT,
  `descricion` VARCHAR(255) NOT NULL,
  `usuario_id` INT NOT NULL,
  `area_nombre` VARCHAR(255) NOT NULL,
  `materiales_id` INT NOT NULL,
  PRIMARY KEY (`interviniente_id`),
  CONSTRAINT `materiales_id`FOREIGN KEY (`materiales_id`) REFERENCES `eventos`.`materiales` (`materiales_id`)

)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `materiales_id_idx` ON `eventos`.`interviniente` (`materiales_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `eventos`.`tareas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `eventos`.`tareas` ;

CREATE TABLE IF NOT EXISTS `eventos`.`tareas` (

  `tareas_id` INT NOT NULL AUTO_INCREMENT,
  `tarea_nombre` TEXT NOT NULL,
  `tarea_descripcion` TEXT NOT NULL,
  `fecha_inicio` timestamp DEFAULT CURRENT_TIMESTAMP,
  `fecha_baja` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`tareas_id`)
  
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `eventos`.`solicitante`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `eventos`.`solicitante` ;

CREATE TABLE IF NOT EXISTS `eventos`.`solicitante` (

  `solicitante_id` INT NOT NULL AUTO_INCREMENT,
  `nombre_solicitante` VARCHAR(255) NOT NULL,
  `descripcion` VARCHAR(255) NOT NULL,
  `solicitar_area` VARCHAR(255) NOT NULL DEFAULT 'Pendiente', PRIMARY KEY (`solicitante_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `eventos`.`eventos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `eventos`.`eventos` ;

CREATE TABLE IF NOT EXISTS `eventos`.`eventos` (

  `evento_id` INT NOT NULL AUTO_INCREMENT,
  `nombre_evento` VARCHAR(255) NOT NULL,
  `descripcion` VARCHAR(255) NOT NULL,
  `interviniente_id` INT NOT NULL,
  `solicitante_id` INT NULL,
  PRIMARY KEY (`evento_id`),
  CONSTRAINT `eventos_ibfk_1`
    FOREIGN KEY (`interviniente_id`)
    REFERENCES `eventos`.`interviniente` (`interviniente_id`),
  CONSTRAINT `eventos_ibfk_3`FOREIGN KEY (`solicitante_id`) REFERENCES `eventos`.`solicitante` (`solicitante_id`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `interviniente_id` ON `eventos`.`eventos` (`interviniente_id` ASC) VISIBLE;



CREATE INDEX `eventos_ibfk_3_idx` ON `eventos`.`eventos` (`solicitante_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `eventos`.`cambios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `eventos`.`cambios` ;

CREATE TABLE IF NOT EXISTS `eventos`.`cambios` (

  `cambio_id` INT NOT NULL AUTO_INCREMENT,
  `estado` TEXT NOT NULL,
  `responsable` INT NOT NULL,
  `fecha` TEXT NOT NULL,
  `motivo` TEXT NOT NULL,
  `evento_id` INT NOT NULL,
  PRIMARY KEY (`cambio_id`),
  CONSTRAINT `cambios_ibfk_1` FOREIGN KEY (`evento_id`) REFERENCES `eventos`.`eventos` (`evento_id`),
  CONSTRAINT `cambios_ibfk_2` FOREIGN KEY (`responsable`) REFERENCES `eventos`.`interviniente` (`interviniente_id`)
  
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `evento_id` ON `eventos`.`cambios` (`evento_id` ASC) VISIBLE;

CREATE INDEX `responsable_id` ON `eventos`.`cambios` (`responsable` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `eventos`.`espacios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `eventos`.`espacios` ;

CREATE TABLE IF NOT EXISTS `eventos`.`espacios` (

  `espacio_id` INT NOT NULL AUTO_INCREMENT,
  `capacidad` INT NOT NULL,
  `descricion` TEXT NOT NULL,
  `tipo_de_espacio` TEXT NOT NULL,
  `usuario_id` int NOT NULL,
  PRIMARY KEY (`espacio_id`)
  )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;




-- -----------------------------------------------------
-- Table `eventos`.`reservas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `eventos`.`reservas` ;

CREATE TABLE IF NOT EXISTS `eventos`.`reservas` (
  
  `reserva_id` INT NOT NULL AUTO_INCREMENT,
  `espacio_id` INT NOT NULL,
  `evento_id` INT NOT NULL,
  `fecha_reserva` TEXT NOT NULL,
  `fecha_evento` TEXT NOT NULL,
  `hora_inicio` TEXT NOT NULL,
  `hora_fin` TEXT NOT NULL,
  `reserva_estado` TEXT NOT NULL,
  `tareas_id` INT NOT NULL,
  PRIMARY KEY (`reserva_id`),
  CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`espacio_id`) REFERENCES `eventos`.`espacios` (`espacio_id`),
  CONSTRAINT `reservas_ibfk_2` FOREIGN KEY (`evento_id`) REFERENCES `eventos`.`eventos` (`evento_id`),
  CONSTRAINT `eventos_ibfk_2` FOREIGN KEY (`tareas_id`) REFERENCES `eventos`.`tareas` (`tareas_id`)

)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `espacio_id` ON `eventos`.`reservas` (`espacio_id` ASC) VISIBLE;

CREATE INDEX `evento_id` ON `eventos`.`reservas` (`evento_id` ASC) VISIBLE;

CREATE INDEX `tareas_id` ON `eventos`.`reservas` (`tareas_id` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `eventos`.`usuarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `eventos`.`usuarios` ;

CREATE TABLE IF NOT EXISTS `eventos`.`usuarios` (

  `usuario_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `telefono` VARCHAR(255) NOT NULL,
  `direccion` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`usuario_id`)

)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `eventos`.`rhumanos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `eventos`.`rhumanos` ;

CREATE TABLE IF NOT EXISTS `eventos`.`rhumanos` (

  `RHumanos_id` INT NOT NULL AUTO_INCREMENT,
  `validacion` VARCHAR(255) NOT NULL DEFAULT 'Pendiente',
  `nombre_recurso` VARCHAR(255) NOT NULL,
  `usuario_id` INT NOT NULL,
  `fecha_alta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_baja` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `interviniente_id` INT NOT NULL,
  `tareas_id` INT NOT NULL,
  `disponible` VARCHAR(255) NOT NULL DEFAULT 'disponible',
  PRIMARY KEY (`RHumanos_id`),
  CONSTRAINT `rhumanos`FOREIGN KEY (`usuario_id`) REFERENCES `eventos`.`usuarios` (`usuario_id`),
  CONSTRAINT `interviniente` FOREIGN KEY (`interviniente_id`) REFERENCES `eventos`.`interviniente` (`interviniente_id`),
  CONSTRAINT `tareas` FOREIGN KEY (`tareas_id`) REFERENCES `eventos`.`tareas` (`tareas_id`)

    )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `usuario_id` ON `eventos`.`rhumanos` (`usuario_id` ASC) VISIBLE;


DROP TABLE IF EXISTS `eventos`.`reservaTarea` ;

CREATE TABLE IF NOT EXISTS `eventos`.`reservaTareas` (

  `RHumanos_id` INT NOT NULL,
  `nombre_recurso` VARCHAR(255) NOT NULL,
  `tareas_id` INT NOT NULL,
  `tarea_nombre` TEXT,
  CONSTRAINT `RHumanos_id` FOREIGN KEY (`RHumanos_id`) REFERENCES `eventos`.`rhumanos` (`RHumanos_id`),
  CONSTRAINT `tareas_id` FOREIGN KEY (`tareas_id`) REFERENCES `eventos`.`tareas` (`tareas_id`)

)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `tareas_id` ON `eventos`.`reservaTareas` (`tareas_id` ASC) VISIBLE;

CREATE INDEX `rhumano_id` ON `eventos`.`reservaTareas` (`RHumanos_id` ASC) VISIBLE;


DROP TABLE IF EXISTS `mensajes`;
-- agregue el evento_id
CREATE TABLE IF NOT EXISTS `eventos`.`mensajes` (

  `mensaje_id` INT NOT NULL AUTO_INCREMENT,
  `evento_id` INT NOT null,
  `usuario_id` INT NOT NULL,
  `texto` VARCHAR(255),
  `mensaje_fecha` timestamp DEFAULT CURRENT_TIMESTAMP,
  `sala_id` int not null,
  `mensaje_adjunto` VARCHAR(225),
  PRIMARY KEY (`mensaje_id`),
  CONSTRAINT `eventos` FOREIGN KEY (`evento_id`) REFERENCES `eventos`(`evento_id`),
  CONSTRAINT `mensajes` FOREIGN KEY(`usuario_id`) REFERENCES `usuarios`(`usuario_id`),
  CONSTRAINT `sala` FOREIGN KEY(`sala_id`) REFERENCES `sala`(`sala_id`)

);
CREATE TABLE if NOT EXISTS `eventos`.`tipo_sala` (

  `tipo_id` int not null AUTO_INCREMENT,
  `nombre` VARCHAR(50),
  `sala_id` int not null,
  PRIMARY KEY(`tipo_id`),
  FOREIGN KEY (`sala_id`) REFERENCES `sala`(`sala_id`)

);

CREATE TABLE if NOT EXISTS `eventos`.`sala_usuario` (

  `sala_usuario_id` INT NOT NULL AUTO_INCREMENT,
  `sala_id` INT NOT NULL,
  `usuario_id` INT NOT NULL,
  primary key(`sala_usuario_id`),
  FOREIGN KEY (`sala_id`) REFERENCES `sala`(`sala_id`),
  FOREIGN KEY (`usuario_id`) REFERENCES `usuarios`(`usuario_id`)


);


CREATE TABLE if NOT EXISTS `eventos`.`sala` (

  `sala_id` int not null AUTO_INCREMENT,
  `tipo_id` int not null,
  `fecha` timestamp,
  primary key(`sala_id`),
  FOREIGN KEY (`tipo_id`) REFERENCES `tipo_sala`(`tipo_id`)

);







SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
