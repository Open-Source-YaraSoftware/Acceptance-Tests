Feature: Sección "About Us" de la Landing Page
  Como visitante de la landing page
  Quiero conocer más sobre la empresa en la sección "About Us"
  Para entender mejor la experiencia y credibilidad de la empresa detrás del producto antes de considerar una compra

  Scenario: Visualización de la Historia de la Empresa
    Given que soy un visitante de la landing page
    When navego a la sección "About Us"
    Then debería ver una descripción clara de la historia de la empresa
    And debería ver la misión de la empresa claramente establecida
    And la información debería estar presentada de manera concisa y fácil de leer

  Scenario: Diseño Atractivo de la Sección
    Given que estoy revisando la sección "About Us"
    When examino el diseño general de la sección
    Then la información debería estar presentada de manera visualmente atractiva
    And el diseño debería ser coherente con el estilo general de la landing page
    And debería poder leer fácilmente toda la información sin esfuerzo visual

  Scenario Outline: Responsividad de la Sección "About Us"
    Given que estoy visitando la landing page en un dispositivo móvil
    When navego a la sección "About Us"
    Then toda la información debería ser legible y bien organizada
    And las imágenes deberían ajustarse adecuadamente al tamaño de la pantalla
    And no debería haber necesidad de zoom o scroll horizontal para leer el contenido

    Examples:

      | Contenido | Descripcion                              |
      | Mision    | Crear soluciones de software innovadoras |
      | Vision    | Ser líderes en desarrollo tecnológico    |
      | Valores   | Innovación, Calidad, Accesibilidad       |
