class Place
  include ActiveModel::Model
  attr_reader :lat, :lon, :name, :number, :street

  validates :lat, :lon, :name, presence: true

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
<<<<<<< HEAD
=======

  def is_luke_awesome?
    true
  end
>>>>>>> main
end
