Feature: As a user, I want to be able to select a first programme preference, in order to progress my application

  @CSR-318 @omit
  Scenario Outline: Select first programme preference
    Given I am on "/en/applicant/programmeselection"
    And I fill form with: 
      | <schemeId> | 1 |
    And I press "Save and continue"
    Then I should see "First preference programme: <scheme>"

  Examples:
    | scheme                  | schemeId |
    | Diplomatic Service      |          |
    | Houses of Parliament    |          |
    | Science and Engineering |          |
    | Central Departments     |          |
