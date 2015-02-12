Feature: As a user, I want to be able to select a first scheme preference, in order to progress my application

  @CSR-319 @omit
  Scenario: Attempt to progress without selection
    Given I am logged in as "four@test.com" with password "P@ssword1"
    And I am on "/en/scheme/selection"
    And I press "Select scheme"
    Then I should see "This value should not be blank"

  @CSR-319
  Scenario Outline: Select first scheme preference
    Given I am logged in as "four@test.com" with password "P@ssword1"
    And I am on "/en/scheme/selection"
    And I fill form with:
      | <schemeId> | <scheme> |
    And I press "Select scheme"
    Then I should see "<pageHeading>"
  Examples:
    | scheme                  | schemeId                       | pageHeading                    |
    | Diplomatic Service      | csr_dm_scheme_selection_name_0 | Diplomatic Service Eligibility |
    | Houses of Parliament    | csr_dm_scheme_selection_name_1 | Houses of Parliament           |
    | Science and Engineering | csr_dm_scheme_selection_name_2 | Science and Engineering        |
    | Central Departments     | csr_dm_scheme_selection_name_3 | Central Departments            |
