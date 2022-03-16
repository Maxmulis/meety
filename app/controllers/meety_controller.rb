require 'net/http'

class MeetyController < ApplicationController
  rescue_from Net::HTTPBadRequest, with: :bad_request

  def start
    @categories = {
      accomodation: "Place to stay or live",
      activity: "Clubs, community centers",
      commercial: "Places where one can buy or sell things",
      catering: "Places of public catering: restaurants, cafes, bars, etc.",
      education: "Place that provides learning spaces and learning environments",
      childcare: "Place that provides care of children service while parents are working",
      entertainment: "Place that where one can spend free time with amusement",
      leisure: "Places where one can relax and unwind",
      natural: "Places where one can enjoy nature, explore natural phenomena",
      parking: "Places where one can park a car",
      pet: "Places that can be interesting for pet owners",
      rent: "Places where one can rent things",
      service: "Places that provide services to the public",
      tourism: "Places that can be interesting for tourists",
      sport: "Infrastructure objects related to different sport kinds",
      public_transport: "Public transport stations and stops"
    }

    @conditions = {
      internet_access: "Places that provide an internet access",
      wheelchair: "Places that are suitable to be used with wheelchairs",
      dogs: "Places where dogs are allowed",
      vegetarian: "Places where you can buy or eat vegetarian food",
      halal: "Places where you can buy or eat halal food",
      kosher: "Places where you can buy or eat kosher food",
      organic: "Places where you can buy or eat organic food"
    }
  end

  def results
    dumbp = %w[internal_access wheelchair dogs vegetarian halal kosher organic]

    @categories = params.select { |_, v| v == "1" }
    @conditions = params.select { |k| dumbp.include?(k) }

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
