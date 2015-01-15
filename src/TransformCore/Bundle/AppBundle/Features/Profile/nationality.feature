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
    Then I should see "My details"
    And I select "British" from "nationality"
    And I check "another-nationality-at-birth"
    And I should see "Please provide us with your nationality at birth:"
    And I select "Belgian" from "nationality-at-birth"
    And I check "additional-nationalities-confirm"
    And I should see "Please provide us with any additional nationalities:"
    And I select "Bahraini" from "additional-nationalities"
    And I check the "not-subject-to-immigration-controls"
    And I check the "no-employment-restrictions"
    And I check "willing-to-have-these-checks"
    And I press "save-and-continue"
    Then I should see "Education"


  @CSR-24
  Scenario: Complete Nationality and immigration section (Dependant fields validation)
    Given I am logged in as "persona5@test.com" with password "P@ssword1" #Would wrong user break it?
    And I follow "My Details"
    Then I should see "My details"
    And I select "British" from "nationality"
    And I check "another-nationality-at-birth"
    And I should see "Please provide us with your nationality at birth:"
    And field "nationality" should not contain "British"
    And I check "additional-nationalities-confirm"
    And I should see "Please provide us with any additional nationalities:"
    And I check the "yes-subject-to-immigration-controls"
    And I fill in "subject-to-immigration-controls-detail" with "Some immigration controls detail"
    And I check the "yes-employment-restrictions"
    And I fill in "employment-restrictions-detail" with "Some employment restrictions detail"
    And I check "willing-to-have-these-checks"
    And I press "save-and-continue"
    Then I should see "Please enter additional nationality"
    Then I should see "Please enter immigration control details"
    Then I should see "Please enter employment restrictions detail"


  @CSR-24
  Scenario: Complete Nationality and immigration section (Sub-dependant fields validation)
    Given I am logged in as "persona5@test.com" with password "P@ssword1"
    And I follow "My Details"
    Then I should see "My details"
    And I select "British" from "nationality"
    And I check "another-nationality-at-birth"
    And I should see "Please provide us with your nationality at birth:"
    And field "nationality" should not contain "British"
    And I check "additional-nationalities-confirm"
    And I should see "Please provide us with any additional nationalities:"
    And I check the "yes-subject-to-immigration-controls"
    And I check the "yes-employment-restrictions"
    And I check "willing-to-have-these-checks"
    And I press "save-and-continue"
    Then I should see "Please enter additional nationality"
    Then I should see "Please enter immigration control details"
    Then I should see "Please enter employment restrictions detail"

  @CSR-24
  Scenario: Complete Nationality and immigration section (Minimal happy path)
    Given I am logged in as "persona5@test.com" with password "P@ssword1"
    And I follow "My Details"
    Then I should see "My details"
    And I check the "not-subject-to-immigration-controls"
    And I check the "no-employment-restrictions"
    And I check "willing-to-have-these-checks"
    And I press "save-and-continue"
    Then I should see "Education"

