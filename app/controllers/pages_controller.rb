require 'net/http'
class PagesController < ApplicationController
  rescue_from Net::HTTPBadRequest, with: :bad_request
  def index
    cat = 'catering.restaurant'
    lat = 52.5068959
    long = 13.3892484 #rate mal wo das ist? :D
    range = 1000
    filters = "circle:#{long},#{lat},#{range}&limit=2" # filters = 'circle:-87.770231,41.878968,5000'
    api_key_string = Rails.application.credentials.geoapify
    uri = URI("https://api.geoapify.com/v2/places?categories=#{cat}&filter=#{filters}&apiKey=#{api_key_string}")
    res = Net::HTTP.get_response(uri)
    json = JSON.parse(res.body)
    binding.pry
    render json: json, status: :ok
  end

  private

  def bad_request(error)
    render json: error.body, status: :bad_request
  end
end
