require 'net/http'

class GeographicMidpoint < ApplicationService
  def initialize(places)
    @p1 = places[0]
    @p2 = places[1]
  end

  def call
    midpoint
  end

  private

  def midpoint
    lat = (@p1.lat + @p2.lat) / 2
    lon = (@p1.lon + @p2.lon) / 2

    Place.new(lat: lat, lon: lon)
  end

  # def haversine
  #   loc1 = [@coordinates[:place_uno].lat, @coordinates[:place_uno].lon]
  #   loc2 = [@coordinates[:place_dos].lat, @coordinates[:place_dos].lon]
  #
  #   rad_per_deg = Math::PI / 180  # PI / 180
  #   rkm         = 6371          # Earth radius in kilometers
  #   rm          = rkm * 1000    # Radius in meters
  #
  #   dlat_rad    = (loc2[0] - loc1[0]) * rad_per_deg # Delta, converted to rad
  #   dlon_rad    = (loc2[1] - loc1[1]) * rad_per_deg
  #
  #   lat1_rad    = loc1.map { |i| i * rad_per_deg }.first
  #   lat2_rad    = loc2.map { |i| i * rad_per_deg }.first
  #
  #   a           = (Math.sin(dlat_rad / 2)**2) + (Math.cos(lat1_rad) * Math.cos(lat2_rad) * (Math.sin(dlon_rad / 2)**2))
  #   c           = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
  #
  #   rm * c # Delta in meters
  # end
  #
  # def to_rad(angle)
  #   angle / 180.0 * Math::PI
  # end
  #
  # def degrees(angle)
  #   angle * Math::PI / 180.0
  # end
end
