Feature: Manage IoT Devices through RESTful API
  Como Developer
  Quiero recuperar dispositivos IoT asociados a un vehículo a través del API
  Para que estén disponibles las funcionalidades de monitoreo y gestión de dispositivos IoT en la aplicación

  Scenario: Retrieve all IoT Devices for a Vehicle
    Given el endpoint GET "/api/v1/iot-devices" está disponible
    When se envía una solicitud GET con un vehicleId válido como parámetro de consulta
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta incluye una lista de todos los IoTDevices asociados al vehicleId
    And cada IoTDevice tiene id, deviceName, status, y lastCommunication

  Scenario: Retrieve IoT Devices for a Vehicle when there are no IoT Devices
    Given el endpoint GET "/api/v1/iot-devices" está disponible
    When se envía una solicitud GET con un vehicleId válido que no tiene dispositivos IoT asociados
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta es una lista vacía

  Scenario: Retrieve IoT Devices with an invalid or non-existent vehicleId
    Given el endpoint GET "/api/v1/iot-devices" está disponible
    When se envía una solicitud GET con un vehicleId no válido o que no existe
    Then se recibe una respuesta con estado 404
    And el cuerpo de la respuesta incluye un mensaje indicando que el Vehicle no fue encontrado o que no hay dispositivos IoT asociados
