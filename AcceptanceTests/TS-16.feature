Feature: Manage Notifications through RESTful API
  Como Developer
  Quiero recuperar notificaciones para un usuario a través del API
  Para que estén disponibles las funcionalidades de mostrar y gestionar notificaciones en la aplicación

  Scenario: Retrieve all Notifications for a User
    Given el endpoint GET "/api/v1/notifications" está disponible
    When se envía una solicitud GET con un userId válido como parámetro de consulta
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta incluye una lista de todas las Notifications asociadas al userId
    And cada Notification tiene date, content, state, y endpoint

  Scenario: Retrieve Notifications for a User when there are no Notifications
    Given el endpoint GET "/api/v1/notifications" está disponible
    When se envía una solicitud GET con un userId válido que no tiene notificaciones asociadas
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta es una lista vacía

  Scenario: Retrieve Notifications with an invalid or non-existent userId
    Given el endpoint GET "/api/v1/notifications" está disponible
    When se envía una solicitud GET con un userId no válido o inexistente
    Then se recibe una respuesta con estado 404
    And el cuerpo de la respuesta incluye un mensaje indicando que el User no fue encontrado o que no hay notificaciones asociadas
