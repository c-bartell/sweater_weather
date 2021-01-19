require 'rails_helper'

describe 'GeocodeFacade' do
  it 'can create a location object from a location string' do
    VCR.use_cassette('denverco_coord_request') do
      location_string = 'denver,co'
      location = GeocodeFacade.location(location_string)

      expect(location).to be_a Location
      expect(location.latitude).to be_a Float
      expect(location.longitude).to be_a Float
    end
  end
end
