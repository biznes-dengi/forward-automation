Feature: Test scenarios for auth module

  Scenario: Should successfully register new user in the system
    Given url 'http://localhost:8080/api/auth/register'
    And request { "email": "test@test.com", "pass": "test", "nickname": "cool_test" }
    When method POST
    Then status 200
    And match $ contains #string

  Scenario: Shouldn't register new user with already existing credentials in the system
    Given url 'http://localhost:8080/api/auth/register'
    And request { "email": "test@test.com", "pass": "test", "nickname": "cool_test" }
    When method POST
    Then status 409
    And match $ contains { "date": "#string", "status": "409 CONFLICT", "message": "User with this email [test@test.com], already exists.", "cause": "#string" }

  Scenario: Should successfully login user in the system
    Given url 'http://localhost:8080/api/auth/login'
    And request { "email": "test@test.com", "pass": "test" }
    When method POST
    Then status 200
    And match $ contains "#string"

  Scenario: Shouldn't login user with incorrect password in the system
    Given url 'http://localhost:8080/api/auth/login'
    And request { "email": "test@test.com", "pass": "BOOLSHIT" }
    When method POST
    Then status 401
    And match $ contains { "date": "#string", "status": "401 AUTHORIZED", "message": "Exception occurred during [JWT generation]. Please check that data is valid.", "cause": "#string" }

  Scenario: Should successfully validate token in the system
    Given url 'http://localhost:8080/api/auth/validate'
    And request { "token": "TOKEN" }
    When method POST
    Then status 200
    And match $ contains { "email": "test@test.com", "isValid": true }

  Scenario: Shouldn't validate token without signature in the system
    Given url 'http://localhost:8080/api/auth/validate'
    And request { "token": "TOKEN" }
    When method POST
    Then status 401
    And match $ contains { "date": "#string", "status": "401 AUTHORIZED", "message": "Exception occurred during [JWT generation]. Please check that data is valid.", "cause": "#string" }ó