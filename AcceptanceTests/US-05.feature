Feature: Manejo de información de empleados

  Como dueño de taller
  Quiero manejar la información de mis empleados
  Para gestionar sus cuentas

  Scenario: Visualización de detalles de empleado activo
    Given que tengo los siguientes empleados registrados:
      | Nombre       | Puesto      | Estado   | Email              |
      | Juan Pérez   | Mecánico    | Activo   | juan@example.com   |
      | María López  | Administradora | Activo   | maria@example.com  |
      | Carlos Gómez | Ayudante    | Inactivo | carlos@example.com |
    And me encuentro en la lista de empleados
    When selecciono al empleado "Juan Pérez" con estado "Activo"
    Then el sistema muestra la información completa del empleado:
      | Campo       | Valor             |
      | Nombre      | Juan Pérez        |
      | Puesto      | Mecánico          |
      | Estado      | Activo            |
      | Email       | juan@example.com  |
      | Teléfono    | 555-1234          |
      | Dirección   | Calle Falsa 123   |

  Scenario: Actualizar datos de empleado
    Given que me encuentro en los detalles del empleado "Juan Pérez"
    And he modificado el campo "Teléfono" a "555-5678"
    And he modificado el campo "Dirección" a "Avenida Siempre Viva 742"
    When hago clic en "Actualizar"
    Then el sistema actualiza los datos correspondientes del empleado
    And muestra un mensaje "Datos actualizados correctamente"
    And los nuevos datos del empleado son:
      | Campo     | Valor                    |
      | Teléfono  | 555-5678                 |
      | Dirección | Avenida Siempre Viva 742 |

  Scenario: Actualizar correo de empleado
    Given que me encuentro en los detalles del empleado "Juan Pérez"
    And he cambiado el "Email" a "juanperez@example.com"
    When hago clic en "Actualizar"
    Then el sistema envía una confirmación de cambio de correo a "juanperez@example.com"
    And muestra un mensaje "Se ha enviado una confirmación al nuevo correo electrónico"
    And el correo electrónico del empleado se actualiza a "juanperez@example.com" después de la confirmación

  Scenario: Eliminación de empleado
    Given que me encuentro en los detalles del empleado "Juan Pérez"
    When hago clic en "Eliminar"
    Then el sistema solicita confirmación para eliminar al empleado
    When confirmo la eliminación
    Then el sistema cambia el estado del empleado a "Inactivo"
    And muestra un mensaje "Empleado eliminado correctamente"
    And el empleado "Juan Pérez" ya no aparece en la lista de empleados activos

  Scenario: Restaurar empleado inactivo
    Given que tengo empleados con estado "Inactivo":
      | Nombre        | Puesto    | Estado   |
      | Carlos Gómez  | Ayudante  | Inactivo |
    And me encuentro en la lista de empleados
    When filtro empleados por estado "Inactivo"
    And selecciono al empleado "Carlos Gómez" con estado "Inactivo"
    Then el sistema muestra la información completa del empleado:
      | Campo     | Valor             |
      | Nombre    | Carlos Gómez      |
      | Puesto    | Ayudante          |
      | Estado    | Inactivo          |
      | Email     | carlos@example.com|
    And muestra la opción "Restaurar empleado"
    When hago clic en "Restaurar empleado"
    Then el sistema cambia el estado del empleado a "Activo"
    And muestra un mensaje "Empleado restaurado correctamente"
    And el empleado "Carlos Gómez" aparece en la lista de empleados activos
