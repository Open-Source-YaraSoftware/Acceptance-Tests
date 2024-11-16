Feature: Visualización y gestión del personal
  Como dueño de taller
  Quiero visualizar mi lista de empleados
  Para saber qué empleados están registrados en el sistema

  Scenario: Lista de empleados vacía
    Given que no tengo empleados registrados en el sistema
    When accedo a la sección "Personal" en la aplicación
    Then el sistema muestra un mensaje indicando "No hay personal registrado"
    And el sistema muestra una opción destacada para "Registrar Personal"

  Scenario: Visualización de lista de empleados
    Given que tengo los siguientes empleados registrados:
      | Nombre       | Puesto        | Estado  |
      | Juan Pérez   | Mecánico      | Activo  |
      | María López  | Administradora| Activo  |
    When accedo a la sección "Personal" en la aplicación
    Then el sistema muestra la lista de empleados con su información básica:
      | Nombre       | Puesto        | Estado  |
      | Juan Pérez   | Mecánico      | Activo  |
      | María López  | Administradora| Activo  |

  Scenario Outline: Filtrado de empleados por nombre
    Given que tengo los siguientes empleados registrados:
      | Nombre       | Puesto        | Estado    |
      | Juan Pérez   | Mecánico      | Activo    |
      | María López  | Administradora| Activo    |
      | Carlos Gómez | Mecánico      | Inactivo  |
    And me encuentro en la sección "Personal"
    When ingreso "<TextoBusqueda>" en el campo de búsqueda
    Then el sistema muestra los empleados cuyos nombres contienen "<TextoBusqueda>":
      | Nombre        | Puesto         | Estado     |
      | <Nombre1>     | <Puesto1>      | <Estado1>  |
      | <Nombre2>     | <Puesto2>      | <Estado2>  |

    Examples:
      | TextoBusqueda | Nombre1      | Puesto1       | Estado1 | Nombre2     | Puesto2        | Estado2 |
      | Juan          | Juan Pérez   | Mecánico      | Activo  |             |                |         |
      | María         | María López  | Administradora| Activo  |             |                |         |
      | Gómez         | Carlos Gómez | Mecánico      | Inactivo|             |                |         |
      | a             | Juan Pérez   | Mecánico      | Activo  | María López | Administradora | Activo  |

  Scenario Outline: Filtrado de empleados por estado
    Given que tengo los siguientes empleados registrados:
      | Nombre       | Puesto        | Estado    |
      | Juan Pérez   | Mecánico      | Activo    |
      | María López  | Administradora| Activo    |
      | Carlos Gómez | Mecánico      | Inactivo  |
    And me encuentro en la sección "Personal"
    When selecciono el filtro por estado "<EstadoSeleccionado>"
    Then el sistema muestra los empleados con estado "<EstadoSeleccionado>":
      | Nombre        | Puesto         | Estado     |
      | <Nombre1>     | <Puesto1>      | <Estado1>  |
      | <Nombre2>     | <Puesto2>      | <Estado2>  |

    Examples:
      | EstadoSeleccionado | Nombre1      | Puesto1       | Estado1 | Nombre2     | Puesto2        | Estado2 |
      | Activo             | Juan Pérez   | Mecánico      | Activo  | María López | Administradora | Activo  |
      | Inactivo           | Carlos Gómez | Mecánico      | Inactivo|             |                |         |
