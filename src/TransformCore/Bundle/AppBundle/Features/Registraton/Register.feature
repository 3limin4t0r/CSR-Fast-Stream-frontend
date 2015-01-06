Feature: As an user, I want to be able to register a new account, in order to apply for jobs

  @CSR-6
  Scenario Outline: Create Account with valid details
    Given I am on the homepage
    And I press "Register"
    Then I should see "Register Your Details:"
    #    Your details
    When I select "<salutation>" from "salutation"
    And I fill in "first-name" with "<first-name>"
    And I fill in "last-name" with "<last-name>"
    # Contact details
    And I fill in "email" with "<email-input>"
        # Signin Details
    And I fill in "password" with "<password>"
    And I fill in "passwordConfirm" with "<password>"
    # Referrer
    And I fill in "referrer" with "<referrer-input>"
    # Disability details
    And I check "I require adjustments based on my disability"
    And I select "<disability>" from "disability"
    And I fill in "phone-input" with "<phone-input>"
    And I fill in "disability-adjustments" with "some disability adjustments text"
    # Checkboxes
    And I follow "What is the Guaranteed Interview Scheme?"
    Then I should see:
    """
    The Civil Service Fast Stream operates the Guaranteed Interview Scheme (GIS) which means that applicants with a registered disability need only meet the minimum qualifying criteria for their chosen scheme(s).
    """
    And I check "I wish to apply via the Guaranteed Interview Scheme"
    Then I follow "terms and conditions"
    And I check "accept-terms"
    And I press "Register"
    Then I should see "Registration: COMPLETE"
    And I should see "Welcome, <first-name>"
  # And I should get an email on "<email-input>" with:
  #  """
  #  Confirmation email content detail here
  #  """

  Examples:
    | salutation | first-name | last-name | email-input       | phone-input | password  | disability |referrer-input|
    | Mr         | One    | Persona       | persona1@test.com | 07739898078 | P@ssword1 | Diabetes           | Search Engine |
    | Mr         | Two    | persona       | persona2@test.com | 07739898079 | P@ssword1 | Hearing impairment | Friend or Family |


  @CSR-6
  Scenario: Create account with invalid details (field formats)
    Given I am on the homepage
    And I press "Register"
    Then I should see "Create an account"
    # Your details
    When I select "Mr" from "salutation"
    And I fill in "first-name" with "Bil@l"
    And I fill in "last-name" with "Ca!rr"
        # Contact details
    And I fill in "email" with "bill.carr@test"
        # Signin Details
    And I fill in "password" with "P@ssword1"
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
    And I press "Register"
    Then I should see "Create an account"
    When I select "Mr" from "salutation"
    And I fill in "first-name" with "Bill"
    And I fill in "last-name" with "Carr"
    And I fill in "password" with "<password1>"
    And I fill in "passwordConfirm" with "<password2>"
    And I fill in "email" with "bill.carr@test.com"
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
    And I press "Register"
    Then I should see "Create an account"
    And I press "Create account"
    Then I should see "<fieldname> should not be blank"
    Examples:
    |fieldname|
    |salutation|
    |first-name|
    |last-name|
    |password|
    |email|
    
    @CSR-6
  Scenario Outline: Create account using email that has already been used
    Given I am on the homepage
    And I press "Register"
    Then fill in email with "<email>"
    And I press "Create account"
    Then I should see "<email> is already taken"
    Examples:
    |email|
    |persona3@test.com|
