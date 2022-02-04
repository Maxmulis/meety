require 'net/http'

class PagesController < ApplicationController
  rescue_from Net::HTTPBadRequest, with: :bad_request

  def index
    # json = GetPage.call("")
    # render json: json, status: :ok
  end

  def show
    address_uno = params[:address_field_one]
    address_dos = params[:address_field_two]

    coordinates_uno = GetGeocodeAddress.call(address_uno)
    coordinates_dos = GetGeocodeAddress.call(address_dos)

    @place_uno = GetPage.call(coordinates_uno)
    @place_dos = GetPage.call(coordinates_dos)
  end

  private

  def bad_request(error)
    render json: error.body, status: :bad_request
  end
end
