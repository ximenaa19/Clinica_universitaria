# CRUD PACIENTES

DELIMITER $$
CREATE PROCEDURE insertar_paciente(
    IN p_codigo VARCHAR(6),
    IN p_nombre VARCHAR(50),
    IN p_apellido VARCHAR(50),
    IN p_telefono VARCHAR(20)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO logs_errores(procedimiento, nombre_tabla, codigo_error, mensaje)
        VALUES ('insertar_paciente', 'pacientes', 100, 'Error al insertar paciente');
    END;

    INSERT INTO pacientes(codigo, nombre, apellido, telefono)
    VALUES (p_codigo, p_nombre, p_apellido, p_telefono);
END$$

DELIMITER ;

CREATE PROCEDURE obtener_pacientes()
SELECT * FROM pacientes;

DELIMITER $$

CREATE PROCEDURE actualizar_paciente(
    IN p_id INT,
    IN p_nombre VARCHAR(50)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO logs_errores(procedimiento, nombre_tabla, codigo_error, mensaje)
        VALUES ('actualizar_paciente', 'pacientes', 200, 'Error al actualizar');
    END;

    UPDATE pacientes SET nombre = p_nombre WHERE id = p_id;
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE eliminar_paciente(IN p_id INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO logs_errores(procedimiento, nombre_tabla, codigo_error, mensaje)
        VALUES ('eliminar_paciente', 'pacientes', 300, 'Error al eliminar');
    END;

    DELETE FROM pacientes WHERE id = p_id;
END$$

DELIMITER ;


#CRUD CITAS
DELIMITER $$

CREATE PROCEDURE insertar_cita(
    IN p_codigo VARCHAR(6),
    IN p_fecha DATE,
    IN p_paciente_id INT,
    IN p_medico_id INT,
    IN p_sede_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO logs_errores(procedimiento, tabla_afectada, codigo_error, mensaje_error)
        VALUES ('insertar_cita','citas',100,'Error al insertar cita');
    END;

    INSERT INTO citas(codigo, fecha, paciente_id, medico_id, id_sede)
    VALUES (p_codigo, p_fecha, p_paciente_id, p_medico_id, p_sede_id);
END $$

DELIMITER ;

CREATE PROCEDURE obtener_citas()
SELECT 
    c.codigo,
    c.fecha,
    p.nombre,
    p.apellido,
    m.nombre_medico,
    s.hospital_sede
FROM citas c
JOIN pacientes p ON c.paciente_id = p.id
JOIN medicos m ON c.medico_id = m.id
JOIN sedes s ON c.id_sede = s.id;

DELIMITER $$

CREATE PROCEDURE actualizar_cita(
    IN p_id INT,
    IN p_fecha DATE,
    IN p_paciente_id INT,
    IN p_medico_id INT,
    IN p_sede_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO logs_errores(procedimiento, tabla_afectada, codigo_error, mensaje_error)
        VALUES ('actualizar_cita','citas',200,'Error al actualizar cita');
    END;

    UPDATE citas
    SET fecha = p_fecha,
        paciente_id = p_paciente_id,
        medico_id = p_medico_id,
        id_sede = p_sede_id
    WHERE id = p_id;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE eliminar_cita(IN p_id INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO logs_errores(procedimiento, tabla_afectada, codigo_error, mensaje_error)
        VALUES ('eliminar_cita','citas',300,'Error al eliminar cita');
    END;

    DELETE FROM citas WHERE id = p_id;
END $$

DELIMITER ;

# PARA EL RESTO DE TABLAS SE APLICA UN CRUD SIMPLE: INSERT, SELECT

#FUNCIONES

#numero de doctores por especialidad

CREATE FUNCTION total_doctores_por_especialidad(p_id_especialidad INT)
RETURNS INT
DETERMINISTIC
RETURN (
    SELECT COUNT(*) 
    FROM medicos 
    WHERE id_especialidad = p_id_especialidad
);

#total pacientes por medico

CREATE FUNCTION total_pacientes_por_medico(p_medico_id INT)
RETURNS INT
DETERMINISTIC
RETURN (
    SELECT COUNT(DISTINCT paciente_id)
    FROM citas
    WHERE medico_id = p_medico_id
);

#pacientes por sede

CREATE FUNCTION total_pacientes_por_sede(p_sede_id INT)
RETURNS INT
DETERMINISTIC
RETURN (
    SELECT COUNT(DISTINCT paciente_id)
    FROM citas
    WHERE id_sede = p_sede_id
);