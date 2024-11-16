Feature: Gestión de existencias de inventario

  Como dueño de taller
  Quiero poder manejar existencias en mi inventario
  Para asegurar que siempre haya disponibilidad de piezas y materiales necesarios para las intervenciones eficientemente

  Scenario: Visualización de existencias en el inventario
    Given que tengo las siguientes entradas en el inventario:
      | Nombre           | Cantidad | Límite | Descripción                    |
      | Aceite 10W-40    | 50       | 20     | Aceite sintético de motor       |
      | Filtro de aire   | 30       | 10     | Filtro de aire para vehículos    |
      | Pastillas de freno| 40      | 15     | Pastillas de freno estándar      |
    When accedo a la sección "Inventario" en la aplicación
    Then el sistema muestra una lista de existencias con los siguientes detalles:
      | Nombre           | Cantidad | Límite | Descripción                    |
      | Aceite 10W-40    | 50       | 20     | Aceite sintético de motor       |
      | Filtro de aire   | 30       | 10     | Filtro de aire para vehículos    |
      | Pastillas de freno| 40      | 15     | Pastillas de freno estándar      |
    And cada entrada muestra un indicador de nivel de stock:
      | Nivel de Stock | Indicador                  |
      | Alto           | Verde                       |
      | Medio          | Amarillo                    |
      | Bajo           | Rojo                        |

  Scenario: Añadir una nueva entrada al inventario
    Given que estoy en la sección "Inventario"
    When hago clic en el botón "Añadir entrada"
    Then el sistema muestra un formulario para crear una nueva entrada de inventario con los siguientes campos:
      | Campo        | Tipo de Entrada    | Validación                  |
      | Nombre       | Texto              | Obligatorio, único          |
      | Cantidad     | Número              | Obligatorio, mayor que 0    |
      | Límite       | Número              | Obligatorio, mayor que 0    |
      | Descripción  | Texto              | Opcional                    |
    And el botón "Crear" está deshabilitado hasta que se completen los campos obligatorios

  Scenario Outline: Registro exitoso de una nueva entrada de inventario
    Given que estoy en el formulario de "Añadir entrada" en la sección "Inventario"
    And he ingresado "<Nombre>" en el campo "Nombre"
    And he ingresado "<Cantidad>" en el campo "Cantidad"
    And he ingresado "<Límite>" en el campo "Límite"
    And he ingresado "<Descripción>" en el campo "Descripción"
    When hago clic en el botón "Crear"
    Then el sistema añade la nueva entrada al inventario
    And muestra un mensaje "Entrada de inventario creada exitosamente"
    And la nueva entrada aparece en la lista de inventario con los detalles ingresados:
      | Nombre           | Cantidad | Límite | Descripción                    |
      | <Nombre>         | <Cantidad>| <Límite>| <Descripción>                  |

    Examples:
      | Nombre            | Cantidad | Límite | Descripción                        |
      | Lubricante XYZ    | 25       | 10     | Lubricante de alta resistencia       |
      | Bujías ABC        | 60       | 30     | Bujías estándar para motores modernos |

  Scenario Outline: Registro fallido de una nueva entrada de inventario por datos inválidos
    Given que estoy en el formulario de "Añadir entrada" en la sección "Inventario"
    And he ingresado "<Nombre>" en el campo "Nombre"
    And he ingresado "<Cantidad>" en el campo "Cantidad"
    And he ingresado "<Límite>" en el campo "Límite"
    When hago clic en el botón "Crear"
    Then el sistema no añade la nueva entrada al inventario
    And muestra un mensaje de error "<MensajeError>"
    And resalta los campos con errores

    Examples:
      | Nombre         | Cantidad | Límite | MensajeError                               |
      |                | 10       | 5      | "El campo Nombre es obligatorio."          |
      | Aceite 5W-30   | -5       | 10     | "El campo Cantidad debe ser mayor que 0."  |
      | Filtro de aceite| 20      | 0      | "El campo Límite debe ser mayor que 0."    |
      | Pastillas de freno| 15    | 10     | "El campo Cantidad debe ser mayor que 0."  |

  Scenario: Modificar una entrada existente en el inventario
    Given que tengo la siguiente entrada en el inventario:
      | Nombre         | Cantidad | Límite | Descripción                    |
      | Aceite 10W-40  | 50       | 20     | Aceite sintético de motor       |
    And estoy en la sección "Inventario"
    And selecciono la entrada "Aceite 10W-40"
    When hago clic en el botón "Modificar entrada"
    Then el sistema muestra un formulario de modificación con los siguientes campos prellenados:
      | Campo        | Valor                   |
      | Nombre       | Aceite 10W-40           |
      | Cantidad     | 50                      |
      | Límite       | 20                      |
      | Descripción  | Aceite sintético de motor |
    And puedo editar los campos "Cantidad" y "Límite"
    And el botón "Guardar cambios" y "Descartar cambios" están disponibles

  Scenario Outline: Guardar cambios en una entrada de inventario
    Given que estoy en el formulario de modificación de la entrada "<Nombre>"
    And he cambiado el campo "Cantidad" a "<NuevaCantidad>"
    And he cambiado el campo "Límite" a "<NuevoLímite>"
    When hago clic en el botón "Guardar cambios"
    Then el sistema actualiza la entrada con los nuevos valores:
      | Nombre         | Cantidad | Límite | Descripción                    |
      | <Nombre>       | <NuevaCantidad>| <NuevoLímite>| Aceite sintético de motor       |
    And muestra un mensaje "Cambios guardados correctamente"

    Examples:
      | Nombre         | NuevaCantidad | NuevoLímite |
      | Aceite 10W-40  | 60            | 25          |
      | Filtro de aire | 35            | 15          |

  Scenario: Descartar cambios en una entrada de inventario
    Given que estoy en el formulario de modificación de la entrada "Aceite 10W-40"
    And he cambiado el campo "Cantidad" a "60"
    When hago clic en el botón "Descartar cambios"
    Then el sistema no guarda los cambios realizados
    And vuelve a mostrar los detalles originales de la entrada "Aceite 10W-40"
      | Nombre         | Cantidad | Límite | Descripción                    |
      | Aceite 10W-40  | 50       | 20     | Aceite sintético de motor       |
    And muestra un mensaje "Cambios descartados"

  Scenario Outline: Deshacer cambios en el inventario
    Given que estoy en la sección "Inventario"
    And he realizado cambios en la entrada "<Nombre>"
    When hago clic en el botón "Deshacer"
    Then el sistema revierte los cambios realizados en la entrada "<Nombre>"
      | Nombre         | Cantidad | Límite | Descripción                    |
      | <Nombre>       | <CantidadOriginal>| <LímiteOriginal>| <DescripciónOriginal> |
    And muestra un mensaje "Cambios deshechos correctamente"

    Examples:
      | Nombre          | CantidadOriginal | LímiteOriginal | DescripciónOriginal         |
      | Aceite 10W-40   | 50                | 20              | Aceite sintético de motor     |
      | Filtro de aire  | 30                | 10              | Filtro de aire para vehículos  |

  Scenario Outline: Ordenamiento de entradas de inventario por campo
    Given que tengo las siguientes entradas en el inventario:
      | Nombre           | Cantidad | Límite | Descripción                    |
      | Aceite 10W-40    | 50       | 20     | Aceite sintético de motor       |
      | Filtro de aire   | 30       | 10     | Filtro de aire para vehículos    |
      | Pastillas de freno| 40      | 15     | Pastillas de freno estándar      |
      | Lubricante XYZ    | 25      | 10     | Lubricante de alta resistencia    |
    And me encuentro en la sección "Inventario"
    When ordeno las entradas por "<Campo>" en orden "<Orden>"
    Then el sistema muestra las entradas ordenadas por "<Campo>" en orden "<Orden>":
      | Nombre           | Cantidad | Límite | Descripción                    |
      | ...              | ...      | ...    | ...                              |

    Examples:
      | Campo    | Orden      |
      | Nombre   | Ascendente |
      | Nombre   | Descendente|
      | Cantidad | Ascendente |
      | Cantidad | Descendente|
      | Límite   | Ascendente |
      | Límite   | Descendente|

  Scenario: Responsividad en dispositivos móviles durante gestión de inventario
    Given que estoy utilizando un dispositivo móvil
    When accedo a la sección "Inventario"
    Then el sistema adapta la interfaz al tamaño de la pantalla del dispositivo
    And todas las columnas de la tabla de inventario son legibles sin desplazamiento horizontal
    And puedo interactuar con los botones "Añadir entrada", "Modificar entrada", "Guardar cambios" y "Deshacer" sin problemas de usabilidad

  Scenario: Validación de campos al añadir una nueva entrada
    Given que estoy en el formulario de "Añadir entrada" en la sección "Inventario"
    And he ingresado "<Nombre>" en el campo "Nombre"
    And he ingresado "<Cantidad>" en el campo "Cantidad"
    And he ingresado "<Límite>" en el campo "Límite"
    When hago clic en el botón "Crear"
    Then el sistema valida los campos ingresados
    And si hay campos inválidos, muestra mensajes de error específicos:
      | Campo      | Mensaje de Error                        |
      | <Campo>    | "<MensajeError>"                        |

    Examples:
      | Nombre         | Cantidad | Límite | Campo   | MensajeError                             |
      | Lubricante XYZ | -10      | 5      | Cantidad| "El campo Cantidad debe ser mayor que 0." |
      |                | 10       | 5      | Nombre  | "El campo Nombre es obligatorio."          |
      | Aceite ABC     | 20       | -5     | Límite  | "El campo Límite debe ser mayor que 0."    |
      | Bujías         | abc      | 10     | Cantidad| "El campo Cantidad debe ser un número válido." |
      | Pastillas      | 30       | xyz    | Límite  | "El campo Límite debe ser un número válido."   |

  Scenario: Manejo de duplicados al añadir una nueva entrada
    Given que tengo una entrada en el inventario con el nombre "Aceite 10W-40"
    When intento añadir una nueva entrada con el nombre "Aceite 10W-40"
    Then el sistema muestra un mensaje de error "Ya existe una entrada con este nombre."
    And no añade la nueva entrada al inventario

  Scenario: Eliminación de una entrada de inventario
    Given que tengo la siguiente entrada en el inventario:
      | Nombre         | Cantidad | Límite | Descripción                    |
      | Aceite 10W-40  | 50       | 20     | Aceite sintético de motor       |
    And estoy en la sección "Inventario"
    And selecciono la entrada "Aceite 10W-40"
    When hago clic en el botón "Eliminar entrada"
    Then el sistema solicita confirmación para eliminar la entrada
    When confirmo la eliminación
    Then el sistema elimina la entrada "Aceite 10W-40" del inventario
    And muestra un mensaje "Entrada eliminada correctamente"
    And la entrada "Aceite 10W-40" ya no aparece en la lista de inventario

  Scenario: Acceso a detalles de una entrada de inventario
    Given que tengo la siguiente entrada en el inventario:
      | Nombre           | Cantidad | Límite | Descripción                    |
      | Pastillas de freno| 40      | 15     | Pastillas de freno estándar      |
    And estoy en la sección "Inventario"
    When selecciono la entrada "Pastillas de freno"
    Then el sistema muestra los detalles completos de la entrada:
      | Campo        | Valor                     |
      | Nombre       | Pastillas de freno        |
      | Cantidad     | 40                        |
      | Límite       | 15                        |
      | Descripción  | Pastillas de freno estándar|

  Scenario: Notificación cuando el stock está por debajo del límite
    Given que tengo la siguiente entrada en el inventario:
      | Nombre          | Cantidad | Límite | Descripción                    |
      | Filtro de aire  | 8        | 10     | Filtro de aire para vehículos    |
    And estoy en la sección "Inventario"
    Then el sistema resalta la entrada "Filtro de aire" con un indicador de stock bajo
    And muestra una notificación "El stock de 'Filtro de aire' está por debajo del límite."

  Scenario: Notificación cuando el stock está por encima del límite
    Given que tengo la siguiente entrada en el inventario:
      | Nombre           | Cantidad | Límite | Descripción                    |
      | Aceite 10W-40    | 50       | 20     | Aceite sintético de motor       |
    And estoy en la sección "Inventario"
    Then el sistema resalta la entrada "Aceite 10W-40" con un indicador de stock alto
    And no muestra ninguna notificación de stock bajo para esta entrada
