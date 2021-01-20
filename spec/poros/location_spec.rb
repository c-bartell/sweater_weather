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

  it 'can instantiate from a latLng hash' do
    lat_lng = {
      lat: 5,
      lng: 6
    }
    location = Location.new(lat_lng)
    expect(location).to be_a Location
    expect(location.latitude).to eq 5
    expect(location.longitude).to eq 6
  end
end
