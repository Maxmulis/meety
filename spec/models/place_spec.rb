require 'rails_helper'

JSON_STRING = '{ "name": "Aigner",
"housenumber": "25",
"street": "Französische Straße",
"suburb": "Mitte",
"district": "Mitte",
"city": "Berlin",
"state": "Berlin",
"postcode": "10117",
"country": "Germany",
"country_code": "de",
"lon": 13.3909281,
"lat": 52.514689,
"formatted": "Aigner, Französische Straße 25, 10117 Berlin, Germany",
"address_line1": "Aigner",
"address_line2": "Französische Straße 25, 10117 Berlin, Germany",
"categories": [
"catering",
"catering.restaurant",
"wheelchair",
"wheelchair.limited"
],
"details": [
"details",
"details.contact",
"details.facilities",
"details.payment"
],
"datasource": {
"sourcename": "openstreetmap",
"attribution": "© OpenStreetMap contributors",
"license": "Open Database Licence",
"url": "https://www.openstreetmap.org/copyright"
},
"place_id": "51c12c59ba27c82a4059a5584154e1414a40f00103f90195482005000000009203064169676e6572"
}'

RSpec.describe Place, type: :model do
  let(:valid_hash) { FactoryBot.build(:place) }
  let(:valid_json) { Place.new(JSON_STRING) }

  context 'when initialised with valid data' do
    it 'is valid' do
      expect(valid_hash.valid?).to be true
      expect(valid_json.valid?).to be true
    end
  end

  describe '#lat' do
    it 'returns the correct latitude' do
      expect(valid_hash.lat).to eq(52.514689)
      expect(valid_json.lat).to eq(52.514689)
    end
  end

  describe '#lon' do
    it 'returns the correct longitude' do
      expect(valid_hash.lon).to eq(13.3909281)
      expect(valid_json.lon).to eq(13.3909281)
    end
  end

  describe '#name' do
    it 'returns the correct name' do
      expect(valid_hash.name).to eq('Aigner')
      expect(valid_json.name).to eq('Aigner')
    end
  end

  describe '#street' do
    it 'returns the correct street' do
      expect(valid_hash.street).to eq('Französische Straße')
      expect(valid_json.street).to eq('Französische Straße')
    end
  end

  describe '#number' do
    it 'returns the correct street number' do
      expect(valid_hash.number).to eq(25)
      expect(valid_json.number).to eq(25)
    end
  end

  describe '#is_restaurant?' do
    it 'returns true' do
      expect(valid_hash.is_restaurant?).to be true
      expect(valid_json.is_restaurant?).to be true
    end
  end
  context 'when initialised with invalid data' do
    let(:invalid_place) { FactoryBot.build(:place, lat: nil) }
    it 'is invalid' do
      expect(invalid_place.valid?).not_to be true
    end
  end
end
