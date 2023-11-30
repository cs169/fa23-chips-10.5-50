# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MyNewsItemsController, type: :controller do
  # Setup, authentication, etc.

  let(:representative) { create(:representative) }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new news item with an issue' do
        expect do
          post :create, params: { 
                          representative_id: representative.id,
                          news_item: attributes_for(:news_item, issue: 'Climate Change') 
                        }
        end.to change(NewsItem, :count).by(1)
        expect(NewsItem.last.issue).to eq('Climate Change')
      end
    end
  end

  let(:representative) { create(:representative) }
  let!(:news_item) { create(:news_item, issue: 'Immigration', representative: representative) }

  describe 'PUT #update' do
    context 'with valid attributes' do
      it 'updates the issue of the news item' do
        put :update, params: { 
                      id: news_item.id, 
                      representative_id: representative.id,
                      news_item: { issue: 'Tax Reform' } 
                    }
        news_item.reload
        expect(news_item.issue).to eq('Tax Reform')
      end
    end
  end

  # Other tests...
end
