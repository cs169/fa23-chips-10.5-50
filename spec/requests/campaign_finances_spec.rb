# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CampaignFinances', type: :request do
  describe 'GET /index' do
    context 'without parameters' do
      it 'returns an empty array' do
        get campaign_finances_path
        expect(response).to be_successful
        expect(assigns(:finances)).to eq([])
      end
    end

    # context 'with valid parameters' do
    #   before do
    #     # Mock the external API response
    #     allow(Net::HTTP).to receive(:start).and_return(double(Net::HTTPSuccess, body: '{'results': []}'))
    #   end

    #   it 'returns a non-empty array' do
    #     get campaign_finances_path, params: { cycle: '2020', category: 'some_category' }
    #     expect(response).to be_successful
    #     expect(assigns(:finances)).not_to be_empty
    #   end
    # end

    # context 'with invalid parameters' do
    #   it 'handles the error gracefully' do
    #     get campaign_finances_path, params: { cycle: 'invalid', category: 'invalid' }
    #     expect(response).to be_successful
    #     expect(flash[:alert]).to be_present
    #     expect(assigns(:finances)).to eq([])
    #   end
    # end
  end
end
