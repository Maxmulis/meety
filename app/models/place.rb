class Place
  attr_reader :lat, :lon, :name, :number, :street

  def initialize(*attr)
    hash = ActiveSupport::HashWithIndifferentAccess.new(attr.first)
    @lat = hash[:lat]
    @lon = hash[:lon]
    @name = hash[:name]
    @number = hash[:number]
    @street = hash[:street]
    @categories = hash[:categories]
  end

  def is_restaurant?
    @categories.include?('catering.restaurant')
  end

end
