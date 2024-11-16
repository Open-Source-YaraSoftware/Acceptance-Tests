Feature: Gestión de Solicitudes de Inventario

  Como dueño de taller
  Quiero manejar solicitudes de inventario realizadas por los mecánicos
  Para conocer los materiales y repuestos necesarios para las intervenciones pendientes

  Scenario: Visualización de solicitudes de inventario pendientes
    Given que tengo las siguientes solicitudes de inventario pendientes:
      | Mecánico       | Pieza           | CantidadSolicitada | FechaSolicitud |
      | Juan Pérez     | Filtro de aire  | 5                  | 01/09/2023      |
      | María López    | Aceite 10W-40    | 10                 | 02/09/2023      |
      | Carlos Gómez   | Bujías          | 20                 | 03/09/2023      |
    When accedo a la sección "Solicitudes de Inventario" en la aplicación
    Then el sistema muestra una lista de solicitudes pendientes con los siguientes detalles:
      | Mecánico       | Pieza           | CantidadSolicitada | FechaSolicitud |
      | Juan Pérez     | Filtro de aire  | 5                  | 01/09/2023      |
      | María López    | Aceite 10W-40    | 10                 | 02/09/2023      |
      | Carlos Gómez   | Bujías          | 20                 | 03/09/2023      |

  Scenario Outline: Filtrado de solicitudes de inventario por mecánico o pieza
    Given que tengo las siguientes solicitudes de inventario pendientes:
      | Mecánico       | Pieza           | CantidadSolicitada | FechaSolicitud |
      | Juan Pérez     | Filtro de aire  | 5                  | 01/09/2023      |
      | María López    | Aceite 10W-40    | 10                 | 02/09/2023      |
      | Carlos Gómez   | Bujías          | 20                 | 03/09/2023      |
      | Laura Martínez | Pastillas        | 15                 | 04/09/2023      |
    And me encuentro en la sección "Solicitudes de Inventario"
    When ingreso "<TextoBusqueda>" en el campo de búsqueda
    Then el sistema muestra las solicitudes que coinciden con "<TextoBusqueda>":
      | Mecánico       | Pieza           | CantidadSolicitada | FechaSolicitud |
      | <Mecánico1>    | <Pieza1>        | <Cantidad1>         | <Fecha1>        |
      | <Mecánico2>    | <Pieza2>        | <Cantidad2>         | <Fecha2>        |

    Examples:
      | TextoBusqueda | Mecánico1     | Pieza1          | Cantidad1 | Fecha1    | Mecánico2    | Pieza2         | Cantidad2 | Fecha2    |
      | Juan          | Juan Pérez    | Filtro de aire  | 5         | 01/09/2023|              |                |           |           |
      | Aceite        | María López   | Aceite 10W-40    | 10        | 02/09/2023|              |                |           |           |
      | Bujías        | Carlos Gómez  | Bujías          | 20        | 03/09/2023|              |                |           |           |
      | Pastillas     | Laura Martínez| Pastillas       | 15        | 04/09/2023|              |                |           |           |
      | Pérez         | Juan Pérez    | Filtro de aire  | 5         | 01/09/2023|              |                |           |           |

  Scenario Outline: Filtrado de solicitudes de inventario por estado
    Given que tengo las siguientes solicitudes de inventario:
      | Mecánico       | Pieza           | CantidadSolicitada | FechaSolicitud | Estado       |
      | Juan Pérez     | Filtro de aire  | 5                  | 01/09/2023      | Pendiente    |
      | María López    | Aceite 10W-40    | 10                 | 02/09/2023      | Aprobado     |
      | Carlos Gómez   | Bujías          | 20                 | 03/09/2023      | Pendiente    |
      | Laura Martínez | Pastillas        | 15                 | 04/09/2023      | Rechazado    |
    And me encuentro en la sección "Solicitudes de Inventario"
    When selecciono el filtro por estado "<EstadoSeleccionado>"
    Then el sistema muestra las solicitudes con estado "<EstadoSeleccionado>":
      | Mecánico       | Pieza           | CantidadSolicitada | FechaSolicitud | Estado       |
      | <Mecánico1>    | <Pieza1>        | <Cantidad1>         | <Fecha1>        | <EstadoSeleccionado> |
      | <Mecánico2>    | <Pieza2>        | <Cantidad2>         | <Fecha2>        | <EstadoSeleccionado> |

    Examples:
      | EstadoSeleccionado | Mecánico1     | Pieza1          | Cantidad1 | Fecha1    | Mecánico2     | Pieza2         | Cantidad2 | Fecha2    |
      | Pendiente           | Juan Pérez    | Filtro de aire  | 5         | 01/09/2023| Carlos Gómez  | Bujías         | 20        | 03/09/2023|
      | Aprobado            | María López   | Aceite 10W-40    | 10        | 02/09/2023|               |                |           |           |
      | Rechazado           | Laura Martínez| Pastillas       | 15        | 04/09/2023|               |                |           |           |

  Scenario: Guardar cambios en solicitudes de inventario
    Given que tengo las siguientes solicitudes de inventario pendientes:
      | Mecánico       | Pieza           | CantidadSolicitada | FechaSolicitud |
      | Juan Pérez     | Filtro de aire  | 5                  | 01/09/2023      |
      | María López    | Aceite 10W-40    | 10                 | 02/09/2023      |
      | Carlos Gómez   | Bujías          | 20                 | 03/09/2023      |
    And me encuentro en la sección "Solicitudes de Inventario"
    And he seleccionado las solicitudes de "Juan Pérez" y "Carlos Gómez"
    When hago clic en el botón "Guardar cambios"
    Then el sistema elimina las solicitudes seleccionadas de la lista
    And notifica a "Juan Pérez" y "Carlos Gómez" que sus solicitudes han sido aprobadas

  Scenario: Deshacer cambios en solicitudes de inventario
    Given que tengo las siguientes solicitudes de inventario pendientes:
      | Mecánico       | Pieza           | CantidadSolicitada | FechaSolicitud |
      | Juan Pérez     | Filtro de aire  | 5                  | 01/09/2023      |
      | María López    | Aceite 10W-40    | 10                 | 02/09/2023      |
      | Carlos Gómez   | Bujías          | 20                 | 03/09/2023      |
    And me encuentro en la sección "Solicitudes de Inventario"
    And he seleccionado la solicitud de "Juan Pérez"
    When hago clic en el botón "Deshacer"
    Then el sistema revierte la selección
    And ninguna solicitud es eliminada de la lista
    And no se envían notificaciones a los mecánicos

  Scenario Outline: Ordenamiento de solicitudes de inventario por campo
    Given que tengo las siguientes solicitudes de inventario:
      | Mecánico       | Pieza           | CantidadSolicitada | FechaSolicitud | Estado     |
      | Juan Pérez     | Filtro de aire  | 5                  | 01/09/2023      | Pendiente  |
      | María López    | Aceite 10W-40    | 10                 | 02/09/2023      | Aprobado   |
      | Carlos Gómez   | Bujías          | 20                 | 03/09/2023      | Pendiente  |
      | Laura Martínez | Pastillas        | 15                 | 04/09/2023      | Rechazado  |
    And me encuentro en la sección "Solicitudes de Inventario"
    When ordeno las solicitudes por "<Campo>" en orden "<Orden>"
    Then el sistema muestra las solicitudes ordenadas por "<Campo>" en orden "<Orden>":
      | Mecánico       | Pieza           | CantidadSolicitada | FechaSolicitud | Estado     |
      | ...            | ...             | ...                | ...             | ...        |

    Examples:
      | Campo             | Orden       |
      | Mecánico          | Ascendente  |
      | Mecánico          | Descendente |
      | Pieza             | Ascendente  |
      | Pieza             | Descendente |
      | CantidadSolicitada| Ascendente  |
      | CantidadSolicitada| Descendente |
      | FechaSolicitud    | Ascendente  |
      | FechaSolicitud    | Descendente |
      | Estado            | Ascendente  |
      | Estado            | Descendente |

  Scenario: Responsividad en dispositivos móviles durante gestión de solicitudes de inventario
    Given que estoy utilizando un dispositivo móvil
    When accedo a la sección "Solicitudes de Inventario"
    Then el sistema adapta la interfaz al tamaño de la pantalla del dispositivo
    And todas las columnas de la tabla de solicitudes son legibles sin desplazamiento horizontal
    And puedo seleccionar y gestionar solicitudes sin problemas de usabilidad

  Scenario: Validación de campos al realizar una solicitud de inventario
    Given que un mecánico está creando una solicitud de inventario
    When ingresa "<Pieza>" en el campo "Pieza"
    And ingresa "<CantidadSolicitada>" en el campo "CantidadSolicitada"
    And ingresa "<FechaSolicitud>" en el campo "FechaSolicitud"
    Then el sistema valida los campos ingresados
    And si hay campos inválidos, muestra mensajes de error específicos:
      | Campo             | Mensaje de Error                                 |
      | CantidadSolicitada| "La cantidad solicitada debe ser un número positivo." |
      | FechaSolicitud    | "La fecha de solicitud debe ser válida y no puede ser futura." |

    Examples:
      | Pieza            | CantidadSolicitada | FechaSolicitud  |
      | Filtro de aire   | -5                 | 01/09/2023      |
      | Aceite 10W-40    | 10                 | 31/02/2023      |
      | Bujías           | abc                | 03/09/2023      |
      | Pastillas        | 15                 | 35/13/2023      |

  Scenario: Manejo de solicitudes duplicadas
    Given que tengo una solicitud de inventario existente:
      | Mecánico     | Pieza          | CantidadSolicitada | FechaSolicitud |
      | Juan Pérez   | Filtro de aire | 5                  | 01/09/2023      |
    When intento crear una nueva solicitud para "Juan Pérez" con "Filtro de aire" y "5" cantidad
    Then el sistema muestra un mensaje de error "Ya existe una solicitud similar para este mecánico."
    And no añade la nueva solicitud al inventario

  Scenario: Notificación al aprobar una solicitud de inventario
    Given que tengo una solicitud de inventario pendiente:
      | Mecánico     | Pieza          | CantidadSolicitada | FechaSolicitud |
      | Juan Pérez   | Filtro de aire | 5                  | 01/09/2023      |
    When apruebo la solicitud de "Juan Pérez"
    Then el sistema elimina la solicitud de la lista
    And notifica a "Juan Pérez" que su solicitud ha sido aprobada
    And incrementa la cantidad de "Filtro de aire" en el inventario en 5 unidades

  Scenario: Notificación al rechazar una solicitud de inventario
    Given que tengo una solicitud de inventario pendiente:
      | Mecánico     | Pieza          | CantidadSolicitada | FechaSolicitud |
      | Juan Pérez   | Filtro de aire | 5                  | 01/09/2023      |
    When rechazo la solicitud de "Juan Pérez"
    Then el sistema elimina la solicitud de la lista
    And notifica a "Juan Pérez" que su solicitud ha sido rechazada
    And no modifica la cantidad de "Filtro de aire" en el inventario

  Scenario: Acceso a solicitud de inventario no existente
    Given que no existe una solicitud de inventario con ID "9999"
    When intento acceder a los detalles de la solicitud "9999"
    Then el sistema muestra un mensaje de error "Solicitud de inventario no encontrada"
    And redirige a la sección "Solicitudes de Inventario"

