Feature: Pruebas API del inventario

  Background:
    * url 'https://httpbin.org'

  Scenario: Validar respuesta básica de disponibilidad de API
    Given path 'get'
    When method get
    Then status 200
    And match response.url contains 'httpbin.org/get'
