Feature: As an user, I want to be able to register a new account, in order to apply for jobs

  @CSR-6
  Scenario Outline: Create Account with valid details
    Given I am on the homepage
    And I follow "Register"
    Then I should see "Register Your Details"
    # Your details
    And I fill in "fos_user_registration_form_firstname" with "<first-name>"
    And I fill in "fos_user_registration_form_lastname" with "<last-name>"
    # Contact details
    And I fill in "fos_user_registration_form_email" with "<email-input>"
    # Signin Details
    And I fill in "fos_user_registration_form_plainPassword_first" with "<password>"
    And I fill in "fos_user_registration_form[plainPassword][second]" with "<password>"
    # Referrer
    And I select "<referrer-input>" from "fos_user_registration_form_heardAboutUs"
    # Disability details
    And I check "fos_user_registration_form_disabledAdjustmentRequired"
    And I select "<disability>" from "fos_user_registration_form_disabledDetails"
    And I fill in "fos_user_registration_form_disabledAdjustmentDetails" with "some disability adjustments text"
    And I fill in "fos_user_registration_form_phoneNumber1" with "<phone-input1>"
    And I fill in "fos_user_registration_form_phoneNumber2" with "<phone-input2>"
    # Checkboxes
    Then I should see "Guaranteed Interview Scheme"
    And I check "fos_user_registration_form_guaranteedInterviewScheme"
    And I check "fos_user_registration_form_termsAndConditions"
    And I press "fos_user_registration_form_registerButton"
    Then I should see "My Account"
    And I should see "<email-input>"
  # And I should get an email on "<email-input>" with:
  #  """
  #  Confirmation email content detail here
  #  """

  Examples:
    | first-name | last-name | email-input       | phone-input1 | phone-input2 | password  | disability | referrer-input   |
    | One        | Persona   | persona1@test.com | 07739898078  | 07739898011  | P@ssword1 | 1          | Search Engine    |
    | Two        | persona   | persona2@test.com | 07739898079  | 07739898022  | P@ssword1 | 1          | Friend or Family |


  @CSR-6
  Scenario Outline: Check info links on Register form
    Given I am on homepage
    And I follow "Register"
    When I follow "<linkname>"
    Then I should see "<expectedtext>"
  Examples:
    | linkname                                                                                                        | expectedtext                                                        |
    | What is the Guaranteed Interview Scheme?                                                                        | Guaranteed Interview Scheme                                         |
    | Please review our terms and conditions detailing how we use your personal data, and indicate your consent below | We take our obligations under data protection legislation seriously |

  @CSR-6
  Scenario: Create account with invalid details (field formats)
    Given I am on the homepage
    And I follow "Register"
    Then I should see "Register Your Details"
    # Your details
    And I fill in "fos_user_registration_form_firstname" with "Bil2"
    And I fill in "fos_user_registration_form_lastname" with "Ca2rr"
        # Contact details
    And I fill in "fos_user_registration_form_email" with "bill.carr@test"
        # Signin Details
    And I fill in "fos_user_registration_form_plainPassword_first" with "P@ssword1"
    And I fill in "fos_user_registration_form[plainPassword][second]" with "P@ssword11"
        # Disability details
    And I check "I require adjustments based on my disability"
    And I press "fos_user_registration_form_registerButton"
    Then I should see "This value should be of type alpha"
    Then I should see "This value should be of type alpha"
    Then I should see "The entered passwords don't match"
    Then I should see "This value is not a valid email address"

  @omit
  Scenario Outline: Create account with invalid details (password check)
    Given I am on the homepage
    And I follow "Register"
    Then I should see "Register Your Details"
    And I fill in "fos_user_registration_form_firstname" with "Bill"
    And I fill in "fos_user_registration_form_lastname" with "Carr"
    And I fill in "fos_user_registration_form_plainPassword_first" with "<password>"
    And I fill in "fos_user_registration_form[plainPassword][second]" with "<password>"
    And I fill in "fos_user_registration_form_email" with "bill.carr@test.com"
    And I press "fos_user_registration_form_registerButton"
    Then I should see "Your password should be eight characters long and include a mix of letters, numbers and symbols"
  Examples:
    | password  |
    | 1234567   |
    | 12345678  |
    | abcdefgh  |
    | abcdefgh1 |
    | abcdefgh@ |

  @CSR-6
  Scenario: Create account using blank form text fields (mandatory field check)
    Given I am on the homepage
    And I follow "Register"
    And I press "fos_user_registration_form_registerButton"
    Then I should see "This value should not be blank"
    And I fill in "fos_user_registration_form_firstname" with "Four"
    And I press "fos_user_registration_form_registerButton"
    Then I should see "This value should not be blank"
    And I fill in "fos_user_registration_form_lastname" with "Persona"
    And I fill in "fos_user_registration_form_email" with "email@test"
    And I press "fos_user_registration_form_registerButton"
    Then I should see "This value is not a valid email address"
    And I fill in "fos_user_registration_form_email" with "persona4@test.com"
    And I press "fos_user_registration_form_registerButton"
    Then I should see "This value should not be blank"
    And I fill in "fos_user_registration_form_plainPassword_first" with "P@ssword1"
    And I press "fos_user_registration_form_registerButton"
    Then I should see "The entered passwords don't match"
    And I fill in "fos_user_registration_form_plainPassword_first" with "P@ssword1"
    And I fill in "fos_user_registration_form_plainPassword_second" with "P@ssword1"
    And I press "fos_user_registration_form_registerButton"
    Then I should see "This value should not be blank"
    And I check "fos_user_registration_form_termsAndConditions"
    And I press "fos_user_registration_form_registerButton"
    And I fill in "fos_user_registration_form_plainPassword_first" with "P@ssword1"
    And I fill in "fos_user_registration_form_plainPassword_second" with "P@ssword1"
    And I press "fos_user_registration_form_registerButton"
    Then I should not see "This value should not be blank"
    And I should see "My Account"

  @CSR-6
  Scenario Outline: Create account using email that has already been used
    Given I am on the homepage
    And I follow "Register"
    And I fill in "fos_user_registration_form_email" with "<email>"
    And I fill in "fos_user_registration_form_firstname" with "<first-name>"
    And I fill in "fos_user_registration_form_lastname" with "<last-name>"
    And I fill in "fos_user_registration_form_plainPassword_first" with "<password>"
    And I fill in "fos_user_registration_form[plainPassword][second]" with "<password>"
    And I check "fos_user_registration_form_disabledAdjustmentRequired"
    And I select "Diabetes" from "fos_user_registration_form_disabledDetails"
    And I fill in "fos_user_registration_form_disabledAdjustmentDetails" with "some disability adjustments text"
    And I fill in "fos_user_registration_form_phoneNumber1" with "02084567878"
    And I check "fos_user_registration_form_guaranteedInterviewScheme"
    And I check "fos_user_registration_form_termsAndConditions"
    And I press "fos_user_registration_form_registerButton"
    Then I should see "This value is already used"
  Examples:
    | email             |
    | persona3@test.com |
