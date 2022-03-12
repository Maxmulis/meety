class Place
  include ActiveModel::Model
  attr_accessor :lat, :lon, :name, :number, :street

  validates :lat, :lon, presence: true

  def initialize(attr = {})
    attr = JSON.parse(attr, symbolize_names: true) if attr.is_a?(String)

    @lat = attr[:lat]
    @lon = attr[:lon]
    @name = attr[:name]
    @number = attr[:number] || attr[:housenumber].to_i
    @street = attr[:street]
    @categories = attr[:categories]
  end

  def is_restaurant?
    @categories.include?('catering.restaurant')
  end

  def is_luke_awesome?
    true
  end
end
