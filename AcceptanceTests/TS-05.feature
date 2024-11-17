Feature: Manage Checkpoints for Tasks through RESTful API
  Como Developer
  Quiero gestionar los checkpoints de una tarea a través del API
  Para que estén disponibles las funcionalidades de seguimiento detallado en la aplicación

  Scenario: Retrieve all Checkpoints for a Task
    Given el endpoint GET "/api/v1/interventions/{interventionId}/tasks/{taskId}/checkpoints" está disponible
    When se envía una solicitud GET con un taskId válido
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta incluye una lista de todos los Checkpoints asociados a la Task
    And cada Checkpoint tiene un id, name, y timestamp

  Scenario: Retrieve all Checkpoints when there are no Checkpoints
    Given el endpoint GET "/api/v1/interventions/{interventionId}/tasks/{taskId}/checkpoints" está disponible
    When se envía una solicitud GET con un taskId válido que no tiene checkpoints asociados
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta es una lista vacía

  Scenario: Retrieve Checkpoints for a non-existent Task
    Given el endpoint GET "/api/v1/interventions/{interventionId}/tasks/{taskId}/checkpoints" está disponible
    When se envía una solicitud GET con un taskId no válido
    Then se recibe una respuesta con estado 404
    And el cuerpo de la respuesta incluye un mensaje de error indicando que la Task no fue encontrada

  Scenario: Create a new Checkpoint for a Task
    Given el endpoint POST "/api/v1/interventions/{interventionId}/tasks/{taskId}/checkpoints" está disponible
    When se envía una solicitud POST con valores válidos para name
    Then se recibe una respuesta con estado 201
    And el cuerpo de la respuesta incluye el nuevo Checkpoint con un id único y el name registrado

  Scenario: Create a new Checkpoint with missing or invalid values
    Given el endpoint POST "/api/v1/interventions/{interventionId}/tasks/{taskId}/checkpoints" está disponible
    When se envía una solicitud POST con valores faltantes o inválidos
    Then se recibe una respuesta con estado 400
    And el cuerpo de la respuesta incluye un mensaje de error indicando los problemas con los datos enviados

  Scenario: Update a Checkpoint for a Task
    Given el endpoint PUT "/api/v1/interventions/{interventionId}/tasks/{taskId}/checkpoints/{checkpointId}" está disponible
    When se envía una solicitud PUT con un checkpointId válido y nuevos valores para actualizar
    Then se recibe una respuesta con estado 200
    And los detalles del Checkpoint se actualizan correctamente
    And el cuerpo de la respuesta refleja los valores actualizados

  Scenario: Update a Checkpoint with invalid data
    Given el endpoint PUT "/api/v1/interventions/{interventionId}/tasks/{taskId}/checkpoints/{checkpointId}" está disponible
    When se envía una solicitud PUT con un checkpointId válido pero datos no válidos
    Then se recibe una respuesta con estado 400
    And el cuerpo de la respuesta incluye un mensaje de error indicando qué valores son incorrectos

  Scenario: Update a non-existent Checkpoint
    Given el endpoint PUT "/api/v1/interventions/{interventionId}/tasks/{taskId}/checkpoints/{checkpointId}" está disponible
    When se envía una solicitud PUT con un checkpointId no válido
    Then se recibe una respuesta con estado 404
    And el cuerpo de la respuesta incluye un mensaje indicando que el Checkpoint no fue encontrado

  Scenario: Delete a Checkpoint from a Task
    Given el endpoint DELETE "/api/v1/interventions/{interventionId}/tasks/{taskId}/checkpoints/{checkpointId}" está disponible
    When se envía una solicitud DELETE con un checkpointId válido
    Then se recibe una respuesta con estado 204
    And el Checkpoint se elimina de la Task

  Scenario: Delete a non-existent Checkpoint
    Given el endpoint DELETE "/api/v1/interventions/{interventionId}/tasks/{taskId}/checkpoints/{checkpointId}" está disponible
    When se envía una solicitud DELETE con un checkpointId no válido
    Then se recibe una respuesta con estado 404
    And el cuerpo de la respuesta incluye un mensaje indicando que el Checkpoint no fue encontrado
