module MeetyHelper
  CATEGORIES = {
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

  CONDITIONS = {
    internet_access: "Places that provide an internet access",
    wheelchair: "Places that are suitable to be used with wheelchairs",
    dogs: "Places where dogs are allowed",
    vegetarian: "Places where you can buy or eat vegetarian food",
    halal: "Places where you can buy or eat halal food",
    kosher: "Places where you can buy or eat kosher food",
    organic: "Places where you can buy or eat organic food"
  }

  VALID = %w[internet_access wheelchair dogs vegetarian halal kosher organic]

  def self.generate_query_string(opts)
    case VALID.include?(opts["dogs"])
    when true then transform_conditions(opts)
    else transform_categories(opts) end
  end

  def self.select_categories(categories_hash)
    categories_hash.select { |_, value| value == "1" }
  end

  def self.select_conditions(conditions_hash)
    conditions_hash.select { |key| VALID.include?(key) }
  end

  protected

  def transform_conditions(hash = {})
    hash.map { |k| "conditions=#{k}" }
  end

  def transform_categories(hash = {})
    hash.map { |k| "categories=#{k}" }
  end
end
