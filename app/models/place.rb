class Place
  attr_reader :lat
  def initialize(*attr)
    binding.pry
    @lat = attr['lat']
  end

end
