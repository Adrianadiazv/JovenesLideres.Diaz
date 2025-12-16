USE juventud_talleres;

SET cte_max_recursion_depth = 400;

WITH RECURSIVE fechas AS (
    SELECT DATE('2025-01-01') AS fecha
    UNION ALL
    SELECT fecha + INTERVAL 1 DAY
    FROM fechas
    WHERE fecha < '2025-12-31'
)
INSERT INTO DIM_FECHA (
    id_fecha,
    fecha,
    anio,
    mes,
    dia,
    trimestre,
    semana
)
SELECT
    DATE_FORMAT(fecha, '%Y%m%d') AS id_fecha,
    fecha,
    YEAR(fecha) AS anio,
    MONTH(fecha) AS mes,
    DAY(fecha) AS dia,
    QUARTER(fecha) AS trimestre,
    WEEK(fecha, 1) AS semana
FROM fechas;

SELECT COUNT(*) AS total_dias FROM DIM_FECHA;

-- DIMENSIONES

INSERT INTO DIM_MUNICIPIO (nombre_municipio)
VALUES ('Bogotá'), ('Medellín');

INSERT INTO DIM_INSTITUCION (nombre_institucion, jornada, tipo)
VALUES
('Colegio Central', 'Mañana', 'Pública'),
('Colegio Occidental', 'Mañana', 'Privada');

INSERT INTO DIM_CURSO (nombre_curso, grado)
VALUES
('Décimo A', '1001'),
('Décimo B', '1002'),
('Once A', '1101'),
('Once B', '1102');

INSERT INTO DIM_MODALIDAD (modalidad)
VALUES ('Presencial'), ('Mixto'), ('Virtual');

INSERT INTO DIM_REFRIGERIO (tipo, calorias)
VALUES ('Snack', '250'), ('Fruta', '270');
INSERT INTO DIM_FASE (nombre_fase, tipo_fase)
VALUES
('Fase 1', 'Liderazgo Introducción'),
('Fase 2', 'Liderazgo Fortalecimiento'),
('Fase 3', 'Liderazgo Aplicación');

INSERT INTO DIM_TIPO_TALLER (nombre_taller, tipo)
VALUES
('Habilidades Blandas 1', 'Formativo'),
('Habilidades Blandas 2', 'Formativo');

INSERT INTO DIM_ASESORES (nombre, id_especialidad)
VALUES
('Juan Pérez', 'Comunicación'),
('Ana Vargas', 'Expresión Oral'),
('Jesús Díaz', 'Programación Lingüística');

INSERT INTO DIM_JOVEN (nombre, apellido, edad, sexo, fecha_nacimiento, direccion)
VALUES
('Ana', 'Gómez', 17, 'Femenino', '2007-05-12', 'Calle 10 #5-20'),
('Luis', 'Martínez', 18, 'Masculino', '2006-08-03', 'Cra 15 #20-45'),
('María', 'Rodríguez', 16, 'Femenino', '2008-02-21', 'Av 30 #12-60'),
('Carlos', 'Pérez', 17, 'Masculino', '2007-11-09', 'Calle 80 #40-12'),
('Laura', 'Hernández', 18, 'Femenino', '2006-01-15', 'Cra 7 #50-90');

INSERT INTO HECHOS_ASISTENCIAS (
    id_fecha,
    id_joven,
    id_institucion,
    id_curso,
    id_taller,
    id_asesor,
    id_fase,
    id_municipio,
    id_modalidad,
    id_refrigerio,
    asistio
)
VALUES
(20250101, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(20250101, 2, 1, 1, 1, 2, 1, 1, 1, 1, 1),
(20250115, 3, 2, 2, 2, 1, 2, 2, 2, 2, 0),
(20250201, 4, 1, 1, 2, 2, 3, 1, 3, 1, 1),
(20250201, 5, 2, 2, 1, 1, 3, 2, 2, 2, 1);

SELECT 
    h.id_asistencia,
    f.fecha,
    j.nombre,
    j.apellido,
    i.nombre_institucion,
    m.nombre_municipio,
    h.asistio
FROM HECHOS_ASISTENCIAS h
JOIN DIM_FECHA f ON h.id_fecha = f.id_fecha
JOIN DIM_JOVEN j ON h.id_joven = j.id_joven
JOIN DIM_INSTITUCION i ON h.id_institucion = i.id_institucion
JOIN DIM_MUNICIPIO m ON h.id_municipio = m.id_municipio;



