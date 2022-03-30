module MeetyHelper
  def self.generate_query_string(opts)
    case VALID.include?(opts.first)
    when true then MeetyHelper.transform_conditions(opts)
    else MeetyHelper.transform_categories(opts) end
  end

  def self.select_categories(categories_hash)
    categories_hash.select { |_, value| value == "1" }.keys
  end

  def self.select_conditions(conditions_hash)
    conditions_hash.select { |key| VALID.include?(key) }.keys
  end

  def self.transform_categories(hash)
    hash.each_with_index.map do |category, index|
      index.zero? ? "categories=#{category}" : category
    end
  end

  def self.transform_conditions(hash)
    hash.each_with_index.map do |condition, index|
      index.zero? ? "conditions=#{condition}" : condition
    end
  end

  API_URL = "https://api.geoapify.com/v2/places"
  API_KEY = "apiKey=#{Rails.application.credentials.geoapify}"

  CATEGORIES = {
    # accomodation: "Place to stay or live",
    activity: "<i class=\"fas fa-glass-cheers\"></i>",
    # commercial: "Places where one can buy or sell things",
    catering: "<i class=\"fas fa-hamburger\"></i>",
    # education: "Place that provides learning spaces and learning environments",
    # childcare: "Place that provides care of children service while parents are working",
    entertainment: "<i class=\"fas fa-film\"></i>",
    leisure: "<i class=\"fas fa-couch\"></i>",
    natural: "<i class=\"fas fa-tree\"></i>",
    # parking: "Places where one can park a car",
    # pet: "<i class=\"fas fa-kiwi-bird\"></i>",
    # rent: "Places where one can rent things",
    # service: "Places that provide services to the public",
    # tourism: "Places that can be interesting for tourists",
    sport: "<i class=\"fas fa-running\"></i>"
    # public_transport: "<i class=\"fas fa-bus-alt\"></i>"
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
end
