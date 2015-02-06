Feature: As an user, I want to be able to add details about myself on my account, in order to apply for jobs

  Background:
    Given following users for each persona exist on system:
      | one@test.com |
      | two@test.com |

  @CSR-135
  Scenario: Complete About You Section (Happy path)
    Given I am logged in as "one@test.com" with password "P@ssword1"
    And I follow "Profile"
    Then the "csr_dm_user_profile_name_group_firstname" field should contain "One"
    And the "csr_dm_user_profile_name_group_lastname" field should contain "Persona"
    And I fill in "csr_dm_user_profile_name_group_firstname" with "Onechange"
    And I fill in "csr_dm_user_profile_name_group_lastname" with "Personachange"
    # Address Details
#    And I follow "Enter address manually"
    And I fill in "csr_dm_user_profile_address_address_group_line1" with "address line one"
    And I fill in "csr_dm_user_profile_address_address_group_line2" with "address line two"
    And I fill in "csr_dm_user_profile_address_address_group_line3" with "address line three"
    And I fill in "csr_dm_user_profile_address_address_group_town" with "a town"
    And I fill in "csr_dm_user_profile_address_address_group_county" with "a county"
    And I fill in "csr_dm_user_profile_address_address_group_postcode" with "post code"
    # Date of Birth
#    And I fill in "csr_dm_user_profile_date_of_birth_group_dateOfBirth" with "1968-08-02"
    And I fill in "csr_dm_user_profile_date_of_birth_group_dateOfBirth_day" with "02"
    And I fill in "csr_dm_user_profile_date_of_birth_group_dateOfBirth_month" with "08"
    And I fill in "csr_dm_user_profile_date_of_birth_group_dateOfBirth_year" with "1968"
    # Phone details
    And I fill in "csr_dm_user_profile_phone_number_group_phoneNumber_number" with "07951234567"
    And I select "United Kingdom" from "csr_dm_user_profile_address_address_group_country"
#    And I check "mobile-number-yes"
#    # End of My Details step one form
    When I press "Save and continue"
    Then I should see "Nationality, Immigration and Employment Restrictions"
    Then I follow "Profile"
    # Checking that values have been retained
    And the "csr_dm_user_profile_name_group_firstname" field should contain "Onechange"
    And the "csr_dm_user_profile_name_group_lastname" field should contain "Personachange"
    # Date of birth
#    And the "csr_dm_user_profile_date_of_birth_group_dateOfBirth" field should contain "1968-08-02"
    And the "csr_dm_user_profile_date_of_birth_group_dateOfBirth_day" field should contain "02"
    And the "csr_dm_user_profile_date_of_birth_group_dateOfBirth_month" field should contain "08"
    And the "csr_dm_user_profile_date_of_birth_group_dateOfBirth_year" field should contain "1968"
    # Address details
    And the "csr_dm_user_profile_address_address_group_postcode" field should contain "post code"
    And the "csr_dm_user_profile_address_address_group_line1" field should contain "address line one"
    And the "csr_dm_user_profile_address_address_group_line2" field should contain "address line two"
    And the "csr_dm_user_profile_address_address_group_line3" field should contain "address line three"
    And the "csr_dm_user_profile_address_address_group_county" field should contain "a county"
    And the "csr_dm_user_profile_address_address_group_town" field should contain "a town"
    And the "csr_dm_user_profile_address_address_group_postcode" field should contain "post code"
    And I select "United Kingdom" from "csr_dm_user_profile_address_address_group_country"
    # Phone details
    And the "csr_dm_user_profile_phone_number_group_phoneNumber_number" field should contain "07951234567"
    # conditional checkboxes
#    And the "checkbox1" checkbox should be checked
#    And the "This is my mobile number" checkbox should be checked

  @CSR-135
  Scenario: Complete About You Section (Field validation)
    Given I am logged in as "two@test.com" with password "P@ssword1"
    And I follow "Profile"
    And I fill in "csr_dm_user_profile_name_group_firstname" with "Bill1"
    And I fill in "csr_dm_user_profile_name_group_lastname" with "C4@rr"
#    And I fill in "csr_dm_user_profile_date_of_birth_group_dateOfBirth" with "c/b/d"
    And I fill in "csr_dm_user_profile_address_address_group_postcode" with "CFT 888"
#    And I follow "Enter address manually"
    And I fill in "csr_dm_user_profile_address_address_group_line1" with "address line one"
    And I fill in "csr_dm_user_profile_address_address_group_town" with "London"
    And I fill in "csr_dm_user_profile_address_address_group_postcode" with "SW9 999"
#    And I fill in "csr_dm_user_profile_credentials_group_plainPassword_first" with "a"
#    And I fill in "csr_dm_user_profile_credentials_group_plainPassword_second" with "a"
    And I fill in "csr_dm_user_profile_credentials_group_email" with "bill.carr@test"
#    And I fill in "csr_dm_user_profile_phone_number_group_phoneNumber_number" with "abc"
    When I press "Save and continue"
    # Checking that field validation is working
    Then I should see "Please enter only letters for your first name"
    And I should see "Please enter only letters for your last name"
#    And I should see "Please make sure your password is at least 8 characters long"
#    And I should see "Please make sure your password contains at least 1 number"
#    And I should see "Please make sure your password contains at least 1 symbol (e.g. !@#$%^*_-)"
    And I should see "Please make sure your e-mail address is valid"
#    And I should see "Date of birth in wrong format"
#    And I should see "Phone input in wrong format"
#    And I should see "Please accept terms and conditions before continuing"
#    And I should see "Please tell us how you found faststream"

  @CSR-135
  Scenario: Complete About You Section (Mandatory fields)
    Given I am logged in as "two@test.com" with password "P@ssword1"
    And I follow "Profile"
    Then I should see "First Name"
#    And I check "sms-alerts-yes"
#    And I check "sms-alerts-mobile-number"
    When I press "Save and continue"
    And I should see "Please enter your date of birth"
    Then count of "3" instances of "This value should not be blank" exists on page
#    Then I should see "This value should not be blank"
#    And I should see "Please enter your date of birth"
#    And I should see "Please enter your daytime telephone number"
#    And I should see "Please enter mobile number for sms alerts"

  @CSR-135 @omit
  Scenario: Password reset in About You Section
    Given I am logged in as "one@test.com" with password "P@ssword1"
    And I follow "Profile"
    And I fill in "csr_dm_user_profile_credentials_group_plainPassword_first" with "P@ssword2"
    And I fill in "csr_dm_user_profile_credentials_group_plainPassword_second" with "P@ssword2"
    Then I press "Save and continue"
    And I am on "/en/logout"
#    And I follow "Logout"
    When I am logged in as "one@test.com" with password "P@ssword2"
    Then I should see "Logout"
    And I should not see "Login"
    And I follow "Profile"
    And I fill in "csr_dm_user_profile_credentials_group_plainPassword_first" with "P@ssword1"
    And I fill in "csr_dm_user_profile_credentials_group_plainPassword_second" with "P@ssword1"
    Then I press "Save and continue"
    And I am on "/en/logout"
#    And I follow "Logout"
    When I am logged in as "one@test.com" with password "P@ssword1"
    Then I should see "Logout"
    And I should not see "Login"
