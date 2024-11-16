Feature: Visualización y gestión de detalles de intervenciones

  Como dueño de taller
  Quiero visualizar los detalles asociados a una intervención
  Para tener un control claro y detallado del trabajo realizado y gestionar los cambios de los clientes

  Scenario: Visualización de detalles generales de intervención
    Given que tengo las siguientes intervenciones registradas:
      | Cliente        | Vehículo   | Estado     | Fecha       | Mecánico       |
      | Carlos García  | ABC-1234   | Pendiente  | 01/09/2023  | Juan Pérez     |
      | Ana Torres     | XYZ-5678   | Finalizado | 15/08/2023  | María López    |
    And me encuentro en la sección "Intervenciones"
    When selecciono la intervención "Carlos García - ABC-1234"
    Then el sistema muestra los detalles generales de la intervención:
      | Campo         | Valor             |
      | Placa         | ABC-1234          |
      | Cliente       | Carlos García     |
      | Mecánico      | Juan Pérez        |
      | Estado        | Pendiente         |
      | Fecha         | 01/09/2023        |

  Scenario: Visualización del resumen de intervención
    Given que estoy viendo los detalles generales de la intervención "Carlos García - ABC-1234"
    When hago clic en la pestaña "Resumen"
    Then el sistema muestra la información específica de las tareas realizadas:
      | Tarea            | Descripción                   | Estado      |
      | Cambio de aceite | Reemplazo de aceite sintético | Completada  |
      | Filtro de aire   | Sustitución de filtro         | En progreso |
    And el sistema muestra observaciones adicionales:
      | Observación                               |
      | El cliente solicitó revisión de frenos    |
      | Se encontraron piezas desgastadas         |

  Scenario: Modificar intervención en estado pendiente
    Given que estoy viendo los detalles generales de la intervención "Carlos García - ABC-1234"
    And la intervención está en estado "Pendiente"
    When edito el campo "Fecha" a "05/09/2023"
    And edito el campo "Mecánico" a "Luis Mendoza"
    Then el sistema permite modificar los valores registrados
    And el sistema muestra los campos "Fecha" y "Mecánico" como editables

  Scenario: Guardar cambios en intervención
    Given que he modificado el campo "Fecha" a "05/09/2023"
    And he modificado el campo "Mecánico" a "Luis Mendoza"
    When hago clic en el botón "Guardar"
    Then el sistema actualiza los cambios realizados en la intervención
    And muestra un mensaje "Intervención actualizada correctamente"
    And los nuevos detalles de la intervención son:
      | Campo    | Valor          |
      | Fecha    | 05/09/2023     |
      | Mecánico | Luis Mendoza    |

  Scenario: Cancelar intervención en estado pendiente desde detalles generales
    Given que estoy viendo los detalles generales de la intervención "Carlos García - ABC-1234"
    And la intervención está en estado "Pendiente"
    When hago clic en el botón "Cancelar intervención"
    Then el sistema solicita confirmación para cancelar la intervención
    When confirmo la cancelación
    Then el sistema elimina la intervención del sistema
    And muestra un mensaje "Intervención cancelada correctamente"
    And la intervención "Carlos García - ABC-1234" ya no aparece en la lista de intervenciones

  Scenario: Cancelar intervención en estado pendiente desde resumen
    Given que estoy viendo el resumen de la intervención "Carlos García - ABC-1234"
    And la intervención está en estado "Pendiente"
    When hago clic en el botón "Cancelar intervención"
    Then el sistema solicita confirmación para cancelar la intervención
    When confirmo la cancelación
    Then el sistema elimina la intervención del sistema
    And muestra un mensaje "Intervención cancelada correctamente"
    And la intervención "Carlos García - ABC-1234" ya no aparece en la lista de intervenciones

  Scenario Outline: Validación de campos al modificar intervención
    Given que estoy viendo los detalles generales de la intervención "<Intervención>"
    And la intervención está en estado "Pendiente"
    When edito el campo "<Campo>" a "<ValorInvalido>"
    And hago clic en el botón "Guardar"
    Then el sistema no actualiza la intervención
    And muestra un mensaje de error "El campo <Campo> es inválido."

    Examples:
      | Intervención               | Campo    | ValorInvalido |
      | Carlos García - ABC-1234   | Fecha    | 31/02/2024    |
      | Carlos García - ABC-1234   | Mecánico |               |

  Scenario: Responsividad en dispositivos móviles durante visualización de intervención
    Given que estoy utilizando un dispositivo móvil
    When accedo a los detalles generales de la intervención "Carlos García - ABC-1234"
    Then el sistema adapta correctamente la interfaz a la pantalla del dispositivo
    And todos los campos son legibles y accesibles sin necesidad de desplazamiento horizontal
    And puedo navegar a la pestaña "Resumen" sin problemas

  Scenario: Responsividad en dispositivos móviles durante modificación de intervención
    Given que estoy utilizando un dispositivo móvil
    When accedo al formulario de modificación de la intervención "Carlos García - ABC-1234"
    Then el sistema adapta correctamente el formulario a la pantalla del dispositivo
    And puedo editar y guardar los cambios sin problemas de usabilidad

  Scenario: Acceso a intervención no existente
    Given que no existe una intervención con ID "9999"
    When intento acceder a los detalles de la intervención "9999"
    Then el sistema muestra un mensaje de error "Intervención no encontrada"
    And redirige a la lista de intervenciones
