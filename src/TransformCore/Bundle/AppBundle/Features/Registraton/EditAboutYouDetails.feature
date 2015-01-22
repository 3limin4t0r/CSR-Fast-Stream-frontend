Feature: As an user, I want to be able to add details about myself on my account, in order to apply for jobs

  Background:
    Given following users for each persona exist on system:
      | persona1@test.com |
      | persona2@test.com |

  @CSR-135
  Scenario: Complete About You Section (Happy path)
    Given I am logged in as "persona1@test.com" with password "P@ssword1"
    And I am on "/en/account/edit"
    Then I should see "First Name"
    And the "csr_dm_user_profile_firstname" field should contain "One"
    And the "csr_dm_user_profile_lastname" field should contain "Persona"
    And I fill in "csr_dm_user_profile_firstname" with "Onechange"
    And I fill in "csr_dm_user_profile_lastname" with "Personachange"
    # Address Details
#    And I follow "Enter address manually"
    And I fill in "csr_dm_user_profile_address_line1" with "address line one"
    And I fill in "csr_dm_user_profile_address_line2" with "address line two"
    And I fill in "csr_dm_user_profile_address_line3" with "address line three"
    And I fill in "csr_dm_user_profile_address_town" with "a town"
    And I fill in "csr_dm_user_profile_address_county" with "a county"
    And I fill in "csr_dm_user_profile_address_postcode" with "post code"
    # Date of Birth
    And I fill in "csr_dm_user_profile_dateOfBirth" with "08/02/1968"
    # Phone details
    And I fill in "csr_dm_user_profile_phoneNumber_number" with "07951234567"
    And I fill in "csr_dm_user_profile_address_country" with "United Kingdom"
#    And I check "mobile-number-yes"
#    # End of My Details step one form
    When I press "Update"
    Then I should see "Your changes were saved"
#    Then I follow "Go back the the previous section"
    # Checking that values have been retained
    And the "csr_dm_user_profile_firstname" field should contain "Onechange"
    And the "csr_dm_user_profile_lastname" field should contain "Personachange"
    # Date of birth
    And the "csr_dm_user_profile_dateOfBirth" field should contain "08/02/1968"
    # Address details
    And the "csr_dm_user_profile_address_postcode" field should contain "post code"
    And the "csr_dm_user_profile_address_line1" field should contain "address line one"
    And the "csr_dm_user_profile_address_line2" field should contain "address line two"
    And the "csr_dm_user_profile_address_line3" field should contain "address line three"
    And the "csr_dm_user_profile_address_county" field should contain "a county"
    And the "csr_dm_user_profile_address_town" field should contain "a town"
    And the "csr_dm_user_profile_address_postcode" field should contain "post code"
    And the "csr_dm_user_profile_country" field should contain "United Kingdom"
    # Phone details
    And the "csr_dm_user_profile_phoneNumber_number" field should contain "07951234567"
    # conditional checkboxes
    And the "checkbox1" checkbox should be checked
    And the "This is my mobile number" checkbox should be checked

  @CSR-135
  Scenario: Complete About You Section (Field validation)
    Given I am logged in as "persona2@test.com" with password "P@ssword1"
    And I follow "Profile"
    Then I should see "First Name"
    And I fill in "csr_dm_user_profile_firstname" with "Bill1"
    And I fill in "csr_dm_user_profile_lastname" with "C4@rr"
    And I fill in "csr_dm_user_profile_dateOfBirth" with "c/b/d"
    And I fill in "csr_dm_user_profile_address_postcode" with "CFT 888"
#    And I follow "Enter address manually"
    And I fill in "csr_dm_user_profile_address_line1" with "address line one"
    And I fill in "csr_dm_user_profile_address_town" with "London"
    And I fill in "csr_dm_user_profile_address_postcode" with "SW9 999"
    And I fill in "csr_dm_user_profile_plainPassword_first" with "a"
    And I fill in "csr_dm_user_profile_plainPassword_second" with "a"
    And I fill in "csr_dm_user_profile_email" with "bill.carr@test"
    And I fill in "csr_dm_user_profile_phoneNumber_number" with "abc"
    And I press "Update"
    # Checking that field validation is working
    Then count of "2" instances of "This value should be of type alpha" exists on page
    And I should see "This value is too short. It should have 8 characters or more."
    And I should see "Must contain at least 1 letter"
    And I should see "Must contain at least 1 symbol (eg. !@#$%^*_-)"
    And I should see "This value is not a valid email address"
    And I should see "Date of birth in wrong format"
    And I should see "Phone input in wrong format"
    And I should see "Please accept terms and conditions before continuing"
    And I should see "Please tell us how you found faststream"

  @CSR-135
  Scenario: Complete About You Section (Mandatory fields)
    Given I am logged in as "persona2@test.com" with password "P@ssword1"
    And I follow "Profile"
    Then I should see "First Name"
#    And I check "sms-alerts-yes"
#    And I check "sms-alerts-mobile-number"
    And I press "Update"
    Then count of "5" instances of "This value should not be blank" exists on page
#    Then I should see "This value should not be blank"
#    And I should see "Please enter your date of birth"
#    And I should see "Please enter your daytime telephone number"
#    And I should see "Please enter mobile number for sms alerts"
