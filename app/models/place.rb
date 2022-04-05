class Place
  include ActiveModel::Model
  attr_accessor :lat, :lon, :name, :number, :street, :address

  validates :lat, :lon, presence: true

  def initialize(attr = {})
    attr = JSON.parse(attr, symbolize_names: true) if attr.is_a?(String)

    @address = attr[:address]
    @categories = attr[:categories]
    @lat = attr[:lat].to_f
    @lon = attr[:lon].to_f
    @number = attr[:number] || attr[:housenumber].to_i
    @name = attr[:name]
    @street = attr[:street]
  end

  def is_restaurant?
    @categories.include?('catering.restaurant')
  end

  def is_luke_awesome?
    true
  end
end
