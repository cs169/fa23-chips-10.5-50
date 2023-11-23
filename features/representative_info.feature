Feature: 
  As a user
  I want to view a representative's info and news articles

Background: search for representatives in California
  Given I am on the representatives page
  And I fill in "address" with "California"
  And I press "Search"

  Scenario: view representative info
    When I follow "Fiona Ma"
    Then I should see "CA State Treasurer"

  Scenario: view representative articles
    When I click the first News Articles link
    Then I should see "Listing News Articles for"
    When I follow "All Representatives"
    Then I am on the representatives page

  Scenario: add news article when not logged in
    When I click the first News Articles link
    And I follow "Add News Article"
    Then I should see "Sign in"
