require 'net/http'

class GetGeocodeAddress < ApplicationService
  API_KEY = Rails.application.credentials.geoapify

  def initialize(address)
    @address = address
  end

  def call
    raise StandardError, "invalid address" if @address.empty?

    uri = URI("https://api.geoapify.com/v1/geocode/search?text=#{@address}&filter=countrycode:de&apiKey=#{API_KEY}")
    res = Net::HTTP.get_response(uri)
    response = JSON.parse(res.body)

    raise StandardError, "unspecific address" if response['features'].count > 1

    {
      lon: response['features'].first['properties']['lon'],
      lat: response['features'].first['properties']['lat']
    }
  end
end
