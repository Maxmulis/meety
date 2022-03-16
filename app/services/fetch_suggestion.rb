require 'net/http'

class FetchSuggestion < ApplicationService
  API_KEY = Rails.application.credentials.geoapify
  raise StandardError, "GEOAPIFY_API_KEY unretrievable" if API_KEY.nil?

  def initialize(place, _category, _condition)
    @place = place
    # &categories=
    # &conditions=
  end

  def call
    # cat = 'catering.restaurant'
    filters = "bias=proximity:#{@place.lon},#{@place.lat}&limit=1"
    uri = URI("https://api.geoapify.com/v2/places?categories=#{@categories}&#{filters}&apiKey=#{API_KEY}")
    res = Net::HTTP.get_response(uri)
    response = JSON.parse(res.body, symbolize_names: true)
    Place.new(response[:features].first[:properties])
  end
end
