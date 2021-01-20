require 'rails_helper'

describe 'Road Trip Facade' do
  it 'can generate a road trip' do
    VCR.use_cassette('denver_to_pueblo_travel_request') do
      start_point = 'Denver,Co'
      end_point = 'Pueblo,Co'
      road_trip = RoadTripFacade.road_trip(start_point, end_point)

      expect(road_trip).to be_a RoadTrip
      expect(road_trip.weather_at_eta).to eq(
        {
          temperature: 24.17,
          conditions: "Few clouds"
        }
      )
    end
  end
end
