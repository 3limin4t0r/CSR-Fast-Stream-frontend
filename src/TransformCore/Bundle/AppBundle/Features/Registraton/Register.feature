Feature: As an user, I want to be able to create an account, in order to apply for jobs

  @CSR-6
  Scenario: Create Account with valid details
    Given I am on the homepage
    And I press "Register"
    Then I should see "Register Your Details:"
    When I fill "salutation" with "Mr"
    And I fill in "first-name" with "One"
    And I fill in "last-name" with "Apprentice"
    And I fill in "email-input" with "apprentice1@test.com"
    And I fill in "password" with "Password1"
    And I fill in "passwordConfirm" with "Password1"
    And I select "Google" from "how-you-found-us"
    And I check "I require adjustments based on my disability"
    And I select "Diabetes" from "disability"
    And I fill in "disability-adjustments" with "disability-adjustments"
    And I check "I wish to apply via the Guaranteed Interview Scheme"
    And I check "accept-terms"
    And I press "Register"
    Then I should see "Registration: COMPLETE"
    And I should see "Welcome, One"
    And email "test@test.com" should receive registration confirmation

  CSR-6
  Scenario: Create account with invalid details (format)
    Given I am on the homepage
    And I press "Register"
    Then I should see "Register Your Details:"
    When I select "Mr" from "salutation"
    And I fill in "first-name" with "Bil@l"
    And I fill in "last-name" with "Carr"
    And I fill in "password" with "a"
    And I fill in "passwordConfirm" with "a"
    And I fill in "email-input" with "bill.carr@test"
    And I check "I require adjustments based on my disability"
    And I press "Create account"
    Then I should see "first name contains illegal characters"
    Then I should see "password too short"
    Then I should see "email address in wrong format"
    Then I should see "Please select your disability"
    Then I should see "Please accept terms and conditions before continuing"
    Then I should see "Please tell us how you found faststream"