Feature: As an user, I want to be able to add details about myself on my account, in order to apply for jobs

  Background:
    Given following users for each persona exist on system:
    |persona4@test.com|
    |persona5@test.com|
    And "persona4@test.com" has completed the "About you" section
    And "persona5@test.com" has completed the "About you" section

  @CSR-24
  Scenario: Complete Nationality and immigration section (Happy path)
    Given I am logged in as "persona4@test.com" with password "P@ssword1"
    And I follow "My Details"
    Then I should see "About You"
    And I follow "save-and-continue"
    And I select "British" from "nationality"
    And I check "not-subject-to-immigration-controls"
    And I check "no-employment-restrictions"
    And I check "permission-to-undertake-checks"
    And I press "save-and-continue"
    Then I should see "Education"

  @CSR-24
  Scenario: Complete Nationality and immigration section (Dependant fields validation)
    Given I am logged in as "persona4@test.com" with password "P@ssword1"
    And I follow "My Details"
    Then I should see "About You"
    And I follow "save-and-continue"
    And I select "British" from "nationality"
    And I check "yes-subject-to-immigration-controls"
    And I fill in "subject-to-immigration-controls-detail" with "Some immigration controls detail"
    And I check "yes-employment-restrictions"
    And I fill in "employment-restrictions-detail" with "Some employment restrictions detail"
    And I check "permission-to-undertake-checks"
    And I press "save-and-continue"
    Then I should see "Education"
    And I follow "go back to the previous section"
    Then the "subject-to-immigration-controls-detail" field should contain "Some immigration controls detail"
    And the "Some employment restrictions detail" field should contain "Some employment restrictions detail"

  @CSR-24
  Scenario: Complete Nationality and immigration section (Dependant fields validation)
    Given I am logged in as "persona5@test.com" with password "P@ssword1"
    And I follow "My Details"
    Then I should see "About You"
    And I follow "save-and-continue"
    And I select "British" from "nationality"
    And I check "yes-subject-to-immigration-controls"
    And I fill in "subject-to-immigration-controls-detail" with "Some immigration controls detail"
    And I check "yes-employment-restrictions"
    And I fill in "employment-restrictions-detail" with "Some employment restrictions detail"
    And I check "permission-to-undertake-checks"
    And I press "save-and-continue"
    Then I should see "Please enter additional nationality"
    Then I should see "Please enter immigration control details"
    Then I should see "Please enter employment restrictions detail"


  @CSR-24
  Scenario: Complete Nationality and immigration section (Minimal happy path)
    Given I am logged in as "persona5@test.com" with password "P@ssword1"
    And I follow "My Details"
    Then I should see "About You"
    And I follow "save-and-continue"
    And I check "not-subject-to-immigration-controls"
    And I check "no-employment-restrictions"
    And I check "permission-to-undertake-checks"
    And I press "save-and-continue"
    Then I should see "Education"

