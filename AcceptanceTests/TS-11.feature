Feature: Manage Product Requests through RESTful API
  Como Developer
  Quiero gestionar las solicitudes de productos a través del API
  Para que estén disponibles las funcionalidades de creación, actualización y aceptación o rechazo de solicitudes en la aplicación

  Scenario: Retrieve all Product Requests
    Given el endpoint GET "/api/v1/product-requests" está disponible
    When se envía una solicitud GET sin parámetros
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta incluye una lista de todas las Product Requests
    And cada Product Request tiene id, requestedQuantity, taskId, productId, workshopId, y status

  Scenario: Retrieve Product Requests when there are no requests
    Given el endpoint GET "/api/v1/product-requests" está disponible
    When se envía una solicitud GET sin parámetros y no hay solicitudes de productos registradas
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta es una lista vacía

  Scenario: Create a new Product Request
    Given el endpoint POST "/api/v1/product-requests" está disponible
    When se envía una solicitud POST con valores válidos para requestedQuantity, taskId, productId, workshopId, y status
    Then se recibe una respuesta con estado 201
    And el cuerpo de la respuesta incluye la nueva Product Request con un id único y los valores registrados

  Scenario: Create a new Product Request with missing or invalid values
    Given el endpoint POST "/api/v1/product-requests" está disponible
    When se envía una solicitud POST con valores faltantes o inválidos
    Then se recibe una respuesta con estado 400
    And el cuerpo de la respuesta incluye un mensaje de error indicando los problemas con los datos proporcionados

  Scenario: Update an existing Product Request
    Given el endpoint PUT "/api/v1/product-requests/{productRequestId}" está disponible
    When se envía una solicitud PUT con un productRequestId válido y nuevos valores para actualizar
    Then se recibe una respuesta con estado 200
    And los detalles de la Product Request se actualizan correctamente
    And el cuerpo de la respuesta refleja los valores actualizados

  Scenario: Update a Product Request with invalid data
    Given el endpoint PUT "/api/v1/product-requests/{productRequestId}" está disponible
    When se envía una solicitud PUT con un productRequestId válido pero datos no válidos
    Then se recibe una respuesta con estado 400
    And el cuerpo de la respuesta incluye un mensaje de error indicando qué valores son incorrectos

  Scenario: Update a non-existent Product Request
    Given el endpoint PUT "/api/v1/product-requests/{productRequestId}" está disponible
    When se envía una solicitud PUT con un productRequestId no válido
    Then se recibe una respuesta con estado 404
    And el cuerpo de la respuesta incluye un mensaje indicando que la Product Request no fue encontrada

  Scenario: Accept a Product Request
    Given el endpoint POST "/api/v1/product-requests/{productRequestId}/accept" está disponible
    When se envía una solicitud POST con un productRequestId válido
    Then se recibe una respuesta con estado 200
    And el estado de la Product Request se actualiza a ACCEPTED
    And el cuerpo de la respuesta incluye un mensaje de éxito y el productRequestId

  Scenario: Reject a Product Request
    Given el endpoint POST "/api/v1/product-requests/{productRequestId}/reject" está disponible
    When se envía una solicitud POST con un productRequestId válido
    Then se recibe una respuesta con estado 200
    And el estado de la Product Request se actualiza a REJECTED
    And el cuerpo de la respuesta incluye un mensaje de éxito y el productRequestId

  Scenario: Accept or Reject a non-existent Product Request
    Given el endpoint POST "/api/v1/product-requests/{productRequestId}/{action}" está disponible
    When se envía una solicitud POST con un productRequestId no válido
    Then se recibe una respuesta con estado 404
    And el cuerpo de la respuesta incluye un mensaje indicando que la Product Request no fue encontrada
