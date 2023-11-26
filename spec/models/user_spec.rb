# frozen_string_literal: true

require 'rails_helper'

describe User do
  describe 'name' do
    it 'returns the first and last name of the user' do
      user = build(:user, first_name: 'Hello', last_name: 'World')
      expect(user.name).to eq('Hello World')
    end
  end

  describe 'auth_provider' do
    it 'returns google when provider is google_oauth2' do
      user = build(:user, provider: :google_oauth2)
      expect(user.auth_provider).to eq('Google')
    end

    it 'returns github when provider is github' do
      user = build(:user, provider: :github)
      expect(user.auth_provider).to eq('Github')
    end
  end
end
