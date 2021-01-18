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

  it 'has attributes' do
    location = Location.new(@data)
    lat_lng = @data[:results][0][:locations][0][:latLng]

    expect(location.latitude).to eq(lat_lng[:lat])
    expect(location.longitude).to eq(lat_lng[:lng])
  end
end
