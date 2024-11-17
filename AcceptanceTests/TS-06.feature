Feature: Manage Workshops through RESTful API
  Como Developer
  Quiero gestionar talleres a través del API
  Para que estén disponibles las funcionalidades de visualización, creación y actualización de talleres en la aplicación

  Scenario: Retrieve details of a specific Workshop
    Given el endpoint GET "/api/v1/workshops/{workshopId}" está disponible
    When se envía una solicitud GET con un workshopId válido
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta incluye los detalles del Workshop, como name, address, ownerId, y createdAt

  Scenario: Retrieve details of a non-existent Workshop
    Given el endpoint GET "/api/v1/workshops/{workshopId}" está disponible
    When se envía una solicitud GET con un workshopId no válido
    Then se recibe una respuesta con estado 404
    And el cuerpo de la respuesta incluye un mensaje indicando que el Workshop no fue encontrado

  Scenario: Update an existing Workshop
    Given el endpoint PUT "/api/v1/workshops/{workshopId}" está disponible
    When se envía una solicitud PUT con un workshopId válido y nuevos valores para actualizar
    Then se recibe una respuesta con estado 200
    And los detalles del Workshop se actualizan correctamente
    And el cuerpo de la respuesta refleja los nuevos valores

  Scenario: Update a Workshop with invalid data
    Given el endpoint PUT "/api/v1/workshops/{workshopId}" está disponible
    When se envía una solicitud PUT con un workshopId válido pero datos no válidos
    Then se recibe una respuesta con estado 400
    And el cuerpo de la respuesta incluye un mensaje de error explicando los problemas con los datos enviados

  Scenario: Update a non-existent Workshop
    Given el endpoint PUT "/api/v1/workshops/{workshopId}" está disponible
    When se envía una solicitud PUT con un workshopId no válido
    Then se recibe una respuesta con estado 404
    And el cuerpo de la respuesta incluye un mensaje indicando que el Workshop no fue encontrado

  Scenario: Create a new Workshop
    Given el endpoint POST "/api/v1/workshops" está disponible
    When se envía una solicitud POST con valores válidos para name y otros detalles opcionales
    Then se recibe una respuesta con estado 201
    And el cuerpo de la respuesta incluye el nuevo Workshop con un id único y los valores registrados

  Scenario: Create a new Workshop with missing or invalid values
    Given el endpoint POST "/api/v1/workshops" está disponible
    When se envía una solicitud POST con valores faltantes o no válidos
    Then se recibe una respuesta con estado 400
    And el cuerpo de la respuesta incluye un mensaje de error indicando los problemas con los datos proporcionados
