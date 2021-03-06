require 'rails_helper'

RSpec.describe FetchSuggestion, type: :services do
  let(:valid_place) { Place.new(lon: 13.3231312, lat: 52.4605144) }

  describe '#call' do
    context 'when called with valid lon and lat' do
      it 'returns a valid place' do
        expect(valid_place.valid?).to be true
      end
    end
  end
end
