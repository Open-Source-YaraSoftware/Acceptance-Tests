Feature: Manage Mechanics within a Workshop through RESTful API
  Como Developer
  Quiero gestionar los mecánicos de un taller a través del API
  Para que estén disponibles las funcionalidades de asignación y gestión de mecánicos en la aplicación

  Scenario: Retrieve all Mechanics for a Workshop
    Given el endpoint GET "/api/v1/workshops/{workshopId}/mechanics" está disponible
    When se envía una solicitud GET con un workshopId válido
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta incluye una lista de todos los Mechanics asociados al Workshop
    And cada Mechanic tiene id, name, expertise, phoneNumber, y availabilityStatus

  Scenario: Retrieve Mechanics for a Workshop when there are no Mechanics
    Given el endpoint GET "/api/v1/workshops/{workshopId}/mechanics" está disponible
    When se envía una solicitud GET con un workshopId válido sin mecánicos asociados
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta es una lista vacía

  Scenario: Retrieve Mechanics for a non-existent Workshop
    Given el endpoint GET "/api/v1/workshops/{workshopId}/mechanics" está disponible
    When se envía una solicitud GET con un workshopId no válido
    Then se recibe una respuesta con estado 404
    And el cuerpo de la respuesta incluye un mensaje indicando que el Workshop no fue encontrado

  Scenario: Add a new Mechanic to a Workshop
    Given el endpoint POST "/api/v1/workshops/{workshopId}/mechanics" está disponible
    When se envía una solicitud POST con valores válidos para el nuevo mecánico, como name, expertise, y phoneNumber
    Then se recibe una respuesta con estado 201
    And el cuerpo de la respuesta incluye el nuevo Mechanic con un id único y los valores registrados

  Scenario: Add a new Mechanic with missing or invalid values
    Given el endpoint POST "/api/v1/workshops/{workshopId}/mechanics" está disponible
    When se envía una solicitud POST con valores faltantes o inválidos para el mecánico
    Then se recibe una respuesta con estado 400
    And el cuerpo de la respuesta incluye un mensaje de error explicando los problemas con los datos proporcionados
