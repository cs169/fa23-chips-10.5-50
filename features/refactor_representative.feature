Feature: Refactor Representative Import
  In order to avoid creating duplicate representatives in the database
  As a developer
  I want to refactor the civic_api_to_representative_params method

  Scenario: Import a new representative
    Given a representative named "John Doe" does not exist in the database
    When I import the representative "John Doe"
    Then I should see "John Doe" in the database

  Scenario: Avoid duplicate representatives
    Given a representative named "John Doe" already exists in the database
    When I import the representative "John Doe"
    Then I should see only one "John Doe" in the database
