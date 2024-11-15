Feature: Footer de la Landing Page
  Como visitante de la landing page
  Quiero acceder a enlaces importantes en el footer
  Para encontrar rápidamente información adicional, como políticas de privacidad, términos de servicio y detalles de contacto de la empresa

  Scenario: Enlaces Importantes en el Footer
    Given que soy un visitante de la landing page
    When navego hasta el footer de la página
    Then debería ver una sección de "Enlaces Útiles"
    And debería ver enlaces a "Inicio", "Conoce más", "Beneficios", "Testimonios", "Sobre Nosotros", "Planes" y "Contacto"
    And debería ver una sección "Legal"
    And en la sección "Legal" debería ver enlaces a "Política de Privacidad" y "Términos y Condiciones"

  Scenario: Información de Contacto en el Footer
    Given que estoy en el footer de la landing page
    When busco la información de contacto
    Then debería ver una sección titulada "Contacto"
    And debería ver un número de teléfono
    And debería ver una dirección de correo electrónico
    And debería ver una dirección física
    And debería ver un mapa con la ubicación de la empresa

  Scenario: Enlaces a Redes Sociales
    Given que estoy en el footer de la landing page
    When busco los enlaces a redes sociales
    Then debería ver iconos para Facebook, Twitter e Instagram
    And cada icono debería ser clickeable y llevar a la respectiva red social

  Scenario: Diseño Consistente del Footer
    Given que estoy viendo el footer de la landing page
    When examino su diseño
    Then el footer debería tener un fondo oscuro consistente con el diseño del sitio
    And el texto debería ser legible contra el fondo
    And debería estar organizado en columnas claramente definidas

  Scenario: Funcionalidad del Botón "Crear Cuenta"
    Given que estoy en el footer de la landing page
    When hago clic en el botón "Crear Cuenta"
    Then debería ser dirigido a la página de registro de cuenta

  Scenario: Verificación del Copyright
    Given que estoy en el footer de la landing page
    When busco la información de copyright
    Then debería ver un aviso de copyright que incluya el año actual y el nombre de la empresa

  Scenario Outline: Funcionalidad de Enlaces del Footer
    Given que estoy en el footer de la landing page
    When hago clic en el enlace "<enlace>"
    Then debería ser dirigido a la página correspondiente de "<destino>"

    Examples:
      | enlace                 | destino                |
      | Inicio                 | sección de inicio       |
      | Conoce más             | sección de información  |
      | Beneficios             | sección de beneficios  |
      | Testimonios            | sección de testimonios |
      | Sobre Nosotros         | sección Sobre Nosotros  |
      | Planes                 | sección de planes      |
      | Contacto               | página de contacto     |
      | Política de Privacidad | política de privacidad |
      | Términos y Condiciones | términos y condiciones |

  Scenario: Responsividad del Footer
    Given que estoy viendo la landing page en un dispositivo móvil
    When navego hasta el footer
    Then todos los elementos del footer deberían ser visibles y legibles
    And la disposición debería ajustarse adecuadamente al tamaño de la pantalla
