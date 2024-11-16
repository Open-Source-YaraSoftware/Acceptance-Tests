Feature: Navegación dinámica por rol

  Como usuario
  Quiero tener a disposición los beneficios que me ofrece la aplicación web
  Para sacarles provecho rápidamente

  Background:
    Given que el sistema tiene los siguientes roles definidos:
      | Rol               | Descripción                                    |
      | Dueño de taller   | Acceso a gestión de inventario, métricas y clientes |
      | Cliente           | Acceso a mis vehículos y mis notificaciones     |
      | Mecánico          | Acceso a mis actividades                         |

  Scenario Outline: Redirección a secciones basadas en el rol del usuario
    Given que el usuario se encuentra en la pantalla de login
    And ha completado todos los campos requeridos con datos válidos
    When el usuario ordena "Agendar"
    And el sistema valida su rol "<rol>"
    Then el sistema carga la información de su cuenta
    And carga las siguientes secciones correspondientes a su cuenta en la pantalla principal:
      | Sección              |
      | <seccion1>           |
      | <seccion2>           |
      | <seccion3>           |

    Examples:
      | rol               | seccion1    | seccion2 | seccion3 |
      | "dueño de taller" | "Inventario"| "Métricas" | "Clientes" |
      | "cliente"         | "Mis vehículos" | "Mis notificaciones" |          |
      | "mecánico"        | "Mis actividades" |          |          |

  Scenario: Redirección con rol inválido
    Given que el usuario se encuentra en la pantalla de login
    And ha completado todos los campos requeridos con datos válidos
    When el usuario ordena "Agendar"
    And el sistema valida su rol "administrador"
    Then el sistema muestra un mensaje de error "Rol de usuario inválido."
    And redirige al usuario a la pantalla de login

  Scenario: Usuario sin secciones asignadas
    Given que el usuario se encuentra en la pantalla de login
    And ha completado todos los campos requeridos con datos válidos
    When el usuario ordena "Agendar"
    And el sistema valida su rol "interno"
    Then el sistema muestra un mensaje de error "No se han asignado secciones a este rol."
    And redirige al usuario a la pantalla de login

  Scenario: Responsividad en dispositivos móviles durante redirección por rol
    Given que el usuario está utilizando un dispositivo móvil
    And el usuario se encuentra en la pantalla de login
    And ha completado todos los campos requeridos con datos válidos
    When el usuario ordena "Agendar"
    And el sistema valida su rol "dueño de taller"
    Then el sistema adapta la interfaz al tamaño de la pantalla del dispositivo
    And carga las secciones "Inventario", "Métricas" y "Clientes" sin necesidad de desplazamiento horizontal
    And el usuario puede navegar entre las secciones fácilmente mediante gestos táctiles

  Scenario: Acceso a secciones específicas después de redirección
    Given que el usuario ha iniciado sesión como "dueño de taller"
    When accede a la sección "Inventario" desde la pantalla principal
    Then el sistema muestra la interfaz de "Inventario" con todas las funcionalidades correspondientes
    And el usuario puede gestionar el inventario de manera eficiente

    When accede a la sección "Métricas" desde la pantalla principal
    Then el sistema muestra la interfaz de "Métricas" con gráficos y reportes detallados

    When accede a la sección "Clientes" desde la pantalla principal
    Then el sistema muestra la lista de clientes y sus detalles

  Scenario: Verificación de permisos por rol
    Given que el usuario ha iniciado sesión como "cliente"
    When intenta acceder a la sección "Inventario"
    Then el sistema deniega el acceso
    And muestra un mensaje "No tienes permisos para acceder a esta sección."

    When intenta acceder a la sección "Mis vehículos"
    Then el sistema permite el acceso y muestra la información correspondiente

  Scenario: Cambio de rol y actualización de secciones
    Given que el usuario ha iniciado sesión como "cliente"
    And el administrador cambia su rol a "dueño de taller"
    When el usuario recarga la página principal
    Then el sistema actualiza las secciones disponibles a "Inventario", "Métricas" y "Clientes"
    And el usuario puede acceder a estas nuevas secciones desde la pantalla principal

  Scenario: Notificación de actualización de secciones tras cambio de rol
    Given que el usuario ha iniciado sesión como "cliente"
    And el administrador cambia su rol a "mecánico"
    When el usuario recarga la página principal
    Then el sistema actualiza las secciones disponibles a "Mis actividades"
    And muestra una notificación "Tu rol ha sido actualizado a Mecánico. Ahora tienes acceso a 'Mis actividades'."

  Scenario: Redirección fallida debido a error del sistema
    Given que el usuario se encuentra en la pantalla de login
    And ha completado todos los campos requeridos con datos válidos
    When el usuario ordena "Agendar"
    And el sistema encuentra un error al validar el rol
    Then el sistema muestra un mensaje de error "Error al procesar tu solicitud. Por favor, intenta nuevamente."
    And redirige al usuario a la pantalla de login

