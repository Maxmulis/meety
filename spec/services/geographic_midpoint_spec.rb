require 'rails_helper'

RSpec.describe GeographicMidpoint, type: :services do
  describe '#call' do
    context 'when called with a valid address' do
      let(:valid_address1) do
        GeocodeAddress.new("Rudi-Dutschke-Str. 26, Berlin").call
      end
      let(:valid_address2) do
        GeocodeAddress.new("Kochstrasse 9, 10969 Berlin").call
      end

      let(:lat) do
        GeographicMidpoint.call([valid_address1, valid_address2]).lat
      end
      let(:lon) do
        GeographicMidpoint.call([valid_address1, valid_address2]).lon
      end

      it "returns the geographic midpoint" do
        expect(lon: lon.round, lat: lat.round).to eq(lon: 13, lat: 53)
      end

      let(:place) { GeographicMidpoint.call([valid_address1, valid_address2]) }
      it "returns a valid Place" do
        expect(place).to be_a(Place)
      end
    end
  end
end
