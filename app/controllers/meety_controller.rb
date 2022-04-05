require 'net/http'

class MeetyController < ApplicationController
  include MeetyHelper

  rescue_from Net::HTTPBadRequest, with: :bad_request

  def start
    @categories = CATEGORIES
    @conditions = CONDITIONS
  end

  def map
    person_one_place = Place.new(address: CGI.escape(params[:address_field_one]))
    person_two_place = Place.new(address: CGI.escape(params[:address_field_two]))

    @person_one = GeocodePlace.call(person_one_place)
    @person_two = GeocodePlace.call(person_two_place)
    @categories = MeetyHelper.select_categories(params)
    # @conditions = MeetyHelper.select_conditions(params)
    @token = FetchTempToken.call
    @people_markers = [@person_one, @person_two].map do |place|
      { lat: place.lat, lon: place.lon }
    end
  end

  def suggestions
    @categories = params[:categories].split(',')
    person_one = Place.new(lat: params[:person_one_lat], lon: params[:person_one_lon])
    person_two = Place.new(lat: params[:person_two_lat], lon: params[:person_two_lon])
    midpoint = GeographicMidpoint.call([person_one, person_two])
    suggestions = FetchSuggestions.call(place: midpoint,
                                        categories: MeetyHelper.generate_query_string(@categories),)
                                        # conditions: MeetyHelper.generate_query_string(@conditions)
    suggestions_markers = suggestions.map do |place|
      {
        lat: place.lat, lon: place.lon,
        info_window: render_to_string(partial: "marker_popup", locals: { place: place })
      }
    end
    render json: suggestions_markers.to_json
  end

  private

  def bad_request(error)
    render json: error.body, status: :bad_request
  end
end
