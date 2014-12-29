Feature: As an user, I want to be able to register a new account, in order to apply for jobs

  @CSR-6
  Scenario Outline: Create Account with valid details
    Given I am on the homepage
    And I press "Register"
    Then I should see "Create an account"
    #    Your details
    When I select "<salutation>" from "salutation"
    And I fill in "first-name" with "<first-name>"
    And I fill in "last-name" with "<last-name>"
    # Contact details
    And I fill in "email-input" with "<email-input>"
    # Disability details
    And I check "I require adjustments based on my disability"
    And I select "<disability>" from "disability"
    And I fill in "phone-input" with "07739898078"
    And I fill in "disability-adjustments" with "disability adjustments text"
    # Signin Details
    And I fill in "password" with "<password>"
    And I fill in "passwordConfirm" with "<password>"
    # Checkboxes
    And I check "I wish to apply via the Guaranteed Interview Scheme"
    And I check "accept-terms"
    And I press "Register"
    Then I should see "Registration: COMPLETE"
    And I should see "Welcome, <first-name>"
    And email "test@test.com" should receive registration confirmation

  Examples:
    | salutation | first-name | last-name | email-input       | phone-input | password  | disability         |
    | Mr         | Persona    | One       | persona1@test.com | 07739898078 | P@ssword1 | Diabetes           |
    | Mr         | Persona    | Two       | persona2@test.com | 07739898079 | P@ssword1 | Hearing impairment |


  @CSR-6
  Scenario: Create account with invalid details (field formats)
    Given I am on the homepage
    And I press "Register"
    Then I should see "Create an account"
    # Your details
    When I select "Mr" from "salutation"
    And I fill in "first-name" with "Bil@l"
    And I fill in "last-name" with "Ca!rr"
        # Contact details
    And I fill in "email-input" with "bill.carr@test"
        # Signin Details
    And I fill in "password" with "P@ssword1"
    And I fill in "passwordConfirm" with "P@ssword11"
        # Disability details
    And I check "I require adjustments based on my disability"
    And I press "Create account"
    Then I should see "first name contains illegal characters"
    Then I should see "last name name contains illegal characters"
    Then I should see "passwords do not match"
    Then I should see "email address in wrong format"
    Then I should see "Please select your disability"
    Then I should see "Please accept terms and conditions before continuing"
    Then I should see "Please tell us how you found faststream"

  @CSR-6
  Scenario Outline: Create account with invalid details (password check)
    Given I am on the homepage
    And I press "Register"
    Then I should see "Create an account"
    When I select "Mr" from "salutation"
    And I fill in "first-name" with "Bill"
    And I fill in "last-name" with "Carr"
    And I fill in "password" with "<P@ssword1>"
    And I fill in "passwordConfirm" with "<password2>"
    And I fill in "email-input" with "bill.carr@test.com"
    And I press "Create account"
    Then I should see "Your password should be eight characters long and include a mix of letters, numbers and symbols"
  Examples:
    | P@ssword1 | password2 |
    | 1234567   | 1234567   |
    | 12345678  | 12345678  |
    | P@ssword1 | P@ssword1 |
    | P@ssword  | P@ssword  |