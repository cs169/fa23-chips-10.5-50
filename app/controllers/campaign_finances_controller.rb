require 'net/http'
require 'json'

class CampaignFinancesController < ApplicationController
  def index
    if params[:cycle].present? && params[:cycle] != nil && params[:category].present? && params[:category] != nil
      @finances = search(params[:cycle], params[:category])
    else
      @finances = []
    end
  end

  private

  def search(cycle, category)
    url = URI("https://api.propublica.org/campaign-finance/v1/#{cycle}/candidates/leaders/#{category}.json")
    request = Net::HTTP::Get.new(url)
    request["X-API-Key"] = '9lcjslvwVjbqtX0KcQQ3W9rFm316caQQ2T89n4xA'
    begin
      response = Net::HTTP.start(url.hostname, url.port, use_ssl: url.scheme == 'https') do |http|
        http.request(request)
      end
      return JSON.parse(response.body)['results'] if response.is_a?(Net::HTTPSuccess)
    rescue => error
      flash[:alert] = "Invalid address: #{error.message}"
      return []
    end

  end
end