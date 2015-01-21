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
    And the "first-name" field should contain "One"
    And the "last-name" field should contain "Persona"
    And I fill in "first-name" with "Onechange"
    And I fill in "last-name" with "Personachange"
    # Address Details
    And I follow "Enter address manually"
    And I fill in "address1" with "address line one"
    And I fill in "address2" with "address line two"
    And I fill in "address3b" with "address line three"
    And I fill in "town" with "a town"
    And I fill in "county" with "a county"
    And I fill in "postcode" with "post code"
    # Date of Birth
    And I fill in "dob-day" with "08"
    And I fill in "dob-month" with "02"
    And I fill in "dob-year" with "1968"
    And I fill in "post-code" with "SW2 2AU"
    # Phone details
    And I fill in "phone-input" with "07951234567"
    And I check "mobile-number-yes"
    # End of My Details step one form
    When I press "Save and continue"
    Then I should see "Nationality, Immigration and Employment Restrictions"
    Then I follow "Go back the the previous section"
    # Checking that values have been retained
    And the "first-name" field should contain "Onechange"
    And the "last-name" field should contain "Personachange"
    # Date of birth
    And the "dob-day" field should contain "08"
    And the "dob-month" field should contain "02"
    And the "dob-year" field should contain "1968"
    # Address details
    And the "post-code" field should contain "SW2 2AU"
    And the "address1" field should contain "44, Craster Road"
    And the "address2" field should contain "address line two"
    And the "address3b" field should contain "address line three"
    And the "county" field should contain "a county"
    And the "town" field should contain "a town"
    And the "postcode" field should contain "post code"
    # Phone details
    And the "phone-input" field should contain "07951234567"
    # conditional checkboxes
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
    And I follow "Enter address manually"
    And I fill in "address1" with "address line one"
    And I fill in "town" with "London"
    And I fill in "postcode" with "SW9 999"
    And I fill in "password" with "a"
    And I fill in "passwordConfirm" with "a"
    And I fill in "email" with "bill.carr@test"
    And I fill in "phone-input" with "abc"
    And I press "Create account"
    # Checking that field validation is working
    Then I should see "first name in wrong format"
    Then I should see "last name in wrong format"
    Then I should see "Your password should be eight characters long and include a mix of letters, numbers and symbols"
    Then I should see "email address in wrong format"
    Then I should see "Day in wrong format"
    Then I should see "Month in wrong format"
    Then I should see "Year in wrong format"
    Then I should see "Phone input in wrong format"
    Then I should see "Please accept terms and conditions before continuing"
    Then I should see "Please tell us how you found faststream"

  @CSR-135
  Scenario: Complete About You Section (Mandatory fields)
    Given I am logged in as "persona2@test.com" with password "P@ssword1"
    And I follow "My Details"
    Then I should see "About You"
    And I check "sms-alerts"
    And I check "sms-alerts-mobile-number"
    And I press "Save and continue"
    Then I should see "Please enter your address"
    And I should see "Please enter your date of birth"
    And I should see "Please enter your daytime telephone number"
    And I should see "Please enter mobile number for sms alerts"



