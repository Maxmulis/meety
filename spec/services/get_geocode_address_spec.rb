require 'rails_helper'

RSpec.describe GetGeocodeAddress, type: :services do
  subject { described_class }

  it { is_expected.to be_a(Class) }

  describe '#call' do
    context 'when called with a valid address returns hash with lon and lat' do
      let(:input) { "Rudi-Dutschke-Str. 26, Berlin" }

      it {
        expect(is_expected.target.call(input)).to eq({ lon: 13.3913749,
                                                       lat: 52.506872 })
      }
    end

    context 'when called with an invalid address still returns a valid lon and lat' do
      let(:input) { "Rudi-Dutschke-Str, Berlin" }

      it {
        expect(is_expected.target.call(input)).to have_key(:lon)
        expect(is_expected.target.call(input)).to have_key(:lat)
      }
    end
  end
end
