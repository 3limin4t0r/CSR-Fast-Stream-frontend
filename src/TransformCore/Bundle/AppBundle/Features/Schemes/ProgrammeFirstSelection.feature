Feature: As a user, I want to be able to select a first programme preference, in order to progress my application

  @CSR-318 @omit
  Scenario Outline: Select first programme preference
    Given I am logged in as "eleven@test.com" with password "P@ssword1"
    And I am on "/en/applicant/programmeselection"
    And I fill form with:
      | <programmeId> | 1 |
    And I press "Save and continue"
    Then I should see "First preference programme: <programme>"

  Examples:
    | programme                             | programmeId |
    | Analytical                            | x           |
    | Human Resources                       | x           |
    | Government Communication Service      | x           |
    | Northern Ireland                      | x           |
    | Generalist                            | x           |
    | Commercial and Finance                | x           |
    | Digital and Technology                | x           |
    | European                              | x           |
    | Summer Diversity Internship Programme | x           |
    | Early Diversity Internship Programme  | x           |

