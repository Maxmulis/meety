require 'rails_helper'

RSpec.describe GeographicMidpoint, type: :services do
  describe '#call' do
    context 'when called with a valid address' do
      let(:valid_place1) do
        GeocodePlace.new(Place.new(address: "Rudi-Dutschke-Str. 26, Berlin")).call
      end
      let(:valid_place2) do
        GeocodePlace.new(Place.new(address: "Kochstrasse 9, 10969 Berlin")).call
      end
      let(:lat) do
        GeographicMidpoint.call([valid_place1, valid_place2]).lat
      end
      let(:lon) do
        GeographicMidpoint.call([valid_place1, valid_place2]).lon
      end

      it "returns the geographic midpoint" do
        expect(lon: lon.round, lat: lat.round).to eq(lon: 13, lat: 53)
      end

      let(:place) { GeographicMidpoint.call([valid_place1, valid_place2]) }
      it "returns a valid Place" do
        expect(place).to be_a(Place)
      end
    end
  end
end
