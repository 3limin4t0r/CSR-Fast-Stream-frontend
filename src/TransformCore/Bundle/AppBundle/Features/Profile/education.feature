Feature: As registrant, I want to be able to add education details, to fully indicate my experience and skills

  Background:
    Given following users for each persona exist on system:
      | six@test.com |
      | seven@test.com |
    And "six@test.com" has completed sections "About You, Nationality"
    And "seven@test.com" has completed sections "About You, Nationality"

@CSR-26 @omit
  Scenario: Add education details (no degree needed)
    Given I am logged in as "six@test.com" with password "P@ssword1"
    And I follow "My Details"
    And I press "Save and continue"
    And I press "Save and continue"
    Then I should see "Education"
    When I check "I want to apply for the Early Diversity Internship Programme or the Summer Diversity Internship Programme"
    And I press "Save and continue"
    Then I should see "Please answer whether or not you took the Early Diversity Internship Programme"
    Then I should see "Please answer whether or not you took the Summer Diversity Internship Programme"
    And I check "early-diversity-internship-programme-no"
    And I check "summer-diversity-internship-programme-no"
    And I press "Save and continue"
    Then I should see "Diversity"
    And I follow "go back to the previous section"

  @CSR-26 @omit
  Scenario: Add education details (degreee needed)
    Given I am logged in as "seven@test.com" with password "P@ssword1"
    And I follow "My Details"
    And I press "Save and continue"
    And I press "Save and continue"

  @CSR-26 @omit
  Scenario: Applying via In Service Route

  @CSR-26 @omit
  Scenario: Education details fields validation
