-- =======================================================
-- PASO 1: CONFIGURACIÓN INICIAL Y LIMPIEZA
-- =======================================================

-- Deshabilitar temporalmente las comprobaciones de FK y UNICOS
SET FOREIGN_KEY_CHECKS = 0; 
SET UNIQUE_CHECKS = 0;

-- Limpieza de Tablas (TRUNCATE resetea AUTO_INCREMENT)
TRUNCATE TABLE `kosten`.`etiqueta`;
TRUNCATE TABLE `kosten`.`referencia`;
TRUNCATE TABLE `kosten`.`registro`;
TRUNCATE TABLE `kosten`.`archivo`;
TRUNCATE TABLE `kosten`.`documento`;
TRUNCATE TABLE `kosten`.`usuario`;
TRUNCATE TABLE `kosten`.`rol`;
TRUNCATE TABLE `kosten`.`cargo`;
TRUNCATE TABLE `kosten`.`sector`;
TRUNCATE TABLE `kosten`.`estadoU`;
TRUNCATE TABLE `kosten`.`tipoDocumento`;
TRUNCATE TABLE `kosten`.`estado`;
TRUNCATE TABLE `kosten`.`palabraClave`;


-- -----------------------------------------------------
-- B. Inserción de Catálogos (IDs Implícitos)
-- -----------------------------------------------------

-- `rol`
INSERT INTO `kosten`.`rol` (`nombre`, `descripcion`) VALUES
('Administrador', 'Usuario con acceso total al sistema.'),
('Editor', 'Usuario encargado de la gestión de documentos.'),
('Lector', 'Usuario encargado de Leer.');

-- `cargo`
INSERT INTO `kosten`.`cargo` (`nombre`, `descripcion`) VALUES
('Rector', 'Cargo rector'),
('Decano', 'Cargo decano'),
('Vicedecano', 'Cargo vicedecano.');

-- `sector`
INSERT INTO `kosten`.`sector` (`nombre`, `descripcion`) VALUES
('Rectorado', 'Sector Rectorado'),
('Secretaría Académica', 'Sector Secretaría Académica'),
('Administración', 'Sector Administración'),
('Consejo Superior', 'Sector Consejo Superior'),
('Higiene y Seguridad', 'Sector Higiene y Seguridad');

-- `estadoU`
INSERT INTO `kosten`.`estadoU` (`nombre`, `descripcion`) VALUES
('Activo', 'La cuenta del usuario está plenamente operativa y en uso.'),
('Inactivo', 'La cuenta del usuario desactivada.');

-- `tipoDocumento`
INSERT INTO `kosten`.`tipoDocumento` (`nombre`, `descripcion`) VALUES
('Acuerdos', 'acuerdos'),
('Resoluciones', 'resoluciones'),
('Disposiciones', 'disposiciones'),
('Circulares', 'circulares'),
('Ordenanzas', 'ordenanzas');

-- `estado`
INSERT INTO `kosten`.`estado` (`nombre`, `descripcion`) VALUES
('vigente', 'Documento vigente'),
('derogado parcial', 'Documento derogado parcialmente'),
('derogado total', 'Documento derogado totalmente');

-- `palabraClave` 
INSERT INTO `kosten`.`palabraClave` (`nombre`) VALUES
('presupuesto'), ('anual'), ('partidas'), ('rectorado'), ('designacion'), 
('personal'), ('nombramiento'), ('academica'), ('licitacion'), ('publica'), 
('mantenimiento'), ('infraestructura'), ('calendario'), ('academico'), ('fechas'), 
('examen'), ('protocolo'), ('bioseguridad'), ('higiene'), ('laboratorios'), 
('modificacion'), ('plan'), ('estudios'), ('analista'), ('sistemas'), 
('rectificacion'), ('comision'), ('seguimiento'), ('presupuestario'), ('ejecucion'), 
('nuevo'), ('2025'), ('aclaratoria'), ('pliegos'), ('condiciones');


-- -----------------------------------------------------
-- C. Inserción de `usuario` (AUTO_INCREMENT: ID 1, 2, 3)
-- -----------------------------------------------------
INSERT INTO `kosten`.`usuario` 
  (`dni`, `email`, `password`, `nombre`, `apellido`, `legajo`, `rol_idRol`, `sector_idSector`, `estadoU_idEstadoU`, `cargo_idCargo`) 
VALUES
(12345678, 'admin@unpa.edu.ar', 'admin', 'Admin', 'Dev', 101, 1, 1, 1, 1),
(23456789, 'editor@unpa.edu.ar', 'editor', 'Editor', 'Dev', 102, 2, 2, 1, 2),
(34567890, 'jorgito@unpa.edu.ar', 'jorgito', 'Jorgito', 'Gpt', 103, 3, 3, 2, 3);


-- -----------------------------------------------------
-- D. Inserción de `documento` y sus dependencias (Documentos 1-10)
-- -----------------------------------------------------

-- Variables para IDs de Documentos
SET @doc1_id = 0; SET @doc2_id = 0; SET @doc3_id = 0; SET @doc4_id = 0; SET @doc5_id = 0;
SET @doc6_id = 0; SET @doc7_id = 0; SET @doc8_id = 0; SET @doc9_id = 0; SET @doc10_id = 0;

-- DOC 1: Aprobación Presupuesto Anual 2024
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`) VALUES
('Aprobación Presupuesto Anual 2024', 'Se aprueban las partidas presupuestarias para el ejercicio fiscal del año 2024', '2024-10-15', 101, 2, 1, 1);
SET @doc1_id = LAST_INSERT_ID();
INSERT INTO `kosten`.`registro` (`fechaCarga`, `usuario_idUsuario`, `documento_idDocumento`) VALUES ('2024-10-16', 2, @doc1_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES ('RES-2024-101-UART.pdf', '/archivos/RES-2024-101-UART.pdf', @doc1_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc1_id, 1), (@doc1_id, 2), (@doc1_id, 3), (@doc1_id, 4);

-- DOC 2: Designación de Nuevo Personal
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`) VALUES
('Designación de Nuevo Personal', 'Nombramiento de personal administrativo para el área de secretaría académica.', '2024-10-12', 52, 3, 1, 2);
SET @doc2_id = LAST_INSERT_ID();
INSERT INTO `kosten`.`registro` (`fechaCarga`, `usuario_idUsuario`, `documento_idDocumento`) VALUES ('2024-10-13', 2, @doc2_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES 
('DIS-2024-052-UART.pdf', '/archivos/DIS-2024-052-UART.pdf', @doc2_id),
('DIS-2024-052-UART anexo A.pdf', '/archivos/DIS-2024-052-UART-anexo-A.pdf', @doc2_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc2_id, 5), (@doc2_id, 6), (@doc2_id, 7), (@doc2_id, 8);


-- DOC 3: Llamado a Licitación Pública N°5
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`) VALUES
('Llamado a Licitación Pública N°5', 'Convocatoria para la licitación del servicio de mantenimiento de infraestructura edilicia.', '2024-10-11', 102, 2, 1, 3);
SET @doc3_id = LAST_INSERT_ID();
INSERT INTO `kosten`.`registro` (`fechaCarga`, `usuario_idUsuario`, `documento_idDocumento`) VALUES ('2024-10-12', 2, @doc3_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES ('RES-2024-102-UART.pdf', '/archivos/RES-2024-102-UART.pdf', @doc3_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc3_id, 9), (@doc3_id, 10), (@doc3_id, 11), (@doc3_id, 12);


-- DOC 4: Calendario Académico 2025
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`) VALUES
('Calendario Académico 2025', 'Establecimiento de las fechas de inicio, finalización de cuatrimestres y mesas de examen.', '2024-09-30', 3, 5, 2, 4);
SET @doc4_id = LAST_INSERT_ID();
INSERT INTO `kosten`.`registro` (`fechaCarga`, `usuario_idUsuario`, `documento_idDocumento`) VALUES ('2024-10-01', 2, @doc4_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES ('ORD-2024-003-CS.pdf', '/archivos/ORD-2024-003-CS.pdf', @doc4_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc4_id, 13), (@doc4_id, 14), (@doc4_id, 15), (@doc4_id, 16);


-- DOC 5: Protocolo de Bioseguridad
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`) VALUES
('Protocolo de Bioseguridad', 'Actualización de las medidas y protocolos de seguridad e higiene para los laboratorios.', '2024-09-25', 15, 4, 3, 5);
SET @doc5_id = LAST_INSERT_ID();
INSERT INTO `kosten`.`registro` (`fechaCarga`, `usuario_idUsuario`, `documento_idDocumento`) VALUES ('2024-09-26', 2, @doc5_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES ('CIR-2024-015-UART.pdf', '/archivos/CIR-2024-015-UART.pdf', @doc5_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc5_id, 17), (@doc5_id, 18), (@doc5_id, 19), (@doc5_id, 20);

-- DOC 6: Modificación Plan de Estudios
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`) VALUES
('Modificación Plan de Estudios', 'Ajustes en la currícula de la carrera de Analista de Sistemas.', '2024-09-22', 4, 5, 1, 4);
SET @doc6_id = LAST_INSERT_ID();
INSERT INTO `kosten`.`registro` (`fechaCarga`, `usuario_idUsuario`, `documento_idDocumento`) VALUES ('2024-09-23', 2, @doc6_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES ('ORD-2024-004-CS.pdf', '/archivos/ORD-2024-004-CS.pdf', @doc6_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc6_id, 21), (@doc6_id, 22), (@doc6_id, 23), (@doc6_id, 24), (@doc6_id, 25);

-- DOC 7: Rectificación de Fechas Calendario 2025
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`) VALUES
('Rectificación de Fechas Calendario 2025', 'Se rectifican las fechas de mesas de examen del segundo cuatrimestre del Calendario Académico 2025.', '2025-03-10', 1, 2, 1, 4);
SET @doc7_id = LAST_INSERT_ID();
INSERT INTO `kosten`.`registro` (`fechaCarga`, `usuario_idUsuario`, `documento_idDocumento`) VALUES ('2025-03-11', 2, @doc7_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES ('RES-2025-001-CS.pdf', '/archivos/RES-2025-001-CS.pdf', @doc7_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc7_id, 26), (@doc7_id, 15), (@doc7_id, 13), (@doc7_id, 16);

-- DOC 8: Creación Comisión de Seguimiento Presupuestario
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`) VALUES
('Creación Comisión de Seguimiento Presupuestario', 'Se crea una comisión ad-hoc para el seguimiento de la ejecución de las partidas del Presupuesto Anual 2024.', '2024-11-05', 80, 3, 1, 1);
SET @doc8_id = LAST_INSERT_ID();
INSERT INTO `kosten`.`registro` (`fechaCarga`, `usuario_idUsuario`, `documento_idDocumento`) VALUES ('2024-11-06', 2, @doc8_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES ('DIS-2024-080-UART.pdf', '/archivos/DIS-2024-080-UART.pdf', @doc8_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc8_id, 27), (@doc8_id, 28), (@doc8_id, 29), (@doc8_id, 30);

-- DOC 9: Nuevo Protocolo de Bioseguridad 2025
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`) VALUES
('Nuevo Protocolo de Bioseguridad 2025', 'Se establece el nuevo protocolo de bioseguridad para el ciclo lectivo 2025, derogando normativas anteriores.', '2025-02-20', 1, 5, 1, 4);
SET @doc9_id = LAST_INSERT_ID();
INSERT INTO `kosten`.`registro` (`fechaCarga`, `usuario_idUsuario`, `documento_idDocumento`) VALUES ('2025-02-21', 2, @doc9_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES ('ORD-2025-001-CS.pdf', '/archivos/ORD-2025-001-CS.pdf', @doc9_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc9_id, 31), (@doc9_id, 17), (@doc9_id, 18), (@doc9_id, 32);

-- DOC 10: Aclaratoria sobre Licitación Pública N°5
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`) VALUES
('Aclaratoria sobre Licitación Pública N°5', 'Se emite circular aclaratoria sobre los pliegos y condiciones de la Licitación Pública N°5 para mantenimiento.', '2024-10-25', 20, 4, 1, 3);
SET @doc10_id = LAST_INSERT_ID();
INSERT INTO `kosten`.`registro` (`fechaCarga`, `usuario_idUsuario`, `documento_idDocumento`) VALUES ('2024-10-26', 2, @doc10_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES 
('CIR-2024-020-UART.pdf', '/archivos/CIR-2024-020-UART.pdf', @doc10_id),
('CIR-2024-020-UART - anexo B.pdf', '/archivos/CIR-2024-020-UART-anexo-B.pdf', @doc10_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc10_id, 33), (@doc10_id, 9), (@doc10_id, 34), (@doc10_id, 35);


-- -----------------------------------------------------
-- E. Inserción de `referencia` (Relaciones Cruzadas Finales)
-- -----------------------------------------------------
INSERT INTO `kosten`.`referencia` (`documento_idDocumento1`, `documento_idDocumento`) VALUES
(@doc7_id, @doc4_id),
(@doc8_id, @doc1_id),
(@doc9_id, @doc5_id),
(@doc10_id, @doc1_id),
(@doc10_id, @doc3_id);


-- -----------------------------------------------------
-- F. Restaurar el estado inicial de las comprobaciones
-- -----------------------------------------------------
SET UNIQUE_CHECKS = 1;
SET FOREIGN_KEY_CHECKS = 1;