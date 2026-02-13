Feature: Gestión de Inventario - API REST
  Como consumidor de la API
  Quiero gestionar productos en el inventario
  Para poder crear, consultar, actualizar y eliminar productos

  Background:
    * url karate.properties['baseUrl'] ? karate.properties['baseUrl'] : 'http://localhost:8080'
    * path 'api', 'products'
    * configure headers = { 'Content-Type': 'application/json' }

  # 1. Crear un producto exitosamente
  Scenario: Crear un producto con datos válidos
    * def payload =
      """
      {
        "name": "Laptop HP",
        "description": "Laptop 16GB RAM",
        "price": 15000.50,
        "stock": 10,
        "sku": "HP-12345"
      }
      """
    And request payload
    When method post
    Then status 201
    And match response.id == '#number'
    And match response.name == 'Laptop HP'
    And match response.stock == 10

  # 2. Intentar crear un producto con datos inválidos
  Scenario: Intentar crear un producto con datos inválidos
    * def payloadInvalido =
      """
      {
        "name": "",
        "description": "Producto sin precio",
        "price": -100,
        "stock": -5,
        "sku": ""
      }
      """
    And request payloadInvalido
    When method post
    Then status 400
    And match response.message == '#string'
    And match response.errors == '#[]'

  # 3. Obtener un producto por su ID
  Scenario: Obtener un producto existente por ID
    Given path 'api', 'products', 1
    When method get
    Then status 200
    And match response.id == 1
    And match response.name == '#string'
    And match response.price == '#number'
    And match response.stock == '#number'

  # 4. Intentar obtener un producto con un ID inexistente
  Scenario: Obtener un producto con ID inexistente
    Given path 'api', 'products', 9999
    When method get
    Then status 404
    And match response.message == 'Producto no encontrado'

  # 5. Actualizar un producto existente
  Scenario: Actualizar un producto existente
    * def payloadActualizacion =
      """
      {
        "name": "Laptop HP Actualizada",
        "description": "Laptop 32GB RAM",
        "price": 18000.00,
        "stock": 8,
        "sku": "HP-12345"
      }
      """
    Given path 'api', 'products', 2
    And request payloadActualizacion
    When method put
    Then status 200
    And match response.name == 'Laptop HP Actualizada'
    And match response.stock == 8

  # 6. Eliminar un producto
  Scenario: Eliminar un producto existente
    Given path 'api', 'products', 3
    When method delete
    Then status 204

    Given path 'api', 'products', 3
    When method get
    Then status 404

  # 7. Validar esquema de respuesta JSON
  Scenario: Validar esquema id/nombre/cantidad
    * def response = { id: 10, nombre: 'Teclado Mecánico', cantidad: 25 }
    * match response == { id: '#number', nombre: '#string', cantidad: '#? _ == Math.floor(_)'}
