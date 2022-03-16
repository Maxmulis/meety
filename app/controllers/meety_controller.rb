require 'net/http'

class MeetyController < ApplicationController
  include MeetyHelper
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
      midpoint = GeographicMidpoint.call([@person_one, @person_two])
      suggestions = [
        FetchSuggestion.call(place: midpoint,
                             categories: MeetyHelper.generate_query_string(@categories),
                             conditions: MeetyHelper.generate_query_string(@conditions))
      ]
      @token = FetchTempToken.call
      @people_markers = [@person_one, @person_two].map do |place|
        { lat: place.lat, lon: place.lon }
      end
      @suggestions_markers = suggestions.map do |place|
        { lat: place.lat, lon: place.lon }
      end
    else
      render :results
    end
  end

  private

  def bad_request(error)
    render json: error.body, status: :bad_request
  end

  def strong_params(params)
    params.permit(CATEGORIES.keys + CONDITIONS.keys)
  end
end
