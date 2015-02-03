Feature: As an applicant after logging in I want to see my homepage

  Background:
    Given following users for each persona exist on system:
      | four@test.com |
      | five@test.com |
    And "four@test.com" has completed sections "About you,Nationality,Education"
    And "five@test.com" has completed sections "About you,Nationality,Education"

  @CSR-196
  Scenario: Complete Diversity section (Happy path)
    Given I am logged in as "four@test.com" with password "P@ssword1"
    And I am on "/en/applicant/diversity"
    Then I should see "Diversity"
    And I fill form with:
      | csr_dm_diversity_diversity_gender                                             | Male                                                                        |
      | csr_dm_diversity_diversity_ethnicOrigin                                       | White - English / Welsh / Scottish / Northern Irish / British               |
      | csr_dm_diversity_diversity_religionOrBelief                                   | Agnostic                                                                    |
      | csr_dm_diversity_diversity_sexualOrientation                                  | Prefer not to say                                                           |
      | csr_dm_diversity_diversity_maritalStatus                                      | Separated                                                                   |
      | csr_dm_diversity_socioEconomic_typeOfSchoolAttendanceAtFourteen               | A state run or funded school that selected on the basis of academic ability |
      | csr_dm_diversity_socioEconomic_firstPersonInImmediateFamilyToAttendUniversity | No                                                                          |
      | csr_dm_diversity_socioEconomic_eligibleForFreeSchoolMeals                     | No                                                                          |
      | csr_dm_diversity_socioEconomic_everSpentMoreThanThreeMonthsInCare             | No                                                                          |
      | csr_dm_diversity_socioEconomic_everPersonallyHadRefugeeOrAsylumStatus         | Prefer Not to Say                                                           |
    And I press "Save and continue"
    Then I should see "Your changes were saved!"
#    And I should see form with:
#      | csr_dm_diversity_diversity_gender                                             | Male                                                                        |
#      | csr_dm_diversity_diversity_ethnicOrigin                                       | White - English / Welsh / Scottish / Northern Irish / British               |
#      | csr_dm_diversity_diversity_religionOrBelief                                   | Agnostic                                                                    |
#      | csr_dm_diversity_diversity_sexualOrientation                                  | Prefer not to say                                                           |
#      | csr_dm_diversity_diversity_maritalStatus                                      | Separated                                                                   |
#      | csr_dm_diversity_socioEconomic_typeOfSchoolAttendanceAtFourteen               | A state run or funded school that selected on the basis of academic ability |
#      | csr_dm_diversity_socioEconomic_firstPersonInImmediateFamilyToAttendUniversity | No                                                                          |
#      | csr_dm_diversity_socioEconomic_eligibleForFreeSchoolMeals                     | No                                                                          |
#      | csr_dm_diversity_socioEconomic_everSpentMoreThanThreeMonthsInCare             | No                                                                          |
#      | csr_dm_diversity_socioEconomic_everPersonallyHadRefugeeOrAsylumStatus         | Prefer Not to Say                                                           |

  @CSR-196
  Scenario: Complete Diversity section (Mandatory field validation)
    Given I am logged in as "five@test.com" with password "P@ssword1"
    And I am on "/en/applicant/diversity"
    Then I should see "Diversity"
    And I press "Save and continue"
    Then I should see "This value should not be blank"
    And I select "Male" from "csr_dm_diversity_diversity_gender"
    And I press "Save and continue"
    Then I should see "This value should not be blank"
    Then I select "Mixed - White and Black Caribbean" from "csr_dm_diversity_diversity_ethnicOrigin"
    And I press "Save and continue"
    Then I should see "This value should not be blank"
    Then I select "Zoroastrianism" from "csr_dm_diversity_diversity_religionOrBelief"
    And I press "Save and continue"
    Then I should see "This value should not be blank"
    Then I select "Prefer not to say" from "csr_dm_diversity_diversity_sexualOrientation"
    And I press "Save and continue"
    Then I should see "This value should not be blank"
    Then I select "In a Domestic Partnership" from "csr_dm_diversity_diversity_maritalStatus"
    And I press "Save and continue"
    Then I should see "This value should not be blank"
    Then I select "A state run or funded school that selected on the basis of academic ability" from "csr_dm_diversity_socioEconomic_typeOfSchoolAttendanceAtFourteen"
    And I press "Save and continue"
    Then I should see "This value should not be blank"
    Then I select "Yes" from "csr_dm_diversity_socioEconomic_firstPersonInImmediateFamilyToAttendUniversity"
    And I press "Save and continue"
    Then I should see "This value should not be blank"
    Then I select "Yes" from "csr_dm_diversity_socioEconomic_eligibleForFreeSchoolMeals"
    And I press "Save and continue"
    Then I should see "This value should not be blank"
    Then I select "Prefer Not to Say" from "csr_dm_diversity_socioEconomic_everSpentMoreThanThreeMonthsInCare"
    And I press "Save and continue"
    Then I should see "This value should not be blank"
    Then I select "Prefer Not to Say" from "csr_dm_diversity_socioEconomic_everPersonallyHadRefugeeOrAsylumStatus"
    And I press "Save and continue"
    Then I should see "Your changes were saved"