require 'net/http'

class FetchSuggestions < ApplicationService
  include MeetyHelper

  raise StandardError, "GEOAPIFY_API_KEY unretrievable" if API_KEY.nil?

  def initialize(args)
    @place = args[:place]
    @categories = args[:categories]
    @conditions = args[:conditions]
  end

  def call
    filters = "bias=proximity:#{@place.lon},#{@place.lat}&limit=5"
    categories = @categories.empty? ? "categories=catering" : @categories.join(',')

    uri = URI("#{API_URL}?#{categories}&#{filters}&#{API_KEY}")
    res = Net::HTTP.get_response(uri)
    response = JSON.parse(res.body, symbolize_names: true)
    response[:features].map do |hash|
      Place.new(hash[:properties])
    end
  end
end
