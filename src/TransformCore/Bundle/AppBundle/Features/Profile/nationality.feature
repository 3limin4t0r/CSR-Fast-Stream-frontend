Feature: As an user, I want to be able to add details about myself on my account, in order to apply for jobs

  Background:
    Given following users for each persona exist on system:
      | four@test.com |
      | five@test.com |
    And "four@test.com" has completed sections "About you"
    And "five@test.com" has completed sections "About you"


  @CSR-135
  Scenario Outline: Complete About You Section (For nationality test applicants)
    Given I am logged in as "<applicant>" with password "P@ssword1"
    And I follow "Profile"
    Then the "csr_dm_user_profile_name_group_firstname" field should contain "<firstname>"
    And the "csr_dm_user_profile_name_group_lastname" field should contain "Persona"
# Address Details
#    And I follow "Enter address manually"
    And I fill in "csr_dm_user_profile_address_address_group_line1" with "address line one"
    And I fill in "csr_dm_user_profile_address_address_group_line2" with "address line two"
    And I fill in "csr_dm_user_profile_address_address_group_line3" with "address line three"
    And I fill in "csr_dm_user_profile_address_address_group_town" with "a town"
    And I fill in "csr_dm_user_profile_address_address_group_postcode" with "post code"
# Date of Birth
    And I fill in "csr_dm_user_profile_date_of_birth_group_dateOfBirth_day" with "02"
    And I fill in "csr_dm_user_profile_date_of_birth_group_dateOfBirth_month" with "08"
    And I fill in "csr_dm_user_profile_date_of_birth_group_dateOfBirth_year" with "1968"
# Phone details
    And I fill in "csr_dm_user_profile_phone_number_group_phoneNumber_number" with "07951234567"
    And I select "United Kingdom" from "csr_dm_user_profile_address_address_group_country"
#    And I check "mobile-number-yes"
#    # End of My Details step one form
    Then I press "Save and continue"
    Then I should see "Nationality, Immigration and Employment Restrictions"

  Examples:
    | applicant     | firstname |
    | four@test.com | four      |
    | five@test.com | five      |

  @CSR-24
  Scenario: Complete Nationality and immigration section (Happy path)
    Given I am logged in as "four@test.com" with password "P@ssword1"
    And I am on "/en/applicant/eligibility"
    Then I should see "Nationality, Immigration and Employment Restrictions"
    And I fill in "csr_dm_user_eligibility_nationality_group_presentNationality_name" with "British"
    And I check "csr_dm_user_eligibility_immigration_group_subjectToImmigrationControls"
    And I check "csr_dm_user_eligibility_immigration_group_residencyOrEmploymentRestrictions"
    And I check "csr_dm_user_eligibility_permissionToCheckBackground"
    Then I press "Save and continue"
    Then I should see "Your changes were saved"

  @CSR-24
  Scenario: Complete Nationality and immigration section (Dependant fields validation)
    Given I am logged in as "two@test.com" with password "P@ssword1"
    And I am on "/en/applicant/eligibility"
    Then I should see "Nationality"
    Then I should see "Nationality, Immigration and Employment Restrictions"
    And I fill in "csr_dm_user_eligibility_nationality_group_presentNationality_name" with "British"
    When I press "Save and continue"
    Then I should see "Please check whether or not you are subject to immigration controls"
    And I check "csr_dm_user_eligibility_immigration_group_subjectToImmigrationControls"
    When I press "Save and continue"
    Then I should see "Please fill in immigration controls details"
    And I fill in "csr_dm_user_eligibility_immigration_group_subjectToImmigrationControlsDetails" with "Some immigration controls detail"
    When I press "Save and continue"
    Then I should see "Please select whether or not you have employment restrictions"
    And I check "csr_dm_user_eligibility_immigration_group_residencyOrEmploymentRestrictions"
    When I press "Save and continue"
    Then I should see "Please fill in employment restrictions details"
    And I fill in "csr_dm_user_eligibility_immigration_group_residencyOrEmploymentRestrictionsDetails" with "Some employment restrictions detail"
    When I press "Save and continue"
    Then I should see "Please check box to indicate you give permission for us to undertake checks"
    And I check "csr_dm_user_eligibility_permissionToCheckBackground"
    And I press "Save and continue"
    Then I should see "Your changes were saved"
#    And I follow "go back to the previous section"
#    Then the "csr_dm_user_eligibility_immigration_group_subjectToImmigrationControlsDetails" field should contain "Some immigration controls detail"
#    And the "csr_dm_user_eligibility_immigration_group_residencyOrEmploymentRestrictionsDetails" field should contain "Some employment restrictions detail"

  @CSR-24
  Scenario: Complete Nationality and immigration section (Minimal happy path)
    Given I am logged in as "five@test.com" with password "P@ssword1"
    And I am on "/en/applicant/eligibility"
    Then I should see "Nationality, Immigration and Employment Restrictions"
    And I fill in "csr_dm_user_eligibility_nationality_group_presentNationality_name" with "British"
    And I press "Save and continue"
    Then I should see "Your changes were saved"
