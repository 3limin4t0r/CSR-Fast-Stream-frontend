Feature: Homepage in English

  Scenario: Homepage
    Given I am on "/"
    Then I should see "Hello"

  Scenario: Homepage
    Given I am on "/en"
    Then I should see "Hello"
