require 'rails_helper'

RSpec.describe GetPage, type: :services do
  subject { described_class }

  it { is_expected.to be_a(Class) }

  # test initialize
  describe '#initialize/call' do
    subject do
      described_class.call("")['features'][0]['properties']
    end

    context 'with param \'@addr\'' do
      it {
        is_expected.to eq({ "address_line1" => "Aigner",
                            "address_line2" => "Französische Straße 25, 10117 Berlin, Germany", "categories" => ["catering", "catering.restaurant", "wheelchair", "wheelchair.limited"], "city" => "Berlin", "country" => "Germany", "country_code" => "de", "datasource" => { "attribution" => "© OpenStreetMap contributors", "license" => "Open Database Licence", "sourcename" => "openstreetmap", "url" => "https://www.openstreetmap.org/copyright" }, "details" => ["details", "details.contact", "details.facilities", "details.payment"], "district" => "Mitte", "formatted" => "Aigner, Französische Straße 25, 10117 Berlin, Germany", "housenumber" => "25", "lat" => 52.514689, "lon" => 13.3909281, "name" => "Aigner", "place_id" => "51c12c59ba27c82a4059a5584154e1414a40f00103f90195482005000000009203064169676e6572", "postcode" => "10117", "state" => "Berlin", "street" => "Französische Straße", "suburb" => "Mitte" })
      }
    end
  end
end
