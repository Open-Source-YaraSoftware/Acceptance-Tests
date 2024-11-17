Feature: Manage Interventions through RESTful API
  Como Developer
  Quiero gestionar intervenciones a través del API
  Para que estén disponibles las funcionalidades de creación, actualización y estado de las intervenciones en la aplicación

  Scenario: Retrieve all Interventions
    Given el endpoint GET "/api/v1/interventions" está disponible
    When se envía una solicitud GET sin parámetros
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta incluye una lista de todas las Interventions
    And cada intervención tiene workshopId, mechanicLeaderId, vehicleId, scheduledAt, type, status, y description

  Scenario: Retrieve all Interventions when there are no records
    Given el endpoint GET "/api/v1/interventions" está disponible
    When se envía una solicitud GET sin parámetros
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta es una lista vacía

  Scenario: Create a new Intervention
    Given el endpoint POST "/api/v1/interventions" está disponible
    When se envía una solicitud POST con valores válidos para workshopId, mechanicLeaderId, vehicleId, scheduledAt, type, status, y description
    Then se recibe una respuesta con estado 201
    And el cuerpo de la respuesta incluye la nueva Intervention con un id único
    And los valores registrados corresponden correctamente a workshopId, mechanicLeaderId, vehicleId, scheduledAt, type, status, y description

  Scenario: Create a new Intervention with missing or invalid values
    Given el endpoint POST "/api/v1/interventions" está disponible
    When se envía una solicitud POST con valores faltantes o no válidos
    Then se recibe una respuesta con estado 400
    And el cuerpo de la respuesta incluye un mensaje de error explicando qué valores son incorrectos o faltantes

  Scenario: Retrieve details of a specific Intervention
    Given el endpoint GET "/api/v1/interventions/{interventionId}" está disponible
    When se envía una solicitud GET con un interventionId válido
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta incluye los detalles completos de la Intervention, como workshopId, mechanicLeaderId, vehicleId, scheduledAt, type, status, y description

  Scenario: Retrieve details of a non-existent Intervention
    Given el endpoint GET "/api/v1/interventions/{interventionId}" está disponible
    When se envía una solicitud GET con un interventionId inexistente
    Then se recibe una respuesta con estado 404
    And el cuerpo de la respuesta incluye un mensaje de error indicando que la Intervention no fue encontrada

  Scenario: Update an existing Intervention
    Given el endpoint PUT "/api/v1/interventions/{interventionId}" está disponible
    When se envía una solicitud PUT con un interventionId válido y nuevos valores para workshopId, mechanicLeaderId, vehicleId, scheduledAt, type, status, o description
    Then se recibe una respuesta con estado 200
    And los detalles de la Intervention se actualizan correctamente
    And el cuerpo de la respuesta refleja los valores actualizados

  Scenario: Update an existing Intervention with invalid data
    Given el endpoint PUT "/api/v1/interventions/{interventionId}" está disponible
    When se envía una solicitud PUT con un interventionId válido pero con datos no válidos
    Then se recibe una respuesta con estado 400
    And el cuerpo de la respuesta incluye un mensaje de error indicando los problemas con los datos enviados

  Scenario: Update a non-existent Intervention
    Given el endpoint PUT "/api/v1/interventions/{interventionId}" está disponible
    When se envía una solicitud PUT con un interventionId inexistente
    Then se recibe una respuesta con estado 404
    And el cuerpo de la respuesta incluye un mensaje indicando que la Intervention no fue encontrada
