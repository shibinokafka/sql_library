-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-08-2024 a las 22:20:28
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `biblioteca`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_libro` ()   BEGIN
DELETE  FROM libro
WHERE lib_titulo = 'El Secreto de las Estrellas Olvidadas';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_socio` (`c1_numero` INT(11), `c2_nombre` VARCHAR(45), `c3_apellido` VARCHAR(45), `c4_direccion` VARCHAR(255), `c5_telefono` VARCHAR(10))   BEGIN
INSERT INTO 
socio(soc_numero,soc_nombre,soc_apellido,soc_direccion,soc_telefono)
VALUES(c1_numero,c2_nombre,c3_apellido,c4_direccion,c5_telefono);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `libro_prestamo` ()   BEGIN
    SELECT 
        lib_titulo, pres_fechaDevolucion, pres_fechaPrestamo
    FROM 
        libro
    LEFT JOIN 
        prestamo 
    ON 
        libro.lib_isbn = prestamo.lib_copiaISBN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `nom_libro` ()   BEGIN
SELECT* FROM libro
WHERE lib_titulo like CONCAT ('%', 'susurros', '%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prestamo_socio` ()   BEGIN
SELECT soc_nombre AS socio, pres_fechaDevolucion, pres_fechaPrestamo
FROM socio
INNER JOIN prestamo
ON socio.soc_numero= prestamo.soc_copiaNumero;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_socio` ()   BEGIN
UPDATE socio
SET soc_telefono='3425423', soc_direccion='cra 14#56c-9'
WHERE soc_numero=4;
END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `contar_socios` () RETURNS INT(11) DETERMINISTIC BEGIN
    DECLARE num_socios INT;
    
    
    SELECT COUNT(*) INTO num_socios
    FROM socios;
    
  
    RETURN num_socios;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `dias_en_prestamo` (`lib_isbn` BIGINT) RETURNS INT(11)  BEGIN
    DECLARE dias INT;

    -- Calcular la diferencia en días entre la fecha de devolución y la fecha de préstamo
    SELECT DATEDIFF(pres_fechaDevolucion, pres_fechaPrestamo) INTO dias
    FROM prestamo
  WHERE lib_copiaISBN = lib_isbn;

    RETURN dias;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `audi_autor`
--

CREATE TABLE `audi_autor` (
  `aud_id` int(11) NOT NULL,
  `aut_codigo_audi` int(11) DEFAULT NULL,
  `aut_apellido_anterior` varchar(45) DEFAULT NULL,
  `aut_nacimiento_anterior` date DEFAULT NULL,
  `aut_muerte_anterior` date DEFAULT NULL,
  `aut_apellido_nuevo` varchar(45) DEFAULT NULL,
  `aut_nacimiento_nuevo` date DEFAULT NULL,
  `aut_muerte_nuevo` date DEFAULT NULL,
  `aut_fechaModificacion` datetime DEFAULT NULL,
  `aut_usuario` varchar(20) DEFAULT NULL,
  `aut_accion` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `audi_autor`
--

INSERT INTO `audi_autor` (`aud_id`, `aut_codigo_audi`, `aut_apellido_anterior`, `aut_nacimiento_anterior`, `aut_muerte_anterior`, `aut_apellido_nuevo`, `aut_nacimiento_nuevo`, `aut_muerte_nuevo`, `aut_fechaModificacion`, `aut_usuario`, `aut_accion`) VALUES
(1, 345, 'Wilson', '1975-08-29', '0000-00-00', 'martinez', '1899-08-23', '2000-04-12', '2024-07-31 22:29:45', 'root@localhost', 'Actualizacion'),
(2, 9889, NULL, NULL, NULL, 'jimenez', '1999-08-27', '2001-06-12', '2024-08-01 07:38:03', 'root@localhost', 'insertar'),
(3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-08-01 09:15:09', 'root@localhost', 'registro eliminado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `audi_socio`
--

CREATE TABLE `audi_socio` (
  `id_audi` int(10) NOT NULL,
  `socNumero_audi` int(11) DEFAULT NULL,
  `socNombre_anterior` varchar(45) DEFAULT NULL,
  `socApellido_anterior` varchar(45) DEFAULT NULL,
  `socDireccion_anterior` varchar(255) DEFAULT NULL,
  `socTelefono_anterior` varchar(10) DEFAULT NULL,
  `socNombre_nuevo` varchar(45) DEFAULT NULL,
  `socApellido_nuevo` varchar(45) DEFAULT NULL,
  `socDireccion_nuevo` varchar(255) DEFAULT NULL,
  `socTelefono_nuevo` varchar(10) DEFAULT NULL,
  `audi_fechaModificacion` datetime DEFAULT NULL,
  `audi_usuario` varchar(10) DEFAULT NULL,
  `audi_accion` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `audi_socio`
--

INSERT INTO `audi_socio` (`id_audi`, `socNumero_audi`, `socNombre_anterior`, `socApellido_anterior`, `socDireccion_anterior`, `socTelefono_anterior`, `socNombre_nuevo`, `socApellido_nuevo`, `socDireccion_nuevo`, `socTelefono_nuevo`, `audi_fechaModificacion`, `audi_usuario`, `audi_accion`) VALUES
(1, 6, 'Ana', 'López', 'Avenida Central 987, Villa Hermosa, Bilbao', '6123456781', 'Ana', 'López', 'Calle 72 # 2', '2928088', '2024-07-31 10:01:09', 'root@local', 'Actualización');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `autor`
--

CREATE TABLE `autor` (
  `aut_codigo` int(11) NOT NULL,
  `aut_apellido` varchar(45) NOT NULL,
  `aut_nacimiento` date NOT NULL,
  `aut_muerte` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `autor`
--

INSERT INTO `autor` (`aut_codigo`, `aut_apellido`, `aut_nacimiento`, `aut_muerte`) VALUES
(97, 'Gonzales', '2000-11-23', '2005-12-24'),
(98, 'Smith', '1974-12-21', '2018-07-21'),
(123, 'Taylor', '1980-04-15', '0000-00-00'),
(234, 'Medina', '1977-06-21', '2005-09-12'),
(345, 'martinez', '1899-08-23', '2000-04-12'),
(432, 'Miller', '1981-10-26', '0000-00-00'),
(456, 'García', '1978-09-27', '2021-12-09'),
(567, 'Davis', '1983-03-04', '2010-03-28'),
(678, 'Silva', '1986-02-02', '0000-00-00'),
(765, 'López', '1976-07-08', '1990-07-31'),
(789, 'Rodríguez', '1985-12-10', '0000-00-00'),
(890, 'Brown', '1982-11-17', '0000-00-00'),
(901, 'Soto', '1979-05-13', '2015-11-05');

--
-- Disparadores `autor`
--
DELIMITER $$
CREATE TRIGGER `autor_after_delete` AFTER DELETE ON `autor` FOR EACH ROW INSERT INTO audi_autor(
aut_codigo_audi,
aut_apellido_anterior,
aut_nacimiento_anterior,
aut_muerte_anterior,
aut_fechaModificacion,
aut_usuario,
aut_accion
)
Values(aut_codigo_audi,aut_apellido_anterior,aut_nacimiento_anterior,aut_muerte_anterior,
NOW(),                        
CURRENT_USER(),                 
'registro eliminado'               
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `autor_before_insert` BEFORE INSERT ON `autor` FOR EACH ROW begin
insert into audi_autor(
aut_codigo_audi,
aut_apellido_nuevo,
aut_nacimiento_nuevo,
aut_muerte_nuevo,
aut_fechaModificacion,
aut_usuario,
aut_accion
)
Values(new.aut_codigo,new.aut_apellido,new.aut_nacimiento,new.aut_muerte,
NOW(),                        
CURRENT_USER(),                 
'insertar'               
);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `autores_before_update` BEFORE UPDATE ON `autor` FOR EACH ROW BEGIN
    -- Insertar los valores antiguos y nuevos en la tabla de auditoría
    INSERT INTO audi_autor (
        aut_codigo_audi,
        aut_apellido_anterior,
        aut_nacimiento_anterior,
        aut_muerte_anterior,
        aut_apellido_nuevo,
        aut_nacimiento_nuevo,
        aut_muerte_nuevo,
        aut_fechaModificacion,
        aut_usuario,
        aut_accion
    )
    VALUES (
        OLD.aut_codigo,                 -- Código anterior del autor
        OLD.aut_apellido,               -- Apellido anterior del autor
        OLD.aut_nacimiento,             -- Fecha de nacimiento anterior del autor
        OLD.aut_muerte,                 -- Fecha de muerte anterior del autor
        NEW.aut_apellido,               -- Nuevo apellido del autor
        NEW.aut_nacimiento,             -- Nueva fecha de nacimiento del autor
        NEW.aut_muerte,                 -- Nueva fecha de muerte del autor
        NOW(),                          -- Fecha y hora de la modificación
        CURRENT_USER(),                 -- Usuario que realiza la modificación
        'Actualizacion'                 -- Acción realizada (Actualización)
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `libro`
--

CREATE TABLE `libro` (
  `lib_isbn` bigint(20) NOT NULL,
  `lib_titulo` varchar(255) NOT NULL,
  `lib_genero` varchar(20) NOT NULL,
  `lib_numeroPaginas` int(11) NOT NULL,
  `lib_diasPrestamo` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `libro`
--

INSERT INTO `libro` (`lib_isbn`, `lib_titulo`, `lib_genero`, `lib_numeroPaginas`, `lib_diasPrestamo`) VALUES
(1234567890, 'El Sueño de los Susurros', 'novela', 275, 7),
(1357924680, 'El Jardín de las Mariposas Perdidas', 'novela', 536, 7),
(2468135790, 'La Melodía de la Oscuridad', 'romance', 189, 7),
(2718281828, 'El Bosque de los Suspiros', 'novela', 387, 2),
(3141592653, 'El Secreto de las Estrellas Olvidadas', 'Misterio', 203, 7),
(5555555555, 'La Última Llave del Destino', 'cuento', 503, 7),
(7777777777, 'El Misterio de la Luna Plateada', 'Misterio', 422, 7),
(8642097531, 'El Reloj de Arena Infinito', 'novela', 321, 7),
(8888888888, 'La Ciudad de los Susurros', 'Misterio', 274, 1),
(9517530862, 'Las Crónicas del Eco Silencioso', 'fantasía', 448, 7),
(9876543210, 'El Laberinto de los Recuerdos', 'cuento', 412, 7),
(9999999999, 'El Enigma de los Espejos Rotos', 'romance', 156, 7);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `libro_tipoautor`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `libro_tipoautor` (
`lib_titulo` varchar(255)
,`lib_genero` varchar(20)
,`lib_numeroPaginas` int(11)
,`tip_Autor` varchar(20)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamo`
--

CREATE TABLE `prestamo` (
  `pres_id` varchar(20) NOT NULL,
  `pres_fechaPrestamo` date NOT NULL,
  `pres_fechaDevolucion` date NOT NULL,
  `soc_copiaNumero` int(11) NOT NULL,
  `lib_copiaISBN` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `prestamo`
--

INSERT INTO `prestamo` (`pres_id`, `pres_fechaPrestamo`, `pres_fechaDevolucion`, `soc_copiaNumero`, `lib_copiaISBN`) VALUES
('pres1', '2023-01-15', '2023-01-20', 1, 1234567890),
('pres2', '2023-02-03', '2023-02-04', 2, 9999999999),
('pres3', '2023-04-09', '2023-04-11', 6, 2718281828),
('pres4', '2023-06-14', '2023-06-15', 9, 8888888888),
('pres5', '2023-07-02', '2023-07-09', 10, 5555555555),
('pres6', '2023-08-19', '2023-08-26', 12, 5555555555),
('pres7', '2023-10-24', '2023-10-27', 3, 1357924680),
('pres8', '2023-11-11', '2023-11-12', 4, 9999999999);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `prestamo_socio`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `prestamo_socio` (
`soc_nombre` varchar(45)
,`soc_apellido` varchar(45)
,`pres_fechaPrestamo` date
,`pres_fechaDevolucion` date
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `socio`
--

CREATE TABLE `socio` (
  `soc_numero` int(11) NOT NULL,
  `soc_nombre` varchar(45) NOT NULL,
  `soc_apellido` varchar(45) NOT NULL,
  `soc_direccion` varchar(255) NOT NULL,
  `soc_telefono` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `socio`
--

INSERT INTO `socio` (`soc_numero`, `soc_nombre`, `soc_apellido`, `soc_direccion`, `soc_telefono`) VALUES
(1, 'Ana', 'Ruiz', 'Calle Primavera 123, Ciudad Jardín, Barcelona', '9123456780'),
(2, 'Andrés Felipe', 'Galindo Luna', 'Avenida del Sol 456, Pueblo Nuevo, Madrid', '2123456789'),
(3, 'Juan', 'González', 'Calle Principal 789, Villa Flores, Valencia', '2012345678'),
(4, 'María', 'Rodríguez', 'Carrera del Río 321, El Pueblo, Sevilla', '3012345678'),
(5, 'Pedro', 'Martínez', 'Calle del Bosque 654, Los Pinos, Málaga', '1234567812'),
(6, 'Ana', 'López', 'Calle 72 # 2', '2928088'),
(7, 'Carlos', 'Sánchez', 'Calle de la Luna 234, El Prado, Alicante', '1123456781'),
(8, 'Laura', 'Ramírez', 'Carrera del Mar 567, Playa Azul, Palma de Mallorca', '1312345678'),
(9, 'Luis', 'Hernández', 'Avenida de la Montaña 890, Monte Verde, Granada', '6101234567'),
(10, 'Andrea', 'García', 'Calle del Sol 432, La Colina, Zaragoza', '1112345678'),
(11, 'Alejandro', 'Torres', 'Carrera del Oeste 765, Ciudad Nueva, Murcia', '4951234567'),
(12, 'Sofia', 'Morales', 'Avenida del Mar 098, Costa Brava, Gijón', '5512345678'),
(23, 'mario', 'perez', 'cra 7#21-c', '8736273');

--
-- Disparadores `socio`
--
DELIMITER $$
CREATE TRIGGER `socios_after_delete` AFTER DELETE ON `socio` FOR EACH ROW INSERT INTO audi_socio(
socNumero_audi,
socNombre_anterior,
socApellido_anterior,
socDireccion_anterior,
socTelefono_anterior,
audi_fechaModificacion,
audi_usuario,
audi_accion)
VALUES(
old.soc_numero,
old.soc_nombre,
old.soc_apellido,
old.soc_direccion,
old.soc_telefono,
NOW(),
CURRENT_USER(),
'Registro eliminado')
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `socios_before_update` BEFORE UPDATE ON `socio` FOR EACH ROW INSERT INTO audi_socio(
socNumero_audi,
socNombre_anterior,
socApellido_anterior,
socDireccion_anterior,
socTelefono_anterior,
socNombre_nuevo,
socApellido_nuevo,
socDireccion_nuevo,
socTelefono_nuevo,
audi_fechaModificacion,
audi_usuario,
audi_accion)
VALUES(
new.soc_numero,
old.soc_nombre,
old.soc_apellido,
old.soc_direccion,
old.soc_telefono,
new.soc_nombre,
new.soc_apellido,
new.soc_direccion,
new.soc_telefono,
NOW(),
CURRENT_USER(),
'Actualización')
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipoautores`
--

CREATE TABLE `tipoautores` (
  `copiaISBN` bigint(20) NOT NULL,
  `copiaAutor` int(11) NOT NULL,
  `tip_Autor` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipoautores`
--

INSERT INTO `tipoautores` (`copiaISBN`, `copiaAutor`, `tip_Autor`) VALUES
(1357924680, 123, 'Traductor'),
(1234567890, 123, 'Autor'),
(1234567890, 456, 'Coautor'),
(2718281828, 789, 'Traductor'),
(8888888888, 234, 'Autor'),
(2468135790, 234, 'Autor'),
(9876543210, 567, 'Autor'),
(1234567890, 890, 'Autor'),
(8642097531, 345, 'Autor'),
(8888888888, 345, 'Coautor'),
(5555555555, 678, 'Autor'),
(3141592653, 901, 'Autor'),
(9517530862, 432, 'Autor'),
(7777777777, 765, 'Autor'),
(9999999999, 98, 'Autor');

-- --------------------------------------------------------

--
-- Estructura para la vista `libro_tipoautor`
--
DROP TABLE IF EXISTS `libro_tipoautor`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `libro_tipoautor`  AS SELECT `libro`.`lib_titulo` AS `lib_titulo`, `libro`.`lib_genero` AS `lib_genero`, `libro`.`lib_numeroPaginas` AS `lib_numeroPaginas`, `tipoautores`.`tip_Autor` AS `tip_Autor` FROM (`libro` join `tipoautores` on(`libro`.`lib_isbn` = `tipoautores`.`copiaISBN`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `prestamo_socio`
--
DROP TABLE IF EXISTS `prestamo_socio`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `prestamo_socio`  AS SELECT `socio`.`soc_nombre` AS `soc_nombre`, `socio`.`soc_apellido` AS `soc_apellido`, `prestamo`.`pres_fechaPrestamo` AS `pres_fechaPrestamo`, `prestamo`.`pres_fechaDevolucion` AS `pres_fechaDevolucion` FROM (`socio` join `prestamo` on(`prestamo`.`soc_copiaNumero` = `socio`.`soc_numero`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `audi_autor`
--
ALTER TABLE `audi_autor`
  ADD PRIMARY KEY (`aud_id`);

--
-- Indices de la tabla `audi_socio`
--
ALTER TABLE `audi_socio`
  ADD PRIMARY KEY (`id_audi`);

--
-- Indices de la tabla `autor`
--
ALTER TABLE `autor`
  ADD PRIMARY KEY (`aut_codigo`);

--
-- Indices de la tabla `libro`
--
ALTER TABLE `libro`
  ADD PRIMARY KEY (`lib_isbn`),
  ADD KEY `idx_libro` (`lib_titulo`);

--
-- Indices de la tabla `prestamo`
--
ALTER TABLE `prestamo`
  ADD PRIMARY KEY (`pres_id`),
  ADD KEY `soc_copiaNumero` (`soc_copiaNumero`),
  ADD KEY `lib_copiaISBN` (`lib_copiaISBN`);

--
-- Indices de la tabla `socio`
--
ALTER TABLE `socio`
  ADD PRIMARY KEY (`soc_numero`);

--
-- Indices de la tabla `tipoautores`
--
ALTER TABLE `tipoautores`
  ADD KEY `copiaISBN` (`copiaISBN`),
  ADD KEY `copiaAutor` (`copiaAutor`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `audi_autor`
--
ALTER TABLE `audi_autor`
  MODIFY `aud_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `audi_socio`
--
ALTER TABLE `audi_socio`
  MODIFY `id_audi` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `prestamo`
--
ALTER TABLE `prestamo`
  ADD CONSTRAINT `prestamo_ibfk_1` FOREIGN KEY (`soc_copiaNumero`) REFERENCES `socio` (`soc_numero`),
  ADD CONSTRAINT `prestamo_ibfk_2` FOREIGN KEY (`lib_copiaISBN`) REFERENCES `libro` (`lib_isbn`);

--
-- Filtros para la tabla `tipoautores`
--
ALTER TABLE `tipoautores`
  ADD CONSTRAINT `tipoautores_ibfk_1` FOREIGN KEY (`copiaISBN`) REFERENCES `libro` (`lib_isbn`),
  ADD CONSTRAINT `tipoautores_ibfk_2` FOREIGN KEY (`copiaAutor`) REFERENCES `autor` (`aut_codigo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
