Feature: Visualización y gestión de clientes

  Como dueño de taller
  Quiero visualizar mi lista de clientes
  Para saber quiénes son mis clientes

  Scenario: Visualización de lista de clientes
    Given que tengo al menos un cliente registrado
    When accedo a la sección "Clientes" en la aplicación
    Then el sistema muestra la lista de clientes con su información básica:
      | Nombre        | Contacto   | Estado   |
      | Ana García    | 555-1234   | Activo   |
      | Luis Pérez    | 555-5678   | Activo   |

  Scenario Outline: Filtrado de clientes por nombre
    Given que tengo los siguientes clientes registrados:
      | Nombre        | Contacto   | Estado   |
      | Ana García    | 555-1234   | Activo   |
      | Luis Pérez    | 555-5678   | Activo   |
      | Carlos López  | 555-9012   | Inactivo |
    And me encuentro en la sección "Clientes"
    When ingreso "<TextoBusqueda>" en el campo de búsqueda
    Then el sistema muestra los clientes cuyos nombres contienen "<TextoBusqueda>":
      | Nombre        | Contacto   | Estado    |
      | <Nombre1>     | <Contacto1>| <Estado1> |
      | <Nombre2>     | <Contacto2>| <Estado2> |

    Examples:
      | TextoBusqueda | Nombre1      | Contacto1 | Estado1 | Nombre2     | Contacto2 | Estado2 |
      | Ana           | Ana García   | 555-1234  | Activo  |             |           |         |
      | Luis          | Luis Pérez   | 555-5678  | Activo  |             |           |         |
      | o             | Carlos López | 555-9012  | Inactivo| Ana García  | 555-1234  | Activo  |
      |               |              |           |         |             |           |         |

  Scenario Outline: Filtrado de clientes por estado
    Given que tengo los siguientes clientes registrados:
      | Nombre        | Contacto   | Estado   |
      | Ana García    | 555-1234   | Activo   |
      | Luis Pérez    | 555-5678   | Activo   |
      | Carlos López  | 555-9012   | Inactivo |
    And me encuentro en la sección "Clientes"
    When selecciono el filtro por estado "<EstadoSeleccionado>"
    Then el sistema muestra los clientes con estado "<EstadoSeleccionado>":
      | Nombre        | Contacto   | Estado    |
      | <Nombre1>     | <Contacto1>| <Estado1> |
      | <Nombre2>     | <Contacto2>| <Estado2> |

    Examples:
      | EstadoSeleccionado | Nombre1      | Contacto1 | Estado1 | Nombre2     | Contacto2 | Estado2 |
      | Activo             | Ana García   | 555-1234  | Activo  | Luis Pérez  | 555-5678  | Activo  |
      | Inactivo           | Carlos López | 555-9012  | Inactivo|             |           |         |

  Scenario: Responsividad en dispositivos móviles
    Given que accedo a la sección "Clientes" desde un dispositivo móvil
    When visualizo la lista de clientes
    Then el contenido se adapta correctamente a la pantalla sin necesidad de desplazamiento horizontal o zoom manual
    And puedo realizar búsquedas y filtrados de manera eficiente

  Scenario: Lista de clientes vacía
    Given que no tengo clientes registrados en el sistema
    When accedo a la sección "Clientes" en la aplicación
    Then el sistema muestra un mensaje indicando "No hay clientes registrados"
    And muestra una opción destacada para "Registrar Cliente"

  Scenario: Navegación en la lista de clientes
    Given que tengo más de 20 clientes registrados
    When me encuentro en la sección "Clientes"
    Then puedo navegar entre páginas o utilizar scroll para ver todos los clientes
    And la interfaz es fluida y fácil de usar

  Scenario: Ordenamiento de la lista de clientes
    Given que me encuentro en la sección "Clientes"
    When ordeno la lista por "<CriterioOrdenamiento>"
    Then el sistema muestra los clientes ordenados por "<CriterioOrdenamiento>"

    Examples:
      | CriterioOrdenamiento |
      | Nombre               |
      | Estado               |
      | Fecha de Registro    |
