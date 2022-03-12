require 'net/http'

class PagesController < ApplicationController
  rescue_from Net::HTTPBadRequest, with: :bad_request

  def index
    # json = GetPage.call("")
    # render json: json, status: :ok
  end

  def show
    address_one = CGI.escape(params[:address_field_one])
    address_two = CGI.escape(params[:address_field_two])

    @person_one = GetGeocodeAddress.call(address_one)
    @person_two = GetGeocodeAddress.call(address_two)

    if @person_one.valid? && @person_two.valid?
      @token = GetTempToken.call
      @people_markers = [@person_one, @person_two].map do |place|
        { lat: place.lat, lon: place.lon }
      end
    else
      render :index
    end
  end

  private

  def bad_request(error)
    render json: error.body, status: :bad_request
  end
end
