Feature: As an applicant after logging in I want to see my homepage

  Background:
    Given following users for each persona exist on system:
      | persona6@test.com |
      | persona7@test.com |
    And "six@test.com" has completed sections "About you,Nationality,Education,Diversity"
    And "seven@test.com" has completed sections "About you,Nationality,Education,Diversity"


  @CSR-12
  Scenario: Complete Nationality and immigration section (Mandatory fields)
    Given I am logged in as "six@test.com" with password "P@ssword1"
    And I am on "/en/applicant/socioeconomic"
    Then I should see "Socio Economic Details"
    And I press "Save and continue"
    Then count of "10" instances of "This value should not be blank" exists on page

  @CSR-12
  Scenario: Complete Socio-economic section (Happy path)
    Given I am logged in as "six@test.com" with password "P@ssword1"
    And I am on "/en/applicant/socioeconomic"
    Then I should see "Socio Economic Details"
    And I fill form with:
#Parent/guardian's Education
      | csr_dm_parents_education_group_education_highestEducationLevelThatYourFatherAchievedAtNormalEducationAge | No qualifications                                                                                                                  |
      | csr_dm_parents_education_group_education_highestEducationLevelThatYourMotherAchievedAtNormalEducationAge | Degree level or Degree equivalent or above (for example first or higher degrees, postgraduate diplomas, NVQ/SVQ level 4 or 5, etc) |
      # Parent/guardian's Employment
      | csr_dm_parents_employment_group_employment_whenYouWereFourteenYourFathersEmploymentStatus                | Employee                                                                                                                           |
      | csr_dm_parents_employment_group_employment_whenYouWereFourteenYourMothersEmploymentStatus                | Self-employed with employees                                                                                                       |
      # Parent/guardian's Employer
      | csr_dm_parents_employer_group_employer_whenYouWereFourteenNumberOfEmployeesByFather                      | 1-24                                                                                                                               |
      | csr_dm_parents_employer_group_employer_whenYouWereFourteenNumberOfEmployeesByMother                      | Do not know or cannot remember                                                                                                     |
      # Parent/guardian's Employment Role
      | csr_dm_parents_role_group_role_whenYouWereFourteenFatherSuperviseAnyEmployees                            | Yes                                                                                                                                |
      | csr_dm_parents_role_group_role_whenYouWereFourteenMotherSuperviseAnyEmployees                            | Prefer not to say                                                                                                                  |
      | csr_dm_parents_role_group_role_whenYouWereFourteenTypeOfWorkYourFatherDid                                | Prefer not to say                                                                                                                  |
      | csr_dm_parents_role_group_role_whenYouWereFourteenTypeOfWorkYourMotherDid                                | Prefer not to say                                                                                                                  |
    And I press "Save and continue"
    And the url should match "/en/applicant/review"
#    When I follow "go back to the previous section"
#    Then I should see "Socio Economic Details"
#    And I should see form with:
#      | csr_dm_parents_education_group_education_highestEducationLevelThatYourFatherAchievedAtNormalEducationAge    | No qualifications                                                                                                                                                                         |
#      | csr_dm_parents_education_group_education_highestEducationLevelThatYourMotherAchievedAtNormalEducationAge    | Degree level or Degree equivalent or above (for example first or higher degrees, postgraduate diplomas, NVQ/SVQ level 4 or 5, etc)                                                        |
#      | csr_dm_parents_employment_group_employment_whenYouWereFourteenYourFathersEmploymentStatus | Employee                                                                                                                                                                       |
#      | csr_dm_parents_employment_group_employment_whenYouWereFourteenYourMothersEmploymentStatus | Self-employed with employees                                                                                                                                                              |
#      | csr_dm_parents_employer_group_employer_whenYouWereFourteenNumberOfEmployeesByFather   | 1-24                                                                                                                                                                                    |
#      | csr_dm_parents_employer_group_employer_whenYouWereFourteenNumberOfEmployeesByMother   | Do not know or cannot remember                                                                                                                                                            |
#      | csr_dm_parents_role_group_role_whenYouWereFourteenFatherSuperviseAnyEmployees  | Yes                                                                                                                                                                                       |
#      | csr_dm_parents_role_group_role_whenYouWereFourteenMotherSuperviseAnyEmployees  | Prefer not to say                                                                                                                                                                         |
#      | csr_dm_parents_role_group_role_whenYouWereFourteenTypeOfWorkYourFatherDid      | Modern professional occupations such as: teacher/lecturer, nurse, physiotherapist, social worker, welfare officer,artist, musician, police officer (sergeant or above), software designer |
#      | csr_dm_parents_role_group_role_whenYouWereFourteenTypeOfWorkYourMotherDid      | Prefer not to say                                                                                                                                                                         |