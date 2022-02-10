require 'rails_helper'

RSpec.describe GetGeocodeAddress, type: :services do
  subject { described_class }

  it { is_expected.to be_a(Class) }

  describe '#call' do
    let(:input) { "Rudi-Dutschke-Str. 26, Berlin" }

    context 'when called with a valid address returns hash with lon and lat' do
      it {
        expect(is_expected.target.call(input)).to eq({ lon: 13.3913749,
                                                       lat: 52.506872 })
      }
    end
  end
end
