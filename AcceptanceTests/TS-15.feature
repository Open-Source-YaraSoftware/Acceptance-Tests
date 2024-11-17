Feature: Manage User Authentication and Registration through RESTful API
  Como Developer
  Quiero gestionar el registro y autenticación de usuarios a través del API
  Para que estén disponibles las funcionalidades de creación de cuentas y gestión de sesiones en la aplicación

  Scenario: User Registration (Sign-Up)
    Given el endpoint POST "/api/v1/authentication/sign-up" está disponible
    When se envía una solicitud POST con valores válidos para username, password, state, role, y workshopId
    Then se recibe una respuesta con estado 201
    And el cuerpo de la respuesta incluye un nuevo User con un id único y los valores registrados
    And la contraseña se almacena de manera segura (hash)

  Scenario: User Registration with missing or invalid values
    Given el endpoint POST "/api/v1/authentication/sign-up" está disponible
    When se envía una solicitud POST con valores faltantes o no válidos
    Then se recibe una respuesta con estado 400
    And el cuerpo de la respuesta incluye un mensaje de error indicando los problemas con los datos proporcionados

  Scenario: User Authentication (Sign-In)
    Given el endpoint POST "/api/v1/authentication/sign-in" está disponible
    When se envía una solicitud POST con valores correctos para username y password
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta incluye un token de autenticación válido
    And el token tiene un tiempo de expiración y es almacenado de manera segura

  Scenario: User Authentication with incorrect credentials
    Given el endpoint POST "/api/v1/authentication/sign-in" está disponible
    When se envía una solicitud POST con valores incorrectos para username o password
    Then se recibe una respuesta con estado 401
    And el cuerpo de la respuesta incluye un mensaje indicando que las credenciales son incorrectas

  Scenario: User Authentication with missing values
    Given el endpoint POST "/api/v1/authentication/sign-in" está disponible
    When se envía una solicitud POST sin username o password
    Then se recibe una respuesta con estado 400
    And el cuerpo de la respuesta incluye un mensaje de error indicando los valores faltantes
