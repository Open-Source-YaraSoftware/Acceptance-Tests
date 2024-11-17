Feature: Manage Products through RESTful API
  Como Developer
  Quiero gestionar los productos a través del API
  Para que estén disponibles las funcionalidades de creación, actualización y eliminación de productos en la aplicación

  Scenario: Retrieve all Products
    Given el endpoint GET "/api/v1/products" está disponible
    When se envía una solicitud GET sin parámetros
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta incluye una lista de todos los Products
    And cada Product tiene id, name, description, stockQuantity, lowStockThreshold, y workshopId

  Scenario: Retrieve all Products when there are no Products
    Given el endpoint GET "/api/v1/products" está disponible
    When se envía una solicitud GET sin parámetros y no hay productos registrados
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta es una lista vacía

  Scenario: Create a new Product
    Given el endpoint POST "/api/v1/products" está disponible
    When se envía una solicitud POST con valores válidos para name, description, stockQuantity, lowStockThreshold, y workshopId
    Then se recibe una respuesta con estado 201
    And el cuerpo de la respuesta incluye el nuevo Product con un id único y los valores registrados

  Scenario: Create a new Product with missing or invalid values
    Given el endpoint POST "/api/v1/products" está disponible
    When se envía una solicitud POST con valores faltantes o inválidos para el producto
    Then se recibe una respuesta con estado 400
    And el cuerpo de la respuesta incluye un mensaje de error explicando los problemas con los datos proporcionados

  Scenario: Update an existing Product
    Given el endpoint PUT "/api/v1/products/{productId}" está disponible
    When se envía una solicitud PUT con un productId válido y nuevos valores para actualizar
    Then se recibe una respuesta con estado 200
    And los detalles del Product se actualizan correctamente
    And el cuerpo de la respuesta refleja los nuevos valores

  Scenario: Update a Product with invalid data
    Given el endpoint PUT "/api/v1/products/{productId}" está disponible
    When se envía una solicitud PUT con un productId válido pero datos no válidos
    Then se recibe una respuesta con estado 400
    And el cuerpo de la respuesta incluye un mensaje de error explicando qué valores son incorrectos

  Scenario: Update a non-existent Product
    Given el endpoint PUT "/api/v1/products/{productId}" está disponible
    When se envía una solicitud PUT con un productId no válido
    Then se recibe una respuesta con estado 404
    And el cuerpo de la respuesta incluye un mensaje indicando que el Product no fue encontrado

  Scenario: Delete a Product
    Given el endpoint DELETE "/api/v1/products/{productId}" está disponible
    When se envía una solicitud DELETE con un productId válido
    Then se recibe una respuesta con estado 204
    And el Product se elimina de manera permanente

  Scenario: Delete a non-existent Product
    Given el endpoint DELETE "/api/v1/products/{productId}" está disponible
    When se envía una solicitud DELETE con un productId no válido
    Then se recibe una respuesta con estado 404
    And el cuerpo de la respuesta incluye un mensaje indicando que el Product no fue encontrado
