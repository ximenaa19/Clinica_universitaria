CREATE DATABASE clinica_universitaria;
USE clinica_universitaria;

CREATE TABLE pacientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(6) NOT NULL UNIQUE,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    telefono VARCHAR(20)
);

CREATE TABLE sedes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(6) NOT NULL UNIQUE,
    hospital_sede VARCHAR(100),
    dir_sede VARCHAR(100)
);

CREATE TABLE facultades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(6) NOT NULL UNIQUE,
    nombre_facultad VARCHAR(50),
    decano VARCHAR(50)
);

CREATE TABLE especialidades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(6) NOT NULL UNIQUE,
    nombre_especialidad VARCHAR(50)
);

CREATE TABLE medicos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(4) NOT NULL UNIQUE,
    nombre_medico VARCHAR(50),
    id_especialidad int,
    id_facultad int,
    FOREIGN KEY (id_especialidad) REFERENCES especialidades(id),
    FOREIGN KEY (id_facultad) REFERENCES facultades(id)
);

CREATE TABLE citas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(6) NOT NULL UNIQUE,
    fecha DATE,
    paciente_id int,
    medico_id int,
    id_sede int,
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id),
    FOREIGN KEY (medico_id) REFERENCES medicos(id),
    FOREIGN KEY (id_sede) REFERENCES sedes(id)
);

CREATE TABLE diagnosticos (
	id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(6) NOT NULL UNIQUE,
    descripcion VARCHAR(100)
);

CREATE TABLE cita_diagnostico (
    id_cita int,
    codigo_cita varchar (6) not null,
    id_diagnostico int,
    PRIMARY KEY (id_cita, id_diagnostico),
    FOREIGN KEY (id_cita) REFERENCES citas(id),
    FOREIGN KEY (codigo_cita) REFERENCES citas(codigo),
    FOREIGN KEY (id_diagnostico) REFERENCES diagnosticos(id)
);

CREATE TABLE medicamentos (
	id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(6) NOT NULL UNIQUE,
    nombre_medicamento VARCHAR(50)
);

CREATE TABLE cita_medicamento (
    id_cita int,
    codigo_cita varchar (6) not null,
    id_medicamento int,
    dosis VARCHAR(20) not null,
    PRIMARY KEY (id_cita, id_medicamento),
    FOREIGN KEY (codigo_cita) REFERENCES citas(codigo),
    FOREIGN KEY (id_medicamento) REFERENCES medicamentos(id),
	FOREIGN KEY (id_cita) REFERENCES citas(id)
);


# TABLA DE LOGS
CREATE TABLE logs_errores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    procedimiento VARCHAR(100),
    nombre_tabla VARCHAR(100),
    codigo_error INT,
    mensaje TEXT,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

