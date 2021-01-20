class Api::V1::RoadTripController < ApplicationController
  def create
    road_trip_data = GeocodeService.road_trip_data(params[:origin], params[:end_point])[:route]

    raw_time = road_trip_data[:formattedTime].split(':')
    trip_time = "#{raw_time[0].to_i} hours #{raw_time[1]} min"
    origin_hash = road_trip_data[:locations].first
    destination_hash = road_trip_data[:locations].last
    origin_city = "#{origin_hash[:adminArea5]}, #{origin_hash[:adminArea3]}"
    destination_city = "#{destination_hash[:adminArea5]}, #{destination_hash[:adminArea3]}"
    destination_lat_lng = destination_hash[:displayLatLng]
    end_location = Location.new(destination_lat_lng)
    destination_forecast = WeatherFacade.forecast(end_location)
    current_hour = destination_forecast.current_weather[:datetime][11..12].to_i
    arrival_hour = raw_time[0].to_i + current_hour
    arrival_forecast_data = destination_forecast.hourly_weather.find do |hour|
      hour[:time].split(':')[0].to_i == arrival_hour
    end

    forecast = {
      temperature: arrival_forecast_data[:temperature],
      conditions: arrival_forecast_data[:conditions].capitalize
    }

    payload = {
      data: {
        id: nil,
        type: 'roadtrip',
        attributes: {
          start_city: origin_city,
          end_city: destination_city,
          travel_time: trip_time,
          weather_at_eta: forecast
        }
      }
    }
    render json: payload
  end
end
