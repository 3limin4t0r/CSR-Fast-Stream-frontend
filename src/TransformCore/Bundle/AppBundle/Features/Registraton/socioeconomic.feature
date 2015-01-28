Feature: As an applicant after logging in I want to see my homepage

  Background:
    Given following users for each persona exist on system:
      | persona6@test.com |
      | persona7@test.com |
    And "persona4@test.com" has completed sections "About you,Nationality,Education,Diversity"
    And "persona5@test.com" has completed sections "About you,Nationality,Education,Diversity"

  @CSR-196 @omit
  Scenario: Complete Nationality and immigration section (Happy path)
    Given I am logged in as "persona4@test.com" with password "P@ssword1"
    And I follow "My Details"
    Then I should see "About You"
    And I follow "save-and-continue"
    Then I should see "Nationality"
    And I follow "save-and-continue"
    Then I should see "Diversity"
    And I follow "save-and-continue"
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
    And I should see "Review Personal Details"
    When I follow "go back to the previous section"
    Then I should see "Socio Economic Details"
    And I should see form with:
      | fathersEducationLevel    | No qualifications                                                                                                                                                                         |
      | mothersEducationLevel    | Degree level or Degree equivalent or above (for example first or higher degrees, postgraduate diplomas, NVQ/SVQ level 4 or 5, etc)                                                        |
      | fathersEmploymentDetails | No qualifications                                                                                                                                                                         |
      | mothersEmploymentDetails | Self-employed with employees                                                                                                                                                              |
      | fathersEmployerDetails   | 1 - 24                                                                                                                                                                                    |
      | mothersEmployerDetails   | Do not know or cannot remember                                                                                                                                                            |
      | fathersSupervisorDuties  | Yes                                                                                                                                                                                       |
      | mothersSupervisorDuties  | Prefer not to say                                                                                                                                                                         |
      | fathersMainWorkType      | Modern professional occupations such as: teacher/lecturer, nurse, physiotherapist, social worker, welfare officer,artist, musician, police officer (sergeant or above), software designer |
      | mothersMainWorkType      | Prefer not to say                                                                                                                                                                         |