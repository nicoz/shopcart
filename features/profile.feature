Feature: Profile

  Scenario: Visit profile page without being logged to the system
    Given a user that visits the profile page
    When he isn't signed in
    Then he should be redirected to the root page
    And he should see an information message
    
  Scenario: Visit profile page for a logged in user
    Given the user has an account 
    And he is signed in
    When he visits the profile page
    Then he should see the profile page
    And the profile page should have his name
    
  Scenario: A user tries to visit another user profile page
    Given the user has an account
    And there is another user
    And he is signed in
    When he tries to visit the other users profile page
    Then he should be redirected to the root page
    And he should see an information message
