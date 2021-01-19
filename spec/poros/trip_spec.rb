require 'rails_helper'

decribe 'Trip' do
  it 'can make a trip with attributes' do
    VCR.use_cassette(denver_to_pueblo_travel_request) do
      trip_data = GeocodeService.trip_data('denver,co', 'pueblo,co')[:routes]
      trip = Trip.new(trip_data)

      expect(trip).to be_a Trip
      expect(trip.formatted_time).to eq trip_data[:formattedTime].split(':')
      expect(trip.destination_city).to eq "#{trip_data[:locations].last[:adminArea5]}, #{trip_data[:locations].last[:adminArea3]}"
      expect(trip.latitude).to eq trip_data[:locations].last[:latLng][:lat]
      expect(trip.longitude).to eq trip_data[:locations].last[:latLng][:lng]
    end
  end
end
