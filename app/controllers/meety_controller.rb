require 'net/http'

class MeetyController < ApplicationController
  rescue_from Net::HTTPBadRequest, with: :bad_request

  def start
    @categories = CATEGORIES
    @conditions = CONDITIONS
  end

  def results
    @categories = MeetyHelper.select_categories(params)
    @conditions = MeetyHelper.select_conditions(params)

    address_one = CGI.escape(params[:address_field_one])
    address_two = CGI.escape(params[:address_field_two])

    @person_one = GeocodeAddress.call(address_one)
    @person_two = GeocodeAddress.call(address_two)

    if @person_one.valid? && @person_two.valid?
      @token = FetchTempToken.call
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
