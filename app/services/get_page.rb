require 'net/http'

class GetPage < ApplicationService
  API_KEY = Rails.application.credentials.geoapify

  def initialize(coordinates)
    @coordinates = coordinates
  end

  def call
    cat = 'catering.restaurant'
    range = 1000
    filters = "circle:#{@coordinates[:lon]},#{@coordinates[:lat]},#{range}&limit=1"
    uri = URI("https://api.geoapify.com/v2/places?categories=#{cat}&filter=#{filters}&apiKey=#{API_KEY}")
    res = Net::HTTP.get_response(uri)
    response = JSON.parse(res.body, symbolize_names: true)
    Place.new(response[:features].first[:properties])
  end
end
