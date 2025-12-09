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
('Decanato', 'Sector Decanato',''),
('Junta Electoral', 'Sector Junta Electoral','JE'),
('Junta Electoral CAE', 'Junta Electoral y Consejo Asesor de Escuelas','JE-CAE');

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
('examen'), ('protocolo'), ('bioseguridad'), ('Decanato'), ('laboratorios'), 
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

-- -----------------------------------------------------
-- D. Inserción de `documento` y sus dependencias
-- -----------------------------------------------------
-- -----------------------------------------------------
-- D. Inserción de `documento` y sus dependencias
-- -----------------------------------------------------

-- Variables para IDs de Documentos
-- Inicializamos todas las variables necesarias
SET @doc1_id = 1; SET @doc2_id = 2; SET @doc3_id = 3; SET @doc4_id = 4; SET @doc5_id = 5;
SET @doc6_id = 6; SET @doc7_id = 7; SET @doc8_id = 8; SET @doc9_id = 9; SET @doc10_id = 10;
SET @doc11_id = 11; SET @doc12_id = 12; SET @doc13_id = 13; SET @doc14_id = 14; 
SET @doc15_id = 15; SET @doc16_id = 16; SET @doc17_id = 17; SET @doc18_id = 18;

-- ID TipoDocumento: 1=Acuerdo, 2=Resolución, 3=Disposición, 4=Circular, 5=Ordenanza
-- ID UnidadEjecutora: 1=UNPA, 2=UASJ, 3=UACO, 4=UART, 5=UARG

-- DOC 1: Aprobación Presupuesto Anual 2023 (Resolución)
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `activo`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`, `unidadEjecutora_idUnidadEjecutora`) VALUES
('Aprobación Presupuesto Anual 2023', 'Se aprueban las partidas presupuestarias para el ejercicio fiscal del año 2023', True, '2023-10-15', 'R-101-23-CS-UNPA', 2, 1, 1, 1);
INSERT INTO `kosten`.`registro` (`fechaCarga`, `tipoOperacion`, `usuarioResponsable_idUsuario`, `documentoAfectado_idDocumento`) VALUES ('2023-10-16', 'Registrar', 2, @doc1_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES 
('R-101-23-CS-UNPA.pdf', 'documentos/000/000/001/R-101-23-CS-UNPA.pdf', @doc1_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc1_id, 1), (@doc1_id, 2), (@doc1_id, 3), (@doc1_id, 4);

-- DOC 2: Designación de Nuevo Personal (Disposición)
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `activo`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`, `unidadEjecutora_idUnidadEjecutora`) VALUES
('Designación de Nuevo Personal', 'Nombramiento de personal administrativo para el área de secretaría académica.', True,'2023-10-12', 'D-52-23-UART', 3, 1, 2, 4);
INSERT INTO `kosten`.`registro` (`fechaCarga`, `tipoOperacion`, `usuarioResponsable_idUsuario`, `documentoAfectado_idDocumento`) VALUES ('2023-10-13', 'Registrar', 2, @doc2_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES 
('D-52-23-UART.pdf', 'documentos/000/000/002/D-52-23-UART.pdf', @doc2_id),
('D-52-23-UART-anexo-A.pdf', 'documentos/000/000/002/D-52-23-UART-anexo-A.pdf', @doc2_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc2_id, 5), (@doc2_id, 6), (@doc2_id, 7), (@doc2_id, 8);

-- DOC 3: Llamado a Licitación Pública N°5 (Resolución)
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `activo`,`fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`, `unidadEjecutora_idUnidadEjecutora`) VALUES
('Llamado a Licitación Pública N°5', 'Convocatoria para la licitación del servicio de mantenimiento de infraestructura edilicia.', True ,'2023-10-11', 'R-102-23-CS-UNPA', 2, 1, 3, 1);
INSERT INTO `kosten`.`registro` (`fechaCarga`, `tipoOperacion`, `usuarioResponsable_idUsuario`, `documentoAfectado_idDocumento`) VALUES ('2023-10-12', 'Registrar', 2, @doc3_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES 
('R-102-23-CS-UNPA.pdf', 'documentos/000/000/003/R-102-23-CS-UNPA.pdf', @doc3_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc3_id, 9), (@doc3_id, 10), (@doc3_id, 11), (@doc3_id, 12);

-- DOC 4: Calendario Académico 2025 (Resolución)
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `activo`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`, `unidadEjecutora_idUnidadEjecutora`) VALUES
('Calendario Académico 2025', 'El documento oficial trata sobre la aprobación del Calendario Académico 2025 para la Universidad Nacional de la Patagonia Austral (UNPA)'
, True,'2024-11-28', 'R-108-24-CS-UNPA', 2, 1, 3, 1);
INSERT INTO `kosten`.`registro` (`fechaCarga`, `tipoOperacion`, `usuarioResponsable_idUsuario`, `documentoAfectado_idDocumento`) VALUES ('2024-10-01', 'Registrar', 2, @doc4_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES 
('R-108-24-CS-UNPA.pdf', 'documentos/000/000/004/R-108-24-CS-UNPA.pdf', @doc4_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc4_id, 13), (@doc4_id, 14), (@doc4_id, 15), (@doc4_id, 16);

-- DOC 5: Designación Suplente Comisión Accesibilidad (Ad-Referendum)
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `activo`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`, `unidadEjecutora_idUnidadEjecutora`) VALUES
('Designación Suplente Comisión Accesibilidad (Ad-Referendum)', 'El Rector de la UNPA resuelve designar a la Prof. Cecilia Mirna Gaitan como representante suplente de la Unidad Académica Río Turbio ante la Comisión Integral de Accesibilidad - Discapacidad de la UNPA. La medida se dicta ad-referendum del Consejo Superior dada la urgencia del trámite para integrar la comisión.', True, '2019-11-04', 'R-1264-19-R-UNPA', 2, 1, 1, 1);
INSERT INTO `kosten`.`registro` (`fechaCarga`, `tipoOperacion`, `usuarioResponsable_idUsuario`, `documentoAfectado_idDocumento`) VALUES ('2019-11-05', 'Registrar', 2, @doc5_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES 
('R-1264-19-R-UNPA.pdf', 'documentos/000/000/005/R-1264-19-R-UNPA.pdf', @doc5_id);
-- Etiquetas: designacion, personal, nombramiento, academica
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc5_id, 5), (@doc5_id, 6), (@doc5_id, 7), (@doc5_id, 8);

-- DOC 6: Modificación Plan de Estudios (Ordenanza)
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `activo`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`, `unidadEjecutora_idUnidadEjecutora`) VALUES
('Modificación Plan de Estudios', 'Ajustes en la currícula de la carrera de Analista de Sistemas.', True, '2023-09-22', 'O-004-23-CS-UNPA', 5, 1, 4, 1);
INSERT INTO `kosten`.`registro` (`fechaCarga`, `tipoOperacion`, `usuarioResponsable_idUsuario`, `documentoAfectado_idDocumento`) VALUES ('2023-09-23', 'Registrar', 2, @doc6_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES 
('O-004-23-CS-UNPA.pdf', 'documentos/000/000/006/O-004-23-CS-UNPA.pdf', @doc6_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc6_id, 21), (@doc6_id, 22), (@doc6_id, 23), (@doc6_id, 24), (@doc6_id, 25);

-- DOC 7: Rectificación de Fechas Calendario 2025 (Resolución) - INTACTO (Depende del Doc 4)
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `activo`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`, `unidadEjecutora_idUnidadEjecutora`) VALUES
('Rectificación de Fechas Calendario 2025', 'Se rectifican las fechas de mesas de examen del segundo cuatrimestre del Calendario Académico 2025.', True, '2025-03-10', 'R-001-25-CS-UNPA', 2, 1, 4, 1);
INSERT INTO `kosten`.`registro` (`fechaCarga`, `tipoOperacion`, `usuarioResponsable_idUsuario`, `documentoAfectado_idDocumento`) VALUES ('2025-03-11', 'Registrar', 2, @doc7_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES 
('R-001-25-CS-UNPA.pdf', 'documentos/000/000/007/R-001-25-CS-UNPA.pdf', @doc7_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc7_id, 26), (@doc7_id, 15), (@doc7_id, 13), (@doc7_id, 16);

-- DOC 8: Creación Comisión de Seguimiento Presupuestario (Disposición)
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `activo`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`, `unidadEjecutora_idUnidadEjecutora`) VALUES
('Creación Comisión de Seguimiento Presupuestario', 'Se crea una comisión ad-hoc para el seguimiento de la ejecución de las partidas del Presupuesto Anual 2023.', True,'2023-11-05', 'D-080-23-UASJ', 3, 1, 1, 2);
INSERT INTO `kosten`.`registro` (`fechaCarga`, `tipoOperacion`, `usuarioResponsable_idUsuario`, `documentoAfectado_idDocumento`) VALUES ('2023-11-06', 'Registrar', 2, @doc8_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES 
('D-080-23-UASJ.pdf', 'documentos/000/0TA/000/008/D-080-23-UASJ.pdf', @doc8_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc8_id, 27), (@doc8_id, 28), (@doc8_id, 29), (@doc8_id, 30);

-- DOC 9: Ratificación Designación Comisión Accesibilidad
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `activo`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`, `unidadEjecutora_idUnidadEjecutora`) VALUES
('Ratificación Designación Comisión Accesibilidad', 'El Consejo Superior ratifica la Resolución N° 1264/19-R-UNPA, dictada ad-referendum, mediante la cual se designó a la Prof. Cecilia Mirna Gaitán como representante suplente de la UART ante la Comisión Integral de Accesibilidad - Discapacidad de la UNPA. Se confirma la integración de la docente en dicho cuerpo colegiado.', True, '2019-11-29', 'R-148-19-CS-UNPA', 2, 1, 4, 1);
INSERT INTO `kosten`.`registro` (`fechaCarga`, `tipoOperacion`, `usuarioResponsable_idUsuario`, `documentoAfectado_idDocumento`) VALUES ('2019-11-30', 'Registrar', 2, @doc9_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES 
('R-148-19-CS-UNPA.pdf', 'documentos/000/000/009/R-148-19-CS-UNPA.pdf', @doc9_id);
-- Etiquetas: designacion, personal, nombramiento, academica
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc9_id, 5), (@doc9_id, 6), (@doc9_id, 7), (@doc9_id, 8);

-- DOC 10: Régimen Electoral de Institutos de la UNPA (Ordenanza)

INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `activo`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`, `unidadEjecutora_idUnidadEjecutora`) VALUES
('Régimen Electoral de Institutos de la UNPA', 'Se aprueba el Régimen Electoral para los Institutos de la Universidad Nacional de la Patagonia Austral. La norma establece los procedimientos para la elección de los miembros de los Comités Asesores y de los Directores de las Sedes de Institutos, definiendo electores, candidatos y metodología de escrutinio. Deroga la Ordenanza N° 172-CS-UNPA.'
, True, '2017-07-04', 'O-204-17-CS-UNPA', 5, 1, 4, 1);
INSERT INTO `kosten`.`registro` (`fechaCarga`, `tipoOperacion`, `usuarioResponsable_idUsuario`, `documentoAfectado_idDocumento`) VALUES ('2017-07-05', 'Registrar', 2, @doc10_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES 
('O-204-17-CS-UNPA.pdf', 'documentos/000/000/010/O-204-17-CS-UNPA.pdf', @doc10_id),
('O-204-17-CS-UNPA-anexo.pdf', 'documentos/000/000/010/O-204-17-CS-UNPA-anexo.pdf', @doc10_id);

-- Etiquetas: academica, designacion, personal (relacionado a elecciones y cargos)
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc10_id, 8), (@doc10_id, 5), (@doc10_id, 6);

-- DOC 11: Acuerdo de Cooperación Académica UACO (Acuerdo)
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `activo`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`, `unidadEjecutora_idUnidadEjecutora`) VALUES
('Acuerdo de Cooperación Académica UACO', 'Se firma un acuerdo de cooperación e intercambio estudiantil con la Unidad Académica Caleta Olivia.', True,'2023-11-20', 'A-012-23-CU-UACO', 1, 1, 2, 3);
INSERT INTO `kosten`.`registro` (`fechaCarga`, `tipoOperacion`, `usuarioResponsable_idUsuario`, `documentoAfectado_idDocumento`) VALUES ('2023-11-21', 'Registrar', 2, @doc11_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES 
('A-012-23-CU-UACO.pdf', 'documentos/000/000/011/A-012-23-CU-UACO.pdf', @doc11_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc11_id, 8), (@doc11_id, 14), (@doc11_id, 23);

-- DOC 12: Régimen de Selección de Docentes de la UNPA (Ordenanza)
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `activo`, `fechaCreacion`, `numDocumento`,
`tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`, `unidadEjecutora_idUnidadEjecutora`) VALUES
('Régimen de Selección de Docentes de la UNPA', 'La Ordenanza Nº 016/1998 de la UNPA establece el régimen de selección de docentes. Regula los concursos, requisitos y procedimientos para la designación de profesores, garantizando transparencia y equidad en el acceso a los cargos. Define criterios de evaluación, plazos y modalidades de convocatoria, buscando asegurar calidad académica y objetividad en la incorporación de personal docente.'
, True, '1998-03-19', 'O-016-98-CS-UNPA', 5, 1, 4, 1);
INSERT INTO `kosten`.`registro` (`fechaCarga`, `tipoOperacion`, `usuarioResponsable_idUsuario`, `documentoAfectado_idDocumento`) VALUES ('2024-10-16', 'Registrar', 2, @doc12_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES 
('O-016-98-CS-UNPA.pdf', 'documentos/000/000/012/O-016-98-CS-UNPA.pdf', @doc12_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc12_id, 5), (@doc12_id, 6), (@doc12_id, 7), (@doc12_id, 8);


-- DOC 13: Modificación Manual de Normas y Procedimientos (Ordenanza)
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `activo`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`, `unidadEjecutora_idUnidadEjecutora`) VALUES
('Modificación Manual de Normas y Procedimientos para la Administración de Programas y Proyectos de Investigación, Desarrollo e Innovación', 'El documento modifica el Manual de Normas y Procedimientos de la UNPA para la Administración de Programas y Proyectos de Investigación, Desarrollo e Innovación. La normativa establece los requisitos del Director y del Codirector local de un Proyecto de Investigación de Ciencia y Tecnología  o de Innovación y Desarrollo. También define las categorías de integrantes . Además, fija condiciones para solicitar financiamiento UNPA para lo proyectos, exigiendo que un mínimo del sesenta por ciento (60%) de los integrantes pertenezca a la UNPA.'
,True,'2020-12-11', 'O-235-20-CS-UNPA', 5, 1, 4, 1);
INSERT INTO `kosten`.`registro` (`fechaCarga`, `tipoOperacion`, `usuarioResponsable_idUsuario`, `documentoAfectado_idDocumento`) VALUES ('2024-10-13', 'Registrar', 2, @doc13_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES 
('O-235-20-CS-UNPA.pdf', 'documentos/000/000/013/O-235-20-CS-UNPA.pdf', @doc13_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc13_id, 21), (@doc13_id, 22), (@doc13_id, 23), (@doc13_id, 8);


-- DOC 14: CONVOCA a Sesión Especial del Consejo de Unidad (Resolución)
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `activo`,`fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`, `unidadEjecutora_idUnidadEjecutora`) VALUES
(' CONVOCA a Sesión Especial del Consejo de Unidad de la UARG, 11 de agosto de 2025','Este documento oficial de la Universidad Nacional de la Patagonia Austral (UNPA) trata sobre la necesidad de realizar una sesión especial en el Consejo de Unidad de la Unidad Académica Río Gallegos (UARG). El motivo es cubrir una vacante generada por la renuncia de un consejero suplente que representaba al claustro de estudiantes ante el Consejo Superior. Por ello, se convoca a una sesión especial del Consejo de Unidad de la UARG para el día 11 de agosto de 2025 , con el propósito de elegir un nuevo representante estudiantil ante el Consejo Superior.'
, True ,'2025-06-25', 'R-034-25-CS-UNPA', 2, 1, 3, 1);
INSERT INTO `kosten`.`registro` (`fechaCarga`, `tipoOperacion`, `usuarioResponsable_idUsuario`, `documentoAfectado_idDocumento`) VALUES ('2024-10-12', 'Registrar', 2, @doc14_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES 
('R-034-25-CS-UNPA.pdf', 'documentos/000/000/014/R-034-25-CS-UNPA.pdf', @doc14_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc14_id, 5), (@doc14_id, 6), (@doc14_id, 7), (@doc14_id, 8);


-- DOC 15: Capacitación en Perspectiva de género (Disposición)
-- Se desplaza a la posición 15 para llenar el hueco
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `activo`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`, `unidadEjecutora_idUnidadEjecutora`) VALUES
('Asignación de "Capacitación en Perspectiva de género y no Violencia por Motivos Sexistas" a Materias Genéricas de Carreras de UART.','El documento oficial trata sobre la aprobación, por parte de la Universidad Nacional de la Patagonia Austral a través de la Unidad Académica Río Turbio, de una medida relacionada con la Capacitación en Perspectiva de Género y No Violencia por Motivos Sexistas, conocida como la "Capacitación Ley Micaela". La disposición reconoce esta capacitación obligatoria con una carga horaria de treinta horas y tres créditos, como materia optativa dentro de los planes de estudio de diversas carreras de la UART, permitiendo cumplir requisitos de créditos optativos.'
, True,'2024-11-05', 'D-325-24-UART', 3, 1, 6, 4);
INSERT INTO `kosten`.`registro` (`fechaCarga`, `tipoOperacion`, `usuarioResponsable_idUsuario`, `documentoAfectado_idDocumento`) VALUES ('2024-11-06', 'Registrar', 2, @doc15_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES 
('D-325-24-UART.pdf', 'documentos/000/000/015/D-325-24-UART.pdf', @doc15_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc15_id, 8), (@doc15_id, 6), (@doc15_id, 31), (@doc15_id, 32);

-- DOC 16: Resolución N° 001/23-JE-CAE-UART (Resolución)
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `activo`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`, `unidadEjecutora_idUnidadEjecutora`) VALUES
('Inclusión de alumnos en listado definitivo de electores', 'Se resuelven los reclamos presentados por tres alumnos (YEGROS, Romina Ramona; CAYO, Carlos Enrique; y BARROS, José Alejandro) por omisiones o errores en los Listados Provisionales del calendario electoral del Consejo Asesor de Escuelas. Se determina incluirlos en los Listados Definitivos, ya que cumplen con las condiciones para ser electores según las Ordenanzas N° 202-CS-UNPA y N° 203-CS-UNPA.'
, True, '2023-08-23', 'R-001-23-JE-CAE-UART', 2, 1, 7, 4); 
INSERT INTO `kosten`.`registro` (`fechaCarga`, `tipoOperacion`, `usuarioResponsable_idUsuario`, `documentoAfectado_idDocumento`) VALUES ('2023-08-23', 'Registrar', 2, @doc16_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES 
('R-001-23-JE-CAE-UART.pdf', 'documentos/000/000/016/R-001-23-JE-CAE-UART.pdf', @doc16_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc16_id, 8), (@doc16_id, 15), (@doc16_id, 6), (@doc16_id, 7);

-- DOC 17: Disposición D. UART - UNPA N° 407/2023 (Disposición) -
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `activo`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`, `unidadEjecutora_idUnidadEjecutora`) VALUES
('Designación de Miembros del Consejo Asesor de la Escuela Sistemas e Informática', 'Se designan los miembros del Claustro Académico (Subclaustros Profesores y Auxiliares) y del Claustro Alumnos para integrar el Consejo Asesor de la Escuela de Sistemas e Informática. La designación rige desde el 16 de octubre de 2023 hasta el 15 de octubre de 2025. Se mencionan los nombres de los titulares y suplentes proclamados electos por la Junta Electoral.'
, True, '2023-10-18', 'D-407-23-UART', 3, 1, 6, 4); 
INSERT INTO `kosten`.`registro` (`fechaCarga`, `tipoOperacion`, `usuarioResponsable_idUsuario`, `documentoAfectado_idDocumento`) VALUES ('2023-10-18', 'Registrar', 2, @doc17_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES 
('D-407-23-UART.pdf', 'documentos/000/000/017/D-407-23-UART.pdf', @doc17_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc17_id, 5), (@doc17_id, 6), (@doc17_id, 7), (@doc17_id, 8), (@doc17_id, 24), (@doc17_id, 25);

-- DOC 18: Disposición D. UART - UNPA N° 340/2021 (Disposición)
INSERT INTO `kosten`.`documento` (`titulo`, `resumen`, `activo`, `fechaCreacion`, `numDocumento`, `tipoDocumento_idTipoDocumento`, `estado_idestado`, `sector_idSector`, `unidadEjecutora_idUnidadEjecutora`) VALUES
('Designación de Directora Interina Escuela de Sistemas e Informática (Lic. Diana Leticia Cruz)', 'Se designa a la Lic. Diana Leticia Cruz, DNI 27.377.195, como Directora Interina de la Escuela de Sistemas e Informática, sede Unidad Académica Río Turbio, a partir del 18 de noviembre de 2021 y hasta tanto se convoque a elecciones nuevamente. La designación se realiza por subrogancia siguiendo el orden de prelación por antigüedad, ya que no se proclamó un candidato electo.'
, True, '2021-12-09', 'D-340-21-UART', 3, 1, 6, 4); 
INSERT INTO `kosten`.`registro` (`fechaCarga`, `tipoOperacion`, `usuarioResponsable_idUsuario`, `documentoAfectado_idDocumento`) VALUES ('2021-12-09', 'Registrar', 2, @doc18_id);
INSERT INTO `kosten`.`archivo` (`nombre`, `url`, `documento_idDocumento`) VALUES 
('D-340-21-UART.pdf', 'documentos/000/000/018/D-340-21-UART.pdf', @doc18_id);
INSERT INTO `kosten`.`etiqueta` (`documento_idDocumento`, `palabraClave_idPalabraClave`) VALUES (@doc18_id, 5), (@doc18_id, 6), (@doc18_id, 7), (@doc18_id, 8), (@doc18_id, 24), (@doc18_id, 25);
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