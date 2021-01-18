require 'rails_helper'

describe 'Location PORO' do
  before :each do
    VCR.use_cassette('denverco_coord_request') do
      @data = GeocodeService.location_to_coords('denver,co')
    end
  end

  it 'exists' do
    expect(Location.new(@data)).to be_a Location
  end
end
