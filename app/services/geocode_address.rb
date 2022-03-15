require 'net/http'

class GeocodeAddress < ApplicationService
  API_KEY = Rails.application.credentials.geoapify
  raise StandardError, "GEOAPIFY_API_KEY unretrievable" if API_KEY.nil?

  def initialize(address)
    @address = address
  end

  def call
    uri = URI("https://api.geoapify.com/v1/geocode/search?text=#{@address}&filter=countrycode:de&apiKey=#{API_KEY}")
    res = Net::HTTP.get_response(uri)
    response = JSON.parse(res.body)

    place = Place.new
    unless response['features'].nil?
      place.lon = response['features'].first['properties']['lon']
      place.lat = response['features'].first['properties']['lat']
    end
    return place
  end
end
