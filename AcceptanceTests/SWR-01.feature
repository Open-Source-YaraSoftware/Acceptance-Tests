Feature: Hero Section de la Landing Page
  Como visitante de la landing page
  Quiero ver una presentación clara y atractiva en la hero section
  Para captar rápidamente la propuesta de valor del sitio y decidir si el producto o servicio es relevante para mi taller

  Scenario: Visibilidad de la Hero Section
    Given que soy un visitante de la landing page
    When la página se carga completamente
    Then debería ver la hero section sin necesidad de hacer scroll

  Scenario: Propuesta de Valor Clara
    Given que estoy en la landing page
    When miro la hero section
    Then debería ver un mensaje claro y conciso que explique la propuesta de valor del producto

  Scenario: Diseño Atractivo con Imagen
    Given que estoy en la landing page
    When miro la hero section
    Then debería ver una imagen atractiva que complementa el mensaje

  Scenario: Llamada a la Acción Visible
    Given que estoy en la hero section
    When busco un botón de llamada a la acción
    Then debería ver al menos un botón claramente visible
    And el botón debería dirigirme a la sección "Contáctanos" al hacer clic

  Scenario Outline: Responsividad en Diferentes Dispositivos
    Given que estoy visitando la landing page en un <dispositivo>
    When miro la hero section
    Then debería ser completamente funcional
    And debería ser visualmente atractiva sin distorsiones

    Examples:
    
      | dispositivo |
      | móvil       |
      | tablet      |
      | escritorio  |
