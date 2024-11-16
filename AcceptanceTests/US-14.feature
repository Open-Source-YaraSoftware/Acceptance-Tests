Feature: Recepción y manejo de notificaciones

  Como usuario
  Quiero recibir notificaciones
  Para estar al tanto y llevar un registro de eventos importantes de la aplicación

  Scenario: Visualización de notificaciones
    Given que tengo las siguientes notificaciones:
      | Fecha y Hora       | Nombre                 | Vínculo Relacionado        |
      | 25/04/2024 10:00   | Solicitud Aprobada     | /intervenciones/123        |
      | 26/04/2024 14:30   | Nuevo Vehículo Añadido | /vehiculos/456             |
    When accedo a la sección "Notificaciones" en la aplicación
    Then el sistema muestra una lista de mis notificaciones con los siguientes detalles:
      | Fecha y Hora       | Nombre                 | Vínculo Relacionado        |
      | 25/04/2024 10:00   | Solicitud Aprobada     | /intervenciones/123        |
      | 26/04/2024 14:30   | Nuevo Vehículo Añadido | /vehiculos/456             |
    And cada notificación muestra un indicador si está leída o no

  Scenario Outline: Filtrado de notificaciones por tipo
    Given que tengo las siguientes notificaciones:
      | Fecha y Hora       | Nombre                 | Vínculo Relacionado        | Tipo          |
      | 25/04/2024 10:00   | Solicitud Aprobada     | /intervenciones/123        | Intervención  |
      | 26/04/2024 14:30   | Nuevo Vehículo Añadido | /vehiculos/456             | Vehículo      |
      | 27/04/2024 09:15   | Mantenimiento Programado | /mantenimientos/789      | Mantenimiento |
    And me encuentro en la sección "Notificaciones"
    When selecciono el filtro por tipo "<TipoFiltro>"
    Then el sistema muestra solo las notificaciones del tipo "<TipoFiltro>":
      | Fecha y Hora       | Nombre                     | Vínculo Relacionado        | Tipo          |
      | <Fecha1>           | <Nombre1>                  | <Vínculo1>                 | <TipoFiltro>  |
      | <Fecha2>           | <Nombre2>                  | <Vínculo2>                 | <TipoFiltro>  |

    Examples:
      | TipoFiltro    | Fecha1          | Nombre1               | Vínculo1           | Fecha2          | Nombre2               | Vínculo2           |
      | Intervención  | 25/04/2024 10:00| Solicitud Aprobada    | /intervenciones/123|                 |                       |                    |
      | Vehículo      | 26/04/2024 14:30| Nuevo Vehículo Añadido| /vehiculos/456     |                 |                       |                    |
      | Mantenimiento | 27/04/2024 09:15| Mantenimiento Programado | /mantenimientos/789 |             |                       |                    |

  Scenario: Navegar al vínculo relacionado desde una notificación
    Given que tengo una notificación con el siguiente detalle:
      | Fecha y Hora     | Nombre               | Vínculo Relacionado   |
      | 25/04/2024 10:00 | Solicitud Aprobada   | /intervenciones/123   |
    And me encuentro en la sección "Notificaciones"
    When hago clic en el vínculo relacionado de la notificación "Solicitud Aprobada"
    Then el sistema redirige a "/intervenciones/123"
    And la página de detalles de la intervención "123" se carga correctamente

  Scenario: Marcar una notificación como leída
    Given que tengo una notificación no leída:
      | Fecha y Hora       | Nombre               | Vínculo Relacionado    | Estado |
      | 26/04/2024 14:30   | Nuevo Vehículo Añadido | /vehiculos/456         | No Leída |
    And me encuentro en la sección "Notificaciones"
    When hago clic en la notificación "Nuevo Vehículo Añadido"
    Then el sistema marca la notificación como "Leída"
    And actualiza el indicador de notificaciones no leídas

  Scenario: Eliminar una notificación
    Given que tengo una notificación:
      | Fecha y Hora       | Nombre               | Vínculo Relacionado    |
      | 27/04/2024 09:15   | Mantenimiento Programado | /mantenimientos/789  |
    And me encuentro en la sección "Notificaciones"
    When hago clic en el botón "Eliminar" de la notificación "Mantenimiento Programado"
    And confirmo la eliminación
    Then el sistema elimina la notificación de la lista
    And muestra un mensaje "Notificación eliminada correctamente"

  Scenario: Contador de notificaciones no leídas
    Given que tengo las siguientes notificaciones:
      | Fecha y Hora       | Nombre               | Vínculo Relacionado    | Estado   |
      | 25/04/2024 10:00   | Solicitud Aprobada   | /intervenciones/123    | No Leída |
      | 26/04/2024 14:30   | Nuevo Vehículo Añadido | /vehiculos/456       | Leída    |
      | 27/04/2024 09:15   | Mantenimiento Programado | /mantenimientos/789 | No Leída |
    When accedo a la sección "Notificaciones"
    Then el sistema muestra el contador de notificaciones no leídas como "2"

  Scenario: Responsividad de la interfaz de notificaciones en dispositivos móviles
    Given que estoy utilizando un dispositivo móvil
    When accedo a la sección "Notificaciones"
    Then el sistema adapta la interfaz al tamaño de la pantalla del dispositivo
    And todas las notificaciones son legibles sin necesidad de desplazamiento horizontal
    And puedo interactuar con los botones y vínculos fácilmente mediante gestos táctiles

  Scenario: Notificación de nueva solicitud de intervención
    Given que un mecánico ha creado una nueva solicitud de intervención
    When se genera la solicitud de intervención "Cambio de frenos" por "Juan Pérez"
    Then el sistema envía una notificación al dueño de taller con el siguiente detalle:
      | Fecha y Hora       | Nombre                 | Vínculo Relacionado        |
      | 28/04/2024 11:00   | Nueva Solicitud         | /intervenciones/124        |
    And la notificación aparece en la lista de notificaciones

  Scenario: Notificación de baja en inventario
    Given que el stock de "Filtro de aire" ha bajado por debajo del límite establecido
    When el sistema detecta el stock bajo de "Filtro de aire"
    Then el sistema genera una notificación con el siguiente detalle:
      | Fecha y Hora       | Nombre                             | Vínculo Relacionado        |
      | 28/04/2024 12:00   | Stock Bajo de "Filtro de aire"      | /inventario/filtro-aire    |
    And la notificación aparece en la lista de notificaciones
