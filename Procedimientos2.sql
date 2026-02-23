select user, host from mysql.user;

#usuarios para clinica universitaria

#admin
create user "adminClinica"@"localhost" identified by "admin123";
grant all privileges on clinica_universitaria.* to "adminClinica"@"localhost" with grant option;

#gestor de pacientes y citas ( recepcionista )
create user "gestorPacientesCitas"@"localhost" identified by "gestorPC123";
revoke all privileges on *.* from "gestorPacientesCitas"@"localhost";
grant select, insert, update on clinica_universitaria.pacientes to "gestorPacientesCitas"@"localhost";
grant select, insert, update on clinica_universitaria.citas to "gestorPacientesCitas"@"localhost";
grant select on clinica_universitaria.medicos to "gestorPacientesCitas"@"localhost";

#medicos
create user "medico"@"localhost" identified by "medico123";
revoke all privileges on *.* from "medico"@"localhost";
grant select on clinica_universitaria.pacientes to "medico"@"localhost";
grant select on clinica_universitaria.citas to "medico"@"localhost";
grant select, insert on clinica_universitaria.cita_diagnostico to "medico"@"localhost";
grant select, insert on clinica_universitaria.cita_medicamento to "medico"@"localhost";

#supervisor
create user "supervisor"@"localhost" identified by "supervisor123";
revoke all privileges on *.* from "supervisor"@"localhost";
grant select on clinica_universitaria.* to "supervisor"@"localhost";

show grants for "adminClinica"@"localhost";
show grants for "gestorPacientesCitas"@"localhost";
show grants for "medico"@"localhost";
show grants for "supervisor"@"localhost";

drop user "supervisor"@"localhost";

alter user "adminClinica"@"localhost" identified by "Admin321."; 

set password for "medico"@"localhost" = "Medico321.";

flush privileges;

# Prepare y Execute

SET @paciente_id = 1;

PREPARE consulta_citas FROM '
SELECT c.codigo, c.fecha, s.hospital_sede
FROM citas c
JOIN sedes s ON c.id_sede = s.id
WHERE c.paciente_id = ?
';

EXECUTE consulta_citas USING @paciente_id;

DEALLOCATE PREPARE consulta_citas;

SET @cita_id = 1;

PREPARE consulta_medicamentos FROM '
SELECT m.nombre_medicamento, cm.dosis
FROM cita_medicamento cm
JOIN medicamentos m ON cm.id_medicamento = m.id
WHERE cm.id_cita = ?
';
EXECUTE consulta_medicamentos USING @cita_id;

DEALLOCATE PREPARE consulta_medicamentos;