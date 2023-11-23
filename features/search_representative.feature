Feature: 
  As a user
  I can search for representatives based on location

  Scenario: search representatives
    When I am on the representatives page
    Then I should see "Search for a Representative"
    When I fill in "address" with "California"
    And I press "Search"
    Then I should see "Ricardo Lara"
