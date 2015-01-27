Feature: As an applicant, after completing all profile sections, I want to be able to review before submitting

  @CSR-211 @omit
  Scenario Outline: Review and Submit (User Journey)
    Given I am on the homepage
    And I follow "Register"
    Then I should see "Register Your Details"
    When I fill form with:
    # Your details
      | fos_user_registration_form_firstname                               | <first-name>                     |
      | fos_user_registration_form_lastname                                | <last-name>                      |
        # Contact details
      | fos_user_registration_form_email                                   | <email-input>                    |
        # Signin Details
      | fos_user_registration_form_plainPassword_first                     | <password>                       |
      | fos_user_registration_form_plainPassword_second                    | <password>                       |
        # Referrer
      | fos_user_registration_form_registration_heardAboutUs               | <referrer-input>                 |
        # Disability details
      | fos_user_registration_form_registration_disabledAdjustmentRequired | YES                              |
      | fos_user_registration_form_registration_disabledDetails            | <disability>                     |
      | fos_user_registration_form_registration_disabledAdjustmentDetails  | some disability adjustments text
      | fos_user_registration_form_phoneNumber_number                      | <phoneNumber>                    |
    # Checkboxes
      | fos_user_registration_form_registration_guaranteedInterviewScheme  | YES                              |
      | fos_user_registration_form_registration_termsAndConditions         | YES                              |
    And I press "fos_user_registration_form_registerButton"
    Then I should see "The user has been created successfully"
    And I follow "Profile"
    When I fill form with:
      | csr_dm_user_profile_firstname          | Onechange                           |
      | csr_dm_user_profile_lastname           | Personachange                       |
      | csr_dm_user_profile_address_line1      | address line one                    |
      | csr_dm_user_profile_address_line2      | address line two                    |
      | csr_dm_user_profile_address_line3      | address line three                  |
      | csr_dm_user_profile_address_town       | a town                              |
      | csr_dm_user_profile_address_county     | a county                            |
      | csr_dm_user_profile_address_postcode   | post code                           |
      | csr_dm_user_profile_dateOfBirth        | 1968-08-02                          |
      | csr_dm_user_profile_phoneNumber_number | 07951234567                         |
      | United Kingdom                         | csr_dm_user_profile_address_country |
    When I press "Save and Continue"
    Then I should see "Nationality, Immigration and Employment Restrictions"
    When I fill form with:
      | csr_dm_user_eligibility_presentNationality_name                                                           | British |
      | csr_dm_user_eligibility_subjectToImmigrationControls                                                      | No      |
      | csr_dm_user_eligibility_residencyOrEmploymentRestrictions                                                 | No      |
      | csr_dm_user_eligibility_permissionToCheckBackground                                                       | Yes     |
      | I want to apply for the Early Diversity Internship Programme or the Summer Diversity Internship Programme | Yes     |
      | early-diversity-internship-programme-no                                                                   | No      |
      | summer-diversity-internship-programme-no                                                                  | No      |
    And I press "Save and continue"
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
    And I fill form with:
#Parent/guardian's Education
      | fathersEducationLevel    | No qualifications                                                                                                                                                                         |
      | mothersEducationLevel    | Degree level or Degree equivalent or above (for example first or higher degrees, postgraduate diplomas, NVQ/SVQ level 4 or 5, etc)                                                        |
      # Parent/guardian's Employment
      | fathersEmploymentDetails | No qualifications                                                                                                                                                                         |
      | mothersEmploymentDetails | Self-employed with employees                                                                                                                                                              |
      # Parent/guardian's Employer
      | fathersEmployerDetails   | 1 - 24                                                                                                                                                                                    |
      | mothersEmployerDetails   | Do not know or cannot remember                                                                                                                                                            |
      # Parent/guardian's Employment Role
      | fathersSupervisorDuties  | Yes                                                                                                                                                                                       |
      | mothersSupervisorDuties  | Prefer not to say                                                                                                                                                                         |
      | fathersMainWorkType      | Modern professional occupations such as: teacher/lecturer, nurse, physiotherapist, social worker, welfare officer,artist, musician, police officer (sergeant or above), software designer |
      | mothersMainWorkType      | Prefer not to say                                                                                                                                                                         |
    And I press "Save and continue"
    Then I should see "Personal Details Form Submit"
    And I should see "About You"
    And I should see "Nationality"
    And I should see "Diversity"
    And I should see "Socio Economic Details"

  Examples:
    | first-name | last-name | email-input         | phoneNumber | password  | disability | referrer-input |
    | ninetynine | Persona   | ninetynine@test.com | 07739898078 | P@ssword1 | 1          | Search Engine  |