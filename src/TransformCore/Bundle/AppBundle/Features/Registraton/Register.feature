Feature: As an user, I want to be able to register a new account, in order to apply for jobs

  Background:
    Given following users for each persona exist on system:
      | persona3@test.com |
      
  @CSR-6
  Scenario Outline: Create Account with valid details
    Given I am on the homepage
    And I follow "Register"
    Then I should see "Register Your Details"
    # Contact details
    And I fill in "fos_user_registration_form_email" with "<email-input>"
    # Your details
    And I fill in "fos_user_registration_form_firstname" with "<first-name>"
    And I fill in "fos_user_registration_form_lastname" with "<last-name>"
    # Signin Details
    And I fill in "fos_user_registration_form_plainPassword_first" with "<password>"
    And I fill in "passwordConfirm" with "<password>"
    # Referrer
    And I select "<referrer-input>" from "fos_user_registration_form_heardAboutUs"
    # Disability details
    And I check "fos_user_registration_form_disabled"
    And I select "<disability>" from "disability"
    And I check "fos_user_registration_form_disabledAdjustmentRequired"
    And I fill in "fos_user_registration_form_disabledAdjustmentDetails" with "some disability adjustments text"
    And I fill in "fos_user_registration_form_phoneNumber1" with "<phone-input1>"
    And I fill in "fos_user_registration_form_phoneNumber2" with "<phone-input2>"
    # Checkboxes
    And I follow "What is the Guaranteed Interview Scheme?"
    Then I should see "The Civil Service Fast Stream operates the Guaranteed Interview Scheme (GIS) which means that applicants with a registered disability need only meet the minimum qualifying criteria for their chosen scheme(s)."
    And I check "fos_user_registration_form_guaranteedInterviewScheme"
    Then I follow "terms and conditions"
    And I check "fos_user_registration_form_termsAndConditions"
    And I follow "Register"
    Then I should see "Registration: COMPLETE"
    And I should see "Welcome, <first-name>"
  # And I should get an email on "<email-input>" with:
  #  """
  #  Confirmation email content detail here
  #  """

  Examples:
    | first-name | last-name | email-input       | phone-input1 | phone-input2 |password  | disability |referrer-input|
    | One    | Persona       | persona1@test.com | 07739898078 | 07739898011 |P@ssword1 | Diabetes           | Search Engine |
    | Two    | persona       | persona2@test.com | 07739898079 | 07739898022 |P@ssword1 | Hearing impairment | Friend or Family |

  @CSR-6
  Scenario: Create account with invalid details (field formats)
    Given I am on the homepage
    And I follow "Register"
    Then I should see "Register Your Details"
    # Your details
    And I fill in "fos_user_registration_form_firstname" with "Bil@l"
    And I fill in "fos_user_registration_form_lastname" with "Ca!rr"
        # Contact details
    And I fill in "fos_user_registration_form_email" with "bill.carr@test"
        # Signin Details
    And I fill in "fos_user_registration_form_plainPassword_first" with "P@ssword1"
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
    And I follow "Register"
    Then I should see "Register Your Details"
    And I fill in "fos_user_registration_form_firstname" with "Bill"
    And I fill in "fos_user_registration_form_lastname" with "Carr"
    And I fill in "fos_user_registration_form_plainPassword_first" with "<password1>"
    And I fill in "passwordConfirm" with "<password2>"
    And I fill in "fos_user_registration_form_email" with "bill.carr@test.com"
    And I press "Create account"
    Then I should see "Your password should be eight characters long and include a mix of letters, numbers and symbols"
  Examples:
    | password1 | password2 |
    | 1234567   | 1234567   |
    | 12345678  | 12345678  |
    | abcdefgh  | abcdefgh  |
    | abcdefgh1  | abcdefgh1  |
    | abcdefgh@  | abcdefgh@  |

    @CSR-6
  Scenario Outline: Create account using blank fields (mandatory field check)
    Given I am on the homepage
    And I follow "Register"
    Then I should see "Register Your Details"
    And I press "Create account"
    Then I should see "<fieldname> should not be blank"
    Examples:
    |fieldname|fieldvalue|
    |first-name|         |
    |last-name|          |
    |password|           |
    |email|              |
    
    @CSR-6
  Scenario Outline: Create account using email that has already been used
    Given I am on the homepage
    And I follow "Register"
    Then I fill in "fos_user_registration_form_email" with "<email>"
    And I press "Create account"
    Then I should see "<email> is already taken"
    Examples:
    |email|
    |persona3@test.com|
