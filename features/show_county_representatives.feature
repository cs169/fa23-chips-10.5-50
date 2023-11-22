Feature: show candidates based on the selected county
  As a user, 
  I want to select a state's county and see its candidates
  So that I can visualize the political environment at the county level

Background: the database has some states

  Given the following states exist:
  | name       | symbol | fips_code | is_territory | lat_min     | lat_max     | long_min  | long_max    |
  | Alaska     | AK     | 02        | 0            | -179.148909 | 179.77847   | 51.214183 | 179.77847   |
  | California | CA     | 06        | 0            | -124.409591 | -114.131211 | 32.534156 | -114.131211 |

  And the following counties in CA exist:
  | name                 | fips_code | fips_class |
  | Alameda County       | 001       | N/A        |
  | Alpine County        | 003       | N/A        |
  | Santa Clara County	 | 085       | N/A        |

Scenario: see candidates on the selected county
  When I am on the state map of CA
  Then I should see "Counties in California"
  When I click on the view link for Alameda County
  Then I should see "Melissa Wilk"
  And I should see "Pamela Price"