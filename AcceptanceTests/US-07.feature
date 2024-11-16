Feature: Manejo de Información de Clientes

  Como dueño de taller
  Quiero manejar información de mis clientes
  Para mantener sus datos actualizados y aprovecharlos

  Scenario: Visualización de detalles de cliente activo
    Given que tengo los siguientes clientes registrados:
      | Nombre        | Contacto  | Estado  | Email               |
      | Ana García    | 555-1234  | Activo  | ana@example.com     |
      | Luis Pérez    | 555-5678  | Activo  | luis@example.com    |
      | Carlos López  | 555-9012  | Inactivo| carlos@example.com  |
    And me encuentro en la sección "Clientes"
    When selecciono al cliente "Ana García" con estado "Activo"
    Then el sistema muestra la información completa del cliente:
      | Campo      | Valor             |
      | Nombre     | Ana García        |
      | Contacto   | 555-1234          |
      | Estado     | Activo            |
      | Email      | ana@example.com   |
    And el sistema muestra una lista de vehículos registrados del cliente:
      | Marca  | Modelo  | Placa    |
      | Toyota | Corolla | ABC-1234 |
      | Honda  | Civic   | DEF-5678 |

  Scenario: Actualización de datos de cliente
    Given que me encuentro en los detalles del cliente "Ana García"
    And he modificado el campo "Teléfono" a "555-4321"
    And he modificado el campo "Dirección" a "Calle Nueva 456"
    When hago clic en "Actualizar"
    Then el sistema debería guardar los cambios realizados
    And muestra un mensaje "Datos actualizados correctamente"
    And los nuevos datos del cliente son:
      | Campo      | Valor           |
      | Teléfono   | 555-4321        |
      | Dirección  | Calle Nueva 456  |

  Scenario: Actualización de correo electrónico de cliente
    Given que me encuentro en los detalles del cliente "Ana García"
    And he cambiado el "Email" a "anagarcia@nuevoemail.com"
    When hago clic en "Actualizar"
    Then el sistema debería enviar una confirmación de cambio de correo a "anagarcia@nuevoemail.com"
    And muestra un mensaje "Se ha enviado una confirmación al nuevo correo electrónico"
    And el correo electrónico del cliente se actualiza a "anagarcia@nuevoemail.com" después de la confirmación

  Scenario: Eliminación de cliente
    Given que me encuentro en los detalles del cliente "Ana García"
    When hago clic en "Eliminar"
    Then el sistema debería solicitar confirmación para eliminar al cliente
    When confirmo la eliminación
    Then el sistema cambia el estado del cliente a "Inactivo"
    And muestra un mensaje "Cliente eliminado correctamente"
    And el cliente "Ana García" ya no aparece en la lista de clientes activos

  Scenario: Restauración de cliente inactivo
    Given que tengo clientes con estado "Inactivo":
      | Nombre        | Contacto  | Estado    | Email                |
      | Carlos López  | 555-9012  | Inactivo  | carlos@example.com   |
    And me encuentro en la sección "Clientes"
    When filtro clientes por estado "Inactivo"
    And selecciono al cliente "Carlos López" con estado "Inactivo"
    Then el sistema muestra la información completa del cliente:
      | Campo      | Valor              |
      | Nombre     | Carlos López       |
      | Contacto   | 555-9012           |
      | Estado     | Inactivo           |
      | Email      | carlos@example.com |
    And el sistema muestra la opción "Restaurar Cliente"
    When hago clic en "Restaurar Cliente"
    Then el sistema cambia el estado del cliente a "Activo"
    And muestra un mensaje "Cliente restaurado correctamente"
    And el cliente "Carlos López" aparece nuevamente en la lista de clientes activos
