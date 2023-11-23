# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

RSpec.describe Representative, type: :model do
  describe '.civic_api_to_representative_params' do
    # Mock the rep_info structure
    let(:rep_info) do
      OpenStruct.new(
        officials: [
          OpenStruct.new(
            name:      'John Doe',
            title:     'Mayor', # Assuming title and ocdid are provided from offices data
            ocdid:     'ocd-division/country:us/state:anystate/place:anytown',
            party:     'Independent',
            photo_url: 'http://example.com/john_doe.jpg',
            address:   [OpenStruct.new(
              line1: '123 Main St',
              city:  'Anytown',
              state: 'Anystate',
              zip:   '12345'
            )]
          )
          # ... Add more officials as needed
        ],
        offices:   [
          OpenStruct.new(
            name:             'Mayor',
            division_id:      'ocd-division/country:us/state:anystate/place:anytown',
            official_indices: [0]
          )
          # ... Add more offices as needed
        ]
      )
    end

    context 'when the representative does not exist' do
      it 'creates a new representative' do
        expect do
          described_class.civic_api_to_representative_params(rep_info)
        end.to change(described_class, :count).by(1)
      end
    end

    context 'when the representative already exists' do
      let!(:existing_rep) do
        described_class.create!(
          name:      'John Doe',
          ocdid:     'ocd-division/country:us/state:anystate/place:anytown',
          title:     'Old Title',
          party:     'Old Party',
          photo_url: 'http://example.com/old_photo.jpg',
          street:    'Old Street',
          city:      'Old City',
          state:     'Old State',
          zip:       'Old Zip'
        )
      end

      before do
        described_class.civic_api_to_representative_params(rep_info)
        existing_rep.reload
      end

      it 'does not create a duplicate representative' do
        expect(described_class.count).to eq(1)
      end

      it 'updates the representative title' do
        expect(existing_rep.title).to eq('Mayor')
      end

      it 'updates the representative party' do
        expect(existing_rep.party).to eq('Independent')
      end

      it 'updates the representative photo_url' do
        expect(existing_rep.photo_url).to eq('http://example.com/john_doe.jpg')
      end

      it 'updates the representative street' do
        expect(existing_rep.street).to eq('123 Main St')
      end

      it 'updates the representative city' do
        expect(existing_rep.city).to eq('Anytown')
      end

      it 'updates the representative state' do
        expect(existing_rep.state).to eq('Anystate')
      end

      it 'updates the representative zip' do
        expect(existing_rep.zip).to eq('12345')
      end
    end
    
    # Testing for Invalid Data
    context 'with nil rep_info' do
      let(:nil_rep_info) { nil }
    
      it 'handles nil rep_info without error' do
        expect { described_class.civic_api_to_representative_params(nil_rep_info) }.not_to raise_error
      end
    end
    
    context 'with invalid rep_info' do
      let(:invalid_rep_info) { 'aaaaaa' }
    
      it 'handles invalid rep_info without error' do
        expect { described_class.civic_api_to_representative_params(invalid_rep_info) }.not_to raise_error
      end
    end    
    
  end
end
