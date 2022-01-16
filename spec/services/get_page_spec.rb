require 'rails_helper'

RSpec.describe GetPage, type: :services do
  subject { described_class }

  it { is_expected.to be_a(Class) }

  # test initialize
  describe '#initialize/call' do
    subject do
      described_class.call("")['features'][0]['properties']['address_line2']
    end

    context 'with param \'@addr\'' do
      it { is_expected.to eq('Französische Straße 25, 10117 Berlin, Germany') }
    end
  end
end
