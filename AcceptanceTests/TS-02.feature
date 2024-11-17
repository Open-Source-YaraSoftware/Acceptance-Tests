Feature: Manage Intervention Status through RESTful API
  Como Developer
  Quiero gestionar los estados de las intervenciones a través del API
  Para que estén disponibles las funcionalidades de seguimiento del progreso y confirmación o cancelación de las intervenciones

  Scenario: Mark an Intervention as In Progress
    Given el endpoint POST "/api/v1/interventions/{interventionId}/in-progresses" está disponible
    When se envía una solicitud POST con un interventionId válido
    Then se recibe una respuesta con estado 200
    And el estado de la Intervention se actualiza a IN_PROGRESS
    And el cuerpo de la respuesta incluye un mensaje de éxito y el interventionId

  Scenario: Mark an Intervention as In Progress when already in progress
    Given el endpoint POST "/api/v1/interventions/{interventionId}/in-progresses" está disponible
    And el estado actual de la Intervention es IN_PROGRESS
    When se envía una solicitud POST con el mismo interventionId
    Then se recibe una respuesta con estado 400
    And el cuerpo de la respuesta incluye un mensaje indicando que la Intervention ya está en progreso

  Scenario: Confirm an Intervention
    Given el endpoint POST "/api/v1/interventions/{interventionId}/confirmations" está disponible
    When se envía una solicitud POST con un interventionId válido
    Then se recibe una respuesta con estado 200
    And el estado de la Intervention se actualiza a COMPLETED
    And el cuerpo de la respuesta incluye un mensaje de éxito y el interventionId

  Scenario: Confirm an already completed Intervention
    Given el endpoint POST "/api/v1/interventions/{interventionId}/confirmations" está disponible
    And el estado actual de la Intervention es COMPLETED
    When se envía una solicitud POST con el mismo interventionId
    Then se recibe una respuesta con estado 400
    And el cuerpo de la respuesta incluye un mensaje indicando que la Intervention ya está completada

  Scenario: Cancel an Intervention
    Given el endpoint POST "/api/v1/interventions/{interventionId}/cancellations" está disponible
    When se envía una solicitud POST con un interventionId válido
    Then se recibe una respuesta con estado 200
    And el estado de la Intervention se actualiza a CANCELED
    And el cuerpo de la respuesta incluye un mensaje de éxito y el interventionId

  Scenario: Cancel an already canceled Intervention
    Given el endpoint POST "/api/v1/interventions/{interventionId}/cancellations" está disponible
    And el estado actual de la Intervention es CANCELED
    When se envía una solicitud POST con el mismo interventionId
    Then se recibe una respuesta con estado 400
    And el cuerpo de la respuesta incluye un mensaje indicando que la Intervention ya está cancelada

  Scenario: Handle invalid interventionId for status updates
    Given el endpoint POST "/api/v1/interventions/{interventionId}/{action}" está disponible
    When se envía una solicitud POST con un interventionId no válido para cualquier acción (in-progresses, confirmations, cancellations)
    Then se recibe una respuesta con estado 404
    And el cuerpo de la respuesta incluye un mensaje de error indicando que la Intervention no fue encontrada
