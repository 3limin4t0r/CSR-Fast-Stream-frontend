Feature: As a user, I want to be able to select a first scheme preference, in order to progress my application  

  @CSR-319 @omit 
  Scenario Outline: Select first scheme preference 
    Given I am on "/en/applicant/programmeselection" 
    And I fill form with:       | <schemeId> | 1 | 
    And I press "Save and continue" 
    Then I should see "First preference programme: <scheme>"  
  Examples: 
    | scheme                  | schemeId | 
    | Diplomatic Service      |          | 
    | Houses of Parliament    |          | 
    | Science and Engineering |          | 
    | Central Departments     |          |
