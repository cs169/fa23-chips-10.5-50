Feature: 
  As a user
  I can view the national and state maps

Background: the database has some states

  Given the following states exist:
  | name       | symbol | fips_code | is_territory | lat_min     | lat_max     | long_min  | long_max    |
  | California | CA     | 06        | 0            | -124.409591 | -114.131211 | 32.534156 | -114.131211 |

  And the following counties in CA exist:
  | name                 | fips_code | fips_class |
  | Alameda County       | 001       | N/A        |

  Scenario: view national map
    When I am on the home page
    Then I should see "National Map"

  Scenario: view valid state map
    When I am on the state map of CA
    Then I should see "Counties in California"

  Scenario: view invalid state map
    When I am on the state map of AK
    Then I should see "not found"