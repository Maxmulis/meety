FactoryBot.define do
  factory :place do
    lat { 52.5068959 }
    long  { 13.3892484 }
    name { 'Le Wagon Coding Bootcamp' }
    street { 'Rudi-Dutschke-Str.' }
    number { 26 }
    is_restaurant? { false }
  end
end
