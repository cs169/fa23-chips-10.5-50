# frozen_string_literal: true

require 'google/apis/civicinfo_v2'

class SearchController < ApplicationController
  # def search
  #   address = params[:address]
  #   service = Google::Apis::CivicinfoV2::CivicInfoService.new
  #   service.key = Rails.application.credentials[:GOOGLE_API_KEY]
  #   result = service.representative_info_by_address(address: address)
  #   @representatives = Representative.civic_api_to_representative_params(result)

  #   render 'representatives/search'
  # end

  def search
    address = params[:address]
    service = Google::Apis::CivicinfoV2::CivicInfoService.new
    service.key = Rails.application.credentials[:GOOGLE_API_KEY]

    begin
      result = service.representative_info_by_address(address: address)
      @representatives = Representative.civic_api_to_representative_params(result)
      render 'representatives/search'
    rescue Google::Apis::Error => e
      handle_invalid_address(e)
    end
  end

  private

  def handle_invalid_address(error)
    # You can customize this part according to your needs.
    # For instance, you could set a flash message to inform the user about the error.
    flash[:alert] = "Invalid address: #{error.message}"

    # Redirect to a specific page or render an error view
    # redirect_to some_error_page_path
    # or
    render 'representatives/index'
  end
end
