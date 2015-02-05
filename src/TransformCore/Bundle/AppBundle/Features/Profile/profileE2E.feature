Feature: End to End profile user journey

  @CSR-6 @e2e @omit
  Scenario Outline: Create Account with valid details
    Given I am on the homepage
    And I follow "Register"
    Then I should see "Register Your Details"
    When I fill form with:
        # Your details
      | fos_user_registration_form_firstname                                                           | <first-name>                     |
      | fos_user_registration_form_lastname                                                            | <last-name>                      |
      | fos_user_registration_form_email                                                               | <email-input>                    |
      | fos_user_registration_form_plainPassword_first                                                 | <password>                       |
      | fos_user_registration_form_plainPassword_second                                                | <password>                       |
      | fos_user_registration_form_registered_disability_group_registration_heardAboutUs               | <referrer-input>                 |
      | fos_user_registration_form_registered_disability_group_registration_disabledAdjustmentRequired | YES                              |
      | fos_user_registration_form_registered_disability_group_registration_disabledDetails            | Heart conditions                 |
      | fos_user_registration_form_registered_disability_group_registration_disabledAdjustmentDetails  | some disability adjustments text |
      | fos_user_registration_form_registered_disability_group_phoneNumber_number                      | <phoneNumber>                    |
      | fos_user_registration_form_registered_disability_group_registration_guaranteedInterviewScheme  | YES                              |
      | fos_user_registration_form_registered_disability_group_registration_termsAndConditions         | YES                              |
    And I press "Save and continue"
    Then I should not see "This value is already used"
    Then I should see "The user has been created successfully"
    And I should see "<email-input>"
  Examples:
    | first-name | last-name | email-input       | phoneNumber | password  | referrer-input |
    | End        | Toend     | endtoend@test.com | 07739898078 | P@ssword1 | Search Engine  |

  @CSR-135 @e2e @omit
  Scenario: Complete About You Section (Happy path)
    Given I am logged in as "endtoend@test.com" with password "P@ssword1"
    And I follow "Profile"
    Then I should see form with:
      | csr_dm_user_profile_name_group_firstname | End   |
      | csr_dm_user_profile_name_group_lastname  | Toend |
    When I fill form with:
      | csr_dm_user_profile_name_group_firstname                  | Onechange          |
      | csr_dm_user_profile_name_group_lastname                   | Personachange      |
      | csr_dm_user_profile_address_address_group_line1           | address line one   |
      | csr_dm_user_profile_address_address_group_line2           | address line two   |
      | csr_dm_user_profile_address_address_group_line3           | address line three |
      | csr_dm_user_profile_address_address_group_town            | a town             |
      | csr_dm_user_profile_address_address_group_county          | a county           |
      | csr_dm_user_profile_address_address_group_postcode        | post code          |
      | csr_dm_user_profile_date_of_birth_group_dateOfBirth       | 1968-08-02         |
      | csr_dm_user_profile_phone_number_group_phoneNumber_number | 07951234567        |
      | csr_dm_user_profile_address_address_group_country         | United Kingdom     |
    When I press "Save and continue"
    Then I should see "Nationality, Immigration and Employment Restrictions"
    Then I follow "Profile"
    Then I should see form with:
      | csr_dm_user_profile_name_group_firstname                  | Onechange                                         |
      | csr_dm_user_profile_name_group_lastname                   | Personachange                                     |
      | csr_dm_user_profile_date_of_birth_group_dateOfBirth       | 1968-08-02                                        |
      | csr_dm_user_profile_address_address_group_postcode        | post code                                         |
      | csr_dm_user_profile_address_address_group_line1           | address line one                                  |
      | csr_dm_user_profile_address_address_group_line2           | address line two                                  |
      | csr_dm_user_profile_address_address_group_line3           | address line three                                |
      | csr_dm_user_profile_address_address_group_county          | a county                                          |
      | csr_dm_user_profile_address_address_group_town            | a town                                            |
      | csr_dm_user_profile_address_address_group_postcode        | post code                                         |
      | United Kingdom                                            | csr_dm_user_profile_address_address_group_country |
      | csr_dm_user_profile_phone_number_group_phoneNumber_number | 07951234567                                       |

  @CSR-24 @e2e @omit
  Scenario: Complete Nationality and immigration section (Happy path)
    Given I am logged in as "endtoend@test.com" with password "P@ssword1"
    And I am on "/en/applicant/eligibility"
    Then I should see "Nationality, Immigration and Employment Restrictions"
    And I fill form with:
      | csr_dm_user_eligibility_nationality_group_presentNationality_name           | British |
      | csr_dm_user_eligibility_immigration_group_subjectToImmigrationControls      | Yes     |
      | csr_dm_user_eligibility_immigration_group_residencyOrEmploymentRestrictions | Yes     |
      | csr_dm_user_eligibility_permissionToCheckBackground                         | Yes     |
    Then I press "Save and continue"
    Then I should see "Your changes were saved"

  @CSR-26 @e2e @omit
  Scenario: Add education details (degrees completed and not a civil servant)
    Given I am logged in as "endtoend@test.com" with password "P@ssword1"
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
    Then I fill form with:
      | csr_dm_form_education_summerInternCompleted | Oct 2014                                         |
      | csr_dm_form_education_summerInternDept      | Summer diversity programme government department |
      | csr_dm_form_education_earlyInternCompleted  | Oct 2014                                         |
      | csr_dm_form_education_earlyInternDept       | Early diversity programme government department  |
    And I press "Save and continue"
    Then I should see "Diversity"

  @CSR-196 @e2e @omit
  Scenario: Complete Diversity section (Happy path)
    Given I am logged in as "endtoend@test.com" with password "P@ssword1"
    And I am on "/en/applicant/diversity"
    Then I should see "Diversity"
    And I fill form with:
      | csr_dm_diversity_diversity_group_diversity_gender                                                 | Male                                                                        |
      | csr_dm_diversity_diversity_group_diversity_ethnicOrigin                                           | White - English / Welsh / Scottish / Northern Irish / British               |
      | csr_dm_diversity_diversity_group_diversity_religionOrBelief                                       | Agnostic                                                                    |
      | csr_dm_diversity_diversity_group_diversity_sexualOrientation                                      | Prefer not to say                                                           |
      | csr_dm_diversity_diversity_group_diversity_maritalStatus                                          | Separated                                                                   |
      | csr_dm_diversity_socioEconomic_group_socioEconomic_typeOfSchoolAttendanceAtFourteen               | A state run or funded school that selected on the basis of academic ability |
      | csr_dm_diversity_socioEconomic_group_socioEconomic_firstPersonInImmediateFamilyToAttendUniversity | No                                                                          |
      | csr_dm_diversity_socioEconomic_group_socioEconomic_eligibleForFreeSchoolMeals                     | No                                                                          |
      | csr_dm_diversity_socioEconomic_group_socioEconomic_everSpentMoreThanThreeMonthsInCare             | No                                                                          |
      | csr_dm_diversity_socioEconomic_group_socioEconomic_everPersonallyHadRefugeeOrAsylumStatus         | Prefer Not to Say                                                           |
    And I press "Save and continue"
    Then I should see "Your changes were saved!"
    And I should see "Socio Economic Details - About your parents/guardians"

  @CSR-12 @e2e @omit
  Scenario: Complete Socio-economic section (Happy path)
    Given I am logged in as "endtoend@test.com" with password "P@ssword1"
    And I am on "/en/applicant/socioeconomic"
    Then I should see "Socio Economic Details"
    And I fill form with:
      | csr_dm_parents_education_group_education_highestEducationLevelThatYourFatherAchievedAtNormalEducationAge | No qualifications                                                                                                                  |
      | csr_dm_parents_education_group_education_highestEducationLevelThatYourMotherAchievedAtNormalEducationAge | Degree level or Degree equivalent or above (for example first or higher degrees, postgraduate diplomas, NVQ/SVQ level 4 or 5, etc) |
      | csr_dm_parents_employment_group_employment_whenYouWereFourteenYourFathersEmploymentStatus                | Employee                                                                                                                           |
      | csr_dm_parents_employment_group_employment_whenYouWereFourteenYourMothersEmploymentStatus                | Self-employed with employees                                                                                                       |
      | csr_dm_parents_employer_group_employer_whenYouWereFourteenNumberOfEmployeesByFather                      | 1-24                                                                                                                               |
      | csr_dm_parents_employer_group_employer_whenYouWereFourteenNumberOfEmployeesByMother                      | Do not know or cannot remember                                                                                                     |
      | csr_dm_parents_role_group_role_whenYouWereFourteenFatherSuperviseAnyEmployees                            | Yes                                                                                                                                |
      | csr_dm_parents_role_group_role_whenYouWereFourteenMotherSuperviseAnyEmployees                            | Prefer not to say                                                                                                                  |
      | csr_dm_parents_role_group_role_whenYouWereFourteenTypeOfWorkYourFatherDid                                | Prefer not to say                                                                                                                  |
      | csr_dm_parents_role_group_role_whenYouWereFourteenTypeOfWorkYourMotherDid                                | Prefer not to say                                                                                                                  |
    And I press "Save and continue"
    And the url should match "/en/applicant/review"

  @CSR-211 @e2e @omit
  Scenario: Review and Submit (User Journey)
    Given I am logged in as "endtoend@test.com" with password "P@ssword1"
    And I am on "/en/applicant/review"
    Then the response status code should be 200
    And I should see "I require a Visa"