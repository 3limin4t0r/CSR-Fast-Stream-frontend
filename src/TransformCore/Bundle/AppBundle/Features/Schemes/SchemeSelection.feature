Feature: As registrant, I want to be able to add education details, to fully indicate my experience and skills

  Background:
    Given following users for each persona exist on system:
      | persona8@test.com |
    And "persona8@test.com" has completed sections "All"

  @CSR-318 @omit
  Scenario: Scheme selection
    Given I am logged in as "persona6@test.com" with password "P@ssword1"
    And I follow "My Applications"
    Then I should see "Select Programme"
    When I check "Digital and Technology"
    And I press "Save and continue"
    Then I should see "Select Scheme - First Preference"