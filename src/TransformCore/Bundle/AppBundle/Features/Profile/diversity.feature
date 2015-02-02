Feature: As an applicant after logging in I want to see my homepage

  Background:
    Given following users for each persona exist on system:
      | four@test.com |
      | five@test.com |
    And "four@test.com" has completed sections "About you,Nationality,Education"
    And "five@test.com" has completed sections "About you,Nationality,Education"

  @CSR-196
  Scenario: Complete Nationality and immigration section (Happy path)
    Given I am logged in as "four@test.com" with password "P@ssword1"
    And I follow "Profile"
    Then I should see "First name"
    And I press "Save and Continue"
    Then I should see "Nationality, Immigration and Employment Restrictions"
#    And I press "Save and Continue"
#    Then I should see "Education"
    And I press "Save and Continue"
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


  @CSR-196
  Scenario: Complete Nationality and immigration section (Mandatory field validation)
    Given I am logged in as "five@test.com" with password "P@ssword1"
    And I follow "Profile"
    Then I should see "First name"
    And I press "Save and Continue"
    Then I should see "Nationality, Immigration and Employment Restrictions"
#    And I press "Save and Continue"
#    Then I should see "Education"
    And I press "Save and Continue"
    Then I should see "Diversity"
    And I press "Save and Continue"
    Then I should see "This value should not be blank"
    And I select "Male" from "gender"
    And I press "Save and Continue"
    Then I should see "This value should not be blank"
    Then I select "Mixed - White and Black Caribbean" from "ethnic-origin"
    And I press "Save and Continue"
    Then I should see "This value should not be blank"
    Then I select "Zoroastrianism" from "religion"
    And I press "Save and Continue"
    Then I should see "This value should not be blank"
    Then I select "Prefer not to say" from "sexual-orientation"
    And I press "Save and Continue"
    Then I should see "This value should not be blank"
    Then I select "In a Domestic Partnership" from "marital-status"
    And I press "Save and Continue"
    Then I should see "This value should not be blank"
    Then I select "An independent school, and your fees were not paid in part by the local authority or bursary/scholarship" from "school-type"
    And I press "Save and Continue"
    Then I should see "This value should not be blank"
    Then I select "Yes" from "first-family-member-in-university"
    And I press "Save and Continue"
    Then I should see "This value should not be blank"
    Then I select "Yes" from "free-meals-eligible"
    And I press "Save and Continue"
    Then I should see "This value should not be blank"
    Then I select "Prefer Not to Say" from "longer-than-three-months-in-care"
    And I press "Save and Continue"
    Then I should see "This value should not be blank"
    Then I select "Prefer Not to Say" from "asylum-seeker-refugee-status"
    And I press "Save and Continue"
    Then I should see "Education"