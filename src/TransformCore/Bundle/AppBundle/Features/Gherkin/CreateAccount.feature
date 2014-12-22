Feature: As an user, I want to be able to create an account, in order to apply for jobs

  Scenario: Create Account with valid details
    Given I am on the homepage
    And I press "Create account"
    Then I should see "Create an account"
    When I fill "salutation" with "Mr"
    And I fill in "firstname" with "Bob"
    And I fill in "lastname" with "Carr"
    And I fill in "day" with "01"
    And I fill in "month" with "11"
    And I fill in "year" with "1978"
    And I fill in "postcode" with "SW4 8LB"
    And I press "Find address"
    Then I should see "21, Clarence Avenue"
    And I fill in "password" with "sunshine"
    And I fill in "passwordConfirm" with "sunshine"
    And I fill in "email" with "bob.carr@test.com"
    And I fill in "mobileNumber" with "07951897867"
    And I fill in "Please tell us where you first heard about the Fast Stream" with "blah blah"
    And I check "TermsAndConditions_yes"
    And I press "Create account"
    Then I should see "Account created"
    And email "bill.carr@test.com" should receive registration confirmation

  Scenario: Create account with invalid details (format)
    Given I am on the homepage
    And I press "Create account"
    Then I should see "Create an account"
    When I select "Mr" from "salutation"
    And I fill in "firstname" with "Bil@l"
    And I fill in "lastname" with "Carr"
    And I fill in "day" with "c"
    And I fill in "month" with "b"
    And I fill in "year" with "a"
    And I fill in "postcode" with "CFT 888"
    And I press "Find address"
    Then I should see "Invalid postcode - no matching address found"
    And I fill in "postcode" with "SW4 8LB"
    And I press "Find address"
    Then I should see "21, Clarence Avenue"
    And I fill in "password" with "a"
    And I fill in "passwordConfirm" with "a"
    And I fill in "email" with "bill.carr@test"
    And I fill in "mobileNumber" with "abc"
    And I fill in "Please tell us where you first heard about the Fast Stream" with "blah blah"
    And I press "Create account"
    Then I should see "username in wrong format"
    Then I should see "password too short"
    Then I should see "email address in wrong format"
    Then I should see "Day in wrong format"
    Then I should see "Month in wrong format"
    Then I should see "Year in wrong format"
    Then I should see "Mobile number in wrong format"

  Scenario: Create account with invalid details (field length)
    Given I am on the homepage