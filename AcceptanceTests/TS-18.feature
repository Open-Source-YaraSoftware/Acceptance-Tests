Feature: Manage Subscriptions through RESTful API
  Como Developer
  Quiero gestionar las suscripciones a través del API
  Para que estén disponibles las funcionalidades de creación, recuperación y cancelación de suscripciones para talleres en la aplicación

  Scenario: Retrieve all Subscriptions for a Workshop
    Given el endpoint GET "/api/v1/subscriptions" está disponible
    When se envía una solicitud GET con un workshopId válido como parámetro de consulta
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta incluye una lista de todas las SubscriptionItems asociadas al workshopId
    And cada SubscriptionItem tiene detalles como status, startedAt, endedAt, isTrial, y trialEndsAt

  Scenario: Retrieve Subscriptions for a Workshop when there are no Subscriptions
    Given el endpoint GET "/api/v1/subscriptions" está disponible
    When se envía una solicitud GET con un workshopId válido que no tiene suscripciones asociadas
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta es una lista vacía

  Scenario: Create a new Subscription
    Given el endpoint POST "/api/v1/subscriptions" está disponible
    When se envía una solicitud POST con valores válidos para workshopId, userId, planId, y otros detalles necesarios
    Then se recibe una respuesta con estado 201
    And el cuerpo de la respuesta incluye la nueva SubscriptionItem con un id único y los valores registrados

  Scenario: Create a new Subscription with missing or invalid values
    Given el endpoint POST "/api/v1/subscriptions" está disponible
    When se envía una solicitud POST con valores faltantes o no válidos
    Then se recibe una respuesta con estado 400
    And el cuerpo de la respuesta incluye un mensaje de error indicando los problemas con los datos proporcionados

  Scenario: Retrieve the Latest Subscription for a Workshop
    Given el endpoint GET "/api/v1/subscriptions/latest" está disponible
    When se envía una solicitud GET con un workshopId válido como parámetro de consulta
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta incluye la última SubscriptionItem activa o relevante asociada al workshopId

  Scenario: Retrieve the Latest Subscription for a Workshop when no Subscriptions exist
    Given el endpoint GET "/api/v1/subscriptions/latest" está disponible
    When se envía una solicitud GET con un workshopId válido que no tiene suscripciones
    Then se recibe una respuesta con estado 404
    And el cuerpo de la respuesta incluye un mensaje indicando que no se encontraron suscripciones

  Scenario: Cancel an Existing Subscription
    Given el endpoint POST "/api/v1/subscriptions/{subscriptionId}/cancel" está disponible
    When se envía una solicitud POST con un subscriptionId válido
    Then se recibe una respuesta con estado 200
    And el estado de la SubscriptionItem se actualiza a CANCELLED
    And cancelledAt se establece con la fecha y hora actuales

  Scenario: Cancel a non-existent Subscription
    Given el endpoint POST "/api/v1/subscriptions/{subscriptionId}/cancel" está disponible
    When se envía una solicitud POST con un subscriptionId no válido
    Then se recibe una respuesta con estado 404
    And el cuerpo de la respuesta incluye un mensaje indicando que la suscripción no fue encontrada
