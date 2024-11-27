CREATE DATABASE  IF NOT EXISTS `Eventos`;
USE `Eventos`;


CREATE TABLE IF NOT EXISTS `espacios` (
	`espacio_id` INTEGER NOT NULL AUTO_INCREMENT,
	`capacidad`	INTEGER NOT NULL,
	`descricion` varchar(255) NOT NULL,
	`tipo_de_espacio` varchar(255) NOT NULL,
	PRIMARY KEY(`espacio_id`)
);

CREATE TABLE IF NOT EXISTS `solicitante` (
	`solicitate_id` INTEGER NOT NULL auto_increment,
	`nombre_solicitante` varchar(255) NOT NULL,
	`descripcion` varchar(255) NOT NULL,
	`solicitar_area` varchar(255) NOT NULL DEFAULT 'Pendiente',
	PRIMARY KEY(`solicitate_id`)
);

CREATE TABLE IF NOT EXISTS `interviniente` (
	`interviniente_id` INTEGER NOT NULL auto_increment,
	`descricion` varchar(255) NOT NULL,
	`usuario_id` INTEGER NOT NULL,
	`area_nombre` varchar(255) NOT NULL,
	PRIMARY KEY(`interviniente_id`)
);

CREATE TABLE IF NOT EXISTS `Materiales` (
	`materiales_id`	INTEGER NOT NULL auto_increment,
	`descripcion` varchar(255) NOT NULL,
	`nombre_material`varchar(255) NOT NULL,
	`validacion`varchar(255) NOT NULL DEFAULT 'Pendiente',
	`area_interviniente`INTEGER NOT NULL,
	PRIMARY KEY(`materiales_id`),
	FOREIGN KEY(`area_interviniente`) REFERENCES `Materiales`(`materiales_id`)
);

CREATE TABLE IF NOT EXISTS `usuarios` (
	`usuario_id` INTEGER NOT NULL auto_increment,
	`email`	varchar(255) NOT NULL,
	`telefono`	varchar(255) NOT NULL,
	`direccion`	varchar(255),
	`interviniente_id` INTEGER NOT NULL,
	PRIMARY KEY(`usuario_id`),
    foreign key(`interviniente_id`) REFERENCES `interviniente`(`intervinientes_id`)
);

CREATE TABLE IF NOT EXISTS `Rhumanos` (
	`RHumanos_id`INTEGER NOT NULL auto_increment,
	`validacion` varchar(255) NOT NULL DEFAULT 'Pendiente',
	`nombre_recurso` varchar(255) NOT NULL,
	`usuario` INTEGER NOT NULL,
	`disponible` varchar(255) NOT NULL DEFAULT 'disponible',
	PRIMARY KEY(`RHumanos_id`),
	FOREIGN KEY(`usuario`) REFERENCES `usuarios`(`usuario_id`)
);
CREATE TABLE IF NOT EXISTS `cambios` (
	`cambio_id`	INTEGER NOT NULL auto_increment,
	`estado` TEXT NOT NULL DEFAULT 'pendiente',
	`responsable` INTEGER NOT NULL,
	`fecha`	TEXT NOT NULL,
	`motivo` TEXT NOT NULL,
	`evento` INTEGER NOT NULL,
	PRIMARY KEY(`cambio_id`),
	FOREIGN KEY(`evento`) REFERENCES `eventos`(`evento_id`),
	FOREIGN KEY(`responsable`) REFERENCES `interviniente`(`interviniente_id`)
);

CREATE TABLE IF NOT EXISTS `eventos` (
	`evento_id`	INTEGER NOT NULL auto_increment,
	`nombre_evento`	TEXT NOT NULL,
	`descripcion` TEXT NOT NULL,
	`area_tecnica_id` NUMERIC NOT NULL,
	`area_ceremonial` INTEGER NOT NULL,
	`area_difusion`	INTEGER NOT NULL,
	`area_diseño` INTEGER NOT NULL,
	`tareas` INTEGER NOT NULL,
	PRIMARY KEY(`evento_id`),
	FOREIGN KEY(`area_ceremonial`) REFERENCES `interviniente`(`interviniente_id`),
	FOREIGN KEY(`area_difusion`) REFERENCES `interviniente`(`interviniente_id`),
	FOREIGN KEY(`area_diseño`) REFERENCES `interviniente`(`interviniente_id`),
	FOREIGN KEY(`area_tecnica_id`) REFERENCES `interviniente`(`interviniente_id`),
	FOREIGN KEY(`tareas`) REFERENCES `tareas`(`tareas_id`)
);


CREATE TABLE IF NOT EXISTS `tareas` (
	`tareas_id`	INTEGER NOT NULL auto_increment,
	`tarea_nombre` TEXT NOT NULL,
	`tarea_descripcion`	TEXT NOT NULL,
	PRIMARY KEY(`tareas_id`)
);


CREATE TABLE IF NOT EXISTS `Reservas` (
	`reserva_id`INTEGER NOT NULL auto_increment,
	`espacio_id`INTEGER NOT NULL,
	`evento_id`	INTEGER,
	`fehca_reserva`	TEXT NOT NULL,
	`fecha_evento`	TEXT NOT NULL,
	`hora_inicio`	TEXT NOT NULL,
	`hora_fin`	TEXT NOT NULL,
	`reserva_estado`TEXT NOT NULL DEFAULT 'Pendiente',
	PRIMARY KEY(`reserva_id`),
	FOREIGN KEY(`espacio_id`) REFERENCES `espacios`(`espacio_id`),
	FOREIGN KEY(`evento_id`) REFERENCES `eventos`(`evento_id`)
);