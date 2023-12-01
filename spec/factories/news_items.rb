# frozen_string_literal: true

FactoryBot.define do
  factory :news_item do
    title { 'Sample News Title' }
    description { 'Sample news description.' }
    link { 'http://example.com/news' }
    issue { 'Climate Change' } # Add a default issue
    representative { create(:representative) } # Assuming you have a representative factory

    # Include other fields as necessary
  end
end
