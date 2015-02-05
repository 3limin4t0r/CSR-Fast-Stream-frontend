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
      | csr_dm_form_education_existingCivilServant_0 | 0   |
      | csr_dm_form_education_inServiceRoute         | Yes |
      | csr_dm_form_education_undergraduateDegree_0  | 0   |
      | csr_dm_form_education_postgraduateDegree_0   | 0   |
      | csr_dm_form_education_earlyIntern_1          | 1   |
      | csr_dm_form_education_summerIntern_1         | 1   |
    And I press "Save and continue"
    Then count of "2" instances of "Please indicate when you completed this programme" exists on page
    And count of "2" instances of "Please also indicate in which Government department you were placed" exists on page
    And I select "Oct 2014" from "csr_dm_form_education_summerInternCompleted"
    Then I fill in "csr_dm_form_education_summerInternDept" with "Summer diversity programme government department"
    And I select "Oct 2014" from "csr_dm_form_education_earlyInternCompleted"
    And I fill in "csr_dm_form_education_earlyInternDept" with "Early diversity programme government department"
    And I press "Save and continue"
    Then I should see "Diversity"
#    And I follow "go back to the previous section"
#    Then I should see form with:
#      | csr_dm_form_education_existingCivilServant_0     | 0                                                |
#      | csr_dm_form_education_inServiceRoute             | Yes                                              |
#      | csr_dm_form_education_undergraduateDegree_0      | 0                                                |
#      | csr_dm_form_education_postgraduateDegree_0       | 0                                                |
#      | csr_dm_form_education_earlyIntern_1              | 1                                                |
#      | csr_dm_form_education_summerIntern_1             | 1                                                |
#      | csr_dm_form_education_summerInternCompleted      | Oct 2014                                           |
#      | csr_dm_form_education_summerInternDept           | Summer diversity programme government department |
#      | from "csr_dm_form_education_earlyInternCompleted | Oct 2014                                           |
#      | csr_dm_form_education_earlyInternDept            | Early diversity programme government department  |

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
    And I check the "csr_dm_form_education_earlyIntern_0" radio button
    And I check the "csr_dm_form_education_summerIntern_0" radio button
    When I press "Save and continue"
#    Then count of "7" instances of "This value should not be blank" exists on page
#    And I should see "Please indicate if you will complete Fast Track apprentice scheme in this recruitment year"
#    And I should see "Please enter details of undergraduate degree"
#    And I should see "Please enter details of postgraduate degree"
#    And I should see "Please enter Fast Track apprentice scheme"
#    And I should see "Please enter Fast Track apprentice year of completion"
    Then I select "2015" from "csr_dm_form_education_yearOfCompletion"
    And I select "Scheme 2" from "csr_dm_form_education_schemeName"
    And I fill in "csr_dm_form_education_undergradDegrees_0_university" with "Undergraduate University 1"
    And I select "First-class honours" from "csr_dm_form_education_undergradDegrees_0_grade"
    And I fill in "csr_dm_form_education_postgradDegrees_0_university" with "Postgraduate University 1"
    And I fill in "csr_dm_form_education_postgradDegrees_0_degree" with "Ordinary degree"
    And I press "Save and continue"
    Then I should see "Diversity"
#    And I follow "go back to the previous section"
#    Then the "civil-servant-yes" checkbox should be checked
#    And the "undergraduate-degree-inside-uk" checkbox should be checked
#    And the "postgraduate-degree-no" checkbox should be checked
#    And the "summer-diversity-internship-programme-no" checkbox should be checked
#    And the "early-diversity-internship-programme-no" checkbox should be checked
#    And the "undergraduate-university" field should contain "Undergraduate University 1"
#    And the "postgraduate-university" field should contain "Postgraduate University 1"

#  @CSR-26
#  Scenario: Add education details (mandatory field check)
#    Given I am logged in as "seven@test.com" with password "P@ssword1"
##    And I follow "Profile"
##    And I press "Save and continue"
##    And I press "Save and continue"
#    And I am on "/en/applicant/education"
#    Then I should see "Education"
#    And I press "Save and continue"
#    Then I should see "Please indicate whether or not you are an existing Civil Servant"
#    And I should see "Please complete the Undergraduate degree section"
#    And I should see "Please complete the Postgraduate degree section"
#    And I should see "Please indicate whether or not you completed the Early Diversity Internship Programme"
#    And I should see "Please indicate whether or not you completed the Summer Diversity Internship Programme"

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
    And I check the "csr_dm_form_education_earlyIntern_1" radio button
    And I check the "csr_dm_form_education_summerIntern_1" radio button
    And I press "Save and continue"
    Then count of "8" instances of "This value should not be blank" exists on page