# frozen_string_literal: true

require 'rails_helper'

describe State do
  describe 'std_fips_code' do
    it 'standardizes FIPS code' do
      state = build(:state, fips_code: '6')
      expect(state.std_fips_code).to eq('06')
    end
  end
end
