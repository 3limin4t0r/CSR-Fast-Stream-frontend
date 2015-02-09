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
    | Analytical                            |             | 
    | Human Resources                       |             | 
    | Government Communication Service      |             |     
    | Northern Ireland                      |             | 
    | Generalist                            |             | 
    | Commercial and Finance                |             | 
    | Digital and Technology                |             | 
    | European                              |             | 
    | Summer Diversity Internship Programme |             | 
    | Early Diversity Internship Programme  |             |

