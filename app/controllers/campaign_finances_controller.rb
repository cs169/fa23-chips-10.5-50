# frozen_string_literal: true

require 'net/http'
require 'json'

class CampaignFinancesController < ApplicationController
  def index
    @finances = if params[:cycle].present? && !params[:cycle].nil? &&
                   params[:category].present? && !params[:category].nil?
                  search(params[:cycle], params[:category])
                else
                  []
                end
  end

  private

  def search(cycle, category)
    url = URI("https://api.propublica.org/campaign-finance/v1/#{cycle}/candidates/leaders/#{category}.json")
    request = Net::HTTP::Get.new(url)
    request['X-API-Key'] = Rails.application.credentials[:PRO_PUBLICA_API_KEY]

    begin
      response = Net::HTTP.start(url.hostname, url.port, use_ssl: url.scheme == 'https') do |http|
        http.request(request)
      end
      return JSON.parse(response.body)['results'] if response.is_a?(Net::HTTPSuccess)
    rescue StandardError => e
      flash[:alert] = "Invalid address: #{e.message}"
      []
    end
  end
end
