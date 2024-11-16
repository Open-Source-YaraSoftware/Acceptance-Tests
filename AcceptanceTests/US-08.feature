Feature: Visualización y gestión de intervenciones

  Como dueño de taller
  Quiero visualizar las intervenciones
  Para controlar los servicios realizados y pendientes en el taller

  Scenario: Visualización de lista de intervenciones
    Given que tengo las siguientes intervenciones registradas:
      | Cliente        | Vehículo   | Estado     | Fecha       | Mecánico       |
      | Carlos García  | ABC-1234   | Pendiente  | 01/09/2023  | Juan Pérez     |
      | Ana Torres     | XYZ-5678   | Finalizado | 15/08/2023  | María López    |
    When accedo a la sección "Intervenciones" en la aplicación
    Then el sistema muestra una lista de todas las intervenciones con su información más relevante:
      | Cliente        | Vehículo   | Estado     | Fecha       | Mecánico       |
      | Carlos García  | ABC-1234   | Pendiente  | 01/09/2023  | Juan Pérez     |
      | Ana Torres     | XYZ-5678   | Finalizado | 15/08/2023  | María López    |

  Scenario Outline: Filtrado de intervenciones por texto
    Given que tengo las siguientes intervenciones registradas:
      | Cliente        | Vehículo   | Estado     | Fecha       | Mecánico       |
      | Carlos García  | ABC-1234   | Pendiente  | 01/09/2023  | Juan Pérez     |
      | Ana Torres     | XYZ-5678   | Finalizado | 15/08/2023  | María López    |
      | Luis Mendoza   | LMN-9012   | En Progreso| 20/09/2023  | Carlos Gómez   |
    And me encuentro en la sección "Intervenciones"
    When ingreso "<TextoBusqueda>" en el campo de búsqueda
    Then el sistema muestra las intervenciones que coinciden con "<TextoBusqueda>":
      | Cliente        | Vehículo   | Estado     | Fecha       | Mecánico       |
      | <Cliente1>     | <Vehículo1>| <Estado1>  | <Fecha1>    | <Mecánico1>    |
      | <Cliente2>     | <Vehículo2>| <Estado2>  | <Fecha2>    | <Mecánico2>    |

    Examples:
      | TextoBusqueda | Cliente1        | Vehículo1 | Estado1    | Fecha1      | Mecánico1    | Cliente2      | Vehículo2 | Estado2   | Fecha2      | Mecánico2    |
      | Carlos        | Carlos García   | ABC-1234  | Pendiente  | 01/09/2023 | Juan Pérez    |               |           |           |             |              |
      | Ana           | Ana Torres      | XYZ-5678  | Finalizado | 15/08/2023 | María López   |               |           |           |             |              |
      | LMN           | Luis Mendoza    | LMN-9012  | En Progreso| 20/09/2023 | Carlos Gómez  |               |           |           |             |              |
      | Pérez         | Carlos García   | ABC-1234  | Pendiente  | 01/09/2023 | Juan Pérez    |               |           |           |             |              |

  Scenario Outline: Filtrado de intervenciones por estado
    Given que tengo las siguientes intervenciones registradas:
      | Cliente        | Vehículo   | Estado       | Fecha       | Mecánico       |
      | Carlos García  | ABC-1234   | Pendiente    | 01/09/2023  | Juan Pérez     |
      | Ana Torres     | XYZ-5678   | Finalizado   | 15/08/2023  | María López    |
      | Luis Mendoza   | LMN-9012   | En Progreso  | 20/09/2023  | Carlos Gómez   |
      | Sofia Ramirez  | QRS-3456   | Pendiente    | 05/10/2023  | Laura Martínez |
    And me encuentro en la sección "Intervenciones"
    When selecciono el filtro por estado "<EstadoSeleccionado>"
    Then el sistema muestra las intervenciones con estado "<EstadoSeleccionado>":
      | Cliente        | Vehículo   | Estado       | Fecha       | Mecánico       |
      | <Cliente1>     | <Vehículo1>| <EstadoSeleccionado> | <Fecha1>    | <Mecánico1>    |
      | <Cliente2>     | <Vehículo2>| <EstadoSeleccionado> | <Fecha2>    | <Mecánico2>    |

    Examples:
      | EstadoSeleccionado | Cliente1        | Vehículo1 | Fecha1      | Mecánico1     | Cliente2        | Vehículo2 | Fecha2      | Mecánico2       |
      | Pendiente           | Carlos García   | ABC-1234  | 01/09/2023 | Juan Pérez     | Sofia Ramirez    | QRS-3456  | 05/10/2023 | Laura Martínez   |
      | Finalizado          | Ana Torres      | XYZ-5678  | 15/08/2023 | María López    |                 |           |             |                  |
      | En Progreso         | Luis Mendoza    | LMN-9012  | 20/09/2023 | Carlos Gómez   |                 |           |             |                  |

  Scenario: Ordenamiento de intervenciones por fecha
    Given que tengo las siguientes intervenciones registradas:
      | Cliente        | Vehículo   | Estado     | Fecha       | Mecánico       |
      | Carlos García  | ABC-1234   | Pendiente  | 01/09/2023  | Juan Pérez     |
      | Ana Torres     | XYZ-5678   | Finalizado | 15/08/2023  | María López    |
      | Luis Mendoza   | LMN-9012   | En Progreso| 20/09/2023  | Carlos Gómez   |
    And me encuentro en la sección "Intervenciones"
    When ordeno las intervenciones por "Fecha" en orden ascendente
    Then el sistema muestra las intervenciones ordenadas por fecha de más antigua a más reciente:
      | Cliente        | Vehículo   | Estado     | Fecha       | Mecánico       |
      | Ana Torres     | XYZ-5678   | Finalizado | 15/08/2023  | María López    |
      | Carlos García  | ABC-1234   | Pendiente  | 01/09/2023  | Juan Pérez     |
      | Luis Mendoza   | LMN-9012   | En Progreso| 20/09/2023  | Carlos Gómez   |

  Scenario: Ordenamiento de intervenciones por estado
    Given que tengo las siguientes intervenciones registradas:
      | Cliente        | Vehículo   | Estado       | Fecha       | Mecánico       |
      | Carlos García  | ABC-1234   | Pendiente    | 01/09/2023  | Juan Pérez     |
      | Ana Torres     | XYZ-5678   | Finalizado   | 15/08/2023  | María López    |
      | Luis Mendoza   | LMN-9012   | En Progreso  | 20/09/2023  | Carlos Gómez   |
      | Sofia Ramirez  | QRS-3456   | Pendiente    | 05/10/2023  | Laura Martínez |
    And me encuentro en la sección "Intervenciones"
    When ordeno las intervenciones por "Estado" en orden descendente
    Then el sistema muestra las intervenciones ordenadas por estado de la siguiente manera:
      | Cliente        | Vehículo   | Estado       | Fecha       | Mecánico       |
      | Ana Torres     | XYZ-5678   | Finalizado   | 15/08/2023  | María López    |
      | Luis Mendoza   | LMN-9012   | En Progreso  | 20/09/2023  | Carlos Gómez   |
      | Carlos García  | ABC-1234   | Pendiente    | 01/09/2023  | Juan Pérez     |
      | Sofia Ramirez  | QRS-3456   | Pendiente    | 05/10/2023  | Laura Martínez |
