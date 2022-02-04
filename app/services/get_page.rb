require 'net/http'

class GetPage < ApplicationService
  API_KEY = Rails.application.credentials.geoapify

  def initialize(coordinates)
    @coordinates = coordinates
  end

  def call
    cat = 'catering.restaurant'
    range = 1000
    filters = "circle:#{@coordinates[:lon]},#{@coordinates[:lat]},#{range}&limit=2" # filters = 'circle:-87.770231,41.878968,5000'
    uri = URI("https://api.geoapify.com/v2/places?categories=#{cat}&filter=#{filters}&apiKey=#{API_KEY}")
    res = Net::HTTP.get_response(uri)
    response = JSON.parse(res.body)
    # TODO: Return a Place.new
    # TODO: features>>properties uebergeben
    Place.new(response['features'].first['properties']).valid?
  end
end
