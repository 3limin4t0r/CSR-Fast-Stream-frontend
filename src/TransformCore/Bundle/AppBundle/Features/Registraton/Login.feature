Feature: As a user, I want to be able to login, in order to manage my account and process applications

  Background:
    Given following users for each persona exist on system:
      | apprentice1@test.com |
      | trainee1@test.com      |

  @CSR-5
  Scenario Outline: Login (Valid details)
    Given I am on the homepage
    And I fill in "user-name" with "<email>"
    And I fill in "password" with "<password>"
    And I press "Login"
    Then I should see "<message>"

  Examples:
    | email     | password  | message               |
    | apprentice1@test.com  | Password1 | You are now logged in |
    | trainee1@test.com    | Password1 | You are now logged in |

  @CSR-5
  Scenario Outline: Login (Invalid password)
    Given I am on the homepage
    And I fill in "user-name" with "<username>"
    And I fill in "password" with "<password>"
    And I press "Login"
    Then I should see "<message>"

  Examples:
    | username     | password   | message                                     |
    | apprentice1@test.com  | Password   | Your username and/or password are incorrect |
    | trainee1@test.com     | password1  | Your username and/or password are incorrect |

  @CSR-5
  Scenario Outline: Login (Invalid username)
    Given I am on the homepage
    And I fill in "user-name" with "<username>"
    And I fill in "password" with "<password>"
    And I press "Login"
    Then I should see "<message>"

  Examples:
    | username      | password  | message                                     |
    | apprentice11@test.com   | Password1 | Your username and/or password are incorrect |
    | trainee11@test.com     | Password1 | Your username and/or password are incorrect |