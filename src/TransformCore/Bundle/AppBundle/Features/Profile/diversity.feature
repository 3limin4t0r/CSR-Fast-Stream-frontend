Feature: As an applicant after logging in I want to see my homepage

  Background:
    Given following users for each persona exist on system:
      | four@test.com |
      | five@test.com |
    And "four@test.com" has completed sections "About you,Nationality,Education"
    And "five@test.com" has completed sections "About you,Nationality,Education"

  @CSR-196 @omit
  Scenario: Complete Nationality and immigration section (Happy path)
    Given I am logged in as "four@test.com" with password "P@ssword1"
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


  @CSR-196 @omit
  Scenario: Complete Nationality and immigration section (Mandatory field validation)
    Given I am logged in as "five@test.com" with password "P@ssword1"
    And I follow "My Details"
    Then I should see "About You"
    And I follow "save-and-continue"
    Then I should see "Nationality"
    And I follow "save-and-continue"
    Then I should see "Diversity"
    And I follow "save-and-continue"
    Then I should see "Please select gender"
    And I select "Male" from "gender"
    And I follow "save-and-continue"
    Then I should see "Please select gender"
    Then I select "Mixed - White and Black Caribbean" from "ethnic-origin"
    And I follow "save-and-continue"
    Then I should see "Please select religion"
    Then I select "Zoroastrianism" from "religion"
    And I follow "save-and-continue"
    Then I should see "Please select sexual orientation"
    Then I select "Prefer not to say" from "sexual-orientation"
    And I follow "save-and-continue"
    Then I should see "Please select marital status"
    Then I select "In a Domestic Partnership" from "marital-status"
    And I follow "save-and-continue"
    Then I should see "Please select school type"
    Then I select "An independent school, and your fees were not paid in part by the local authority or bursary/scholarship" from "school-type"
    And I follow "save-and-continue"
    Then I should see "Please select whether or not your are first member of your family to attend university"
    Then I select "Yes" from "first-family-member-in-university"
    And I follow "save-and-continue"
    Then I should see "Please select whether you were eligible for school meals"
    Then I select "Yes" from "free-meals-eligible"
    And I follow "save-and-continue"
    Then I should see "Please select whether or not you have been in care for over 3 months"
    Then I select "Prefer Not to Say" from "longer-than-three-months-in-care"
    And I follow "save-and-continue"
    Then I should see "Please select Please select whether or not you have been has either asylum seeker or refugee status"
    Then I select "Prefer Not to Say" from "asylum-seeker-refugee-status"
    And I follow "save-and-continue"
    Then I should see "Education"