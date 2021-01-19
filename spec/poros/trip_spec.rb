require 'rails_helper'

decribe 'Trip' do
  it 'can make a trip with attributes' do
    VCR.use_cassette(denver_to_pueblo_travel_request) do
      trip_data = GeocodeService.trip_data('denver,co', 'pueblo,co')
      trip = Trip.new(trip_data)
      
      expect()
    end
  end
end
