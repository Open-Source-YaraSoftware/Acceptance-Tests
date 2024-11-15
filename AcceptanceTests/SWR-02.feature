Feature: Sección "About the Product" de la Landing Page
  Como visitante de la landing page
  Quiero leer una descripción detallada del producto
  Para entender cómo el producto puede resolver mis problemas específicos y mejorar la gestión de mi taller

  Scenario: Descripción Clara del Producto
    Given que soy un visitante de la landing page
    When navego a la sección "About the Product"
    Then debería ver una descripción precisa del producto
    And la descripción debería ser fácil de entender para un propietario de taller

  Scenario: Beneficios Relevantes del Producto
    Given que estoy en la sección "About the Product"
    When leo la información sobre las características del producto
    Then cada característica debería estar acompañada de una explicación de sus beneficios
    And los beneficios deberían ser relevantes para la gestión de un taller

  Scenario: Contenido Visual - Video del Producto
    Given que estoy en la sección "About the Product"
    When busco contenido visual sobre el producto
    Then debería ver un video que muestre las funcionalidades del producto
    And el video debería ser reproducible directamente en la página

  Scenario: Navegación Fácil en la Sección
    Given que estoy en la sección "About the Product"
    When hay múltiples subsecciones de información
    Then debería poder navegar fácilmente entre ellas
    And debería haber un menú o índice para acceder rápidamente a cada parte

  Scenario: Responsividad del Contenido
    Given que estoy visitando la sección "About the Product" en un dispositivo móvil
    When veo el contenido y reproduzco el video
    Then todo el contenido debería ser legible y el video reproducible sin problemas
    And no debería haber necesidad de zoom o scroll horizontal
