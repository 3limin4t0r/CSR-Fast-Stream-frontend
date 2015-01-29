Feature: As registrant, I want to be able to add education details, to fully indicate my experience and skills

  Background:
    Given following users for each persona exist on system:
      | six@test.com   |
      | seven@test.com |
    And "six@test.com" has completed sections "About You, Nationality"
    And "seven@test.com" has completed sections "About You, Nationality"

  @CSR-26 @omit
  Scenario: Add education details (happy path)
    Given I am logged in as "six@test.com" with password "P@ssword1"
    And I follow "My Details"
    And I press "Save and continue"
    And I press "Save and continue"
    Then I should see "Education"
    When I check "civil-servant-yes"
    And I check "undergraduate-degree-inside-uk"
    And I check "postgraduate-degree-no"
    And I check "summer-diversity-internship-programme-no"
    And I check "early-diversity-internship-programme-yes"
    And I check "summer-diversity-internship-programme-completed-no"
    And I press "Save and continue"
    And I should see "Please enter details of government department you were in for summer diversity internship"
    And I should see "Please enter details of government department you were in for early diversity internship"
    And I should see "Please enter date you completed summer diversity internship"
    And I should see "Please enter date you completed early diversity internship"
    And I select "Oct 14" from "summer-diversity-internship-programme-date"
    Then I fill in "summer-diversity-programme-detail" with "Summer diversity programme government department"
    And I select "Oct 14" from "early-diversity-internship-programme-date"
    And I fill in "early-diversity-programme-detail" with "Early diversity programme government department"
    Then I fill in "summer-diversity-programme-detail" with "Summer diversity programme detail"
    And I press "Save and continue"
    Then I should see "Diversity"
    And I follow "go back to the previous section"
    Then the "civil-servant-yes" checkbox should be checked
    And the "undergraduate-degree-inside-uk" checkbox should be checked
    And the "postgraduate-degree-no" checkbox should be checked
    And the "summer-diversity-internship-programme-yes" checkbox should be checked
    And the "early-diversity-programme-detail" field should contain "Summer diversity programme government department"
    And the "early-diversity-internship-programme-yes" checkbox should be checked
    And the "summer-diversity-programme-detail" field should contain "Early diversity programme government department"
    And the "summer-diversity-internship-programme-completed-no" checkbox should be checked

  @CSR-26 @omit
  Scenario: Add education details (mandatory field check)
    Given I am logged in as "seven@test.com" with password "P@ssword1"
    And I follow "My Details"
    And I press "Save and continue"
    And I press "Save and continue"
    Then I should see "Education"
    And I press "Save and continue"
    Then I should see "Please indicate whether you are an existing Civil Servant"
    And I should see "Please complete the Undergraduate degree section"
    And I should see "Please complete the Postgraduate degree section"
    And I should see "Please indicate whether or not you completed the Early Diversity Internship Programme"
    And I should see "Please indicate whether or not you completed the Summer Diversity Internship Programme"



  Internship Programmes
  @CSR-26 @omit
  Scenario: Applying via In Service Route

  @CSR-26 @omit
  Scenario: Education details fields validation
