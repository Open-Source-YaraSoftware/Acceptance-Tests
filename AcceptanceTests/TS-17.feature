Feature: Manage Plans through RESTful API
  Como Developer
  Quiero poder visualizar todos los planes a través del API
  Para que estén disponibles las funcionalidades de selección y comparación de planes en la aplicación

  Scenario: Retrieve all Plans
    Given el endpoint GET "/api/v1/plans" está disponible
    When se envía una solicitud GET sin parámetros
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta incluye una lista de todos los Plans
    And cada Plan tiene detalles como price, durationInMonths, type, cycle, y restricciones como maxMechanics, maxClients, y metricsAvailable

  Scenario: Retrieve all Plans when there are no Plans
    Given el endpoint GET "/api/v1/plans" está disponible
    When se envía una solicitud GET sin parámetros y no hay planes disponibles
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta es una lista vacía

  Scenario: Handle unexpected server error when retrieving Plans
    Given el endpoint GET "/api/v1/plans" está disponible
    When se produce un error inesperado en el servidor al intentar recuperar los planes
    Then se recibe una respuesta con estado 500
    And el cuerpo de la respuesta incluye un mensaje indicando que ocurrió un error en el servidor
