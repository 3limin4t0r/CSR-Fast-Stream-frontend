Feature: As an user, I want to be able to reset my password, for security reasons

  @CSR-344
  Scenario: Password reset in About You Section
    Given I am logged in as "five@test.com" with password "P@ssword1"
    And I am on "/en/profile/change-password"
#    And I follow "Profile"
    And I fill in "fos_user_change_password_form_current_password" with "P@ssword1"
    And I fill in "fos_user_change_password_form_plainPassword_first" with "P@ssword2"
    And I fill in "fos_user_change_password_form_plainPassword_second" with "P@ssword2"
    Then I press "Change password"
    And I follow "Logout"
    When I am logged in as "five@test.com" with password "P@ssword2"
    Then I should see "Logout"
    And I should not see "Login"
    And I follow "Logout"
    Then I am logged in as "five@test.com" with password "P@ssword2"
    And I am on "/en/profile/change-password"
#    And I follow "Profile"
    And I fill in "fos_user_change_password_form_current_password" with "P@ssword2"
    And I fill in "fos_user_change_password_form_plainPassword_first" with "P@ssword1"
    And I fill in "fos_user_change_password_form_plainPassword_second" with "P@ssword1"
    Then I press "Change password"
    And I follow "Logout"
    When I am logged in as "five@test.com" with password "P@ssword1"
    Then I should see "Logout"
    And I should not see "Login"