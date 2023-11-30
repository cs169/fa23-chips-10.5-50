# frozen_string_literal: true

# spec/factories/representatives.rb

FactoryBot.define do
  factory :representative do
    name { 'John Doe' }  # Replace with a realistic name
    title { 'Senator' }  # Replace with a realistic title if necessary
    street { '123 Main St' } # Replace with a realistic street address
    city { 'Anytown' } # Replace with a realistic city
    state { 'State' } # Replace with a realistic state
    zip { '12345' } # Replace with a realistic ZIP code
    party { 'Independent' } # Replace with a realistic party
    photo_url { 'http://example.com/photo.jpg' } # Replace with a realistic photo URL

    # Add any other necessary attributes
  end
end
