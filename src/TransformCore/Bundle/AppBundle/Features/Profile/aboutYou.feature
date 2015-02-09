Feature: As an user, I want to be able to add details about myself on my account, in order to apply for jobs

  Background:
    Given following users for each persona exist on system:
      | one@test.com |
      | two@test.com |

  @CSR-135
  Scenario: Complete About You Section (Happy path)
    Given I am logged in as "one@test.com" with password "P@ssword1"
    And I follow "Profile"
    Then I fill form with:
      | csr_dm_user_profile_name_group_firstname                  | One                |
      | csr_dm_user_profile_name_group_lastname                   | Persona            |
      | csr_dm_user_profile_name_group_firstname                  | Onechange          |
      | csr_dm_user_profile_name_group_lastname                   | Personachange      |
      | csr_dm_user_profile_address_address_group_line1           | address line one   |
      | csr_dm_user_profile_address_address_group_line2           | address line two   |
      | csr_dm_user_profile_address_address_group_line3           | address line three |
      | csr_dm_user_profile_address_address_group_town            | a town             |
      | csr_dm_user_profile_address_address_group_county          | a county           |
      | csr_dm_user_profile_address_address_group_postcode        | post code          |
      | csr_dm_user_profile_date_of_birth_group_dateOfBirth_day   | 02                 |
      | csr_dm_user_profile_date_of_birth_group_dateOfBirth_month | 08                 |
      | csr_dm_user_profile_date_of_birth_group_dateOfBirth_year  | 1968               |
      | csr_dm_user_profile_phone_number_group_phoneNumber_number | 07951234567        |
      | csr_dm_user_profile_address_address_group_country         | United Kingdom     |
    When I press "Save and continue"
    Then I should see "Nationality, Immigration and Employment Restrictions"
    Then I follow "Profile"
    And I should see form with:
      | csr_dm_user_profile_name_group_firstname                  | Onechange          |
      | csr_dm_user_profile_name_group_lastname                   | Personachange      |
      | csr_dm_user_profile_date_of_birth_group_dateOfBirth_day   | 02                 |
      | csr_dm_user_profile_date_of_birth_group_dateOfBirth_month | 08                 |
      | csr_dm_user_profile_date_of_birth_group_dateOfBirth_year  | 1968               |
      | csr_dm_user_profile_address_address_group_postcode        | post code          |
      | csr_dm_user_profile_address_address_group_line1           | address line one   |
      | csr_dm_user_profile_address_address_group_line2           | address line two   |
      | csr_dm_user_profile_address_address_group_line3           | address line three |
      | csr_dm_user_profile_address_address_group_county          | a county           |
      | csr_dm_user_profile_address_address_group_town            | a town             |
      | csr_dm_user_profile_address_address_group_postcode        | post code          |
      | csr_dm_user_profile_address_address_group_country         | United Kingdom     |
      | csr_dm_user_profile_phone_number_group_phoneNumber_number | 07951234567        |

  @CSR-135
  Scenario: Complete About You Section (Field validation)
    Given I am logged in as "two@test.com" with password "P@ssword1"
    And I follow "Profile"
    Then I fill form with:
      | csr_dm_user_profile_name_group_firstname                   | Bill1            |
      | csr_dm_user_profile_name_group_lastname                    | C4@rr            |
      | csr_dm_user_profile_address_address_group_postcode         | CFT 888          |
      | csr_dm_user_profile_address_address_group_line1            | address line one
      | csr_dm_user_profile_address_address_group_town             | London           |
      | csr_dm_user_profile_address_address_group_postcode         | SW9 999          |
      | csr_dm_user_profile_credentials_group_plainPassword_first  | a                |
      | csr_dm_user_profile_credentials_group_plainPassword_second | a                |
      | csr_dm_user_profile_credentials_group_email                | bill.carr@test   |
      | csr_dm_user_profile_phone_number_group_phoneNumber_number  | abc              |
    When I press "Save and continue"
    # Checking that field validation is working
    Then I should see "Please enter only letters for your first name"
    And I should see "Please enter only letters for your last name"
#    And I should see "Please make sure your password is at least 8 characters long"
#    And I should see "Please make sure your password contains at least 1 number"
#    And I should see "Please make sure your password contains at least 1 symbol (e.g. !@#$%^*_-)"
    And I should see "Please make sure your e-mail address is valid"
    And I should see "Please enter your date of birth"
#    And I should see "Phone input in wrong format"
#    And I should see "Please accept terms and conditions before continuing"
#    And I should see "Please tell us how you found faststream"

  @CSR-135
  Scenario: Complete About You Section (Mandatory fields)
    Given I am logged in as "two@test.com" with password "P@ssword1"
    And I follow "Profile"
    Then I should see "First Name"
    When I press "Save and continue"
    And I should see "Please enter your date of birth"
    Then count of "3" instances of "This value should not be blank" exists on page

  @CSR-135 @omit
  Scenario: Password reset in About You Section
    Given I am logged in as "three@test.com" with password "P@ssword1"
    And I follow "Profile"
    And I fill form with:
      | csr_dm_user_profile_credentials_group_plainPassword_first  | P@ssword2 |
      | csr_dm_user_profile_credentials_group_plainPassword_second | P@ssword2 |
      | csr_dm_user_profile_date_of_birth_group_dateOfBirth       | 1968-08-02         |
    Then I press "Save and continue"
    And I am on "/en/logout"
    When I am logged in as "three@test.com" with password "P@ssword2"
    Then I should not see "Invalid credentials"
    And I should see "Logout"
    And I follow "Profile"
    And I fill form with:
      | csr_dm_user_profile_credentials_group_plainPassword_first  | P@ssword1 |
      | csr_dm_user_profile_credentials_group_plainPassword_second | P@ssword1 |
    Then I press "Save and continue"
    And I am on "/en/logout"
    When I am logged in as "three@test.com" with password "P@ssword1"
    Then I should see "Logout"
    And I should not see "Login"
