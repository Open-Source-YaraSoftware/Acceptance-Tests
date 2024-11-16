Feature: Registro y gestión de vehículos

  Como usuario
  Quiero poder registrar vehículos
  Para poder asociar y monitorear su información mediante la aplicación

  Scenario: Visualización de vehículos registrados
    Given que tengo los siguientes vehículos registrados:
      | Marca    | Modelo    | Placa    | Año | Color   | Propietario      |
      | Toyota   | Corolla   | ABC-1234 | 2020| Rojo    | Juan Pérez       |
      | Honda    | Civic     | XYZ-5678 | 2019| Azul    | María López      |
    When accedo a la sección "Mis Vehículos" en la aplicación
    Then el sistema muestra una lista de mis vehículos con la siguiente información:
      | Marca    | Modelo    | Placa    | Año | Color | Propietario |
      | Toyota   | Corolla   | ABC-1234 | 2020| Rojo  | Juan Pérez  |
      | Honda    | Civic     | XYZ-5678 | 2019| Azul  | María López |

  Scenario: Añadir una nueva entrada al inventario de vehículos
    Given que estoy en la sección "Mis Vehículos"
    When hago clic en el botón "Agregar vehículo"
    Then el sistema muestra un formulario para registrar un nuevo vehículo con los siguientes campos:
      | Campo       | Tipo de Entrada | Validación                        |
      | Marca       | Texto           | Obligatorio                       |
      | Modelo      | Texto           | Obligatorio                       |
      | Placa       | Texto           | Obligatorio, único, formato válido |
      | Año         | Número           | Obligatorio, rango válido (1990-2024) |
      | Color       | Texto           | Opcional                          |
      | Propietario | Selección        | Obligatorio, existente en el sistema |
    And el botón "Registrar" está deshabilitado hasta que se completen los campos obligatorios

  Scenario Outline: Registro exitoso de un nuevo vehículo
    Given que estoy en el formulario de "Agregar vehículo" en la sección "Mis Vehículos"
    And he ingresado "<Marca>" en el campo "Marca"
    And he ingresado "<Modelo>" en el campo "Modelo"
    And he ingresado "<Placa>" en el campo "Placa"
    And he ingresado "<Año>" en el campo "Año"
    And he ingresado "<Color>" en el campo "Color"
    And he seleccionado "<Propietario>" en el campo "Propietario"
    When hago clic en el botón "Registrar"
    Then el sistema agrega el vehículo a mi lista de vehículos
    And muestra un mensaje "Vehículo registrado exitosamente"
    And el nuevo vehículo aparece en la lista con los detalles proporcionados:
      | Marca    | Modelo  | Placa    | Año | Color | Propietario  |
      | <Marca>  | <Modelo>| <Placa>  | <Año>| <Color>| <Propietario> |

    Examples:
      | Marca   | Modelo | Placa    | Año | Color | Propietario |
      | Ford    | Focus  | DEF-5678 | 2021| Verde | Juan Pérez  |
      | Chevrolet| Spark | GHI-9012 | 2022| Negro | María López |

  Scenario Outline: Registro fallido de un nuevo vehículo por datos inválidos
    Given que estoy en el formulario de "Agregar vehículo" en la sección "Mis Vehículos"
    And he ingresado "<Marca>" en el campo "Marca"
    And he ingresado "<Modelo>" en el campo "Modelo"
    And he ingresado "<Placa>" en el campo "Placa"
    And he ingresado "<Año>" en el campo "Año"
    When hago clic en el botón "Registrar"
    Then el sistema no agrega el vehículo a la lista
    And muestra un mensaje de error "<MensajeError>"
    And resalta los campos con errores

    Examples:
      | Marca  | Modelo | Placa   | Año | MensajeError                                     |
      |        | Focus  | DEF-5678| 2021| "El campo Marca es obligatorio."                 |
      | Ford   |        | DEF-5678| 2021| "El campo Modelo es obligatorio."                |
      | Ford   | Focus  |        | 2021| "El campo Placa es obligatorio."                 |
      | Ford   | Focus  | DEF-5678|    | "El campo Año es obligatorio."                   |
      | Ford   | Focus  | DEF-5678| 1980| "El campo Año debe estar entre 1990 y 2024."     |
      | Ford   | Focus  | DEF5678 | 2021| "El campo Placa debe tener un formato válido."   |
      | Ford   | Focus  | DEF-5678| abc| "El campo Año debe ser un número válido."        |

  Scenario Outline: Registro fallido de un nuevo vehículo por duplicado
    Given que tengo el siguiente vehículo registrado:
      | Marca | Modelo | Placa    | Año | Color | Propietario |
      | Toyota| Corolla| ABC-1234 | 2020| Rojo  | Juan Pérez  |
    And estoy en el formulario de "Agregar vehículo" en la sección "Mis Vehículos"
    And he ingresado "<Marca>" en el campo "Marca"
    And he ingresado "<Modelo>" en el campo "Modelo"
    And he ingresado "<Placa>" en el campo "Placa"
    And he ingresado "<Año>" en el campo "Año"
    And he ingresado "<Color>" en el campo "Color"
    And he seleccionado "<Propietario>" en el campo "Propietario"
    When hago clic en el botón "Registrar"
    Then el sistema no agrega el vehículo a la lista
    And muestra un mensaje de error "Ya existe un vehículo con esta placa."

    Examples:
      | Marca  | Modelo  | Placa    | Año | Color | Propietario |
      | Toyota | Corolla | ABC-1234 | 2020| Rojo  | Juan Pérez  |
      | Honda  | Civic   | ABC-1234 | 2021| Azul  | María López |

  Scenario: Eliminar un vehículo registrado
    Given que tengo el siguiente vehículo registrado:
      | Marca | Modelo | Placa    | Año | Color | Propietario |
      | Toyota| Corolla| ABC-1234 | 2020| Rojo  | Juan Pérez  |
    And estoy en la sección "Mis Vehículos"
    And selecciono el vehículo "Toyota Corolla - ABC-1234"
    When hago clic en el botón "Eliminar vehículo"
    Then el sistema solicita confirmación para eliminar el vehículo
    When confirmo la eliminación
    Then el sistema elimina el vehículo "Toyota Corolla - ABC-1234" de mi lista de vehículos
    And muestra un mensaje "Vehículo eliminado correctamente"
    And el vehículo "Toyota Corolla - ABC-1234" ya no aparece en la lista de vehículos

  Scenario: Cancelar la eliminación de un vehículo
    Given que tengo el siguiente vehículo registrado:
      | Marca | Modelo | Placa    | Año | Color | Propietario |
      | Honda | Civic  | XYZ-5678 | 2019| Azul  | María López  |
    And estoy en la sección "Mis Vehículos"
    And selecciono el vehículo "Honda Civic - XYZ-5678"
    When hago clic en el botón "Eliminar vehículo"
    Then el sistema solicita confirmación para eliminar el vehículo
    When cancelo la eliminación
    Then el sistema no elimina el vehículo "Honda Civic - XYZ-5678"
    And el vehículo "Honda Civic - XYZ-5678" sigue apareciendo en la lista de vehículos

  Scenario Outline: Ordenamiento de vehículos por campo
    Given que tengo los siguientes vehículos registrados:
      | Marca    | Modelo    | Placa    | Año | Color | Propietario      |
      | Toyota   | Corolla   | ABC-1234 | 2020| Rojo  | Juan Pérez       |
      | Honda    | Civic     | XYZ-5678 | 2019| Azul  | María López      |
      | Ford     | Focus     | DEF-5678 | 2021| Verde | Juan Pérez       |
      | Chevrolet| Spark     | GHI-9012 | 2022| Negro | María López      |
    And estoy en la sección "Mis Vehículos"
    When ordeno la lista de vehículos por "<Campo>" en orden "<Orden>"
    Then el sistema muestra la lista de vehículos ordenada por "<Campo>" en orden "<Orden>":
      | Marca    | Modelo    | Placa    | Año | Color | Propietario      |
      | <Marca1> | <Modelo1> | <Placa1> | <Año1>| <Color1>| <Propietario1>  |
      | <Marca2> | <Modelo2> | <Placa2> | <Año2>| <Color2>| <Propietario2>  |
      | ...      | ...       | ...      | ... | ...   | ...              |

    Examples:
      | Campo     | Orden       | Marca1   | Modelo1 | Placa1   | Año1 | Color1 | Propietario1 |
      | Marca     | Ascendente  | Chevrolet| Spark   | GHI-9012 | 2022 | Negro  | María López  |
      | Marca     | Descendente | Toyota   | Corolla | ABC-1234 | 2020 | Rojo   | Juan Pérez   |
      | Modelo    | Ascendente  | Chevrolet| Spark   | GHI-9012 | 2022 | Negro  | María López  |
      | Modelo    | Descendente | Toyota   | Corolla | ABC-1234 | 2020 | Rojo   | Juan Pérez   |
      | Año       | Ascendente  | Honda    | Civic   | XYZ-5678 | 2019 | Azul   | María López  |
      | Año       | Descendente | Chevrolet| Spark   | GHI-9012 | 2022 | Negro  | María López  |
      | Propietario| Ascendente | Honda    | Civic   | XYZ-5678 | 2019 | Azul   | María López  |
      | Propietario| Descendente| Toyota   | Corolla | ABC-1234 | 2020 | Rojo   | Juan Pérez   |

  Scenario: Responsividad de la interfaz de vehículos en dispositivos móviles
    Given que estoy utilizando un dispositivo móvil
    When accedo a la sección "Mis Vehículos"
    Then el sistema adapta la interfaz al tamaño de la pantalla del dispositivo
    And todas las columnas de la tabla de vehículos son legibles sin desplazamiento horizontal
    And puedo interactuar con los botones "Agregar vehículo", "Eliminar vehículo" y "Editar vehículo" fácilmente mediante gestos táctiles

  Scenario: Acceso a detalles de un vehículo
    Given que tengo el siguiente vehículo registrado:
      | Marca  | Modelo | Placa    | Año | Color | Propietario |
      | Ford   | Focus  | DEF-5678 | 2021| Verde | Juan Pérez  |
    And estoy en la sección "Mis Vehículos"
    When selecciono el vehículo "Ford Focus - DEF-5678"
    Then el sistema muestra los detalles completos del vehículo:
      | Campo       | Valor          |
      | Marca       | Ford           |
      | Modelo      | Focus          |
      | Placa       | DEF-5678       |
      | Año         | 2021           |
      | Color       | Verde          |
      | Propietario | Juan Pérez     |
    And muestra las intervenciones asociadas a este vehículo:
      | Intervención     | Estado     | Fecha       |
      | Cambio de aceite | Pendiente  | 05/09/2023  |
      | Revisión frenos  | Completada | 10/09/2023  |

  Scenario: Actualizar información de un vehículo
    Given que tengo el siguiente vehículo registrado:
      | Marca  | Modelo | Placa    | Año | Color | Propietario |
      | Ford   | Focus  | DEF-5678 | 2021| Verde | Juan Pérez  |
    And estoy en la sección "Mis Vehículos"
    And selecciono el vehículo "Ford Focus - DEF-5678"
    When hago clic en el botón "Editar vehículo"
    Then el sistema muestra un formulario de edición prellenado con los siguientes campos:
      | Campo       | Valor          |
      | Marca       | Ford           |
      | Modelo      | Focus          |
      | Placa       | DEF-5678       |
      | Año         | 2021           |
      | Color       | Verde          |
      | Propietario | Juan Pérez     |
    And puedo modificar los campos "Año" y "Color"
    And el botón "Guardar cambios" y "Descartar cambios" están disponibles

  Scenario Outline: Guardar cambios en la información de un vehículo
    Given que estoy en el formulario de edición del vehículo "<Marca> <Modelo> - <Placa>"
    And he cambiado el campo "Año" a "<NuevoAño>"
    And he cambiado el campo "Color" a "<NuevoColor>"
    When hago clic en el botón "Guardar cambios"
    Then el sistema actualiza la información del vehículo con los nuevos valores:
      | Campo       | Valor        |
      | Año         | <NuevoAño>   |
      | Color       | <NuevoColor> |
    And muestra un mensaje "Información del vehículo actualizada correctamente"
    And el vehículo "<Marca> <Modelo> - <Placa>" muestra los nuevos detalles:
      | Campo       | Valor        |
      | Año         | <NuevoAño>   |
      | Color       | <NuevoColor> |

    Examples:
      | Marca    | Modelo | Placa    | NuevoAño | NuevoColor |
      | Ford     | Focus  | DEF-5678 | 2022     | Azul       |
      | Chevrolet| Spark  | GHI-9012 | 2023     | Negro      |

  Scenario: Cancelar edición de un vehículo
    Given que estoy en el formulario de edición del vehículo "Ford Focus - DEF-5678"
    And he realizado cambios en el campo "Año" a "2022"
    When hago clic en el botón "Descartar cambios"
    Then el sistema descarta los cambios realizados
    And muestra los detalles originales del vehículo "Ford Focus - DEF-5678"
      | Campo       | Valor    |
      | Año         | 2021     |
      | Color       | Verde    |
    And muestra un mensaje "Cambios descartados"

  Scenario: Manejo de duplicados al registrar un vehículo
    Given que tengo el siguiente vehículo registrado:
      | Marca  | Modelo | Placa    | Año | Color | Propietario |
      | Toyota | Corolla| ABC-1234 | 2020| Rojo  | Juan Pérez  |
    And estoy en el formulario de "Agregar vehículo" en la sección "Mis Vehículos"
    And he ingresado "Toyota" en el campo "Marca"
    And he ingresado "Corolla" en el campo "Modelo"
    And he ingresado "ABC-1234" en el campo "Placa"
    And he ingresado "2021" en el campo "Año"
    And he ingresado "Negro" en el campo "Color"
    And he seleccionado "María López" en el campo "Propietario"
    When hago clic en el botón "Registrar"
    Then el sistema no agrega el vehículo a la lista
    And muestra un mensaje de error "Ya existe un vehículo con esta placa."
    And resalta el campo "Placa" con un indicador de error

  Scenario: Notificación al registrar un nuevo vehículo
    Given que estoy en el formulario de "Agregar vehículo" en la sección "Mis Vehículos"
    And he ingresado "Chevrolet" en el campo "Marca"
    And he ingresado "Spark" en el campo "Modelo"
    And he ingresado "GHI-9012" en el campo "Placa"
    And he ingresado "2022" en el campo "Año"
    And he ingresado "Negro" en el campo "Color"
    And he seleccionado "María López" en el campo "Propietario"
    When hago clic en el botón "Registrar"
    Then el sistema agrega el vehículo a la lista de vehículos
    And muestra un mensaje "Vehículo registrado exitosamente"
    And "María López" recibe una notificación "Has registrado un nuevo vehículo: Chevrolet Spark - GHI-9012."

  Scenario: Acceso a vehículo no existente
    Given que no existe un vehículo con placa "9999-XYZ"
    When intento acceder a los detalles del vehículo "9999-XYZ" en "Mis Vehículos"
    Then el sistema muestra un mensaje de error "Vehículo no encontrado"
    And redirige a la sección "Mis Vehículos"

  Scenario: Eliminación de vehículo desde dispositivos móviles
    Given que tengo el siguiente vehículo registrado:
      | Marca | Modelo | Placa    | Año | Color | Propietario |
      | Honda | Civic  | XYZ-5678 | 2019| Azul  | María López  |
    And estoy utilizando un dispositivo móvil
    And estoy en la sección "Mis Vehículos"
    And selecciono el vehículo "Honda Civic - XYZ-5678"
    When hago clic en el botón "Eliminar vehículo"
    Then el sistema solicita confirmación para eliminar el vehículo
    When confirmo la eliminación
    Then el sistema elimina el vehículo "Honda Civic - XYZ-5678" de mi lista de vehículos
    And muestra un mensaje "Vehículo eliminado correctamente"
    And el vehículo "Honda Civic - XYZ-5678" ya no aparece en la lista de vehículos

  Scenario: Notificación al eliminar un vehículo
    Given que tengo el siguiente vehículo registrado:
      | Marca | Modelo | Placa    | Año | Color | Propietario |
      | Ford | Focus  | DEF-5678 | 2021| Verde | Juan Pérez  |
    And estoy en la sección "Mis Vehículos"
    When elimino el vehículo "Ford Focus - DEF-5678"
    Then "Juan Pérez" recibe una notificación "Has eliminado el vehículo Ford Focus - DEF-5678 de tu lista."
