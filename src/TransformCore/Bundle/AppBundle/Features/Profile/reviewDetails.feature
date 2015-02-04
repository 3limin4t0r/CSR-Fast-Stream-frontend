Feature: As an applicant, after completing all profile sections, I want to be able to review before submitting

  @CSR-211
  Scenario: Review and Submit (User Journey)
    Given I am logged in as "four@test.com" with password "P@ssword1"
    And I am on "/en/applicant/review"
    And I should see "123 Some Street"
    And I should see "I require a Visa"