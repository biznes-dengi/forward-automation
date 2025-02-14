Feature: Test actuator endpoints

  Scenario: Testing health check endpoint
    Given url 'https://api.finansy.io/api/actuator/health'
    When method GET
    Then status 200
    And match $.status == "UP"

  Scenario: Testing ping check endpoint
    Given url 'https://api.finansy.io/api/actuator/ping'
    When method GET
    Then status 200