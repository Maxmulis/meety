require 'rails_helper'

RSpec.describe GetPlace, type: :services do
  subject { described_class }

  it { is_expected.to be_a(Class) }

  describe '#call' do
    let(:input) { {lon: 13.3231312, lat: 52.4605144} }

    context 'when called with valid lon and lat returns a valid place' do
      it {
        is_expected.target.call(input).valid? be(true)
      }
    end
  end
end
