# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'Hello' }
    last_name { 'World' }
    provider { :github }
    sequence(:uid) { |n| "uid_#{n}" }
  end
end
