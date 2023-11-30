# frozen_string_literal: true

# spec/controllers/my_news_items_controller_spec.rb

require 'rails_helper'

RSpec.describe MyNewsItemsController, type: :controller do
  let(:representative) { create(:representative) }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new news item with an issue' do
        news_item_attributes = attributes_for(:news_item, issue: 'Climate Change')

        expect do
          post :create, params: {
            representative_id: representative.id,
            news_item:         news_item_attributes
          }
        end.to change(NewsItem, :count).by(1)

        expect(NewsItem.last.issue).to eq('Climate Change')
      end
    end

    # Add other contexts for invalid attributes, etc.
  end

  describe 'PUT #update' do
    let!(:news_item) { create(:news_item, issue: 'Immigration', representative: representative) }

    context 'with valid attributes' do
      it 'updates the issue of the news item' do
        put :update, params: {
          representative_id: representative.id,
          id:                news_item.id,
          news_item:         { issue: 'Tax Reform' }
        }

        news_item.reload
        expect(news_item.issue).to eq('Tax Reform')
      end
    end

    # Add other contexts for invalid attributes, etc.
  end

  # Add more tests for other actions like :new, :edit, :destroy, etc.
end
