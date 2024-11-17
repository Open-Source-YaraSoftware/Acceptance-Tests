Feature: Manage Clients within a Workshop through RESTful API
  Como Developer
  Quiero gestionar los clientes de un taller a través del API
  Para que estén disponibles las funcionalidades de creación y recuperación de clientes en la aplicación

  Scenario: Retrieve all Clients for a Workshop
    Given el endpoint GET "/api/v1/workshops/{workshopId}/clients" está disponible
    When se envía una solicitud GET con un workshopId válido
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta incluye una lista de todos los Clients asociados al Workshop
    And cada Client tiene id, name, email, phoneNumber, y registeredAt

  Scenario: Retrieve Clients for a Workshop when there are no Clients
    Given el endpoint GET "/api/v1/workshops/{workshopId}/clients" está disponible
    When se envía una solicitud GET con un workshopId válido sin clientes asociados
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta es una lista vacía

  Scenario: Retrieve Clients for a non-existent Workshop
    Given el endpoint GET "/api/v1/workshops/{workshopId}/clients" está disponible
    When se envía una solicitud GET con un workshopId no válido
    Then se recibe una respuesta con estado 404
    And el cuerpo de la respuesta incluye un mensaje indicando que el Workshop no fue encontrado

  Scenario: Add a new Client to a Workshop
    Given el endpoint POST "/api/v1/workshops/{workshopId}/clients" está disponible
    When se envía una solicitud POST con valores válidos para el nuevo cliente, como name, email, y phoneNumber
    Then se recibe una respuesta con estado 201
    And el cuerpo de la respuesta incluye el nuevo Client con un id único y los valores registrados

  Scenario: Add a new Client with missing or invalid values
    Given el endpoint POST "/api/v1/workshops/{workshopId}/clients" está disponible
    When se envía una solicitud POST con valores faltantes o inválidos para el cliente
    Then se recibe una respuesta con estado 400
    And el cuerpo de la respuesta incluye un mensaje de error explicando los problemas con los datos proporcionados
