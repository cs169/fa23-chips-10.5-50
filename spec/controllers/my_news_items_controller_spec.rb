# frozen_string_literal: true

# spec/controllers/my_news_items_controller_spec.rb

require 'rails_helper'

RSpec.describe MyNewsItemsController, type: :controller do
  before do
    user = create(:user)
    session[:current_user_id] = user.id
  end

  let(:representative) { create(:representative) }

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:news_item_attributes) do
        attributes_for(:news_item, issue: 'Free Speech', representative_id: representative.id)
      end

      it 'creates a new news item with an issue' do
        expect do
          post :create, params: { news_item: news_item_attributes, representative_id: representative.id }
        end.to change(NewsItem, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new news item' do
        expect do
          post :create, params: { news_item: { title: nil }, representative_id: representative.id }
        end.not_to change(NewsItem, :count)
      end
    end
  end

  describe 'PUT #update' do
    let!(:news_item) { create(:news_item, issue: 'Immigration', representative: representative) }
    let(:valid_update_params) do
      {
        representative_id: representative.id,
        id:                news_item.id,
        news_item:         { issue: 'Tax Reform' }
      }
    end
    let(:invalid_update_params) do
      {
        representative_id: representative.id,
        id:                news_item.id,
        news_item:         { issue: 'Error' }
      }
    end

    context 'with valid parameters' do
      it 'updates the issue of the news item' do
        expect do
          put :update,
              params: valid_update_params
        end.to change { news_item.reload.issue }.from('Immigration').to('Tax Reform')
      end
    end

    context 'with invalid parameters' do
      it 'does not update the issue of the news item and renders edit' do
        put :update, params: invalid_update_params
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:news_item) { create(:news_item, representative: representative) }

    it 'destroys the news item' do
      expect do
        delete :destroy,
               params: { id: news_item.id, representative_id: representative.id }
      end.to change(NewsItem, :count).by(-1)
    end
  end

  describe 'GET #new' do
    it 'assigns a new news item to @news_item' do
      get :new, params: { representative_id: representative.id }
      expect(assigns(:news_item)).to be_a_new(NewsItem)
    end
  end
end
