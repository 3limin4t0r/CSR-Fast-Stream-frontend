Feature: As a user, I want to be able to select a first programme preference, in order to progress my application

  @CSR-318
  Scenario Outline: Select first programme preference
    Given I am logged in as "nine@test.com" with password "P@ssword1"
    And I am on "/en/programme/selection"
    And I fill form with:
      | <programmeId> | <programme> |
    And I press "Save and Continue"
    Then I should see "Your changes were saved"

  Examples:
    | programme                             | programmeId |
    | Analytical                            | csr_dm_program_selection_name_0           |
    | Human Resources                       | csr_dm_program_selection_name_1           |
    | Government Communication Service      | csr_dm_program_selection_name_2           |
    | Northern Ireland                      | csr_dm_program_selection_name_3           |
    | Generalist                            | csr_dm_program_selection_name_4           |
    | Commercial and Finance                | csr_dm_program_selection_name_5           |
    | Digital and Technology                | csr_dm_program_selection_name_6           |
    | European                              | csr_dm_program_selection_name_7           |
    | Summer Diversity Internship Programme | csr_dm_program_selection_name_8           |
    | Early Diversity Internship Programme  | csr_dm_program_selection_name_9           |

  @CSR-318
  Scenario: Attempt to progress without selection
    Given I am logged in as "eight@test.com" with password "P@ssword1"
    And I am on "/en/programme/selection"
    And I press "Save and Continue"
    Then I should see "This value should not be blank"