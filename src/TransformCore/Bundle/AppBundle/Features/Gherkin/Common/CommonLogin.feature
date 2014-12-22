Feature: As a user, I want to be able to login, in order to manage my account and process applications

  Background:
    Given following users for each persona exist on system:
      | apprentice1  |
      | trainee1     |
      | employer1    |
      | trainingorg1 |

  @CSR-5
  Scenario Outline: Login (Valid details)
    Given I am on the homepage
    And I fill in "user-name" with "<username>"
    And I fill in "password" with "<password>"
    And I press "Login"
    Then I should see "<message>"

  Examples:
    | username     | password  | message               |
    | apprentice1  | Password1 | You are now logged in |
    | trainee1     | Password1 | You are now logged in |
    | employer1    | Password1 | You are now logged in |
    | trainingorg1 | Password1 | You are now logged in |

  @CSR-5
  Scenario Outline: Login (Invalid password)
    Given I am on the homepage
    And I fill in "user-name" with "<username>"
    And I fill in "password" with "<password>"
    And I press "Login"
    Then I should see "<message>"

  Examples:
    | username     | password   | message                                     |
    | apprentice1  | Password   | Your username and/or password are incorrect |
    | trainee1     | password1  | Your username and/or password are incorrect |
    | employer1    | Passwword1 | Your username and/or password are incorrect |
    | trainingorg1 | Password11 | Your username and/or password are incorrect |

  @CSR-5
  Scenario Outline: Login (Invalid username)
    Given I am on the homepage
    And I fill in "user-name" with "<username>"
    And I fill in "password" with "<password>"
    And I press "Login"
    Then I should see "<message>"

  Examples:
    | username      | password  | message                                     |
    | apprentice11  | Password1 | Your username and/or password are incorrect |
    | trainee11     | Password1 | Your username and/or password are incorrect |
    | employer11    | Password1 | Your username and/or password are incorrect |
    | trainingorg11 | Password1 | Your username and/or password are incorrect |