Feature: As an user, I want to be able to add details about myself on my account, in order to apply for jobs

  Background:
    Given following users for each persona exist on system:
      | persona1@test.com |
      | persona2@test.com |

  @CSR-135
  Scenario: Complete About You Section (Happy path)
    Given I am logged in as "persona1@test.com" with password "P@ssword1"
    And I follow "My Details"
    Then I should see "Your account settings"
    And I select "Mrs" from "salutation"
    And I fill in "first-name" with "Onechange"
    And I fill in "last-name" with "Apprenticechange"
    And I fill in "dob-day" with "08"
    And I fill in "dob-month" with "02"
    And I fill in "dob-year" with "1968"
    And I fill in "post-code" with "SW2 2AU"
    And I press "Find address"
    And the "address-select" field should contain "44, Craster Road"
    And I select "44, Craster Road" from "address-select"
    And I fill in "address2" with "test address line 2"
    And I fill in "address3b" with "test county"
    And I fill in "address3c" with "post code"
    And I fill in "phone-input" with "07951234567"
    And I check "mobile-number-yes"
    # End of My Details step one form
    When I press "Save and continue"
    Then I should see "Nationality, Immigration and Employment Restrictions"
    Then I follow "Go back the the previous section"
    # Checking that values have been retained
    And the "first-name" field should contain "Onechange"
    And the "last-name" field should contain "Apprenticechange"
    And the "salutation" field should contain "Mrs"
    And the "dob-day" field should contain "08"
    And the "dob-month" field should contain "02"
    And the "dob-year" field should contain "1968"
    And the "post-code" field should contain "SW2 2AU"
    And the "address1" field should contain "44, Craster Road"
    And the "address2" field should contain "test address line 2"
    And the "address3b" field should contain "test county"
    And the "address3c" field should contain "post code"
    And the "phone-input" field should contain "07951234567"
    And the "checkbox1" checkbox should be checked
    And the "This is my mobile number" checkbox should be checked

  @CSR-135
  Scenario: Complete About You Section (Field validation)
    Given I am logged in as "persona2@test.com" with password "P@ssword1"
    And I follow "My Details"
    Then I should see "About You"
    And I fill in "first-name" with "Bil@l"
    And I fill in "last-name" with "Ca*&rr"
    And I fill in "dob-day" with "c"
    And I fill in "dob-month" with "b"
    And I fill in "dob-year" with "a"
    And I fill in "post-code" with "CFT 888"
    And I press "Find address"
    Then I should see "Invalid postcode - no matching address found"
    And I fill in "postcode" with "SW4 8LB"
    And I press "Find address"
    And I select "19, Pinewood Court" from "address-select"
    And I fill in "password" with "a"
    And I fill in "passwordConfirm" with "a"
    And I fill in "email-input" with "bill.carr@test"
    And I fill in "phone-input" with "abc"
    And I press "Create account"
    # Checking that field validation is working
    Then I should see "first name in wrong format"
    Then I should see "last name in wrong format"
    Then I should see "password too short"
    Then I should see "email address in wrong format"
    Then I should see "Day in wrong format"
    Then I should see "Month in wrong format"
    Then I should see "Year in wrong format"
    Then I should see "Mobile number in wrong format"
    Then I should see "Please accept terms and conditions before continuing"
    Then I should see "Please tell us how you found faststream"