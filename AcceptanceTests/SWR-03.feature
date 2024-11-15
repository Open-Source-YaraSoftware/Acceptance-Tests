Feature: Sección de Beneficios de la Landing Page
  Como visitante de la landing page
  Quiero ver una lista de beneficios potenciales
  Para evaluar de manera rápida cómo el producto puede contribuir a la eficiencia y éxito de mi taller

  Scenario: Presentación Clara y Ordenada de Beneficios
    Given que soy un visitante de la landing page
    When navego a la sección de Beneficios
    Then debería ver una lista ordenada y destacada de los principales beneficios del producto
    And cada beneficio debería estar presentado en formato de lista o con viñetas
    And el formato debería facilitar una lectura rápida y comprensión inmediata

  Scenario: Relevancia y Claridad de los Beneficios
    Given que soy un dueño de taller visitando la landing page
    When reviso la lista de beneficios
    Then cada beneficio listado debería abordar un problema común en la gestión de talleres
    And cada descripción debería ser clara y concisa, sin exceder dos líneas de texto
    And debería poder identificar cómo el producto mejora la eficiencia o el éxito de mi taller

  Scenario: Elementos Visuales de los Beneficios
    Given que estoy en la sección de Beneficios
    When miro cada beneficio listado
    Then debería ver un ícono o imagen relevante junto a cada beneficio
    And estos elementos visuales deberían ayudar a comprender rápidamente el beneficio asociado
    And todos los íconos o imágenes deberían tener un estilo consistente

  Scenario Outline: Verificación de Beneficios Específicos
    Given que estoy en la sección de Beneficios
    When busco el beneficio "<beneficio>"
    Then debería ver una descripción que mencione "<descripcion>"
    And debería estar acompañado por un ícono que represente "<icono>"

    Examples:
    
      | icono              | beneficio                  |          descripcion                                   |
      | Carpetas           |  Organiza Tareas           | Aprovecha las herramientas que tenemos para organizar  |
      | Hoja de Tareas     | Gestiona Mejor Tu Taller   | Te ofrecemos un sinfín de herramientas que te ayudarán |

  Scenario: Responsividad de la Sección de Beneficios
    Given que estoy visitando la landing page en un dispositivo móvil
    When navego a la sección de Beneficios
    Then la lista de beneficios debería ser legible y bien organizada
    And los elementos visuales deberían ajustarse adecuadamente al tamaño de la pantalla
