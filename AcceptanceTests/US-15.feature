Feature: Gestión de actividades como líder de intervención

  Como mecánico
  Quiero poder visualizar las intervenciones donde funjo como líder
  Para asignar tareas a mis compañeros

  Scenario: Visualización de intervenciones como líder
    Given que soy líder de las siguientes intervenciones pendientes:
      | Cliente        | Vehículo   | Fecha       | Modalidad  |
      | Carlos García  | ABC-1234   | 01/09/2023  | Urgente    |
      | Ana Torres     | XYZ-5678   | 15/08/2023  | Estándar   |
    When accedo a la sección "Mis Actividades" en la aplicación
    Then el sistema muestra una lista de intervenciones donde soy líder con los siguientes detalles:
      | Cliente        | Vehículo   | Fecha       | Modalidad  |
      | Carlos García  | ABC-1234   | 01/09/2023  | Urgente    |
      | Ana Torres     | XYZ-5678   | 15/08/2023  | Estándar   |
    And cada intervención muestra una etiqueta "Líder de Intervención"

  Scenario: Acceso a más información de intervención como líder
    Given que soy líder de la intervención "Carlos García - ABC-1234"
    When hago clic en el botón "Más información" de la intervención "Carlos García - ABC-1234"
    Then el sistema muestra los detalles de la intervención con las siguientes secciones:
      | Sección                    |
      | Información                |
      | Diagnóstico y Preparación  |
      | Supervisión                |
    And cada sección contiene la información correspondiente:
      | Sección                    | Contenido                                   |
      | Información                | Detalles del cliente, vehículo, fecha, etc. |
      | Diagnóstico y Preparación  | Diagnóstico realizado y preparación del vehículo |
      | Supervisión                | Tareas asignadas y estado de ejecución       |

  Scenario: Asignar tarea a un compañero como líder
    Given que soy líder de la intervención "Carlos García - ABC-1234"
    And la intervención tiene las siguientes tareas pendientes:
      | Tarea             | Descripción                      | Estado    |
      | Cambio de aceite  | Reemplazo de aceite sintético    | Pendiente |
      | Revisión de frenos| Inspección y ajuste de frenos     | Pendiente |
    When asigno la tarea "Cambio de aceite" a "Luis Mendoza"
    Then el sistema actualiza la tarea "Cambio de aceite" con el mecánico asignado "Luis Mendoza"
    And "Luis Mendoza" recibe una notificación de asignación de tarea

  Scenario Outline: Filtrar intervenciones por fecha o modalidad
    Given que soy líder de las siguientes intervenciones pendientes:
      | Cliente        | Vehículo   | Fecha       | Modalidad  |
      | Carlos García  | ABC-1234   | 01/09/2023  | Urgente    |
      | Ana Torres     | XYZ-5678   | 15/08/2023  | Estándar   |
      | Luis Mendoza   | LMN-9012   | 20/09/2023  | Urgente    |
    When aplico el filtro por "<Filtro>" en la sección "Mis Actividades"
    Then el sistema muestra solo las intervenciones que coinciden con "<Filtro>":
      | Cliente        | Vehículo   | Fecha       | Modalidad  |
      | <Cliente1>     | <Vehículo1>| <Fecha1>    | <Modalidad1>|
      | <Cliente2>     | <Vehículo2>| <Fecha2>    | <Modalidad2>|

    Examples:
      | Filtro   | Cliente1        | Vehículo1 | Fecha1      | Modalidad1 | Cliente2      | Vehículo2 | Fecha2      | Modalidad2 |
      | Urgente  | Carlos García   | ABC-1234  | 01/09/2023  | Urgente    | Luis Mendoza  | LMN-9012  | 20/09/2023  | Urgente    |
      | Estándar | Ana Torres      | XYZ-5678  | 15/08/2023  | Estándar   |               |           |             |            |

  Scenario: Responsividad en dispositivos móviles al visualizar actividades como líder
    Given que estoy utilizando un dispositivo móvil
    When accedo a la sección "Mis Actividades"
    Then el sistema adapta la interfaz al tamaño de la pantalla del dispositivo
    And puedo ver todas las intervenciones donde soy líder sin necesidad de desplazamiento horizontal
    And puedo acceder a las secciones de "Más información" y asignar tareas fácilmente mediante gestos táctiles

  Scenario: Validación al asignar una tarea
    Given que soy líder de la intervención "Carlos García - ABC-1234"
    And la intervención tiene las siguientes tareas pendientes:
      | Tarea             | Descripción                      | Estado    |
      | Cambio de aceite  | Reemplazo de aceite sintético    | Pendiente |
      | Revisión de frenos| Inspección y ajuste de frenos     | Pendiente |
    When intento asignar la tarea "Cambio de aceite" sin seleccionar un mecánico
    Then el sistema muestra un mensaje de error "Debe asignar un mecánico para la tarea."
    And la tarea "Cambio de aceite" permanece en estado "Pendiente"

  Scenario: Deshacer asignación de una tarea
    Given que soy líder de la intervención "Carlos García - ABC-1234"
    And he asignado la tarea "Cambio de aceite" a "Luis Mendoza"
    When deshago la asignación de la tarea "Cambio de aceite"
    Then el sistema revierte la tarea "Cambio de aceite" a estado "Pendiente"
    And "Luis Mendoza" ya no está asignado a la tarea "Cambio de aceite"

  Scenario: Notificación al asignar una tarea
    Given que soy líder de la intervención "Carlos García - ABC-1234"
    And la intervención tiene la tarea "Revisión de frenos" en estado "Pendiente"
    When asigno la tarea "Revisión de frenos" a "María López"
    Then el sistema actualiza la tarea "Revisión de frenos" con el mecánico asignado "María López"
    And "María López" recibe una notificación "Has sido asignado a la tarea 'Revisión de frenos' en la intervención 'Carlos García - ABC-1234'."

  Scenario: Acceso a intervención no existente como líder
    Given que no existe una intervención con ID "9999"
    When intento acceder a los detalles de la intervención "9999" en "Mis Actividades"
    Then el sistema muestra un mensaje de error "Intervención no encontrada"
    And redirige a la sección "Mis Actividades"

  Scenario: Manejo de múltiples intervenciones como líder
    Given que soy líder de las siguientes intervenciones pendientes:
      | Cliente        | Vehículo   | Fecha       | Modalidad  |
      | Carlos García  | ABC-1234   | 01/09/2023  | Urgente    |
      | Ana Torres     | XYZ-5678   | 15/08/2023  | Estándar   |
      | Luis Mendoza   | LMN-9012   | 20/09/2023  | Urgente    |
    When accedo a la sección "Mis Actividades"
    Then el sistema muestra todas las intervenciones donde soy líder con los detalles correspondientes
    And puedo asignar tareas a los mecánicos para cada intervención individualmente
