FactoryBot.define do
  factory :place do
    lat { 52.514689 }
    lon { 13.3909281 }
    name { 'Aigner' }
    street { 'Französische Straße' }
    number { 25 }
    categories do
      [
        "catering",
        "catering.restaurant",
        "wheelchair",
        "wheelchair.limited"
      ]
    end
    initialize_with { new(attributes) }
  end
end
