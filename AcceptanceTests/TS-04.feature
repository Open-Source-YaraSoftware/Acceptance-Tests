Feature: Manage Task State Transitions through RESTful API
  Como Developer
  Quiero gestionar las transiciones de estado de las tareas a través del API
  Para que estén disponibles las funcionalidades de inicio y confirmación de tareas en la aplicación

  Scenario: Mark a Task as In Progress
    Given el endpoint POST "/api/v1/interventions/{interventionId}/tasks/{taskId}/in-progresses" está disponible
    When se envía una solicitud POST con un taskId válido
    Then se recibe una respuesta con estado 200
    And el estado de la Task se actualiza a IN_PROGRESS
    And el cuerpo de la respuesta incluye un mensaje de éxito y el taskId

  Scenario: Mark a Task as In Progress when already in progress
    Given el endpoint POST "/api/v1/interventions/{interventionId}/tasks/{taskId}/in-progresses" está disponible
    And el estado actual de la Task es IN_PROGRESS
    When se envía una solicitud POST con el mismo taskId
    Then se recibe una respuesta con estado 400
    And el cuerpo de la respuesta incluye un mensaje indicando que la Task ya está en progreso

  Scenario: Mark a Task as In Progress when already completed
    Given el endpoint POST "/api/v1/interventions/{interventionId}/tasks/{taskId}/in-progresses" está disponible
    And el estado actual de la Task es DONE
    When se envía una solicitud POST con el mismo taskId
    Then se recibe una respuesta con estado 400
    And el cuerpo de la respuesta incluye un mensaje indicando que no se puede poner en progreso una Task completada

  Scenario: Mark a Task as In Progress for a non-existent Task
    Given el endpoint POST "/api/v1/interventions/{interventionId}/tasks/{taskId}/in-progresses" está disponible
    When se envía una solicitud POST con un taskId no válido
    Then se recibe una respuesta con estado 404
    And el cuerpo de la respuesta incluye un mensaje de error indicando que la Task no fue encontrada

  Scenario: Confirm a Task
    Given el endpoint POST "/api/v1/interventions/{interventionId}/tasks/{taskId}/confirmations" está disponible
    When se envía una solicitud POST con un taskId válido
    Then se recibe una respuesta con estado 200
    And el estado de la Task se actualiza a DONE
    And el cuerpo de la respuesta incluye un mensaje de éxito y el taskId

  Scenario: Confirm a Task that is not in progress
    Given el endpoint POST "/api/v1/interventions/{interventionId}/tasks/{taskId}/confirmations" está disponible
    And el estado actual de la Task no es IN_PROGRESS
    When se envía una solicitud POST con el taskId
    Then se recibe una respuesta con estado 400
    And el cuerpo de la respuesta incluye un mensaje indicando que solo se pueden confirmar tareas en progreso

  Scenario: Confirm a Task that is already done
    Given el endpoint POST "/api/v1/interventions/{interventionId}/tasks/{taskId}/confirmations" está disponible
    And el estado actual de la Task es DONE
    When se envía una solicitud POST con el mismo taskId
    Then se recibe una respuesta con estado 400
    And el cuerpo de la respuesta incluye un mensaje indicando que la Task ya está completada

  Scenario: Confirm a Task for a non-existent Task
    Given el endpoint POST "/api/v1/interventions/{interventionId}/tasks/{taskId}/confirmations" está disponible
    When se envía una solicitud POST con un taskId no válido
    Then se recibe una respuesta con estado 404
    And el cuerpo de la respuesta incluye un mensaje de error indicando que la Task no fue encontrada