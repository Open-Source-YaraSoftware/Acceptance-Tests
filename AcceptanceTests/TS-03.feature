Feature: Manage Tasks within an Intervention through RESTful API
  Como Developer
  Quiero gestionar las tareas dentro de una intervención a través del API
  Para que estén disponibles las funcionalidades de creación, actualización y eliminación de tareas en la aplicación

  Scenario: Retrieve all Tasks for an Intervention
    Given el endpoint GET "/api/v1/interventions/{interventionId}/tasks" está disponible
    When se envía una solicitud GET con un interventionId válido
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta incluye una lista de todas las Tasks asociadas a la Intervention
    And cada Task tiene mechanicAssignedId, state, y description

  Scenario: Retrieve all Tasks when there are no tasks
    Given el endpoint GET "/api/v1/interventions/{interventionId}/tasks" está disponible
    When se envía una solicitud GET con un interventionId válido sin tareas asociadas
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta es una lista vacía

  Scenario: Retrieve Tasks for a non-existent Intervention
    Given el endpoint GET "/api/v1/interventions/{interventionId}/tasks" está disponible
    When se envía una solicitud GET con un interventionId no válido
    Then se recibe una respuesta con estado 404
    And el cuerpo de la respuesta incluye un mensaje de error indicando que la Intervention no fue encontrada

  Scenario: Create a new Task for an Intervention
    Given el endpoint POST "/api/v1/interventions/{interventionId}/tasks" está disponible
    When se envía una solicitud POST con valores válidos para mechanicAssignedId, state, y description
    Then se recibe una respuesta con estado 201
    And el cuerpo de la respuesta incluye la nueva Task con un id único y los valores registrados

  Scenario: Create a new Task with missing or invalid values
    Given el endpoint POST "/api/v1/interventions/{interventionId}/tasks" está disponible
    When se envía una solicitud POST con valores faltantes o inválidos
    Then se recibe una respuesta con estado 400
    And el cuerpo de la respuesta incluye un mensaje de error indicando los problemas con los datos proporcionados

  Scenario: Update a Task within an Intervention
    Given el endpoint PUT "/api/v1/interventions/{interventionId}/tasks/{taskId}" está disponible
    When se envía una solicitud PUT con un taskId válido y nuevos valores para actualizar
    Then se recibe una respuesta con estado 200
    And los detalles de la Task se actualizan correctamente
    And el cuerpo de la respuesta refleja los nuevos valores

  Scenario: Update a Task with invalid data
    Given el endpoint PUT "/api/v1/interventions/{interventionId}/tasks/{taskId}" está disponible
    When se envía una solicitud PUT con un taskId válido pero datos no válidos
    Then se recibe una respuesta con estado 400
    And el cuerpo de la respuesta incluye un mensaje de error explicando qué valores son incorrectos

  Scenario: Update a Task for a non-existent Intervention or Task
    Given el endpoint PUT "/api/v1/interventions/{interventionId}/tasks/{taskId}" está disponible
    When se envía una solicitud PUT con un interventionId o taskId inexistente
    Then se recibe una respuesta con estado 404
    And el cuerpo de la respuesta incluye un mensaje indicando que la Intervention o Task no fue encontrada

  Scenario: Delete a Task from an Intervention
    Given el endpoint DELETE "/api/v1/interventions/{interventionId}/tasks/{taskId}" está disponible
    When se envía una solicitud DELETE con un taskId válido
    Then se recibe una respuesta con estado 204
    And la Task se elimina de la Intervention

  Scenario: Delete a non-existent Task
    Given el endpoint DELETE "/api/v1/interventions/{interventionId}/tasks/{taskId}" está disponible
    When se envía una solicitud DELETE con un taskId no válido
    Then se recibe una respuesta con estado 404
    And el cuerpo de la respuesta incluye un mensaje indicando que la Task no fue encontrada
