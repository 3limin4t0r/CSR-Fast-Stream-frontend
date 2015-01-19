Feature: As an applicant after logging in I want to see my homepage

  Background:
    Given following users for each persona exist on system:
      | persona4@test.com |
      | persona5@test.com |
    And "persona4@test.com" has completed the "About you,Nationality" section
    And "persona5@test.com" has completed the "About you,Nationality" section

  @CSR-196
  Scenario: Complete Nationality and immigration section (Happy path)
    Given I am logged in as "persona4@test.com" with password "P@ssword1"
    And I follow "My Details"
    Then I should see "About You"
    And I follow "save-and-continue"
    Then I should see "Nationality"
    And I follow "save-and-continue"
    Then I should see "Diversity"
    And I fill form with:
      | gender                          | Male                                                                        |
      | ethnic-origin                   | White - English / Welsh / Scottish / Northern Irish / British               |
      | religion                        | Agnostic                                                                    |
      | sexual-orientation              | Prefer not to say                                                           |
      | marital-status                  | Separated                                                                   |
      | school-attended                 | A state run or funded school that selected on the basis of academic ability |
      | first-to-attend-university      | No                                                                          |
      | school-meals-eligibility        | No                                                                          |
      | three-plus-months-in-care       | No                                                                          |
      | refugee-status-or-asylum-status | Prefer Not to Say                                                           |
    And I press "save-and-continue"
    Then I should see "Socio Economic Details"
    And I follow "go back to the previous section"
    Then I should see form with:
      | gender                          | Male                                                                        |
      | ethnic-origin                   | White - English / Welsh / Scottish / Northern Irish / British               |
      | religion                        | Agnostic                                                                    |
      | sexual-orientation              | Prefer not to say                                                           |
      | marital-status                  | Separated                                                                   |
      | school-attended                 | A state run or funded school that selected on the basis of academic ability |
      | first-to-attend-university      | No                                                                          |
      | school-meals-eligibility        | No                                                                          |
      | three-plus-months-in-care       | No                                                                          |
      | refugee-status-or-asylum-status | Prefer Not to Say                                                           |