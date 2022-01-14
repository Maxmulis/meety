require 'net/http'

class PagesController < ApplicationController
  def index
    cat = 'commercial.supermarket'
    # filters = 'circle:-87.770231,41.878968,5000'
    filters = "circle:#{params['long']},#{params['lat']},#{params['range']}"
    api_key_string = Rails.application.credentials.development.geoapify

    uri = URI("https://api.geoapify.com/v2/places?categories=#{cat}&filter=#{filters}&apiKey=#{api_key_string}")
    res = Net::HTTP.get_response(uri)

    return unless res.is_a?(Net::HTTPSuccess)

    json = JSON.parse(res.body)
    @res_JSON = JSON.pretty_generate(json)
  end
end
