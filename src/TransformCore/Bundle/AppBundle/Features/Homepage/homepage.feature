Feature: As an applicant, after logging in, I want to see my homepage

  Scenario:
    Given I am logged in as "three@test.com" with password "P@ssword1"
    Then I should see "My Account"
    And I should see "three@test.com"
    And I should see "Logout"
    And I should not see "Login"





