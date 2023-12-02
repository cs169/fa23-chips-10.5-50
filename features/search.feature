Feature: 
  As a user
  I can search for representatives by entering an adress

  Scenario: valid address
    Given I am on the representatives page
    And I fill in "address" with "2024 Durant Ave"
    And I press "Search"
    Then I should see "Yesenia Sanchez"

  Scenario: invalid address
    Given I am on the representatives page
    And I fill in "address" with "abc"
    And I press "Search"
    Then I should see "Failed to parse address"