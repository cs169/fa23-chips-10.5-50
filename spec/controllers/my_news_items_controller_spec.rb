# frozen_string_literal: true

# spec/controllers/my_news_items_controller_spec.rb

require 'rails_helper'

RSpec.describe MyNewsItemsController, type: :controller do
  let(:representative) { create(:representative) }

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:news_item_attributes) { attributes_for(:news_item, issue: 'Climate Change') }

      it 'creates a new news item with an issue' do
        expect { post :create, params: { representative_id: representative.id, news_item: news_item_attributes } }
          .to change(NewsItem, :count).by(1)

        expect(NewsItem.last.issue).to eq('Climate Change')
      end
    end

    # Add other contexts for invalid attributes, etc.
  end

  describe 'PUT #update' do
    let!(:news_item) { create(:news_item, issue: 'Immigration', representative: representative) }
    let(:update_params) do
      { representative_id: representative.id, id: news_item.id, news_item: { issue: 'Tax Reform' } }
    end

    it 'updates the issue of the news item' do
      expect { put :update, params: update_params }.to change {
                                                         news_item.reload.issue
                                                       }.from('Immigration').to('Tax Reform')
    end

    # Add other contexts for invalid attributes, etc.
  end

  # Add more tests for other actions like :new, :edit, :destroy, etc.
end
