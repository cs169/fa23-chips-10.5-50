# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsItem, type: :model do
  # Assuming you have factories set up for your models
  let(:representative) { create(:representative) }
  let(:news_item) { build(:news_item, representative: representative) }

  describe 'validations' do
    it 'is valid with a valid issue' do
      valid_issues = ['Free Speech', 'Immigration', 'Terrorism', 'Social Security and Medicare', 'Abortion',
                      'Student Loans', 'Gun Control', 'Unemployment', 'Climate Change', 'Homelessness', 'Racism', 'Tax Reform', 'Net Neutrality', 'Religious Freedom', 'Border Security', 'Minimum Wage', 'Equal Pay']
      valid_issues.each do |issue|
        news_item.issue = issue
        expect(news_item).to be_valid
      end
    end

    it 'is not valid with an invalid issue' do
      news_item.issue = 'Invalid Issue'
      expect(news_item).not_to be_valid
      expect(news_item.errors[:issue]).to include('Invalid Issue is not a valid issue')
    end
  end

  # Other tests for your model...
end
