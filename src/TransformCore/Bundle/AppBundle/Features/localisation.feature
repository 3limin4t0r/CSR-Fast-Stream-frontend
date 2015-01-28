Feature: Localisation

  Scenario: Switching localisation
    Given I am on "/en/terms-and-conditions"
    Then I should see "Terms and Conditions"
    When I follow "fr"
    Then I should see "Termes et conditions"
