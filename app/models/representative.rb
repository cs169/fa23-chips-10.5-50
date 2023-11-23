# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  class << self
    def civic_api_to_representative_params(rep_info)
      return [] if rep_info.nil? || !rep_info.respond_to?(:officials)
      rep_info.officials.each_with_index.map do |official, index|
        process_official(official, rep_info, index)
      end.compact
    end

    private

    def process_official(official, rep_info, index)
      title, ocdid = extract_office_info(rep_info, index)
      address = extract_address(official)
      party = official.party if official.respond_to?(:party)
      photo_url = official.photo_url if official.respond_to?(:photo_url)

      update_or_create_representative({
                                        official:  official,
                                        title:     title,
                                        ocdid:     ocdid,
                                        address:   address,
                                        party:     party,
                                        photo_url: photo_url
                                      })
    end

    def extract_office_info(rep_info, index)
      office = rep_info.offices.find { |o| o.official_indices.include?(index) }
      [office&.name, office&.division_id]
    end

    def extract_address(official)
      address = official.address&.first
      {
        street: address&.line1,
        city:   address&.city,
        state:  address&.state,
        zip:    address&.zip
      }
    end

    def update_or_create_representative(params)
      rep = Representative.find_or_initialize_by(name: params[:official].name)
      rep.assign_attributes({
                              title:     params[:title],
                              street:    params[:address][:street],
                              city:      params[:address][:city],
                              state:     params[:address][:state],
                              zip:       params[:address][:zip],
                              party:     params[:party],
                              photo_url: params[:photo_url]
                            })
      # Save the record only if it's a new record or if any attribute has changed
      rep.save! if rep.new_record? || rep.changed?
      rep
    end
  end
end
