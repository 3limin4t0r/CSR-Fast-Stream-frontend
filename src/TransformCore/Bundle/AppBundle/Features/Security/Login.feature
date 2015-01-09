Feature: As a user, I want to be able to login, in order to manage my account and process applications

  Background:
    Given following users for each persona exist on system:
      | persona3@test.com |

  @CSR-5
  Scenario Outline: Login (Valid details)
    Given I am on the homepage
    And I fill in "user-name" with "<email>"
    And I fill in "password" with "<password>"
    And I press "Login"
    Then I should see "<message>"

  Examples:
    | email             | password  | message    |
    | persona3@test.com | P@ssword1 | My Account |

  @CSR-5
  Scenario Outline: Login (Invalid password)
    Given I am on the homepage
    And I fill in "user-name" with "<username>"
    And I fill in "password" with "<password>"
    And I press "Login"
    Then I should see "<message>"

  Examples:
    | username          | password  | message             |
    | persona3@test.com | P@ssword  | Invalid credentials |
    | persona3@test.com | p@ssword1 | Invalid credentials |

  @CSR-5
  Scenario Outline: Login (Invalid username)
    Given I am on the homepage
    And I fill in "user-name" with "<username>"
    And I fill in "password" with "<password>"
    And I press "Login"
    Then I should see "<message>"

  Examples:
    | username          | password  | message             |
    | Persona3@test.com | P@ssword1 | Invalid credentials |
