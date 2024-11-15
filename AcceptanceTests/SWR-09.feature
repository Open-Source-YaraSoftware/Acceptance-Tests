Feature: Internacionalización de la Landing Page
  Como visitante de la landing page
  Quiero que la landing page sea accesible en español e inglés
  Para que pueda acceder a la información en el idioma que prefiera y proporcionar una experiencia adecuada para usuarios de diferentes regiones

  Scenario: Soporte para Idiomas Español e Inglés
    Given que soy un visitante de la landing page
    When cargo la página por primera vez
    Then debería ver el contenido en el idioma predeterminado
    And debería haber una opción para cambiar entre español e inglés

  Scenario: Selector de Idioma Visible y Accesible
    Given que estoy en cualquier seccion de la landing page
    When busco una forma de cambiar el idioma
    Then debería ver un selector de idioma en la parte superior de la página
    And el selector debería mostrar las opciones "ES" para español y "EN" para inglés

  Scenario Outline: Cambio de Idioma
    Given que estoy viendo la landing page en "<idioma_inicial>"
    When selecciono "<idioma_destino>" en el selector de idioma
    Then todo el contenido de la página debería cambiar a "<idioma_destino>"
    And el selector de idioma debería mostrar "<idioma_destino>" como seleccionado

    Examples:
      | idioma_inicial | idioma_destino |
      | español        | inglés         |
      | inglés         | español        |

  Scenario Outline: Traducción Completa del Contenido
    Given que he seleccionado el idioma "<idioma>"
    When navego por diferentes secciones de la landing page
    Then todos los textos, botones y mensajes deberían estar en "<idioma>"
    And el contenido debería ser coherente y gramaticalmente correcto en "<idioma>"

    Examples:
      | idioma  |
      | español |
      | inglés  |

  Scenario Outline: Manejo de Enlaces en Diferentes Idiomas
    Given que estoy viendo la landing page en "<idioma>"
    When hago clic en el enlace de "<seccion>"
    Then debería ser dirigido a la versión de "<seccion>" en "<idioma>"
    And la URL debería reflejar el idioma seleccionado

    Examples:
      | idioma  | seccion        |
      | español | Conoce más     |
      | inglés  | Learn more     |
      | español | Beneficios     |
      | inglés  | Benefits       |
      | español | Testimonios    |
      | inglés  | Testimonials   |
      | español | Sobre nosotros |
      | inglés  | About us       |
      | español | Planes         |
      | inglés  | Plans          |

  Scenario: Persistencia de la Selección de Idioma
    Given que he seleccionado el idioma inglés
    When navego a diferentes páginas del sitio
    Then el idioma debería permanecer en inglés en todas las páginas
    And cuando vuelvo a visitar el sitio más tarde, debería recordar mi preferencia de idioma

  Scenario: Responsividad del Selector de Idioma
    Given que estoy viendo la landing page en un dispositivo móvil
    When busco el selector de idioma
    Then el selector de idioma debería ser visible y fácilmente accesible
    And debería poder cambiar el idioma sin dificultad en la interfaz móvil
