# Trigger validacion de pacientes

DELIMITER //

CREATE TRIGGER validar_nombre_paciente
BEFORE INSERT ON pacientes
FOR EACH ROW
BEGIN
    IF NEW.nombre IS NULL OR NEW.nombre = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El nombre del paciente es obligatorio';
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER validar_telefono_paciente
BEFORE INSERT ON pacientes
FOR EACH ROW
BEGIN
    IF NEW.telefono IS NULL OR LENGTH(NEW.telefono) < 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El telefono debe tener al menos 10 digitos';
    END IF;
END //

DELIMITER ;

# Trigger validacion fecha de cita
DELIMITER //

CREATE TRIGGER validar_fecha_cita
BEFORE INSERT ON citas
FOR EACH ROW
BEGIN
    IF NEW.fecha > CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No puedes insertar fechas futuras';
    END IF;
END //

DELIMITER ;

# Tabla de informe Event

CREATE TABLE informe_diario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sede VARCHAR(100),
    medico VARCHAR(100),
    fecha DATE,
    total_pacientes INT
);
SET GLOBAL event_scheduler = ON;

CREATE EVENT reporte_diario
ON SCHEDULE EVERY 1 DAY
DO
INSERT INTO informe_diario (sede, medico, fecha, total_pacientes)
SELECT 
    s.hospital_sede,
    m.nombre,
    c.fecha,
    COUNT(c.paciente_id)
FROM citas c
JOIN sedes s ON c.id_sede = s.id
JOIN medicos m ON c.medico_id = m.id
GROUP BY s.hospital_sede, m.nombre, c.fecha;