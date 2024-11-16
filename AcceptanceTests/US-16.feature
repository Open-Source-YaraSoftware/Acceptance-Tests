Feature: Gestión de actividades como asistente de intervención

  Como mecánico asistente
  Quiero poder visualizar mis actividades pendientes
  Para poder hacer seguimiento del trabajo que queda por hacer en mis vehículos

  Scenario: Visualización de intervenciones como asistente
    Given que soy asistente en las siguientes intervenciones pendientes:
      | Cliente        | Vehículo   | Fecha       | Modalidad  | Líder          |
      | Carlos García  | ABC-1234   | 01/09/2023  | Urgente    | Juan Pérez     |
      | Ana Torres     | XYZ-5678   | 15/08/2023  | Estándar   | María López    |
    When accedo a la sección "Mis Actividades" en la aplicación
    Then el sistema muestra una lista de intervenciones donde soy asistente con los siguientes detalles:
      | Cliente        | Vehículo   | Fecha       | Modalidad  | Líder          |
      | Carlos García  | ABC-1234   | 01/09/2023  | Urgente    | Juan Pérez     |
      | Ana Torres     | XYZ-5678   | 15/08/2023  | Estándar   | María López    |
    And cada intervención muestra una etiqueta "Asistente"

  Scenario: Acceso a más información de intervención como asistente
    Given que soy asistente de la intervención "Carlos García - ABC-1234"
    When hago clic en el botón "Más información" de la intervención "Carlos García - ABC-1234"
    Then el sistema muestra los detalles de la intervención con las siguientes secciones:
      | Sección   |
      | Información|
      | Ejecución |
    And cada sección contiene la información correspondiente:
      | Sección   | Contenido                                     |
      | Información| Detalles del cliente, vehículo, fecha, líder   |
      | Ejecución  | Tareas asignadas y estado de ejecución          |

  Scenario: Actualizar el estado de una tarea como asistente
    Given que soy asistente de la intervención "Carlos García - ABC-1234"
    And la intervención tiene las siguientes tareas pendientes:
      | Tarea             | Descripción                      | Estado    |
      | Cambio de aceite  | Reemplazo de aceite sintético    | Pendiente |
      | Revisión de frenos| Inspección y ajuste de frenos     | Pendiente |
    When marco la tarea "Cambio de aceite" como "Completada"
    Then el sistema actualiza el estado de la tarea "Cambio de aceite" a "Completada"
    And muestra un mensaje "Tarea actualizada correctamente"
    And el estado de la intervención refleja las tareas completadas

  Scenario Outline: Filtrar intervenciones por cliente o modalidad
    Given que soy asistente en las siguientes intervenciones pendientes:
      | Cliente        | Vehículo   | Fecha       | Modalidad  | Líder          |
      | Carlos García  | ABC-1234   | 01/09/2023  | Urgente    | Juan Pérez     |
      | Ana Torres     | XYZ-5678   | 15/08/2023  | Estándar   | María López    |
      | Luis Mendoza   | LMN-9012   | 20/09/2023  | Urgente    | Carlos Gómez   |
    When aplico el filtro por "<Filtro>" en la sección "Mis Actividades"
    Then el sistema muestra solo las intervenciones que coinciden con "<Filtro>":
      | Cliente        | Vehículo   | Fecha       | Modalidad  | Líder          |
      | <Cliente1>     | <Vehículo1>| <Fecha1>    | <Modalidad1>| <Líder1>       |
      | <Cliente2>     | <Vehículo2>| <Fecha2>    | <Modalidad2>| <Líder2>       |

    Examples:
      | Filtro    | Cliente1        | Vehículo1 | Fecha1      | Modalidad1 | Líder1      | Cliente2      | Vehículo2 | Fecha2      | Modalidad2 | Líder2      |
      | Urgente   | Carlos García   | ABC-1234  | 01/09/2023  | Urgente    | Juan Pérez  | Luis Mendoza  | LMN-9012  | 20/09/2023  | Urgente    | Carlos Gómez|
      | Estándar  | Ana Torres      | XYZ-5678  | 15/08/2023  | Estándar   | María López |               |           |             |            |             |

  Scenario: Responsividad de la interfaz en dispositivos móviles al visualizar actividades
    Given que estoy utilizando un dispositivo móvil
    When accedo a la sección "Mis Actividades"
    Then el sistema adapta la interfaz al tamaño de la pantalla del dispositivo
    And todas las intervenciones son legibles sin necesidad de desplazamiento horizontal
    And puedo acceder a las secciones de "Más información" y actualizar tareas fácilmente mediante gestos táctiles

  Scenario: Notificación al asignar una nueva tarea
    Given que soy líder de la intervención "Carlos García - ABC-1234"
    When asigno la tarea "Revisión de frenos" a "María López"
    Then el sistema actualiza la tarea "Revisión de frenos" con el mecánico asignado "María López"
    And "María López" recibe una notificación "Has sido asignada a la tarea 'Revisión de frenos' en la intervención 'Carlos García - ABC-1234'."

  Scenario: Acceso a intervención no existente como asistente
    Given que no existe una intervención con ID "9999"
    When intento acceder a los detalles de la intervención "9999" en "Mis Actividades"
    Then el sistema muestra un mensaje de error "Intervención no encontrada"
    And redirige a la sección "Mis Actividades"

  Scenario: Manejo de múltiples intervenciones como asistente
    Given que soy asistente de las siguientes intervenciones pendientes:
      | Cliente        | Vehículo   | Fecha       | Modalidad  | Líder          |
      | Carlos García  | ABC-1234   | 01/09/2023  | Urgente    | Juan Pérez     |
      | Ana Torres     | XYZ-5678   | 15/08/2023  | Estándar   | María López    |
      | Luis Mendoza   | LMN-9012   | 20/09/2023  | Urgente    | Carlos Gómez   |
    When accedo a la sección "Mis Actividades"
    Then el sistema muestra todas las intervenciones donde soy asistente con los detalles correspondientes
    And puedo asignar o actualizar tareas para cada intervención individualmente

  Scenario: Validación al asignar una tarea como asistente
    Given que soy asistente de la intervención "Carlos García - ABC-1234"
    And la intervención tiene las siguientes tareas pendientes:
      | Tarea             | Descripción                      | Estado    |
      | Cambio de aceite  | Reemplazo de aceite sintético    | Pendiente |
      | Revisión de frenos| Inspección y ajuste de frenos     | Pendiente |
    When intento asignar la tarea "Cambio de aceite" sin seleccionar un mecánico
    Then el sistema muestra un mensaje de error "Debe asignar un mecánico para la tarea."
    And la tarea "Cambio de aceite" permanece en estado "Pendiente"

  Scenario: Deshacer asignación de una tarea como asistente
    Given que soy asistente de la intervención "Carlos García - ABC-1234"
    And he asignado la tarea "Cambio de aceite" a "Luis Mendoza"
    When deshago la asignación de la tarea "Cambio de aceite"
    Then el sistema revierte la tarea "Cambio de aceite" a estado "Pendiente"
    And "Luis Mendoza" ya no está asignado a la tarea "Cambio de aceite"

  Scenario: Notificación al actualizar el estado de una tarea
    Given que soy asistente de la intervención "Carlos García - ABC-1234"
    And he marcado la tarea "Cambio de aceite" como "Completada"
    When guardo los cambios
    Then el sistema actualiza el estado de la tarea "Cambio de aceite" a "Completada"
    And el líder "Juan Pérez" recibe una notificación "La tarea 'Cambio de aceite' ha sido completada por ti."

  Scenario: Acceso a tareas desde diferentes intervenciones
    Given que soy asistente de las siguientes intervenciones pendientes:
      | Cliente        | Vehículo   | Fecha       | Modalidad  | Líder          |
      | Carlos García  | ABC-1234   | 01/09/2023  | Urgente    | Juan Pérez     |
      | Ana Torres     | XYZ-5678   | 15/08/2023  | Estándar   | María López    |
    When accedo a la sección "Mis Actividades"
    Then el sistema muestra todas las intervenciones donde soy asistente con sus respectivas tareas
      | Intervención              | Tarea             | Descripción                      | Estado    |
      | Carlos García - ABC-1234  | Cambio de aceite  | Reemplazo de aceite sintético    | Pendiente |
      | Carlos García - ABC-1234  | Revisión de frenos| Inspección y ajuste de frenos     | Pendiente |
      | Ana Torres - XYZ-5678      | Inspección general| Revisión completa del vehículo    | Pendiente |

