Feature: 
  As a user
  I should be able to login and logout

  Scenario: see the login page
    When I am on the login page
    Then I should see "Sign in with Google"
    And I should see "Sign in with GitHub"

  Scenario: logout
    When I am on the logout page
    Then I should see "You have successfully logged out"