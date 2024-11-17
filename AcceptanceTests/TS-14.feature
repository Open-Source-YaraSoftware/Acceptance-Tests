Feature: Manage Profiles through RESTful API
  Como Developer
  Quiero gestionar perfiles a través del API
  Para que estén disponibles las funcionalidades de visualización y actualización de perfiles en la aplicación

  Scenario: Retrieve all Profiles
    Given el endpoint GET "/api/v1/profiles" está disponible
    When se envía una solicitud GET sin parámetros
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta incluye una lista de todos los Profiles
    And cada Profile tiene id, firstName, lastName, dni, email, age, location, y userId

  Scenario: Retrieve all Profiles when there are no Profiles
    Given el endpoint GET "/api/v1/profiles" está disponible
    When se envía una solicitud GET sin parámetros y no hay perfiles registrados
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta es una lista vacía

  Scenario: Retrieve details of a specific Profile
    Given el endpoint GET "/api/v1/profiles/{profileId}" está disponible
    When se envía una solicitud GET con un profileId válido
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta incluye los detalles completos del Profile, como firstName, lastName, dni, email, age, location, y userId

  Scenario: Retrieve details of a non-existent Profile
    Given el endpoint GET "/api/v1/profiles/{profileId}" está disponible
    When se envía una solicitud GET con un profileId no válido
    Then se recibe una respuesta con estado 404
    And el cuerpo de la respuesta incluye un mensaje indicando que el Profile no fue encontrado

  Scenario: Update an existing Profile
    Given el endpoint PUT "/api/v1/profiles/{profileId}" está disponible
    When se envía una solicitud PUT con un profileId válido y nuevos valores para actualizar
    Then se recibe una respuesta con estado 200
    And los detalles del Profile se actualizan correctamente
    And el cuerpo de la respuesta refleja los nuevos valores

  Scenario: Update a Profile with invalid data
    Given el endpoint PUT "/api/v1/profiles/{profileId}" está disponible
    When se envía una solicitud PUT con un profileId válido pero datos no válidos
    Then se recibe una respuesta con estado 400
    And el cuerpo de la respuesta incluye un mensaje de error explicando los problemas con los datos proporcionados

  Scenario: Update a non-existent Profile
    Given el endpoint PUT "/api/v1/profiles/{profileId}" está disponible
    When se envía una solicitud PUT con un profileId no válido
    Then se recibe una respuesta con estado 404
    And el cuerpo de la respuesta incluye un mensaje indicando que el Profile no fue encontrado
