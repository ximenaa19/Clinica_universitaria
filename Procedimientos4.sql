# Vista medico, facultad, especialidad

CREATE VIEW vista_medicos_academico AS
SELECT 
    m.nombre_medico AS medico,
    f.nombre_facultad AS facultad,
    e.nombre_especialidad AS especialidad
FROM medicos m
JOIN facultades f ON m.id_facultad = f.id
JOIN especialidades e ON m.id_especialidad = e.id;

SELECT * FROM vista_medicos_academico;

# Tabla de citas particionada

CREATE TABLE citas_particionada (
    id INT not null,
    codigo VARCHAR(20),
    fecha DATE not null,
    paciente_id INT,
    medico_id INT,
    id_sede INT,
    PRIMARY KEY (id, fecha)
)
PARTITION BY RANGE (YEAR(fecha)) (
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p2026 VALUES LESS THAN (2027)
);