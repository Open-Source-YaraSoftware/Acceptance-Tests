Feature: Retrieve Workshop Interventions through RESTful API
  Como Developer
  Quiero obtener todas las intervenciones asociadas a un taller a través del API
  Para que estén disponibles las funcionalidades de planificación y gestión de intervenciones en la aplicación

  Scenario: Retrieve all Interventions for a Workshop
    Given el endpoint GET "/api/v1/workshops/{workshopId}/interventions" está disponible
    When se envía una solicitud GET con un workshopId válido
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta incluye una lista de todas las Interventions asociadas al Workshop
    And cada Intervention tiene workshopId, mechanicLeaderId, vehicleId, scheduledAt, type, status, y description

  Scenario: Retrieve Interventions for a Workshop when there are no Interventions
    Given el endpoint GET "/api/v1/workshops/{workshopId}/interventions" está disponible
    When se envía una solicitud GET con un workshopId válido sin intervenciones asociadas
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta es una lista vacía

  Scenario: Retrieve Interventions for a non-existent Workshop
    Given el endpoint GET "/api/v1/workshops/{workshopId}/interventions" está disponible
    When se envía una solicitud GET con un workshopId no válido
    Then se recibe una respuesta con estado 404
    And el cuerpo de la respuesta incluye un mensaje indicando que el Workshop no fue encontrado
