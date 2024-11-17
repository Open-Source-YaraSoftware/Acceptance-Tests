Feature: Manage Invoices through RESTful API
  Como Developer
  Quiero gestionar las facturas a través del API
  Para que estén disponibles las funcionalidades de creación y recuperación de facturas para talleres en la aplicación

  Scenario: Create a new Invoice
    Given el endpoint POST "/api/invoices" está disponible
    When se envía una solicitud POST con valores válidos para subscriptionId, workshopId, planId, amount, status, issueDate, dueDate, y paymentDate
    Then se recibe una respuesta con estado 201
    And el cuerpo de la respuesta incluye la nueva Invoice con un id único y los valores registrados

  Scenario: Create a new Invoice with missing or invalid values
    Given el endpoint POST "/api/invoices" está disponible
    When se envía una solicitud POST con valores faltantes o inválidos
    Then se recibe una respuesta con estado 400
    And el cuerpo de la respuesta incluye un mensaje de error indicando los problemas con los datos proporcionados

  Scenario: Retrieve all Invoices for a Workshop
    Given el endpoint GET "/api/invoices" está disponible
    When se envía una solicitud GET con un workshopId válido como parámetro de consulta
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta incluye una lista de todas las Invoices asociadas al workshopId
    And cada Invoice tiene detalles como amount, status, issueDate, dueDate, y paymentDate

  Scenario: Retrieve Invoices for a Workshop when there are no Invoices
    Given el endpoint GET "/api/invoices" está disponible
    When se envía una solicitud GET con un workshopId válido que no tiene facturas asociadas
    Then se recibe una respuesta con estado 200
    And el cuerpo de la respuesta es una lista vacía

  Scenario: Handle unexpected server error when retrieving Invoices
    Given el endpoint GET "/api/invoices" está disponible
    When se produce un error inesperado en el servidor al intentar recuperar las facturas
    Then se recibe una respuesta con estado 500
    And el cuerpo de la respuesta incluye un mensaje indicando que ocurrió un error en el servidor
