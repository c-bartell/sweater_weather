require 'rails_helper'

describe 'Road Trip PORO' do
  before :each do
    VCR.use_cassette('denver_to_pueblo_travel_request') do
      start_point = 'Denver,Co'
      end_point = 'Pueblo,Co'
      @trip_data = GeocodeService.road_trip_data(start_point, end_point)
    end
  end

  it 'has trip data attributes' do
    road_trip = RoadTrip.new(@trip_data)

    expect(road_trip).to be_a RoadTrip
    expect(road_trip.id).to be_nil
    expect(road_trip.start_city).to eq 'Denver, CO'
    expect(road_trip.end_city).to eq 'Pueblo, CO'
    expect(road_trip.travel_time).to eq '1 hours 44 min'
    expect(road_trip.lat_lng).to eq(
      { lat: 38.265427, lng: -104.610413 }
    )
  end

  it 'can add weather info' do

  end
end
