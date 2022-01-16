require 'rails_helper'

RSpec.describe Place, type: :model do
  valid_place = FactoryBot.build(
    :place,
    {
      'lat' => 52.514689,
      'lon' => 13.3909281,
      'name' => 'Aigner',
      'street' => 'Französische Straße',
      'number' => 25,
      'categories' => ["catering", "catering.restaurant", "wheelchair", "wheelchair.limited"]
    }
  )
  context 'when initialised with valid data' do
    it 'is valid'

    describe '#lat' do
      it 'returns the correct latitude' do
        expect(valid_place.lat).to eq(52.514689)
      end
    end

    describe '#lon' do
      it 'returns the correct longitude' do
        expect(valid_place.lon).to eq(13.3909281)
      end
    end

    describe '#name' do
      it 'returns the correct name' do
        expect(valid_place.name).to eq(13.3892484)
      end
    end

    describe '#street' do
      it 'returns the correct street' do
        expect(valid_place.street).to eq('Französische Straße')
      end
    end

    describe '#street' do
      it 'returns the correct street' do
        expect(valid_place.number).to eq(25)
      end
    end

    describe '#is_restaurant' do
      it 'returns true' do
        expect(valid_place.is_restaurant?).to be_true
      end
    end
    it '#is_restaurant? returns true if Place is a restaurant'
  end
    context 'when initialised invalid data' do
      it 'is valid'
  end
end
