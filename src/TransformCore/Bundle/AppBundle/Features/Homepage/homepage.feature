Feature: As an applicant after logging in I want to see my homepage

Scenario:
  Given I am logged in as "persona1@test.com" with password "P@ssword1"
  Then I should see "Welcome, One Persona, to your home page"