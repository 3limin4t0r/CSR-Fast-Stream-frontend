Feature: As a user, I want to be able to select a first scheme preference, in order to progress my application

  @CSR-319
  Scenario Outline: Select first scheme preference
    Given I am logged in as "four@test.com" with password "P@ssword1"
    And I am on "/en/scheme/selection"
    And I fill form with:
      | <schemeId> | <scheme> |
    And I press "Select scheme (second preference)"
    Then I should see "Your changes were saved"
  Examples:
    | scheme                  | schemeId                |
    | Diplomatic Service      | csr_dm_scheme_selection_name_0 |
    | Houses of Parliament    | csr_dm_scheme_selection_name_1 |
    | Science and Engineering | csr_dm_scheme_selection_name_2 |
    | Central Departments     | csr_dm_scheme_selection_name_3 |