Feature: Update User Password

  Scenario: Visit the edit password form
    Given the user has an account 
    And he is signed in
    And he visits the profile page
    When he visits the user edit password page
    Then he should see the user edit password page
    And the user edit password page should have a form with all the relevant inputs

  Scenario: When user fills incorrect information in update password form
    Given the user has an account 
    And he is signed in
    And he visits the profile page
    When he visits the user edit password page
    And he fills incorrect user password information
    Then he should see the errors
  
  Scenario: When user fills incorrect old password in update password form
    Given the user has an account 
    And he is signed in
    And he visits the profile page
    When he visits the user edit password page
    And he fills incorrect old password information
    Then he should see the errors


  Scenario: When user fill correct information in update password form
    Given the user has an account
    And he is signed in
    And he visits the profile page
    When he visits the user edit password page
    And he fills correct user password information
    Then he should see the profile page
