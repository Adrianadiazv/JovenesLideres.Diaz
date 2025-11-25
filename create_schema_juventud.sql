-- =============================================
-- CREACIÓN DE BASE DE DATOS DEL PROGRAMA
-- =============================================
DROP DATABASE IF EXISTS juventud_talleres;
CREATE DATABASE juventud_talleres;
USE juventud_talleres;

-- =============================================
-- TABLAS DIMENSIONALES
-- =============================================

-- A. DIM_JOVEN
CREATE TABLE DIM_JOVEN (
    id_joven INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    edad INT,
    sexo VARCHAR(20),
    fecha_nacimiento DATE,
    direccion VARCHAR(200)
);

-- B. DIM_MUNICIPIO
CREATE TABLE DIM_MUNICIPIO (
    id_municipio INT PRIMARY KEY AUTO_INCREMENT,
    nombre_municipio VARCHAR(100)
);

-- C. DIM_INSTITUCION
CREATE TABLE DIM_INSTITUCION (
    id_institucion INT PRIMARY KEY AUTO_INCREMENT,
    nombre_institucion VARCHAR(200),
    jornada VARCHAR(50),
    tipo VARCHAR(50)
);

-- D. DIM_FECHA
CREATE TABLE DIM_FECHA (
    id_fecha INT PRIMARY KEY,
    fecha DATE,
    anio INT,
    mes INT,
    dia INT,
    trimestre INT,
    semana INT
);

-- E. DIM_CURSO
CREATE TABLE DIM_CURSO (
    id_curso INT PRIMARY KEY AUTO_INCREMENT,
    nombre_curso VARCHAR(50),
    grado VARCHAR(50)
);

-- F. DIM_TIPO_TALLER
CREATE TABLE DIM_TIPO_TALLER (
    id_tipo_taller INT PRIMARY KEY AUTO_INCREMENT,
    nombre_taller VARCHAR(200),
    tipo VARCHAR(100)
);

-- G. DIM_ASESORES
CREATE TABLE DIM_ASESORES (
    id_asesor INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(150),
    id_especialidad VARCHAR(100)
);

-- H. DIM_FASE
CREATE TABLE DIM_FASE (
    id_fase INT PRIMARY KEY AUTO_INCREMENT,
    nombre_fase VARCHAR(150),
    tipo_fase VARCHAR(100)
);

-- I. DIM_MODALIDAD
CREATE TABLE DIM_MODALIDAD (
    id_modalidad INT PRIMARY KEY AUTO_INCREMENT,
    modalidad VARCHAR(50)
);

-- J. DIM_REFRIGERIO
CREATE TABLE DIM_REFRIGERIO (
    id_refrigerio INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(100),
    calorias VARCHAR(50)
);

-- =============================================
-- TABLA DE HECHOS
-- =============================================

-- K. HECHOS_ASISTENCIAS
CREATE TABLE HECHOS_ASISTENCIAS (
    id_asistencia INT PRIMARY KEY AUTO_INCREMENT,
    id_fecha INT,
    id_joven INT,
    id_institucion INT,
    id_curso INT,
    id_taller INT,
    id_asesor INT,
    id_fase INT,
    id_municipio INT,
    id_modalidad INT,
    id_refrigerio INT,
    asistio BOOLEAN,

    -- FOREIGN KEYS
    FOREIGN KEY (id_fecha) REFERENCES DIM_FECHA(id_fecha),
    FOREIGN KEY (id_joven) REFERENCES DIM_JOVEN(id_joven),
    FOREIGN KEY (id_institucion) REFERENCES DIM_INSTITUCION(id_institucion),
    FOREIGN KEY (id_curso) REFERENCES DIM_CURSO(id_curso),
    FOREIGN KEY (id_taller) REFERENCES DIM_TIPO_TALLER(id_tipo_taller),
    FOREIGN KEY (id_asesor) REFERENCES DIM_ASESORES(id_asesor),
    FOREIGN KEY (id_fase) REFERENCES DIM_FASE(id_fase),
    FOREIGN KEY (id_municipio) REFERENCES DIM_MUNICIPIO(id_municipio),
    FOREIGN KEY (id_modalidad) REFERENCES DIM_MODALIDAD(id_modalidad),
    FOREIGN KEY (id_refrigerio) REFERENCES DIM_REFRIGERIO(id_refrigerio)
);

