Feature: As an applicant after logging in I want to see my homepage

  Background:
    Given following users for each persona exist on system:
      | persona4@test.com |

  @CSR-173
  Scenario Outline: Create Account with valid details
    Given I am on the homepage
    And I fill in "persona4@test.com" for "email"
    And I flll in "P@ssword1"
    And I press "Sign In"
    Then I should see "Welcome <first-name>"
    And I should see an "Logout" element
  Examples:
  |first-name|last-name|
  |Four      |Persona  |