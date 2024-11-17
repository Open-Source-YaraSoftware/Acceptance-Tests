Feature: Manage Vehicles through RESTful API
  Como Developer
  Quiero gestionar vehículos a través del API
  Para que estén disponibles las funcionalidades de creación, actualización, recuperación y eliminación de vehículos en la aplicación

  Scenario: Retrieve all Vehicles
    Given el endpoint GET "/api/v1/vehicles" está disponible
    When se envía una solicitud GET sin parámetros
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta incluye una lista de todos los Vehicles
    And cada Vehicle tiene id, licensePlate, brand, model, image, userId, y iotDeviceId

  Scenario: Retrieve all Vehicles when there are no Vehicles
    Given el endpoint GET "/api/v1/vehicles" está disponible
    When se envía una solicitud GET sin parámetros y no hay vehículos registrados
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta es una lista vacía

  Scenario: Create a new Vehicle
    Given el endpoint POST "/api/v1/vehicles" está disponible
    When se envía una solicitud POST con valores válidos para licensePlate, brand, model, image, userId, y iotDeviceId
    Then se recibe una respuesta con estado 201
    And el cuerpo de la respuesta incluye un nuevo Vehicle con un id único y todos los valores registrados

  Scenario: Create a new Vehicle with missing or invalid values
    Given el endpoint POST "/api/v1/vehicles" está disponible
    When se envía una solicitud POST con valores faltantes o inválidos
    Then se recibe una respuesta con estado 400
    And el cuerpo de la respuesta incluye un mensaje de error explicando los problemas con los datos proporcionados

  Scenario: Retrieve details of a specific Vehicle
    Given el endpoint GET "/api/v1/vehicles/{vehicleId}" está disponible
    When se envía una solicitud GET con un vehicleId válido
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta incluye los detalles completos del Vehicle, como licensePlate, brand, model, image, userId, y iotDeviceId

  Scenario: Retrieve details of a non-existent Vehicle
    Given el endpoint GET "/api/v1/vehicles/{vehicleId}" está disponible
    When se envía una solicitud GET con un vehicleId no válido
    Then se recibe una respuesta con estado 404
    And el cuerpo de la respuesta incluye un mensaje indicando que el Vehicle no fue encontrado

  Scenario: Update an existing Vehicle
    Given el endpoint PUT "/api/v1/vehicles/{vehicleId}" está disponible
    When se envía una solicitud PUT con un vehicleId válido y nuevos valores para actualizar
    Then se recibe una respuesta con estado 200
    And los detalles del Vehicle se actualizan correctamente
    And el cuerpo de la respuesta refleja los nuevos valores

  Scenario: Update a Vehicle with invalid data
    Given el endpoint PUT "/api/v1/vehicles/{vehicleId}" está disponible
    When se envía una solicitud PUT con un vehicleId válido pero datos no válidos
    Then se recibe una respuesta con estado 400
    And el cuerpo de la respuesta incluye un mensaje de error explicando qué valores son incorrectos

  Scenario: Update a non-existent Vehicle
    Given el endpoint PUT "/api/v1/vehicl
