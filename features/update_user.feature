Feature: Update User

  Scenario: Visit the edit form
    Given the user has an account 
    And he is signed in
    And he visits the profile page
    When he visits the user edit page
    Then he should see the user edit page
    And the user edit page should have a form with all the relevant inputs
    And the user edit page should a submit button
  
  Scenario: Non signed user trying to visit the edit page
    Given an anonymous user
    When he visits tries to visit the user edit page
    Then he should be redirected to the root page
    Then he should see an information message
    
    
  Scenario: When user fills incorrect information in update form
    Given the user has an account 
    And he is signed in
    And he visits the profile page
    When he visits the user edit page
    And he fills incorrect user information
    Then he should see the errors
      
  Scenario: When user fill correct information in update form
    Given the user has an account
    And he is signed in
    And he visits the profile page
    When he visits the user edit page
    And he fills correct user information
    Then he should see the profile page
    And he should see the new user information
