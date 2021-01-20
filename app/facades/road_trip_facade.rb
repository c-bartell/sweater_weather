class RoadTripFacade
  class << self
    def road_trip(start_point, end_point)
      road_trip_data = GeocodeService.road_trip_data(start_point, end_point)
      road_trip = RoadTrip.new(road_trip_data)

      raw_time = road_trip_data[:route][:formattedTime].split(':')
      end_location = Location.new(road_trip.lat_lng)
      end_forecast = WeatherFacade.forecast(end_location)
      current_hour = end_forecast.current_weather[:datetime][11..12].to_i
      arrival_hour = raw_time[0].to_i + current_hour
      arrival_forecast_data = end_forecast.hourly_weather.find do |hour|
        hour[:time].split(':')[0].to_i == arrival_hour
      end

      forecast = {
        temperature: arrival_forecast_data[:temperature],
        conditions: arrival_forecast_data[:conditions].capitalize
      }
      road_trip.add_weather(forecast)

      road_trip
    end
  end
end
