require 'rails_helper'

RSpec.describe GeocodePlace, type: :services do
  describe '#call' do
    context 'when called with a valid address' do
      let(:valid_address) do
        GeocodePlace.new(Place.new(address: "Rudi-Dutschke-Str. 26, Berlin")).call
      end
      it "returns a hash with the correct lon and lat" do
        expect(lon: valid_address.lon,
               lat: valid_address.lat).to eq(lon: 13.3913749,
                                             lat: 52.506872)
      end
    end
  end
end
