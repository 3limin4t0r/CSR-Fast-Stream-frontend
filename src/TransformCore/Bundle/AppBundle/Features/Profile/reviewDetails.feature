Feature: As an applicant, after completing all profile sections, I want to be able to review before submitting

  @CSR-211
  Scenario: Review and Submit (User Journey)
    Given I am logged in as "four@test.com" with password "P@ssword1"
    And I am on "/en/applicant/review"
    Then the response status code should be 200
#    And I should see "address line one"
    And I should see "I require a Visa"