Given /the following states exist/ do |states_table|
  states_table.hashes.each do |state|
    State.create!(name:         state['name'],
                  symbol:       state['symbol'],
                  fips_code:    state['fips_code'],
                  is_territory: state['is_territory'],
                  lat_min:      state['lat_min'],
                  lat_max:      state['lat_max'],
                  long_min:     state['long_min'],
                  long_max:     state['long_max'])
  end
end

Given /the following counties in (.*) exist/ do |state_symbol, counties_table|
  state = State.find_by(symbol: state_symbol)
  counties_table.hashes.each do |county|
    state.counties.create!(name:       county['name'],
                           fips_code:  county['fips_code'],
                           fips_class: county['fips_class'])
  end
end

When /^I click on the view link for (.*)$/ do |county_name|
  within('tr', text: county_name) do
    find('a.btn.btn-primary', text: 'View').click
  end
end