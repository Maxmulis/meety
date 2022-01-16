require 'net/http'

class GetPage < ApplicationService
  attr_reader :response

  def initialize(args)
    @addr = args['address'] || ""
    @response ||= ""
  end

  def call
    cat = 'catering.restaurant'
    lat = 52.5068959
    long = 13.3892484 # rate mal wo das ist? :D
    range = 1000
    filters = "circle:#{long},#{lat},#{range}&limit=2" # filters = 'circle:-87.770231,41.878968,5000'
    api_key_string = Rails.application.credentials.geoapify
    uri = URI("https://api.geoapify.com/v2/places?categories=#{cat}&filter=#{filters}&apiKey=#{api_key_string}")
    res = Net::HTTP.get_response(uri)
    @response = JSON.parse(res.body)
  end
end
