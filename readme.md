#  Clínica Universitaria - Base de Datos

## 📌 Descripción

Este proyecto consiste en el diseño e implementación de una base de datos para la gestión de una clínica universitaria.

El sistema permite administrar información sobre:

* Pacientes
* Médicos
* Citas
* Diagnósticos
* Medicamentos
* Sedes

Se aplicaron principios de **normalización hasta Cuarta Forma Normal (4FN)** para evitar redundancias y garantizar la integridad de los datos.

---

## 🧠 Modelo de Datos

La base de datos está estructurada en las siguientes tablas principales:



## ⚙️ Tecnologías utilizadas

* MySQL
* MySQL Workbench

---

## 🧩 Normalización

Se aplicaron las siguientes formas normales:

* **1FN:** Eliminación de datos repetitivos (medicamentos separados en filas)
* **2FN:** Separación de dependencias parciales
* **3FN:** Eliminación de dependencias transitivas
* **4FN:** Separación de relaciones multivaluadas (diagnósticos y medicamentos)

---

## 🔄 Operaciones CRUD

Se implementaron procedimientos almacenados (CRUD) para las entidades principales:

###  Pacientes

* Insertar paciente
* Consultar pacientes
* Actualizar paciente
* Eliminar paciente

###  Citas

* Insertar cita
* Consultar citas (con JOIN)
* Actualizar cita
* Eliminar cita

---

##  Funciones implementadas

Se crearon funciones para:

* Total de doctores por especialidad
* Total de pacientes por médico
* Total de pacientes por sede

---

##  Manejo de errores

Se implementó una tabla de logs:

* `logs_errores`

Esta tabla almacena:

* Procedimiento donde ocurrió el error
* Tabla afectada
* Código del error
* Mensaje
* Fecha y hora

---

# Modelo EER
![alt text](image.png)

---

## Gestión de Usuarios y Roles

Se crearon distintos usuarios en la base de datos con el objetivo de simular el funcionamiento real de una clínica universitaria y aplicar control de acceso según responsabilidades.

### Roles creados:

### Administrador

Acceso total a la base de datos.

Puede crear, modificar y eliminar estructuras (DDL).

Gestiona usuarios y permisos.

### Recepcionista

Puede registrar pacientes.

Puede crear y consultar citas.

No puede eliminar registros médicos.

### Médico

Puede consultar sus citas.

Puede actualizar información médica relacionada.

No puede eliminar pacientes ni modificar estructura.

### Supervisor

Solo puede consultar información.

Acceso a reportes e informes.

No puede insertar, actualizar ni eliminar datos.

Esto permite aplicar seguridad basada en roles y simula una estructura organizacional real.

---

## Uso de PREPARE y EXECUTE

Se implementaron consultas dinámicas utilizando PREPARE y EXECUTE con el fin de:

Ejecutar consultas parametrizadas.

Separar los datos de la estructura SQL.

Simular escenarios dinámicos de consulta.

Ejemplo aplicado:

Consulta de citas por paciente.

Consulta de medicamentos asociados a una cita.

Esto permite reutilizar consultas y mejora la organización del código SQL.

---

## Triggers de Validación

Se implementaron triggers para garantizar la integridad de los datos antes de ser almacenados.

Validaciones realizadas:

El nombre del paciente no puede estar vacío.

El teléfono debe cumplir con una longitud mínima.

La fecha de la cita no puede ser una fecha futura.

Estos triggers funcionan con BEFORE INSERT, evitando que se almacenen datos inválidos en el sistema.

---

## Eventos Programados

Se creó un evento que genera automáticamente un informe diario.

Este evento:

Se ejecuta cada día.

Genera un resumen con sede, médico y número de pacientes atendidos.

Permite mantener un reporte actualizado sin intervención manual.

Se activó el event_scheduler para permitir la ejecución automática.

---

## Vista Académica

Se creó una vista que relaciona:

Médico

Facultad

Especialidad

Esto permite visualizar cómo se integra el componente académico con la práctica clínica, reflejando el modelo de una clínica universitaria real.

La vista facilita el análisis organizacional sin modificar la estructura original de las tablas.

----

## Particiones

Se decidió particionar únicamente la tabla citas porque es la que más crece dentro del sistema, ya que allí se registran todas las atenciones realizadas a los pacientes. Además, esta tabla maneja fechas, lo que permite organizar la información por años y facilitar consultas por periodos de tiempo.

Las demás tablas, como pacientes, médicos, especialidades o facultades, no fueron particionadas porque no tienen un crecimiento tan alto y funcionan más como tablas de referencia. 

No se eliminó la tabla original de citas para evitar afectar las relaciones y claves foráneas ya creadas en la base de datos. En su lugar, se creó una versión particionada como propuesta de optimización, manteniendo la estructura original intacta.

##  Autor

Ximena Afanador
