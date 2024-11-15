Feature: Formulario de Contacto de la Landing Page
  Como visitante de la landing page
  Quiero encontrar un formulario de contacto fácil de usar
  Para poder hacer preguntas específicas sobre el producto y recibir asistencia antes de tomar una decisión de compra

  Scenario: Accesibilidad del Formulario de Contacto
    Given que soy un visitante de la landing page
    When busco la sección de contacto
    Then debería ver fácilmente un formulario de contacto
    And el formulario debería estar claramente titulado "CONTÁCTANOS"
    And debería ver un mensaje que diga "¿Tienes alguna pregunta? Envíanos tu comentario."

  Scenario: Campos Relevantes en el Formulario
    Given que estoy en la sección del formulario de contacto
    When examino los campos del formulario
    Then debería ver un campo para "Nombre"
    And debería ver un campo para "Correo electrónico"
    And debería ver un campo para "Teléfono"
    And debería ver un campo para "Mensaje"

  Scenario Outline: Validación de Campos del Formulario
    Given que estoy llenando el formulario de contacto
    When ingreso "<valor>" en el campo "<campo>"
    Then el sistema debería "<accion>"

    Examples:
      | campo             | valor                   | accion                                        |
      | Nombre            |                         | mostrar un mensaje de error de campo requerido |
      | Correo electrónico| correo_invalido         | mostrar un mensaje de error de formato inválido |
      | Correo electrónico| correo@valido.com       | aceptar el valor sin mostrar error             |
      | Teléfono          | 123488561               | mostrar un mensaje de error de formato inválido |
      | Teléfono          | 123456789               | aceptar el valor sin mostrar error             |
      | Mensaje           |                         | mostrar un mensaje de error de campo requerido |

  Scenario: Envío Exitoso del Formulario
    Given que he llenado correctamente todos los campos del formulario
    When hago clic en el botón "CONTÁCTANOS"
    Then debería ver un mensaje de confirmación
    And el mensaje debería indicar que mi consulta ha sido enviada correctamente

  Scenario: Diseño Responsivo del Formulario
    Given que estoy viendo el formulario de contacto
    When cambio el tamaño de la ventana del navegador a diferentes dimensiones
    Then el formulario debería ajustarse y ser fácilmente utilizable en todas las dimensiones
    And todos los campos y el botón deberían permanecer visibles y accesibles

  Scenario: Estética del Formulario
    Given que estoy viendo el formulario de contacto
    When examino el diseño del formulario
    Then debería ver un diseño limpio y ordenado
    And los campos deberían estar claramente separados y etiquetados
    And el botón "CONTÁCTANOS" debería ser clickeable
