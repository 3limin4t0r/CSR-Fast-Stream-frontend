Feature: As an user, I want to be able to register a new account, in order to apply for jobs

  @CSR-6
  Scenario Outline: Create Account with valid details
    Given I am on the homepage
    And I follow "Register"
    Then I should see "Register Your Details"
    When I fill form with:
    # Your details
      | fos_user_registration_form_firstname                                                           | <first-name>                     |
      | fos_user_registration_form_lastname                                                            | <last-name>                      |
        # Contact details
      | fos_user_registration_form_email                                                               | <email-input>                    |
        # Signin Details
      | fos_user_registration_form_plainPassword_first                                                 | <password>                       |
      | fos_user_registration_form_plainPassword_second                                                | <password>                       |
        # Referrer
      | fos_user_registration_form_registered_disability_group_registration_heardAboutUs               | <referrer-input>                 |
        # Disability details
      | fos_user_registration_form_registered_disability_group_registration_disabledAdjustmentRequired | YES                              |
      | fos_user_registration_form_registered_disability_group_registration_disabledDetails            | Heart conditions                 |
      | fos_user_registration_form_registered_disability_group_registration_disabledAdjustmentDetails  | some disability adjustments text |
      | fos_user_registration_form_registered_disability_group_phoneNumber_number                      | <phoneNumber>                    |
    # Checkboxes
      | fos_user_registration_form_registered_disability_group_registration_guaranteedInterviewScheme  | YES                              |
      | fos_user_registration_form_registered_disability_group_registration_termsAndConditions         | YES                              |
    And I press "fos_user_registration_form_registerButton"
    Then I should not see "This value is already used"
    Then I should see "The user has been created successfully"
    And I should see "<email-input>"
  # And I should get an email on "<email-input>" with:
  #  """
  #  Confirmation email content detail here
  #  """

  Examples:
    | first-name | last-name | email-input  | phoneNumber | password  | referrer-input   |
    | One        | Persona   | one@test.com | 07739898078 | P@ssword1 | Search Engine    |
    | Two        | persona   | two@test.com | 07739898079 | P@ssword1 | Friend or Family |


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
    And I fill in "fos_user_registration_form_plainPassword_second" with "P@ssword11"
        # Disability details
    And I check "I require adjustments based on my disability"
    And I press "fos_user_registration_form_registerButton"
    And I should see "Please enter only letters for your first name"
    And I should see "Please enter only letters for your first name"
    Then I should see "The entered passwords don't match"
    And I should see "Please make sure your e-mail address is valid"

  @CSR-6
  Scenario Outline: Create account with invalid details (password check)
    Given I am on the homepage
    And I follow "Register"
    Then I fill form with:
    | fos_user_registration_form_firstname | Bill |
    | fos_user_registration_form_lastname  | Carr |
    | fos_user_registration_form_plainPassword_first | <password> |
    | fos_user_registration_form_plainPassword_second | <password> |
    | fos_user_registration_form_email                                  | bill.carr@test.com        |
    And I press "fos_user_registration_form_registerButton"
    Then I should see "Please make sure your password is at least 8 characters long"
    And I should see "Please make sure your password contains at least 1 number"
    And I should see "Please make sure your password contains at least 1 symbol (e.g. !@#$%^*_-)"
  Examples:
    | password  |
    | 1234567   |
    | 12345678  |
    | abcdefgh  |
    | abcdefgh1 |
    | abcdefgh@ |

  @CSR-6 @omit
  Scenario Outline: Create account with invalid details (password)
    Given I am on the homepage
    And I follow "Register"
    Then I should see "Register Your Details"
    And I fill in "fos_user_registration_form_firstname" with "Bill"
    And I fill in "fos_user_registration_form_lastname" with "Carr"
    And I fill in "fos_user_registration_form_plainPassword_first" with "<password>"
    And I fill in "fos_user_registration_form[plainPassword][second]" with "<password>"
    And I fill in "fos_user_registration_form_email" with "bill.carr@test.com"
    And I press "fos_user_registration_form_registerButton"
    Then I should see "<Message1>"
    Then I should see "<Message2>"
  Examples:
    | password | Message1                                                     | Message2                                                                   |
    | 1234567  | Please make sure your password is at least 8 characters long | Please make sure your password contains at least 1 symbol (e.g. !@#$%^*_-) |
    | abcdefgh | Please make sure your password contains at least 1 number    | Please make sure your password contains at least 1 symbol (e.g. !@#$%^*_-) |

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
    Then I should see "Please make sure your e-mail address is valid"
    And I fill in "fos_user_registration_form_email" with "four@test.com"
    And I press "fos_user_registration_form_registerButton"
    Then I should see "This value should not be blank"
    And I fill in "fos_user_registration_form_plainPassword_first" with "P@ssword1"
    And I press "fos_user_registration_form_registerButton"
    Then I should see "The entered passwords don't match"
    And I fill in "fos_user_registration_form_plainPassword_first" with "P@ssword1"
    And I fill in "fos_user_registration_form_plainPassword_second" with "P@ssword1"
    And I press "fos_user_registration_form_registerButton"
    Then I should see "This value should not be blank"
    And I check "fos_user_registration_form_registered_disability_group_registration_termsAndConditions"
    And I press "fos_user_registration_form_registerButton"
    And I fill in "fos_user_registration_form_plainPassword_first" with "P@ssword1"
    And I fill in "fos_user_registration_form_plainPassword_second" with "P@ssword1"
    And I press "fos_user_registration_form_registerButton"
    Then I should not see "This value should not be blank"

  @CSR-6
  Scenario Outline: Create account using email that has already been used
    Given I am on the homepage
    And I follow "Register"
    And I fill form with:
    And I fill in "fos_user_registration_form_email" with "<email>"
    And I fill in "fos_user_registration_form_firstname" with "<first-name>"
    And I fill in "fos_user_registration_form_lastname" with "<last-name>"
    And I fill in "fos_user_registration_form_plainPassword_first" with "<password>"
    And I fill in "fos_user_registration_form_plainPassword_second" with "<password>"
    And I check "fos_user_registration_form_registered_disability_group_registration_disabledAdjustmentRequired"
    And I select "Diabetes" from "fos_user_registration_form_registered_disability_group_registration_disabledDetails"
    And I fill in "fos_user_registration_form_registered_disability_group_registration_disabledAdjustmentDetails" with "some disability adjustments text"
    And I fill in "fos_user_registration_form_registered_disability_group_phoneNumber_number" with "02084567878"
    And I check "fos_user_registration_form_registered_disability_group_registration_guaranteedInterviewScheme"
    And I check "fos_user_registration_form_registered_disability_group_registration_termsAndConditions"
    And I press "fos_user_registration_form_registerButton"
    Then I should see "This value is already used"
  Examples:
    | email          |
    | three@test.com |
