require 'rails_helper'

RSpec.describe GetGeocodeAddress, type: :services do
  describe '#call' do
    context 'when called with a valid address' do
      # subject { GetGeocodeAddress.new("Rudi-Dutschke-Str. 26, Berlin").call }
      # it { is_expected.to eq({ lon: 13.3913749, lat: 52.506872 }) }
      let(:valid_address) do
        GetGeocodeAddress.call("Rudi-Dutschke-Str. 26, Berlin")
      end
      it "returns a hash with the correct lon and lat" do
        expect(valid_address).to eq({ lon: 13.3913749, lat: 52.506872 })
      end
    end

    context 'when called with an unspecific address' do
      let(:unspecific_address) do
        GetGeocodeAddress.call("Rudi-Dutschke-Str, Berlin")
      end
      it "raises an exception" do
        expect { unspecific_address }.to raise_error(/unspecific address/)
      end
    end
    context 'when called with an invalid address' do
      let(:invalid_address) { GetGeocodeAddress.call("") }
      it "raises an exception" do
        expect { invalid_address }.to raise_error(/invalid address/)
      end
    end
  end
end
