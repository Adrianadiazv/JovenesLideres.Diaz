USE juventud_talleres;

-- ============================
-- VISTAS
-- ============================

CREATE VIEW vw_asistencia_por_municipio AS
SELECT
    m.nombre_municipio,
    COUNT(*) AS total_asistencias
FROM HECHOS_ASISTENCIAS h
JOIN DIM_MUNICIPIO m ON h.id_municipio = m.id_municipio
WHERE h.asistio = TRUE
GROUP BY m.nombre_municipio;


-- ============================
-- FUNCIONES
-- ============================
DELIMITER $$

CREATE FUNCTION fn_porcentaje_asistencia_por_fase(p_id_fase INT)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE total INT;
    DECLARE asistieron INT;
    DECLARE porcentaje DECIMAL(5,2);

    SELECT COUNT(*) INTO total
    FROM HECHOS_ASISTENCIAS
    WHERE id_fase = p_id_fase;

    SELECT COUNT(*) INTO asistieron
    FROM HECHOS_ASISTENCIAS
    WHERE id_fase = p_id_fase AND asistio = TRUE;

    IF total = 0 THEN
        SET porcentaje = 0;
    ELSE
        SET porcentaje = (asistieron * 100.0) / total;
    END IF;

    RETURN porcentaje;
END$$

DELIMITER ;

-- ============================
-- STORED PROCEDURES
-- ============================

DELIMITER $$

CREATE PROCEDURE sp_registrar_asistencia (
    IN p_id_fecha INT,
    IN p_id_joven INT,
    IN p_id_institucion INT,
    IN p_id_curso INT,
    IN p_id_taller INT,
    IN p_id_asesor INT,
    IN p_id_fase INT,
    IN p_id_municipio INT,
    IN p_id_modalidad INT,
    IN p_id_refrigerio INT,
    IN p_asistio BOOLEAN
)
BEGIN
    INSERT INTO HECHOS_ASISTENCIAS (
        id_fecha, id_joven, id_institucion, id_curso,
        id_taller, id_asesor, id_fase, id_municipio,
        id_modalidad, id_refrigerio, asistio
    )
    VALUES (
        p_id_fecha, p_id_joven, p_id_institucion, p_id_curso,
        p_id_taller, p_id_asesor, p_id_fase, p_id_municipio,
        p_id_modalidad, p_id_refrigerio, p_asistio
    );
END$$

DELIMITER ;

