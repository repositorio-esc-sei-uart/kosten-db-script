use kosten;
-- =======================================================
-- PASO A: CONFIGURACIÓN INICIAL Y LIMPIEZA
-- =======================================================
SET FOREIGN_KEY_CHECKS = 0; 
SET UNIQUE_CHECKS = 0;
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
TRUNCATE TABLE `kosten`.`permiso`;
TRUNCATE TABLE `kosten`.`asigna`;
TRUNCATE TABLE `kosten`.`unidadEjecutora`; 

-- B. Inserción de Catálogos 
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
INSERT INTO `kosten`.`sector` (`nombre`, `descripcion`,`nomenclatura`) VALUES
('Rectorado', 'Sector Rectorado',''),
('Secretaría Académica', 'Sector Secretaría Académica',''),
('Administración', 'Sector Administración',''),
('Consejo Superior', 'Sector Consejo Superior','CS'),
('Consejo de Unidad', 'Sector Consejo de Unidad','CU'),
('Higiene y Seguridad', 'Sector Higiene y Seguridad','');

-- `estadoU`
INSERT INTO `kosten`.`estadoU` (`nombre`, `descripcion`) VALUES
('Activo', 'La cuenta del usuario está plenamente operativa y en uso.'),
('Inactivo', 'La cuenta del usuario desactivada.');

-- `tipoDocumento`
INSERT INTO `kosten`.`tipoDocumento` (`nombre`, `descripcion`,`nomenclatura`) VALUES
('Acuerdo', 'acuerdos','A'),
('Resolución', 'resoluciones','R'),
('Disposición', 'disposiciones','D'),
('Circular', 'circulares','C'),
('Ordenanza', 'ordenanzas','O');

-- `estado`
INSERT INTO `kosten`.`estado` (`nombre`, `descripcion`) VALUES
('Vigente', 'Documento vigente'),
('Derogado parcial', 'Documento derogado parcialmente'),
('Derogado total', 'Documento derogado totalmente');

-- `palabraClave` 
INSERT INTO `kosten`.`palabraClave` (`nombre`) VALUES
('presupuesto'), ('anual'), ('partidas'), ('rectorado'), ('designacion'), 
('personal'), ('nombramiento'), ('academica'), ('licitacion'), ('publica'), 
('mantenimiento'), ('infraestructura'), ('calendario'), ('academico'), ('fechas'), 
('examen'), ('protocolo'), ('bioseguridad'), ('higiene'), ('laboratorios'), 
('modificacion'), ('plan'), ('estudios'), ('analista'), ('sistemas'), 
('rectificacion'), ('comision'), ('seguimiento'), ('presupuestario'), ('ejecucion'), 
('nuevo'), ('2025'), ('aclaratoria'), ('pliegos'), ('condiciones');

INSERT INTO `kosten`.`unidadEjecutora` (`nombre`, `descripcion`, `nomenclatura`) VALUES
('UNPA', 'Universidad Nacional de la Patagonia Austral', 'UNPA'),
('UASJ', 'Unidad Académica San Julián', 'UASJ'),
('UACO', 'Unidad Académica Caleta Olivia', 'UACO'),
('UART', 'Unidad Académica Río Turbio', 'UART'),
('UARG', 'Unidad Académica Río Gallegos', 'UARG');
-- -----------------------------------------------------
-- C. Inserción de `usuario` (AUTO_INCREMENT: ID 1, 2, 3)
-- -----------------------------------------------------
INSERT INTO `kosten`.`usuario` 
  (`dni`, `email`, `password`, `nombre`, `apellido`, `legajo`, `rol_idRol`, `sector_idSector`, `estadoU_idEstadoU`, `cargo_idCargo`) 
VALUES
(12345678, 'admin@unpa.edu.ar', '$2a$10$cndBvd4ghY7PGnC5AWjNVOOQ/2MuRQdzIcnemmjYT4YRnHCsU1GAa', 'Admin', 'Dev', 101, 1, 1, 1, 1),
(23456789, 'editor@unpa.edu.ar', '$2a$10$g5rd4eCVXlZQeXfx2p89g.O1D/9iEwMZk8JGUxcAUmZ.W1jJd1muq', 'Editor', 'Dev', 102, 2, 2, 1, 2),
(34567890, 'jorgito@unpa.edu.ar', '', 'Jorgito', 'Gpt', 103, 3, 3, 2, 3);

-- =======================================================
-- INSERTS DE REGISTRO PARA USUARIOS
-- =======================================================
-- Registros de creación de USUARIOS (Ejemplos de log polimórfico)
-- Asumimos que el Admin (ID 1) creó a los otros dos usuarios (ID 2 y 3).
-- (Estos IDs son fijos porque los usuarios se insertan antes)
INSERT INTO `kosten`.`registro` (`fechaCarga`, `tipoOperacion`, `usuarioResponsable_idUsuario`, `usuarioAfectado_idUsuario`) VALUES
('2024-10-01', 'Registrar', 1, 2),
('2024-10-01', 'Registrar', 1, 3);


-- -----------------------------------------------------
-- D. Inserción de `documento` y sus dependencias (Documentos 1-11)
-- -----------------------------------------------------

-- Variables para IDs de Documentos
-- Asumimos los IDs porque TRUNCATE reinicia el contador.
SET @doc1_id = 1; SET @doc2_id = 2; SET @doc3_id = 3; SET @doc4_id = 4; SET @doc5_id = 5;
SET @doc6_id = 6; SET @doc7_id = 7; SET @doc8_id = 8; SET @doc9_id = 9; SET @doc10_id = 10;
SET @doc11_id = 11; -- Añadido nuevo documento

-- ID TipoDocumento: 1=Acuerdo, 2=Resolución, 3=Disposición, 4=Circular, 5=Ordenanza
-- ID UnidadEjecutora: 1=UNPA, 2=UASJ, 3=UACO, 4=UART, 5=UARG

-- DOC 1: Aprobación Presupuesto Anual 2024 (Resolución)
-- REGLA: R-numero-año-CS-UNPA
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `activo`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`, `unidadEjecutora_idUnidadEjecutora`) VALUES
('Aprobación Presupuesto Anual 2024', 'Se aprueban las partidas presupuestarias para el ejercicio fiscal del año 2024', True, '2024-10-15', 'R-101-24-CS-UNPA', 2, 1, 1, 1);
INSERT INTO `kosten`.`registro` (`fechaCarga`, `tipoOperacion`, `usuarioResponsable_idUsuario`, `documentoAfectado_idDocumento`) VALUES ('2024-10-16', 'Registrar', 2, @doc1_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES 
('R-101-24-CS-UNPA.pdf', 'documentos/000/000/001/R-101-24-CS-UNPA.pdf', @doc1_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc1_id, 1), (@doc1_id, 2), (@doc1_id, 3), (@doc1_id, 4);

-- DOC 2: Designación de Nuevo Personal (Disposición)
-- REGLA: D-numero-año-[UnidadEjecutora] (Usando UART)
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `activo`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`, `unidadEjecutora_idUnidadEjecutora`) VALUES
('Designación de Nuevo Personal', 'Nombramiento de personal administrativo para el área de secretaría académica.', True,'2024-10-12', 'D-52-24-UART', 3, 1, 2, 4);
INSERT INTO `kosten`.`registro` (`fechaCarga`, `tipoOperacion`, `usuarioResponsable_idUsuario`, `documentoAfectado_idDocumento`) VALUES ('2024-10-13', 'Registrar', 2, @doc2_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES 
('D-52-24-UART.pdf', 'documentos/000/000/002/D-52-24-UART.pdf', @doc2_id),
('D-52-24-UART-anexo-A.pdf', 'documentos/000/000/002/D-52-24-UART-anexo-A.pdf', @doc2_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc2_id, 5), (@doc2_id, 6), (@doc2_id, 7), (@doc2_id, 8);

-- DOC 3: Llamado a Licitación Pública N°5 (Resolución)
-- REGLA: R-numero-año-CS-UNPA
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `activo`,`fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`, `unidadEjecutora_idUnidadEjecutora`) VALUES
('Llamado a Licitación Pública N°5', 'Convocatoria para la licitación del servicio de mantenimiento de infraestructura edilicia.', True ,'2024-10-11', 'R-102-24-CS-UNPA', 2, 1, 3, 1);
INSERT INTO `kosten`.`registro` (`fechaCarga`, `tipoOperacion`, `usuarioResponsable_idUsuario`, `documentoAfectado_idDocumento`) VALUES ('2024-10-12', 'Registrar', 2, @doc3_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES 
('R-102-24-CS-UNPA.pdf', 'documentos/000/000/003/R-102-24-CS-UNPA.pdf', @doc3_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc3_id, 9), (@doc3_id, 10), (@doc3_id, 11), (@doc3_id, 12);

-- DOC 4: Calendario Académico 2025 (Ordenanza)
-- REGLA: O-numero-año-CS-UNPA
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `activo`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`, `unidadEjecutora_idUnidadEjecutora`) VALUES
('Calendario Académico 2025', 'Establecimiento de las fechas de inicio, finalización de cuatrimestres y mesas de examen.', True,'2024-09-30', 'O-003-24-CS-UNPA', 5, 2, 4, 1);
INSERT INTO `kosten`.`registro` (`fechaCarga`, `tipoOperacion`, `usuarioResponsable_idUsuario`, `documentoAfectado_idDocumento`) VALUES ('2024-10-01', 'Registrar', 2, @doc4_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES 
('O-003-24-CS-UNPA.pdf', 'documentos/000/000/004/O-003-24-CS-UNPA.pdf', @doc4_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc4_id, 13), (@doc4_id, 14), (@doc4_id, 15), (@doc4_id, 16);

-- DOC 5: Protocolo de Bioseguridad (Circular)
-- REGLA: C-numero-año-[UnidadEjecutora] (Usando UACO)
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `activo`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`, `unidadEjecutora_idUnidadEjecutora`) VALUES
('Protocolo de Bioseguridad', 'Actualización de las medidas y protocolos de seguridad e higiene para los laboratorios.', True,'2024-09-25', 'C-015-24-UACO', 4, 3, 5, 3);
INSERT INTO `kosten`.`registro` (`fechaCarga`, `tipoOperacion`, `usuarioResponsable_idUsuario`, `documentoAfectado_idDocumento`) VALUES ('2024-09-26', 'Registrar', 2, @doc5_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES 
('C-015-24-UACO.pdf', 'documentos/000/000/005/C-015-24-UACO.pdf', @doc5_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc5_id, 17), (@doc5_id, 18), (@doc5_id, 19), (@doc5_id, 20);

-- DOC 6: Modificación Plan de Estudios (Ordenanza)
-- REGLA: O-numero-año-CS-UNPA
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `activo`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`, `unidadEjecutora_idUnidadEjecutora`) VALUES
('Modificación Plan de Estudios', 'Ajustes en la currícula de la carrera de Analista de Sistemas.', True, '2024-09-22', 'O-004-24-CS-UNPA', 5, 1, 4, 1);
INSERT INTO `kosten`.`registro` (`fechaCarga`, `tipoOperacion`, `usuarioResponsable_idUsuario`, `documentoAfectado_idDocumento`) VALUES ('2024-09-23', 'Registrar', 2, @doc6_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES 
('O-004-24-CS-UNPA.pdf', 'documentos/000/000/006/O-004-24-CS-UNPA.pdf', @doc6_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc6_id, 21), (@doc6_id, 22), (@doc6_id, 23), (@doc6_id, 24), (@doc6_id, 25);

-- DOC 7: Rectificación de Fechas Calendario 2025 (Resolución)
-- REGLA: R-numero-año-CS-UNPA
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `activo`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`, `unidadEjecutora_idUnidadEjecutora`) VALUES
('Rectificación de Fechas Calendario 2025', 'Se rectifican las fechas de mesas de examen del segundo cuatrimestre del Calendario Académico 2025.', True, '2025-03-10', 'R-001-25-CS-UNPA', 2, 1, 4, 1);
INSERT INTO `kosten`.`registro` (`fechaCarga`, `tipoOperacion`, `usuarioResponsable_idUsuario`, `documentoAfectado_idDocumento`) VALUES ('2025-03-11', 'Registrar', 2, @doc7_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES 
('R-001-25-CS-UNPA.pdf', 'documentos/000/000/007/R-001-25-CS-UNPA.pdf', @doc7_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc7_id, 26), (@doc7_id, 15), (@doc7_id, 13), (@doc7_id, 16);

-- DOC 8: Creación Comisión de Seguimiento Presupuestario (Disposición)
-- REGLA: D-numero-año-[UnidadEjecutora] (Usando UASJ)
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `activo`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`, `unidadEjecutora_idUnidadEjecutora`) VALUES
('Creación Comisión de Seguimiento Presupuestario', 'Se crea una comisión ad-hoc para el seguimiento de la ejecución de las partidas del Presupuesto Anual 2024.', True,'2024-11-05', 'D-080-24-UASJ', 3, 1, 1, 2);
INSERT INTO `kosten`.`registro` (`fechaCarga`, `tipoOperacion`, `usuarioResponsable_idUsuario`, `documentoAfectado_idDocumento`) VALUES ('2024-11-06', 'Registrar', 2, @doc8_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES 
('D-080-24-UASJ.pdf', 'documentos/000/0TA/000/008/D-080-24-UASJ.pdf', @doc8_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc8_id, 27), (@doc8_id, 28), (@doc8_id, 29), (@doc8_id, 30);

-- DOC 9: Nuevo Protocolo de Bioseguridad 2025 (Ordenanza)
-- REGLA: O-numero-año-CS-UNPA
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `activo`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`, `unidadEjecutora_idUnidadEjecutora`) VALUES
('Nuevo Protocolo de Bioseguridad 2025', 'Se establece el nuevo protocolo de bioseguridad para el ciclo lectivo 2025, derogando normativas anteriores.', True,'2025-02-20', 'O-001-25-CS-UNPA', 5, 1, 4, 1);
INSERT INTO `kosten`.`registro` (`fechaCarga`, `tipoOperacion`, `usuarioResponsable_idUsuario`, `documentoAfectado_idDocumento`) VALUES ('2025-02-21', 'Registrar', 2, @doc9_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES 
('O-001-25-CS-UNPA.pdf', 'documentos/000/000/009/O-001-25-CS-UNPA.pdf', @doc9_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc9_id, 31), (@doc9_id, 17), (@doc9_id, 18), (@doc9_id, 32);

-- DOC 10: Aclaratoria sobre Licitación Pública N°5 (Circular)
-- REGLA: C-numero-año-[UnidadEjecutora] (Usando UARG)
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `activo`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`, `unidadEjecutora_idUnidadEjecutora`) VALUES
('Aclaratoria sobre Licitación Pública N°5', 'Se emite circular aclaratoria sobre los pliegos y condiciones de la Licitación Pública N°5 para mantenimiento.', True,'2024-10-25', 'C-020-24-UARG', 4, 1, 3, 5);
INSERT INTO `kosten`.`registro` (`fechaCarga`, `tipoOperacion`, `usuarioResponsable_idUsuario`, `documentoAfectado_idDocumento`) VALUES ('2024-10-26', 'Registrar', 2, @doc10_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES 
('C-020-24-UARG.pdf', 'documentos/000/000/010/C-020-24-UARG.pdf', @doc10_id),
('C-020-24-UARG-anexo-B.pdf', 'documentos/000/000/010/C-020-24-UARG-anexo-B.pdf', @doc10_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc10_id, 33), (@doc10_id, 9), (@doc10_id, 34), (@doc10_id, 35);

-- DOC 11: NUEVO EJEMPLO de Acuerdo (Acuerdo)
-- REGLA: A-numero-año-CU-[UnidadEjecutora] (Usando UACO)
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `activo`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`, `unidadEjecutora_idUnidadEjecutora`) VALUES
('Acuerdo de Cooperación Académica UACO', 'Se firma un acuerdo de cooperación e intercambio estudiantil con la Unidad Académica Caleta Olivia.', True,'2024-11-20', 'A-012-24-CU-UACO', 1, 1, 2, 3);
INSERT INTO `kosten`.`registro` (`fechaCarga`, `tipoOperacion`, `usuarioResponsable_idUsuario`, `documentoAfectado_idDocumento`) VALUES ('2024-11-21', 'Registrar', 2, @doc11_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES 
('A-012-24-CU-UACO.pdf', 'documentos/000/000/011/A-012-24-CU-UACO.pdf', @doc11_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc11_id, 8), (@doc11_id, 14), (@doc11_id, 23);

-- -----------------------------------------------------
-- E. Inserción de `referencia` (Usando los IDs fijos)
-- -----------------------------------------------------
INSERT INTO `kosten`.`referencia` (`documento_idDocumentoOrigen`, `documento_idDocumentoReferencial`) VALUES
(@doc7_id, @doc4_id),
(@doc8_id, @doc1_id),
(@doc9_id, @doc5_id),
(@doc10_id, @doc1_id),
(@doc10_id, @doc3_id);

-- (Tus INSERTs de permisos y asigna van aquí...)
-- INSERTAMOS LOS NUEVOS PERMISOS DESGLOSADOS
INSERT INTO `kosten`.`permiso` (`nombre`, `descripcion`) VALUES
('USER_CREATE', 'Permite crear usuarios'),
('USER_READ', 'Permite leer la lista de usuarios'),
('USER_UPDATE', 'Permite actualizar usuarios'),
('USER_DELETE', 'Permite eliminar usuarios'),
('DOCUMENT_CREATE', 'Permite crear documentos'),
('DOCUMENT_READ', 'Permite leer documentos'),
('DOCUMENT_UPDATE', 'Permite actualizar documentos'),
('DOCUMENT_DELETE', 'Permite eliminar documentos');
-- -----------------------------------------------------
-- Data for table `kosten`.`asigna`
-- -----------------------------------------------------
-- Asignar permisos CRUD de USUARIOS al Administrador (Rol ID 1)
INSERT INTO `kosten`.`asigna` (`rol_idRol`, `permiso_idpermiso`) VALUES
(1, (SELECT idpermiso FROM permiso WHERE nombre = 'USER_CREATE')),
(1, (SELECT idpermiso FROM permiso WHERE nombre = 'USER_READ')),
(1, (SELECT idpermiso FROM permiso WHERE nombre = 'USER_UPDATE')),
(1, (SELECT idpermiso FROM permiso WHERE nombre = 'USER_DELETE'));

-- Asignar permisos CRUD de DOCUMENTOS al Editor (Rol ID 2)
INSERT INTO `kosten`.`asigna` (`rol_idRol`, `permiso_idpermiso`) VALUES
(2, (SELECT idpermiso FROM permiso WHERE nombre = 'DOCUMENT_CREATE')),
(2, (SELECT idpermiso FROM permiso WHERE nombre = 'DOCUMENT_READ')),
(2, (SELECT idpermiso FROM permiso WHERE nombre = 'DOCUMENT_UPDATE')),
(2, (SELECT idpermiso FROM permiso WHERE nombre = 'DOCUMENT_DELETE'));

-- Asignar permiso de LECTURA de DOCUMENTOS al Lector (Rol ID 3)
INSERT INTO `kosten`.`asigna` (`rol_idRol`, `permiso_idpermiso`) VALUES
(3, (SELECT idpermiso FROM permiso WHERE nombre = 'DOCUMENT_READ'));

-- -----------------------------------------------------
-- F. Restaurar el estado inicial de las comprobaciones
-- -----------------------------------------------------
SET UNIQUE_CHECKS = 1;
SET FOREIGN_KEY_CHECKS = 1;
-- -----------------------------------------------------
-- F. Restaurar el estado inicial de las comprobaciones
-- -----------------------------------------------------
SET UNIQUE_CHECKS = 1;
SET FOREIGN_KEY_CHECKS = 1;