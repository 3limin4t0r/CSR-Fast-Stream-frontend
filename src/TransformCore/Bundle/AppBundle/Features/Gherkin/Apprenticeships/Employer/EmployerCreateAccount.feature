Feature: As an employer, I want to be able to create an account, in order to get applicants

  @CSR-100 @CSR-18
  Scenario: Create Employer Account with valid details
    Given I am on the homepage
    And I press "Create employer account"
    Then I should see "Create an account"
    And I fill in "businessOrganDetails" with "Test Org"
    And I select "Construction" from "organ-type"
    And I fill in "busWebAddress" with "http://testsite.com"
    And I select "label=9-49" from "how-many"
    And I check "radio-inline-1"
    And I fill in "contactName" with "Contact name"
    And I fill in "job-title" with "Job Title"
    And I fill in "email" with "test@test.com"
    And I fill in "email-confirm" with "test@test.com"
    And I fill in "telephone" with "02086008000"
    When I press "Save and continue"
    Then I should see "Registration Details Submitted."
    Then I press "Finish"