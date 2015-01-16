Feature: Homepage in English

  Scenario: Homepage
    Given I am on "/"
    Then I should see "Join the Civil Service Fast Stream"

  Scenario: Homepage
    Given I am on "/en"
    Then I should see "Join the Civil Service Fast Stream"
