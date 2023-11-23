# frozen_string_literal: true

Given(/^a representative named "([^"]*)" does not exist in the database$/) do |name|
  Representative.where(name: name).destroy_all
end

Given(/^a representative named "([^"]*)" already exists in the database$/) do |name|
  Representative.find_or_create_by!(name: name)
end

When(/^I import the representative "([^"]*)"$/) do |name|
  rep_info = OpenStruct.new(
    officials: [
      OpenStruct.new(
        name: name
        # ... Add other properties as needed
      )
    ],
    offices:   [
      # ... Add offices data as needed
    ]
  )

  Representative.civic_api_to_representative_params(rep_info)
end

Then(/^I should see "([^"]*)" in the database$/) do |name|
  expect(Representative.find_by(name: name)).not_to be_nil
end

Then(/^I should see only one "([^"]*)" in the database$/) do |name|
  expect(Representative.where(name: name).count).to eq(1)
end

When('I click the first News Articles link') do
  within('table#events tbody tr:first-child') do
    click_link 'News Articles'
  end
end
