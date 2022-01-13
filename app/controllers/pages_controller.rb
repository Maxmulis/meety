require 'uri'
require 'net/http'

class PagesController < ApplicationController
  def index
    api_key_string = Rails.application.credentials.geoapify
    uri = URI("http://api.geoapify.com/v2/places?categories=commercial.supermarket&apiKey=#{api_key_string}")
    res = Net::HTTP.get_response(uri)

    return unless res.is_a?(Net::HTTPSuccess)

    @res_JSON = JSON.parse(res)

    puts 'JSON?::'
    puts @res_JSON
  end
end
