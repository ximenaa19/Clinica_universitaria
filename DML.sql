INSERT INTO pacientes (codigo, nombre, apellido, telefono) VALUES
('P-501','Juan','Rivas','600-111'),
('P-502','Ana','Soto','600-222'),
('P-503','Luis','Paz','600-333');
select * from pacientes;
INSERT INTO sedes (codigo, hospital_sede, dir_sede) VALUES
('S01','Centro Médico','Calle 5 #10'),
('S02','Clínica Norte','Av. Libertador');

INSERT INTO facultades (codigo, nombre_facultad, decano) VALUES
('F01','Medicina','Dr. Wilson'),
('F02','Ciencias','Dr. Palmer');
select * from facultades;
INSERT INTO especialidades (codigo, nombre_especialidad) VALUES
('E01','Infectología'),
('E02','Cardiología'),
('E03','Neurocirugía');

INSERT INTO medicos (codigo, nombre_medico, id_especialidad, id_facultad) VALUES
('M-10','Dr. House', 1, 1),
('M-22','Dra. Grey', 2, 1),
('M-30','Dr. Strange', 3, 2);

INSERT INTO citas (codigo, fecha) VALUES
('C-001','2024-05-10'),
('C-002','2024-05-11'),
('C-003','2024-05-12'),
('C-004','2024-05-15');

INSERT INTO diagnosticos (codigo, descripcion) VALUES
('D01','Gripe Fuerte'),
('D02','Infección'),
('D03','Arritmia'),
('D04','Migraña');

select * from citas;
select * from diagnosticos;
INSERT INTO cita_diagnostico (id_cita, codigo_cita, id_diagnostico) VALUES
(1, 'C-001', 1),
(2, 'C-002', 2),
(3, 'C-003', 3),
(4, 'C-004', 4);

INSERT INTO medicamentos (codigo, nombre_medicamento)VALUES
('ME01','Paracetamol'),
('ME02','Ibuprofeno'),
('ME03','Amoxicilina'),
('ME04','Aspirina'),
('ME05','Ergotamina');
select * from medicamentos;
INSERT INTO cita_medicamento (id_cita, codigo_cita, id_medicamento, dosis) VALUES
(1, 'C-001', 1, '500mg'),
(1, 'C-001', 2, '400mg'),
(2, 'C-002', 3, '875mg'),
(3, 'C-003', 4, '100mg'),
(4, 'C-004', 5, '1mg');

UPDATE medicos SET id_especialidad = 1, id_facultad = 1 WHERE id = 1;
UPDATE medicos SET id_especialidad = 2, id_facultad = 1 WHERE id = 2;
UPDATE medicos SET id_especialidad = 3, id_facultad = 2 WHERE id = 3;

UPDATE citas SET paciente_id = 1, medico_id = 1, id_sede = 1 WHERE id = 1;
UPDATE citas SET paciente_id = 2, medico_id = 1, id_sede = 1 WHERE id = 2;
UPDATE citas SET paciente_id = 1, medico_id = 2, id_sede = 2 WHERE id = 3;
UPDATE citas SET paciente_id = 3, medico_id = 3, id_sede = 2 WHERE id = 4;