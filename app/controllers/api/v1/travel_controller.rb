class Api::V1::TravelController < ApplicationController
  def munchies
    # start_point = GeocodeFacade.location(params[:start])
    # end_point = GeocodeFacade.location(params[:end])
    conn = Faraday.new(
      url: 'https://www.mapquestapi.com/directions/v2',
      params: {
        key: ENV['GEOCODE_API_KEY']
      },
      headers: {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }
    )
    response = conn.get('route') do |req|
      req.params[:from] = params[:start]
      req.params[:to] = params[:end]
    end

    trip_data = JSON.parse(response.body, symbolize_names: true)[:route]
    raw_time = trip_data[:formattedTime].split(':')
    trip_time = "#{raw_time[0].to_i} hours #{raw_time[1]} min"
    destination_hash = trip_data[:locations].last
    destination_city = "#{destination_hash[:adminArea5]}, #{destination_hash[:adminArea3]}"
    destination_lat_lng = destination_hash[:displayLatLng]
    destination_obj = Location.new(destination_lat_lng)

    destination_forecast = Forecast.new(
      WeatherService.weather_at_coords(destination_obj)
    )
    current_hour = destination_forecast.current_weather[:datetime][11..12].to_i
    arrival_hour = raw_time[0].to_i + current_hour
    arrival_forecast_data = destination_forecast.hourly_weather.find do |hour|
      hour[:time].split(':')[0].to_i == arrival_hour
    end

    forecast = {
      summary: arrival_forecast_data[:conditions].capitalize,
      temperature: arrival_forecast_data[:temperature].to_i.to_s
    }

    conn = Faraday.new(
      url: 'https://api.yelp.com/v3/',
      headers: {
        'Authorization' => "Bearer #{ENV['YELP_API_KEY']}"
      }
    )

    response = conn.get('businesses/search') do |req|
      req.params[:limit] = 1
      req.params[:categories] = 'food'
      req.params[:term] = params[:food]
      req.params[:latitude] = destination_obj.latitude
      req.params[:longitude] = destination_obj.longitude
    end

    restaurant_data = JSON.parse(response.body, symbolize_names: true)[:businesses].first
    restaurant_name = restaurant_data[:name]
    restaurant_address = restaurant_data[:location][:display_address].join(', ')
    response_hash = {
      data: {
        id: nil,
        type: 'munchie',
        attributes: {
          destination_city: destination_city,
          travel_time: trip_time,
          forecast: forecast,
          restaurant: {
            name: restaurant_name,
            address: restaurant_address
          }
        }
      }
    }

    render json: response_hash
  end
end
