require 'net/http'

class PagesController < ApplicationController
  rescue_from Net::HTTPBadRequest, with: :bad_request

  def index
    GetTempToken.call
    # json = GetPage.call("")
    # render json: json, status: :ok
  end

  def show
    address_uno = CGI.escape(params[:address_field_one])
    address_dos = CGI.escape(params[:address_field_two])

    coordinates_uno = GetGeocodeAddress.call(address_uno)
    coordinates_dos = GetGeocodeAddress.call(address_dos)

    @place_uno = GetPlace.call(coordinates_uno)
    @place_dos = GetPlace.call(coordinates_dos)
    @people_markers = [@place_uno, @place_dos].map { |place| { lat: place.lat, lon: place.lon } }
  end

  private

  def bad_request(error)
    render json: error.body, status: :bad_request
  end
end
