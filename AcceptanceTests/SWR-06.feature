Feature: Sección de Planes y Precios de la Landing Page
  Como visitante de la landing page
  Quiero ver los planes y precios disponibles en la sección "Planes y precios"
  Para comparar las opciones y decidir cuál se ajusta mejor a mi presupuesto y necesidades

  Scenario: Visualización de la Lista de Planes
    Given que soy un visitante de la landing page
    When navego a la sección "Planes y precios"
    Then debería ver tres planes claramente mostrados: "Plan Gratuito", "Plan Básico" y "Plan Premium"
    And cada plan debería mostrar su precio correspondiente
    And el "Plan Gratuito" debería mostrar un precio de "S/0"
    And el "Plan Básico" debería mostrar un precio de "S/39.90/mes"
    And el "Plan Premium" debería mostrar un precio de "S/89.90/mes"

  Scenario: Comparación de Características de los Planes
    Given que estoy en la sección "Planes y precios"
    When examino las características de cada plan
    Then debería ver una lista clara de características para cada plan
    And las características deberían estar marcadas con un símbolo de verificación

  Scenario: Transparencia en los Precios
    Given que estoy revisando los planes
    When miro los precios de cada plan
    Then los precios deberían ser claramente visibles
    And no debería haber indicios de cargos ocultos o costos adicionales no mencionados

  Scenario: Llamada a la Acción para Cada Plan
    Given que estoy en la sección "Planes y precios"
    When miro cada plan individual
    Then debería ver un botón de "APLICAR" para cada plan
    And los botones deberían ser claramente visibles y clickeables

  Scenario: Diseño Facilitador de Comparación
    Given que estoy comparando los planes
    When examino el diseño de la sección "Planes y precios"
    Then los planes deberían estar presentados en un formato de tabla o columnas
    And debería poder comparar fácilmente las características entre los planes
    And el "Plan Premium" debería destacarse visualmente de los otros planes

  Scenario Outline: Verificación de Características Específicas de los Planes
    Given que estoy en la sección "Planes y precios"
    When reviso las características del "<plan>"
    Then debería ver la característica "<caracteristica>" listada
    And debería mostrar el "<valor>" correspondiente

    Examples:
      | plan           | caracteristica                   | valor                    |
      | Plan Gratuito  | Hasta 5 mecánicos                | 5 mecánicos              |
      | Plan Básico    | Hasta 20 mecánicos               | 20 mecánicos             |
      | Plan Premium   | Mecánicos ilimitados             | ilimitados               |
