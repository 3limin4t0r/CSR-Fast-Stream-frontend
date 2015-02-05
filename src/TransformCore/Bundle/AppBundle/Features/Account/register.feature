Feature: As an user, I want to be able to register a new account, in order to apply for jobs

  @CSR-6
  Scenario Outline: Create Account with valid details
    Given I am on the homepage
    And I follow "Register"
    Then I should see "Register Your Details"
    When I fill form with:
      | fos_user_registration_form_firstname                                                           | <first-name>                     |
      | fos_user_registration_form_lastname                                                            | <last-name>                      |
      | fos_user_registration_form_email                                                               | <email-input>                    |
      | fos_user_registration_form_plainPassword_first                                                 | <password>                       |
      | fos_user_registration_form_plainPassword_second                                                | <password>                       |
      | fos_user_registration_form_registered_disability_group_registration_heardAboutUs               | <referrer-input>                 |
      | fos_user_registration_form_registered_disability_group_registration_disabledAdjustmentRequired | Yes                              |
      | fos_user_registration_form_registered_disability_group_registration_disabledDetails            | Heart conditions                 |
      | fos_user_registration_form_registered_disability_group_registration_disabledAdjustmentDetails  | some disability adjustments text |
      | fos_user_registration_form_registered_disability_group_phoneNumber_number                      | <phoneNumber>                    |
      | fos_user_registration_form_registered_disability_group_registration_guaranteedInterviewScheme  | Yes                              |
      | fos_user_registration_form_registered_disability_group_registration_termsAndConditions         | Yes                              |
    And I press "Register"
    Then I should not see "This value is already used"
    Then I should see "The user has been created successfully"
    And I should see "<email-input>"

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
    And I fill form with:
      | fos_user_registration_form_firstname            | Bil2           |
      | fos_user_registration_form_lastname             | Ca2rr          |
      | fos_user_registration_form_email                | bill.carr@test |
      | fos_user_registration_form_plainPassword_first  | P@ssword1      |
      | fos_user_registration_form_plainPassword_second | P@ssword11     |
      | I require adjustments based on my disability    | Yes            |
    And I press "Register"
    And I should see "Please enter only letters for your first name"
    And I should see "Please enter only letters for your first name"
    Then I should see "The entered passwords don't match"
    And I should see "Please make sure your e-mail address is valid"

  @CSR-6
  Scenario Outline: Create account with invalid details (password check)
    Given I am on the homepage
    And I follow "Register"
    Then I fill form with:
      | fos_user_registration_form_firstname            | Bill               |
      | fos_user_registration_form_lastname             | Carr               |
      | fos_user_registration_form_plainPassword_first  | <password>         |
      | fos_user_registration_form_plainPassword_second | <password>         |
      | fos_user_registration_form_email                | bill.carr@test.com |
    And I press "Register"
    Then I should see "<message>"
    And I should see "Please make sure your password contains at least 1 symbol (e.g. !@#$%^*_-)"
  Examples:
    | password  |message|
    | 123456a   | Please make sure your password is at least 8 characters long     |
    | 12345678  | Please make sure your password contains at least 1 letter        |
    | abcdefgh  | Please make sure your password contains at least 1 number        |


  @CSR-6
  Scenario: Create account using blank form text fields (mandatory field check)
    Given I am on the homepage
    And I follow "Register"
    And I press "Register"
    Then I should see "This value should not be blank"
    And I fill in "fos_user_registration_form_firstname" with "Four"
    And I press "Register"
    Then I should see "This value should not be blank"
    And I fill in "fos_user_registration_form_lastname" with "Persona"
    And I fill in "fos_user_registration_form_email" with "email@test"
    And I press "Register"
    Then I should see "Please make sure your e-mail address is valid"
    And I fill in "fos_user_registration_form_email" with "four@test.com"
    And I press "Register"
    Then I should see "This value should not be blank"
    And I fill in "fos_user_registration_form_plainPassword_first" with "P@ssword1"
    And I press "Register"
    Then I should see "The entered passwords don't match"
    And I fill in "fos_user_registration_form_plainPassword_first" with "P@ssword1"
    And I fill in "fos_user_registration_form_plainPassword_second" with "P@ssword1"
    And I press "Register"
    Then I should see "This value should not be blank"
    And I check "fos_user_registration_form_registered_disability_group_registration_termsAndConditions"
    And I press "Register"
    And I fill in "fos_user_registration_form_plainPassword_first" with "P@ssword1"
    And I fill in "fos_user_registration_form_plainPassword_second" with "P@ssword1"
    And I press "Register"
    Then I should not see "This value should not be blank"

  @CSR-6
  Scenario Outline: Create account using email that has already been used
    Given I am on the homepage
    And I follow "Register"
    And I fill form with:
      | fos_user_registration_form_email                                                               | <email>                           |
      | fos_user_registration_form_firstname                                                           | <first-name>                      |
      | fos_user_registration_form_lastname                                                            | <last-name>                       |
      | fos_user_registration_form_plainPassword_first                                                 | <password>                        |
      | fos_user_registration_form_plainPassword_second                                                | <password>                        |
      | fos_user_registration_form_registered_disability_group_registration_disabledAdjustmentRequired | Yes                               |
      | fos_user_registration_form_registered_disability_group_registration_disabledDetails            | Diabetes                          |
      | fos_user_registration_form_registered_disability_group_registration_disabledAdjustmentDetails  | some disability adjustments text"
      | fos_user_registration_form_registered_disability_group_phoneNumber_number                      | 02084567878                       |
      | fos_user_registration_form_registered_disability_group_registration_guaranteedInterviewScheme  | Yes                               |
      | fos_user_registration_form_registered_disability_group_registration_termsAndConditions         | Yes                               |
    And I press "Register"
    Then I should see "This value is already used"
  Examples:
    | email          |
    | three@test.com |
