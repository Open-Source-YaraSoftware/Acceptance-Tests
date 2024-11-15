Feature: Sección de Testimonios de la Landing Page
  Como visitante de la landing page
  Quiero leer testimonios de otros usuarios que han utilizado la aplicación web
  Para evaluar de manera rápida cómo el producto puede contribuir a la eficiencia y éxito de mi taller

  Scenario: Visualización de Testimonios Genuinos
    Given que soy un visitante de la landing page
    When navego a la sección de Testimonios
    Then debería ver al menos 3 testimonios de clientes
    And cada testimonio debería incluir el nombre del cliente
    And cada testimonio debería incluir detalles de su testimonio

  Scenario: Presentación Atractiva de Testimonios
    Given que estoy en la sección de Testimonios
    When examino la presentación de los testimonios
    Then cada testimonio debería estar en un formato visualmente atractivo
    And los testimonios deberían utilizar citas texto destacados con movimiento
    And el diseño debería ser coherente con el estilo general de la landing page

  Scenario: Responsividad de la Sección de Testimonios
    Given que estoy visitando la landing page en un dispositivo móvil
    When navego a la sección de Testimonios
    Then los testimonios deberían ser legibles y bien organizados
    And las imágenes o logotipos deberían ajustarse adecuadamente al tamaño de la pantalla

  Scenario Outline: Verificación de Testimonios Específicos
    Given que estoy en la sección de Testimonios
    When busco el testimonio de "<cliente>"
    Then debería ver un comentario que mencione "<testimonio>"
    And debería incluir el rol del cliente "<rol>"
    And debería estar acompañado por una <foto del cliente>

    Examples:
    
      | cliente        |           testimonio                                                               |     rol               |       foto       |
      | Carlos Esteban | Workshop N-GINE ha hecho mi trabajo mucho más fácil.                               | Mecánico              | foto del cliente |
      | Laura Jiménez  | Gestionar mi taller se ha vuelto mucho más eficiente desde que uso Workshop N-GINE | Propietaria de Taller |foto del cliente  |
