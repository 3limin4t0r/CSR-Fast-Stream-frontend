Feature: As registrant, I want to be able to add education details, to fully indicate my experience and skills

  Background:
    Given following users for each persona exist on system:
      | six@test.com   |
      | seven@test.com |
    And "six@test.com" has completed sections "About You, Nationality"
    And "seven@test.com" has completed sections "About You, Nationality"

  @CSR-26
  Scenario: Add education details (degrees completed and not a civil servant)
    Given I am logged in as "six@test.com" with password "P@ssword1"
#    And I follow "Profile"
#    And I press "Save and continue"
#    And I press "Save and continue"
    And I am on "/en/applicant/education"
    Then I should see "Education"
    And I fill form with:
      | csr_dm_form_education_existingCivilServant_0 | 0 |
      | csr_dm_form_education_undergraduateDegree_0  | 0 |
      | csr_dm_form_education_postgraduateDegree_0   | 0 |
      | csr_dm_form_education_earlyIntern_1          | 1 |
      | csr_dm_form_education_summerIntern_1         | 1 |
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
    Then the "civil-servant-no" checkbox should be checked
    And the "undergraduate-degree-no" checkbox should be checked
    And the "postgraduate-degree-no" checkbox should be checked
    And the "early-diversity-internship-programme-yes" checkbox should be checked
    And the "summer-diversity-internship-programme-yes" checkbox should be checked
    And the "early-diversity-programme-detail" field should contain "Summer diversity programme government department"
    And the "early-diversity-internship-programme-yes" checkbox should be checked
    And the "summer-diversity-programme-detail" field should contain "Early diversity programme government department"

  @CSR-26
  Scenario: Add education details (degrees completed and civil servant)
    Given I am logged in as "six@test.com" with password "P@ssword1"
#    And I follow "Profile"
#    And I press "Save and continue"
#    And I press "Save and continue"
    And I am on "/en/applicant/education"
    Then I should see "Education"
    When I check the "csr_dm_form_education_existingCivilServant_1" radio button
    Then I check "csr_dm_form_education_fastTrackScheme"
    And I select "Scheme 1" from "csr_dm_form_education_schemeName"
    And I fill in "csr_dm_form_education_yearOfCompletion" with "2015"
    And I check the "csr_dm_form_education_undergraduateDegree_1" radio button
    And I check the "csr_dm_form_education_postgraduateDegree_1" radio button
    And I check the "csr_dm_form_education_earlyInternCompleted_0" radio button
    And I check the "csr_dm_form_education_summerInternCompleted_0" radio button
    When I press "Save and continue"
    And I should see "Please indicate if you will complete Fast Track apprentice scheme in this recruitment year"
    And I should see "Please enter details of undergraduate degree"
    And I should see "Please enter details of postgraduate degree"
    And I should see "Please enter Fast Track apprentice scheme"
    And I should see "Please enter Fast Track apprentice year of completion"
    Then I select "2015" from "year-of-completion"
    And I select "finance" from "fast-track-scheme"
    And I fill in "csr_dm_form_education_undergradDegrees_0_university" with "Undergraduate University 1"
    And I select "First-class honours" from "csr_dm_form_education_undergradDegrees_0_grade"
    And I fill in "csr_dm_form_education_postgradDegrees_0_university" with "Postgraduate University 1"
    And I select "Ordinary degree" from "csr_dm_form_education_postgradDegrees_0_grade"
    And I press "Save and continue"
    Then I should see "Diversity"
    And I follow "go back to the previous section"
    Then the "civil-servant-yes" checkbox should be checked
    And the "undergraduate-degree-inside-uk" checkbox should be checked
    And the "postgraduate-degree-no" checkbox should be checked
    And the "summer-diversity-internship-programme-no" checkbox should be checked
    And the "early-diversity-internship-programme-no" checkbox should be checked
    And the "undergraduate-university" field should contain "Undergraduate University 1"
    And the "postgraduate-university" field should contain "Postgraduate University 1"

  @CSR-26
  Scenario: Add education details (mandatory field check)
    Given I am logged in as "seven@test.com" with password "P@ssword1"
#    And I follow "Profile"
#    And I press "Save and continue"
#    And I press "Save and continue"
    And I am on "/en/applicant/education"
    Then I should see "Education"
    And I press "Save and continue"
    Then I should see "Please indicate whether or not you are an existing Civil Servant"
    And I should see "Please complete the Undergraduate degree section"
    And I should see "Please complete the Postgraduate degree section"
    And I should see "Please indicate whether or not you completed the Early Diversity Internship Programme"
    And I should see "Please indicate whether or not you completed the Summer Diversity Internship Programme"

  @CSR-26
  Scenario: Add education details (no degrees needed)
    Given I am logged in as "six@test.com" with password "P@ssword1"
#    And I follow "Profile"
#    And I press "Save and continue"
#    And I press "Save and continue"
    And I am on "/en/applicant/education"
    Then I should see "Education"
    When I check the "csr_dm_form_education_existingCivilServant_0" radio button
    And I check "csr_dm_form_education_inServiceRoute"
#    And I check "undergraduate-degree-no"
#    And I check "postgraduate-degree-no"
    And I check the "summer-diversity-internship-programme-yes" radio button
    And I check the "early-diversity-internship-programme-yes" radio button
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
