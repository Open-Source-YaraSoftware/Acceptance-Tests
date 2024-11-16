Feature: Creación y gestión de intervenciones

  Como dueño de taller
  Quiero poder gestionar las intervenciones de mi taller
  Para organizar eficientemente a mis mecánicos

  Scenario: Crear intervención desde lista de intervenciones
    Given que me encuentro en la sección "Intervenciones"
    When hago clic en el botón "Realizar intervención"
    Then el sistema muestra un formulario de creación de intervención
    And el formulario incluye los siguientes campos:
      | Campo          | Descripción                           |
      | Cliente        | Seleccionar cliente existente        |
      | Vehículo       | Seleccionar vehículo del cliente     |
      | Fecha          | Seleccionar fecha de la intervención |
      | Descripción    | Ingresar descripción detallada        |
      | Mecánico       | Asignar mecánico responsable          |
    And el botón "Crear" está habilitado

  Scenario: Crear intervención desde detalles de vehículo de cliente
    Given que estoy observando una falla en el vehículo "ABC-1234" del cliente "Carlos García"
    When hago clic en el botón "Realizar intervención"
    Then el sistema muestra un formulario de creación de intervención prellenado con:
      | Campo      | Valor             |
      | Cliente    | Carlos García     |
      | Vehículo   | ABC-1234          |
      | Fecha      | Fecha actual      |
      | Descripción| [Campo vacío]     |
      | Mecánico   | [Campo vacío]     |
    And el botón "Crear" está habilitado

  Scenario: Registro exitoso de intervención
    Given que me encuentro en el formulario de creación de intervención
    And he completado los siguientes campos correctamente:
      | Campo       | Valor                     |
      | Cliente     | Ana Torres                |
      | Vehículo    | XYZ-5678                  |
      | Fecha       | 25/04/2024                |
      | Descripción | Cambio de aceite y filtros |
      | Mecánico    | Juan Pérez                |
    When hago clic en el botón "Crear"
    Then el sistema registra una nueva intervención
    And asigna el estado "Pendiente" a la intervención
    And muestra un mensaje "Intervención creada exitosamente"
    And la nueva intervención aparece en la lista con los detalles proporcionados

  Scenario Outline: Registro fallido de intervención por datos incompletos
    Given que me encuentro en el formulario de creación de intervención
    And he completado los siguientes campos:
      | Campo       | Valor                 |
      | Cliente     | <Cliente>             |
      | Vehículo    | <Vehículo>            |
      | Fecha       | <Fecha>               |
      | Descripción | <Descripción>         |
      | Mecánico    | <Mecánico>            |
    When hago clic en el botón "Crear"
    Then el sistema no registra la intervención
    And muestra un mensaje de error indicando los campos inválidos o incompletos:
      | Campo         | Error                          |
      | <CampoError1> | <MensajeError1>                |
      | <CampoError2> | <MensajeError2>                |

    Examples:
      | Cliente     | Vehículo | Fecha      | Descripción | Mecánico  | CampoError1 | MensajeError1                | CampoError2 | MensajeError2                    |
      | Ana Torres  | XYZ-5678 |            | Cambio aceite| Juan Pérez| Fecha       | "El campo Fecha es obligatorio."|             |                                    |
      |             | XYZ-5678 | 25/04/2024 | Cambio aceite| Juan Pérez| Cliente     | "El campo Cliente es obligatorio."|           |                                    |
      | Ana Torres  |          | 25/04/2024 | Cambio aceite| Juan Pérez| Vehículo    | "El campo Vehículo es obligatorio."|          |                                    |
      | Ana Torres  | XYZ-5678 | 25/04/2024 |              | Juan Pérez| Descripción | "El campo Descripción es obligatorio."|       |                                    |
      | Ana Torres  | XYZ-5678 | 25/04/2024 | Cambio aceite|          | Mecánico    | "El campo Mecánico es obligatorio."|          |                                    |

  Scenario: Cancelar creación de intervención
    Given que me encuentro en el formulario de creación de intervención
    When hago clic en el botón "Cancelar"
    Then el sistema descarta los datos ingresados en el formulario
    And me redirige de vuelta a la sección "Intervenciones"
    And no se crea ninguna nueva intervención

  Scenario: Validación de formato de fecha
    Given que me encuentro en el formulario de creación de intervención
    And he ingresado "31/02/2024" en el campo "Fecha"
    When hago clic en el botón "Crear"
    Then el sistema no registra la intervención
    And muestra un mensaje de error "El formato de fecha es inválido."

  Scenario: Asignación de mecánico disponible
    Given que tengo mecánicos disponibles en el sistema
      | Nombre      | Estado  |
      | Juan Pérez  | Disponible |
      | María López | Ocupado     |
    And me encuentro en el formulario de creación de intervención
    When selecciono "Juan Pérez" en el campo "Mecánico"
    Then el sistema asigna "Juan Pérez" como mecánico responsable de la intervención

  Scenario: Asignación de mecánico no disponible
    Given que solo tengo mecánicos con estado "Ocupado"
      | Nombre        | Estado  |
      | María López   | Ocupado |
      | Carlos Gómez  | Ocupado |
    And me encuentro en el formulario de creación de intervención
    When intento asignar "María López" en el campo "Mecánico"
    Then el sistema muestra un mensaje de error "El mecánico seleccionado no está disponible."
    And no permite asignar un mecánico no disponible

  Scenario: Responsividad en dispositivos móviles durante creación de intervención
    Given que estoy utilizando un dispositivo móvil
    When accedo al formulario de creación de intervención
    Then el formulario se adapta correctamente a la pantalla del dispositivo
    And todos los campos son legibles y accesibles sin necesidad de desplazamiento horizontal
    And puedo completar y enviar el formulario sin problemas de usabilidad
